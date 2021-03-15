package dal;
import bll.GeneralUser;
import com.sun.tools.javah.Gen;
import dal.AWSConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class AWSUserAccess {

    //Execute SQL commands with the remote MySQL database
    //Code adapted from 3rd year Java Project

    public GeneralUser retrieveUser(String inputEmailAddress){
        GeneralUser user = new GeneralUser();
        Connection conn = AWSConnection.establishDatabaseConnection();

        try{
            Statement st = conn.createStatement();
            ResultSet rs;

            rs = st.executeQuery("select * from User where email='"+ inputEmailAddress +"'"); //SQL
            while (rs.next()){
                user.setUserID(rs.getInt("userID"));
                user.setFirstName(rs.getString("firstName"));
                user.setLastName(rs.getString("lastName"));
                user.setEmail(rs.getString("email"));;
                user.setUserType(rs.getInt("userType"));
                user.setOrgID(rs.getInt("orgID"));
                user.setPhone(rs.getString("phone"));
                user.setDateOfBirth(rs.getString("dateOfBirth"));
                user.setGender(rs.getString("gender"));
            }

            conn.close();

        }catch(Exception e){
            System.out.println(e);
        }

        return user;
    }



    public void insertNewUser(GeneralUser newUser){

        Connection conn = AWSConnection.establishDatabaseConnection();

        try{
            Statement st = conn.createStatement();
            st.execute("insert into User (firstName, lastName, email, dateOfBirth, userType) values('" + newUser.getFirstName()
                    + "', '" + newUser.getLastName() + "', '" + newUser.getEmail() + "', '" + newUser.getDateOfBirth()
                    + "', " + newUser.getUserType() + ")");

            conn.close();

        }catch(Exception e){
            System.out.println(e);
        }

    }


    public void deleteUser(String strUserID){

        Connection conn = AWSConnection.establishDatabaseConnection();

        int userID = Integer.parseInt(strUserID);

        try{
            Statement st = conn.createStatement();
            st.execute("delete from User where userID=" + userID);

            conn.close();
        }catch(Exception e){
            System.out.println(e);
        }

        //Also delete their image from the database
        AWSImageAccess awsIA = new AWSImageAccess();
        awsIA.deleteImageFromMySQL(userID);

        //Also delete their hash from the database
        AWSPasswordAccess awsPA = new AWSPasswordAccess();
        awsPA.deleteHash(userID);
    }



    //+++++++++
    // CODE FOR ADMIN ACCOUNTS BELOW
    //+++++++++


    public void insertAdmin(GeneralUser admin){

        Connection conn = AWSConnection.establishDatabaseConnection();

        try{
            Statement st = conn.createStatement();
            st.execute("insert into User (orgID, firstName, lastName, email, phone, dateOfBirth, gender, userType) values ("+ admin.getOrgID()
                    +", '"+ admin.getFirstName() +"', '"+ admin.getLastName() +"', '"+ admin.getEmail() +"', '"+ admin.getPhone() +"', '"+ admin.getDateOfBirth()
                    +"', '"+ admin.getGender() +"', "+ admin.getUserType() +")");

            conn.close();

        }catch(Exception e){
            System.out.println(e);
        }

    }



    public GeneralUser retrieveAdmin(String inputEmailAddress){
        GeneralUser admin = new GeneralUser();
        Connection conn = AWSConnection.establishDatabaseConnection();

        try{
            Statement st = conn.createStatement();
            ResultSet rs;

            rs = st.executeQuery("select * from User where email='"+ inputEmailAddress +"'"); //SQL
            while (rs.next()){
                admin.setUserID(rs.getInt("userID"));
                admin.setOrgID(rs.getInt("orgID"));
                admin.setFirstName(rs.getString("firstName"));
                admin.setLastName(rs.getString("lastName"));
                admin.setEmail(rs.getString("email"));
                admin.setPhone(rs.getString("phone"));
                admin.setDateOfBirth(rs.getString("dateOfBirth"));
                admin.setGender(rs.getString("gender"));
                admin.setUserType(rs.getInt("userType"));
            }

            conn.close();

        }catch(Exception e){
            System.out.println(e);
        }

        return admin;
    }



    public GeneralUser retrieveSingleEmployee(int userID){
        GeneralUser employee = new GeneralUser();
        Connection conn = AWSConnection.establishDatabaseConnection();

        try{
            Statement st = conn.createStatement();
            ResultSet rs;

            rs = st.executeQuery("select * from User where userID="+ userID); //SQL
            while (rs.next()){
                employee.setUserID(rs.getInt("userID"));
                employee.setOrgID(rs.getInt("orgID"));
                employee.setFirstName(rs.getString("firstName"));
                employee.setLastName(rs.getString("lastName"));
                employee.setEmail(rs.getString("email"));
                employee.setPhone(rs.getString("phone"));
                employee.setDateOfBirth(rs.getString("dateOfBirth"));
                employee.setGender(rs.getString("gender"));
                employee.setUserType(rs.getInt("userType"));
            }

            conn.close();

        }catch(Exception e){
            System.out.println(e);
        }

        return employee;
    }



    private ArrayList<GeneralUser> retrieveAllUsers(){

        Connection conn = AWSConnection.establishDatabaseConnection();
        ArrayList<GeneralUser> userList = new ArrayList();

        try{
            Statement st = conn.createStatement();
            ResultSet rs;

            rs = st.executeQuery("select * from User"); //SQL

            //loop through each user from the database
            while (rs.next()){

                //blank user
                GeneralUser user = new GeneralUser();

                //assign attributes
                user.setUserID(rs.getInt("userID"));
                user.setOrgID(rs.getInt("orgID"));
                user.setFirstName(rs.getString("firstName"));
                user.setLastName(rs.getString("lastName"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setDateOfBirth(rs.getString("dateOfBirth"));
                user.setGender(rs.getString("gender"));
                user.setUserType(rs.getInt("userType"));

                //add to the array list
                userList.add(user);
            }

            conn.close();

        }catch(Exception e){
            System.out.println(e);
        }

        return userList;
    }


    public ArrayList<GeneralUser> getEmployees(int orgID){

        //obtain all users
        ArrayList<GeneralUser> userList = retrieveAllUsers();

        //array of employees to be returned
        ArrayList<GeneralUser> employeeList = new ArrayList();

        //loop through all users, and add correct employees to the list
        for(GeneralUser user : userList){
            if(user.getOrgID() == orgID){
                employeeList.add(user);
            }
        }

        return employeeList;
    }



    public void editEmployee(GeneralUser editUser){

        Connection conn = AWSConnection.establishDatabaseConnection();

        try{
            Statement st = conn.createStatement();
            st.execute("update User set firstName='" + editUser.getFirstName()+"', lastName='" + editUser.getLastName()
                    + "', email='" + editUser.getEmail() + "', phone='" + editUser.getPhone() + "', gender='" + editUser.getGender()
                    + "', dateOfBirth='" + editUser.getDateOfBirth() + "' where userID=" + editUser.getUserID());

            conn.close();
        }catch(Exception e){
            System.out.println(e);
        }
    }




}
