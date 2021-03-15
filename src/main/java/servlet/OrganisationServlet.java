package servlet;

import bll.GeneralUser;
import bll.Organisation;
import dal.AWSOrganisationAccess;
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

@WebServlet(name = "OrganisationServlet")
public class OrganisationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

        //Variable to see if user is logging in, retrieving data, editing details or deleting data.
        String action = request.getParameter("action");

        //call suitable method based on input "action"
        switch (action){
            case "addOrg":
                addOrg(request, response);
                break;
            case "addAdmin":
                addAdmin(request, response);
                break;
            case "editOrg":
                editOrg(request, response);
                break;
            case "deleteOrg":
                deleteOrg(request, response);
                break;
            case "removeMessage":
                removeMessage(request, response);
                break;
            default:
                //do nothing if no action
                break;
        }
    }



    protected void addOrg(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //get inputs from the request
        String orgName = request.getParameter("orgname");
        String orgEmail = request.getParameter("orgemail");
        String orgCategory = request.getParameter("orgcategory");
        String orgDomain = request.getParameter("orgdomain");
        String orgPlan = request.getParameter("orgplan");
        String cardNum = request.getParameter("orgcardnum");
        String cardExpiryMM = request.getParameter("orgexpirymm");
        String cardExpiryYY = request.getParameter("orgexpiryyy");
        String cardCVV = request.getParameter("orgcvv");

        String cardExpiry = cardExpiryMM + "/" + cardExpiryYY;

        //Create Organisation Object and assign the input
        Organisation newOrganisation = new Organisation();

        newOrganisation.setOrgName(orgName);
        newOrganisation.setOrgEmail(orgEmail);
        newOrganisation.setOrgDomain(orgDomain);
        newOrganisation.setOrgCategory(orgCategory);
        newOrganisation.setOrgPlan(Integer.parseInt(orgPlan));
        newOrganisation.setCardNum(cardNum);
        newOrganisation.setCardExpiry(cardExpiry);
        newOrganisation.setCardCVV(cardCVV);

        //upload to the database
        AWSOrganisationAccess awsOrg = new AWSOrganisationAccess();
        awsOrg.insertNewOrganisation(newOrganisation);

        //Retrieve the new Organisation (with its newly assigned ID)
        Organisation thisOrganisation = null;
        thisOrganisation = awsOrg.retrieveNewestOrganisation();


        //set session attributes with return data
        request.getSession(true).setAttribute("ORGANISATION", thisOrganisation);

        //create an administrator
        RequestDispatcher rd = request.getRequestDispatcher("/createAdmin.jsp");
        rd.forward(request, response);

    }



    protected void addAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //get inputs from the request
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String email = request.getParameter("email");
        String phonenumber = request.getParameter("phonenumber");
        String gender = request.getParameter("gender");
        String day = request.getParameter("date");
        String month = request.getParameter("month");
        String year = request.getParameter("year");

        //concat date of birth
        String dob = year + "/" + month + "/" + day;

        //Get current Organisation
        Organisation newOrganisation = (Organisation) request.getSession().getAttribute("ORGANISATION");

        //orgID
        int orgID = newOrganisation.getOrgID();

        //userType (default 1 for Admin Account)
        int userType = 1;

        //Assign inputs to the user
        GeneralUser user = new GeneralUser();
        user.setOrgID(orgID);
        user.setFirstName(firstname);
        user.setLastName(lastname);
        user.setEmail(email);
        user.setPhone(phonenumber);
        user.setDateOfBirth(dob);
        user.setGender(gender);
        user.setUserType(userType);

        //Insert new admin to the database
        AWSUserAccess awsUA = new AWSUserAccess();
        awsUA.insertAdmin(user);

        //retrieve the admin and assign it to the session
        GeneralUser admin = awsUA.retrieveAdmin(email); //create a user object from the database
        request.getSession(true).setAttribute("ADMIN", admin);

        //open the upload page
        RequestDispatcher rd = request.getRequestDispatcher("/imageSelection.jsp");
        rd.forward(request, response);
    }



    protected void editOrg(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Get current Organisation
        Organisation thisOrganisation = (Organisation) request.getSession().getAttribute("ORGANISATION");

        //orgID
        int orgID = thisOrganisation.getOrgID();

        //get inputs from the request
        String orgName = request.getParameter("orgname");
        String orgEmail = request.getParameter("orgemail");
        String orgCategory = request.getParameter("orgcategory");
        String orgDomain = request.getParameter("orgdomain");
        String orgPlan = request.getParameter("orgplan");
        String cardNum = request.getParameter("orgcardnum");
        String cardExpiryMM = request.getParameter("orgexpirymm");
        String cardExpiryYY = request.getParameter("orgexpiryyy");
        String cardCVV = request.getParameter("orgcvv");
        String cardExpiry = cardExpiryMM + "/" + cardExpiryYY;

        //create new organisation object
        Organisation newDetailsOrganisation = new Organisation();
        newDetailsOrganisation.setOrgName(orgName);
        newDetailsOrganisation.setOrgEmail(orgEmail);
        newDetailsOrganisation.setOrgDomain(orgDomain);
        newDetailsOrganisation.setOrgCategory(orgCategory);
        newDetailsOrganisation.setOrgPlan(Integer.parseInt(orgPlan));
        newDetailsOrganisation.setCardNum(cardNum);
        newDetailsOrganisation.setCardExpiry(cardExpiry);
        newDetailsOrganisation.setCardCVV(cardCVV);

        //update database
        AWSOrganisationAccess awsOrganisationAccess = new AWSOrganisationAccess();
        awsOrganisationAccess.editOrganisation(orgID, newDetailsOrganisation);

        //retrieve new org details inside Session Attribute 'Organisation'
        Organisation updatedOrg = awsOrganisationAccess.retrieveOrganisation(orgID);

        //Change the alert Banner
        String adminMessage = "<div class=\"alert alert-success alert-dismissible fade show\" role=\"alert\">\n" +
                "                            <strong>Editing Successful:</strong> The organisation's details were changed.\n" +
                "                            <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">\n" +
                "                                <span aria-hidden=\"true\">&times;</span>\n" +
                "                            </button>\n" +
                "                        </div>";
        request.getSession(true).setAttribute("ADMINMESSAGE", adminMessage);

        //set session attributes with return data
        request.getSession(true).setAttribute("ORGANISATION", updatedOrg);

        //return to adminDashboard.jsp
        RequestDispatcher rd = request.getRequestDispatcher("/adminDashboard.jsp");
        rd.forward(request, response);
    }



    protected void deleteOrg(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Get current Organisation
        Organisation thisOrganisation = (Organisation) request.getSession().getAttribute("ORGANISATION");

        //orgID
        int orgID = thisOrganisation.getOrgID();

        //Delete the organisation
        AWSOrganisationAccess awsOA = new AWSOrganisationAccess();
        awsOA.deleteOrganisation(orgID);

        //Clear Session: https://kodejava.org/how-do-i-invalidate-users-session/
        HttpSession session=request.getSession();
        session.invalidate();

        //bring to "sorry to see you leave" page
        RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
        rd.forward(request, response);
    }




    protected void removeMessage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //get input from the request
        String userID = request.getParameter("userid");
        int intUserID = Integer.parseInt(userID);

        //delete the message
        AWSPasswordAccess awsPA = new AWSPasswordAccess();
        awsPA.deleteMessage(intUserID);

        //get session attributes
        GeneralUser admin = (GeneralUser) request.getSession().getAttribute("ADMIN");
        ArrayList<GeneralUser> employees = (ArrayList<GeneralUser>) request.getSession().getAttribute("EMPLOYEES");

        //refresh the message list
        ArrayList<GeneralUser> employeeMessages = awsPA.retrieveMessages(admin.getOrgID(), employees);
        request.getSession(true).setAttribute("EMPLOYEEMESSAGES", employeeMessages);

        //bring back to the dashboard homepage
        RequestDispatcher rd = request.getRequestDispatcher("/adminDashboard.jsp");
        rd.forward(request, response);
    }



    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}
