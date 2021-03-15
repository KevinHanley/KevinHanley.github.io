package servlet;

import bll.GeneralUser;
import bll.PasswordImage;
import dal.AWSImageAccess;
import dal.AWSOrganisationAccess;
import dal.AWSUserAccess;

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
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.nio.file.Paths;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Base64;

@WebServlet(name = "MyServlet")
@MultipartConfig
public class MyServlet extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        // *********************
        // This Servlet is for running tests
        // *********************

        System.out.println("HERE 1");
        randomPage(request, response);

        //Variable to see if user is logging in, retrieving data, editing details or deleting data.
//        String action = request.getParameter("action");
//
//        //call suitable method based on input "action"
//        switch (action) {
//            case "base":
//                base64Test(request, response);
//                break;
//            default:
//                //do nothing if no action
//                break;
//        }

    }

    protected void base64Test(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Substring: https://stackoverflow.com/questions/5131867/removing-the-first-3-characters-from-a-string/15919281

        String base64string = request.getParameter("basestring");
        String imageID = request.getParameter("imageid");

        String newBase64String = base64string.substring(23); //substring of original

        GeneralUser user = new GeneralUser();

        AWSImageAccess awsIA = new AWSImageAccess();
        awsIA.uploadUnsplashImageToMySQL(imageID, newBase64String, user);

        request.getSession(true).setAttribute("BASE64TEST", base64string);

        RequestDispatcher rd = request.getRequestDispatcher("/loggedIn.jsp");
        rd.forward(request, response);
    }

    protected void randomPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("HERE 2");

        //Get the request parameters
        String tilearray = request.getParameter("tilearray");


        request.getSession(true).setAttribute("TILEARRAY", tilearray);

        System.out.println("HERE 3");
        RequestDispatcher rd = request.getRequestDispatcher("/template.jsp");
        rd.forward(request, response);

    }






    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}
