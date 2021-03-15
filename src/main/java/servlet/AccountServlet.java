package servlet;

import bll.GeneralUser;
import dal.AWSPasswordAccess;
import dal.AWSUserAccess;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "AccountServlet")
public class AccountServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

        //Variable to see if user is logging in, retrieving data, editing details or deleting data.
        String action = request.getParameter("action");

        //call suitable method based on input "action"
        switch (action){
            case "login":
                loginUser(request, response);
                break;
            case "add":
                addUser(request, response);
                break;
            case "addEmployee":
                addEmployee(request, response);
                break;
            case "openedit":
                openEditEmployee(request, response);
                break;
            case "editEmployee":
                editEmployee(request, response);
                break;
            case "delete":
                deleteUser(request, response);
                break;
            case "logout":
                logoutUser(request, response);
                break;
            case "forgot":
                forgotPassword(request, response);
                break;
            default:
                //do nothing if no action
                break;
        }

    }



    private void loginUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //get input from the request
        String emailAddress = request.getParameter("loginEmailAddress");

        //instantiate necessary classes
        AWSUserAccess awsUA = new AWSUserAccess();
        GeneralUser user = awsUA.retrieveUser(emailAddress); //create a user object from the database

        String destination, errorMessage;

        //set session attribute to an admin or user
        if(user.getUserType() == 1){
            //change user to admin
            GeneralUser admin = awsUA.retrieveAdmin(emailAddress);
            request.getSession(true).setAttribute("ADMIN", admin);
            destination = "ImageServlet?imageaction=retrieve";
            request.getSession().removeAttribute("EMAILERROR");

        }else if(user.getUserType() == 4){
            request.getSession(true).setAttribute("USER", user);
            destination = "ImageServlet?imageaction=retrieve";
            request.getSession().removeAttribute("EMAILERROR");

        }else{
            destination = "account.jsp";
            errorMessage = "<div class=\"alert alert-danger\"><strong>Incorrect email address provided!</strong></div>";
            request.getSession(true).setAttribute("EMAILERROR", errorMessage);

        }

        //Get the users image from the database
        RequestDispatcher rd = request.getRequestDispatcher(destination);
        rd.forward(request, response);

    }



    private void addUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //get inputs from the request
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
        String day = request.getParameter("day");
        String month = request.getParameter("month");
        String year = request.getParameter("year");

        //concat date of birth
        String dob = year + "/" + month + "/" + day;

        //userType (default 4 for Free Account)
        int userType = 4;

        //instantiate necessary classes
        AWSUserAccess awsUA = new AWSUserAccess();
        GeneralUser newUser = new GeneralUser(fname, lname, email, dob, userType);

        System.out.println();

        //add the new user to the database
        awsUA.insertNewUser(newUser);

        //set session attributes with the new users data
        GeneralUser user = awsUA.retrieveUser(email); //create a user object from the database
        request.getSession(true).setAttribute("USER", user);

        //open the upload page
        RequestDispatcher rd = request.getRequestDispatcher("/imageSelection.jsp");
        rd.forward(request, response);

    }



    private void addEmployee(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Get admin details
        GeneralUser admin = (GeneralUser) request.getSession().getAttribute("ADMIN");

        //New object for employee details
        GeneralUser newEmployee = new GeneralUser();

        //concat date of birth
        String day = request.getParameter("date");
        String month = request.getParameter("month");
        String year = request.getParameter("year");
        String dob = year + "/" + month + "/" + day;

        //Assign new attributes
        newEmployee.setFirstName(request.getParameter("firstname"));
        newEmployee.setLastName(request.getParameter("lastname"));
        newEmployee.setEmail(request.getParameter("email"));
        newEmployee.setGender(request.getParameter("gender"));
        newEmployee.setPhone(request.getParameter("phonenumber"));
        newEmployee.setDateOfBirth(dob);
        newEmployee.setUserType(4);
        newEmployee.setOrgID(admin.getOrgID());

        //add them to database
        AWSUserAccess awsUA = new AWSUserAccess();
        awsUA.insertAdmin(newEmployee); //This method is used as its the same for both employees/admins

        //retrieve the new user and assign it to the session
        GeneralUser addedEmployee = awsUA.retrieveAdmin(newEmployee.getEmail()); //create a user object from the database
        request.getSession(true).setAttribute("NEWEMPLOYEE", addedEmployee);

        String adminMessage = "<div class=\"alert alert-success alert-dismissible fade show\" role=\"alert\">\n" +
                "                            <strong>Creation Successful:</strong> A new employee was added to your team.\n" +
                "                            <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">\n" +
                "                                <span aria-hidden=\"true\">&times;</span>\n" +
                "                            </button>\n" +
                "                        </div>";
        request.getSession(true).setAttribute("ADMINMESSAGE", adminMessage);

        //open the upload page
        RequestDispatcher rd = request.getRequestDispatcher("/imageSelection.jsp");
        rd.forward(request, response);
    }

    private void openEditEmployee(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //get input from the request and store it
        int userID = Integer.parseInt(request.getParameter("userid"));

        //Get all the employees
        ArrayList<GeneralUser> employees = (ArrayList<GeneralUser>) request.getSession().getAttribute("EMPLOYEES");
        GeneralUser returnEmployee = null;

        //Loop through list and find the employee to be edited by the admin
        for(GeneralUser employee : employees){
            if(employee.getUserID() == userID){
                returnEmployee = employee;
                break;
            }
        }

        //Set session Attribute
        request.getSession(true).setAttribute("SINGLEEMPLOYEE", returnEmployee);

        //open the editing page
        RequestDispatcher rd = request.getRequestDispatcher("/editEmployees.jsp");
        rd.forward(request, response);
    }



    private void editEmployee(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Get the unedited employee
        GeneralUser singleEmployee = (GeneralUser) request.getSession().getAttribute("SINGLEEMPLOYEE");

        //Assign new attributes
        singleEmployee.setFirstName(request.getParameter("firstname"));
        singleEmployee.setLastName(request.getParameter("lastname"));
        singleEmployee.setEmail(request.getParameter("email"));
        singleEmployee.setGender(request.getParameter("gender"));
        singleEmployee.setPhone(request.getParameter("phonenumber"));

        String day = request.getParameter("date");
        String month = request.getParameter("month");
        String year = request.getParameter("year");
        String dob = year + "/" + month + "/" + day; //concat date of birth

        singleEmployee.setDateOfBirth(dob);

        //Update the database
        AWSUserAccess awsUA = new AWSUserAccess();
        awsUA.editEmployee(singleEmployee);

        //Clear session attribute
        request.getSession().removeAttribute("SINGLEEMPLOYEE");

        String adminMessage = "<div class=\"alert alert-success alert-dismissible fade show\" role=\"alert\">\n" +
                "                            <strong>Editing Successful:</strong> The employee's details were changed.\n" +
                "                            <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">\n" +
                "                                <span aria-hidden=\"true\">&times;</span>\n" +
                "                            </button>\n" +
                "                        </div>";
        request.getSession(true).setAttribute("ADMINMESSAGE", adminMessage);

        //open the second page
        RequestDispatcher rd = request.getRequestDispatcher("/adminDashboard.jsp");
        rd.forward(request, response);
    }



    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //get input from the request
        String userID = request.getParameter("userid");

        //Get admin details
        GeneralUser admin = (GeneralUser) request.getSession().getAttribute("ADMIN");

        //instantiate necessary classes
        AWSUserAccess awsUA = new AWSUserAccess();
        awsUA.deleteUser(userID); //This cascades to the User, Image and Password tables

        //Remake the employee list
        ArrayList<GeneralUser> employees = awsUA.getEmployees(admin.getOrgID());
        request.getSession(true).setAttribute("EMPLOYEES", employees);

        String adminMessage = "<div class=\"alert alert-success alert-dismissible fade show\" role=\"alert\">\n" +
                "                            <strong>Deletion Successful:</strong> The employee was removed.\n" +
                "                            <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">\n" +
                "                                <span aria-hidden=\"true\">&times;</span>\n" +
                "                            </button>\n" +
                "                        </div>";
        request.getSession(true).setAttribute("ADMINMESSAGE", adminMessage);

        //reopen the dashboard
        RequestDispatcher rd = request.getRequestDispatcher("/adminDashboard.jsp");
        rd.forward(request, response);
    }




    private void logoutUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Clear Session: https://kodejava.org/how-do-i-invalidate-users-session/
        HttpSession session=request.getSession();
        session.invalidate();

        RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
        rd.forward(request, response);
    }


    private void forgotPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //get the users details
        // Get the user and their ID number
        GeneralUser user = (GeneralUser) request.getSession().getAttribute("USER");
        GeneralUser admin = (GeneralUser) request.getSession().getAttribute("ADMIN");

        int userID = 0;
        int orgID = 0;

        //check if a user or admin is logging in.
        if(user != null){
            userID = user.getUserID();
            orgID = user.getOrgID();

        }else if(admin != null){
            userID = admin.getUserID();
            orgID = admin.getOrgID();
        }

        //save their ID and Org ID to "messages" tables
        AWSPasswordAccess awsPA = new AWSPasswordAccess();
        awsPA.saveMessage(userID, orgID);

        //Clear the session so the admin can log in
        HttpSession session=request.getSession();
        session.invalidate();

        //reopen the dashboard
        RequestDispatcher rd = request.getRequestDispatcher("/forgotPassword.jsp");
        rd.forward(request, response);
    }



    //*********************************************************
    //send all POST/GET requests to the "ProcessRequest" method
    //*********************************************************
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}
