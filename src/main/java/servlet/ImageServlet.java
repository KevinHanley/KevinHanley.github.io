package servlet;

import bll.GeneralUser;
import bll.Organisation;
import bll.PasswordImage;
import com.oracle.tools.packager.IOUtils;
import dal.*;

import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Paths;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;

@WebServlet(name = "ImageServlet")
@MultipartConfig
public class ImageServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String imageAction = request.getParameter("imageaction");

        switch (imageAction) {
            case "upload":
                uploadImage(request, response);
                break;
            case "apiUpload":
                apiUpload(request, response);
                break;
            case "retrieve":
                retrieveImage(request, response);
                break;
            case "compare":
                compareImage(request, response);
                break;
            case "firstpassword":
                openConfirmation(request, response);
                break;
            case "secondpassword":
                confirmPasswords(request, response);
                break;
            case "editpassword":
                editImage(request, response);
                break;
            default:
                //do nothing
                break;

        }
    }




    //Called from imageSelection.jsp
    private void uploadImage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Source of retrieval code below: https://stackoverflow.com/questions/2422468/how-to-upload-files-to-server-using-jsp-servlet
        // inputStream to BufferedImage help: https://stackoverflow.com/questions/6464432/how-do-i-convert-a-inputstream-to-bufferedimage-in-java-groovy

        // Get the input file
        Part filePart = request.getPart("file");

        // Get the files name
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        //convert the input file into an inputStream
        InputStream fileContent = filePart.getInputStream();

        //convert the inputStream to a BufferedImage and pass it to the uploading function
        BufferedImage uploadedImage = ImageIO.read(fileContent);

        // Get the current user or admin
        GeneralUser user = (GeneralUser) request.getSession().getAttribute("USER");
        GeneralUser admin = (GeneralUser) request.getSession().getAttribute("ADMIN");
        GeneralUser newEmployee = (GeneralUser) request.getSession().getAttribute("NEWEMPLOYEE");
        GeneralUser singleEmployee = (GeneralUser) request.getSession().getAttribute("SINGLEEMPLOYEE");

        //Image object
        PasswordImage passImg = new PasswordImage();

        //Save as a BLOB in Remote AWS MySQL Database
        AWSImageAccess awsIA = new AWSImageAccess();
        if(newEmployee != null){

            //upload the admins image
            awsIA.uploadImageToMySQL(fileName, uploadedImage, newEmployee);

            //Get image back from database
            int empID = newEmployee.getUserID();
            passImg = awsIA.retrieveImageFromMySQL(empID);

        } else if (singleEmployee != null){

            //upload the admins image
            awsIA.uploadImageToMySQL(fileName, uploadedImage, singleEmployee);

            //Get image back from database
            int editingID = singleEmployee.getUserID();
            passImg = awsIA.retrieveImageFromMySQL(editingID);

        } else if (admin != null){

            //upload the admins image
            awsIA.uploadImageToMySQL(fileName, uploadedImage, admin);

            //Get image back from database
            int adminID = admin.getUserID();
            passImg = awsIA.retrieveImageFromMySQL(adminID);

        }else if (user != null){

            //upload the users image
            awsIA.uploadImageToMySQL(fileName, uploadedImage, user);

            //Get image back from database
            int userID = user.getUserID();
            passImg = awsIA.retrieveImageFromMySQL(userID);

        }else{
            //Error
            System.out.println("Error no users available");

        }

        request.getSession(true).setAttribute("IMAGEPASS", passImg);

        RequestDispatcher rd = request.getRequestDispatcher("/createPassword.jsp");
        rd.forward(request, response);
    }







    //Called from imageSelection.jsp
    private void apiUpload(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Substring: https://stackoverflow.com/questions/5131867/removing-the-first-3-characters-from-a-string/15919281

        //Get the request parameters
        String base64string = request.getParameter("basestring");
        String imageID = request.getParameter("imageid");

        String newBase64String = base64string.substring(23); //substring of original

        // Get the current user or admin
        GeneralUser user = (GeneralUser) request.getSession().getAttribute("USER");
        GeneralUser admin = (GeneralUser) request.getSession().getAttribute("ADMIN");
        GeneralUser newEmployee = (GeneralUser) request.getSession().getAttribute("NEWEMPLOYEE");
        GeneralUser singleEmployee = (GeneralUser) request.getSession().getAttribute("SINGLEEMPLOYEE");

        //Image object
        PasswordImage passImg = new PasswordImage();

        //Save as a BLOB in Remote AWS MySQL Database
        AWSImageAccess awsIA = new AWSImageAccess();
        if(newEmployee != null){

            //upload the new employees image
            awsIA.uploadUnsplashImageToMySQL(imageID, newBase64String, newEmployee);

            //Get image back from database
            int empID = newEmployee.getUserID();
            passImg = awsIA.retrieveImageFromMySQL(empID);

        } else if (singleEmployee != null){

            //upload the editing employees image
            awsIA.uploadUnsplashImageToMySQL(imageID, newBase64String, singleEmployee);

            //Get image back from database
            int editingID = singleEmployee.getUserID();
            passImg = awsIA.retrieveImageFromMySQL(editingID);

        } else if (admin != null){

            //upload the admins image
            awsIA.uploadUnsplashImageToMySQL(imageID, newBase64String, admin);

            //Get image back from database
            int adminID = admin.getUserID();
            passImg = awsIA.retrieveImageFromMySQL(adminID);

        }else if (user != null){

            //upload the users image
            awsIA.uploadUnsplashImageToMySQL(imageID, newBase64String, user);

            //Get image back from database
            int userID = user.getUserID();
            passImg = awsIA.retrieveImageFromMySQL(userID);

        }else{
            //Error
            System.out.println("Error no users available");

        }

        request.getSession(true).setAttribute("IMAGEPASS", passImg);

        RequestDispatcher rd = request.getRequestDispatcher("/createPassword.jsp");
        rd.forward(request, response);

    }







    //normal login (called form AccountServlet)
    protected void retrieveImage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Get the user and their ID number
        GeneralUser user = (GeneralUser) request.getSession().getAttribute("USER");
        GeneralUser admin = (GeneralUser) request.getSession().getAttribute("ADMIN");

        int userID = 0;

        //check if a user or admin is logging in.
        if(user != null){
            userID = user.getUserID();

        }else if(admin != null){
            userID = admin.getUserID();

        }

        //search for their image and return it
        AWSImageAccess imageAccess = new AWSImageAccess();
        PasswordImage passImage;
        passImage = imageAccess.retrieveImageFromMySQL(userID);

        request.getSession(true).setAttribute("IMAGEPASS", passImage);

        RequestDispatcher rd = request.getRequestDispatcher("/password.jsp");
        rd.forward(request, response);
    }



    //Normal Log in: called from password.jsp
    private void compareImage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Capture tiles selected by user
        String tileArray = request.getParameter("tilearray");

        //get the users image
        PasswordImage passImage = (PasswordImage) request.getSession().getAttribute("IMAGEPASS");

        //Get the User/Admin
        GeneralUser user = (GeneralUser) request.getSession().getAttribute("USER");
        GeneralUser admin = (GeneralUser) request.getSession().getAttribute("ADMIN");

        //Convert Co-ordinates into image segments
        ImageHash ih = new ImageHash();
        String generatedHash = ih.generateImageHash(tileArray, passImage);

        //Compare hash to Database
        AWSPasswordAccess passwordAccess = new AWSPasswordAccess();
        boolean matching = false;

        //compare the hashes, checking with admin/user
        if(user != null){
            matching = passwordAccess.compareHash(user, generatedHash);

        }else if(admin != null){
            matching = passwordAccess.compareHash(admin, generatedHash);

        }else{
            matching = false;
        }

        //Strings for if theres an error
        String destination = "/password.jsp";
        String errorMessage = "";

        if(matching == true){
            //set destination based on usertype.
            if(user != null){
                destination = "/loggedIn.jsp";

            }else if(admin != null){
                //instantiate classes
                AWSOrganisationAccess awsOA = new AWSOrganisationAccess();
                AWSUserAccess awsUA = new AWSUserAccess();
                AWSPasswordAccess awsPA = new AWSPasswordAccess();

                //Retrieve organisation and employee details from database
                Organisation organisation = awsOA.retrieveOrganisation(admin.getOrgID());
                ArrayList<GeneralUser> employees = awsUA.getEmployees(admin.getOrgID());
                ArrayList<GeneralUser> employeeMessages = awsPA.retrieveMessages(admin.getOrgID(), employees);

                request.getSession(true).setAttribute("ORGANISATION", organisation);
                request.getSession(true).setAttribute("EMPLOYEES", employees);
                request.getSession(true).setAttribute("EMPLOYEEMESSAGES", employeeMessages);
                destination = "/adminDashboard.jsp";

            }else{
                //do nothing
            }

        }else{
            //return to password.jsp
            destination = "/password.jsp";
            errorMessage = "<div class=\"alert alert-danger\"><strong>Incorrect tiles, please try again!</strong></div>";
            request.getSession(true).setAttribute("TILEERROR", errorMessage);

        }

        RequestDispatcher rd = request.getRequestDispatcher(destination);
        rd.forward(request, response);
    }


    //called from createPassword.jsp
    private void openConfirmation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Capture tiles selected by user
        String tileArray1 = request.getParameter("tilearray1");
        request.getSession(true).setAttribute("TILEARRAY1", tileArray1);

        RequestDispatcher rd = request.getRequestDispatcher("/confirmPassword.jsp");
        rd.forward(request, response);
    }




    //called from confirmPassword.jsp
    private void confirmPasswords(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Capture the second set of tiles selected by user
        String tileArray2 = request.getParameter("tilearray2");
        request.getSession(true).setAttribute("TILEARRAY2", tileArray2);

        //Get the first sequence of Tiles
        String tileArray1 = (String) request.getSession().getAttribute("TILEARRAY1");

        //get session objects
        PasswordImage passImage = (PasswordImage) request.getSession().getAttribute("IMAGEPASS");
        GeneralUser user = (GeneralUser) request.getSession().getAttribute("USER");
        GeneralUser admin = (GeneralUser) request.getSession().getAttribute("ADMIN");
        GeneralUser newEmployee = (GeneralUser) request.getSession().getAttribute("NEWEMPLOYEE");
        GeneralUser singleEmployee = (GeneralUser) request.getSession().getAttribute("SINGLEEMPLOYEE");

        // default destination in event sequences don't match
        String destination = "/confirmPassword.jsp";
        String errorMessage = "";

        //Check if the two sequences of tiles match
        if(tileArray1.equals(tileArray2)){
            //passwords are equal

            //Generate Hash
            ImageHash ih = new ImageHash();
            String generatedHash = ih.generateImageHash(tileArray1, passImage);

            //Save hash to Database
            AWSPasswordAccess passwordAccess = new AWSPasswordAccess();

            //check if user or admin
            if(newEmployee != null){

                //store hash
                passwordAccess.storeHash(newEmployee, generatedHash);
                destination = "/adminDashboard.jsp";

                //refresh employee list
                AWSUserAccess awsUA = new AWSUserAccess();
                ArrayList<GeneralUser> employees = awsUA.getEmployees(admin.getOrgID());
                request.getSession(true).setAttribute("EMPLOYEES", employees);

            } else if (singleEmployee != null){

                //store hash
                passwordAccess.storeHash(singleEmployee, generatedHash);
                destination = "/adminDashboard.jsp";

                //refresh employee list
                AWSUserAccess awsUA = new AWSUserAccess();
                ArrayList<GeneralUser> employees = awsUA.getEmployees(admin.getOrgID());
                request.getSession(true).setAttribute("EMPLOYEES", employees);

                String adminMessage = "<div class=\"alert alert-success alert-dismissible fade show\" role=\"alert\">\n" +
                        "                            <strong>Editing Successful:</strong> The employee's picture password was changed.\n" +
                        "                            <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">\n" +
                        "                                <span aria-hidden=\"true\">&times;</span>\n" +
                        "                            </button>\n" +
                        "                        </div>";
                request.getSession(true).setAttribute("ADMINMESSAGE", adminMessage);


            } else if (user != null){

                //store hash
                passwordAccess.storeHash(user, generatedHash);
                destination = "/loggedIn.jsp";

            }else if (admin != null){

                //store hash
                passwordAccess.storeHash(admin, generatedHash);
                destination = "/adminDashboard.jsp";

                //refresh employee list
                AWSUserAccess awsUA = new AWSUserAccess();
                ArrayList<GeneralUser> employees = awsUA.getEmployees(admin.getOrgID());
                request.getSession(true).setAttribute("EMPLOYEES", employees);

            }else{
                //Error
                System.out.println("Error neither available");

            }

            //clear session variables
            //Clear Session: https://stackoverflow.com/questions/13963720/how-to-effectively-destroy-session-in-java-servlet
            //Clear Session Attributes: https://stackoverflow.com/questions/23476619/removing-all-session-attributes-with-one-command-in-java-web

            request.getSession().removeAttribute("IMAGEPASS");
            request.getSession().removeAttribute("NEWEMPLOYEE");
            request.getSession().removeAttribute("TILEARRAY1");
            request.getSession().removeAttribute("TILEARRAY2");
            request.getSession().removeAttribute("SINGLEEMPLOYEE");
            request.getSession().removeAttribute("TILEERROR");

        }else{
            //send error message back to confirmPassword.jsp
            //use if statement within HTML to display the error message, changed by setting a seesion attribute true/false.*******************************************
            errorMessage = "<div class=\"alert alert-danger\"><strong>Incorrect tiles, please try again!</strong></div>";
            request.getSession(true).setAttribute("TILEERROR", errorMessage);
            destination = "/confirmPassword.jsp";
        }


        //Open the destination
        RequestDispatcher rd = request.getRequestDispatcher(destination);
        rd.forward(request, response);
    }




    //Called from Edit Employees in Admin Dashboard
    protected void editImage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //open create password
        //open confirm password
        //return to admin dashboard

        //Open the destination
        RequestDispatcher rd = request.getRequestDispatcher("/imageSelection.jsp");
        rd.forward(request, response);

    }




    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}