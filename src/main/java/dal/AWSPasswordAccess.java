package dal;

import bll.GeneralUser;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class AWSPasswordAccess {


    public void storeHash(GeneralUser user, String inputHash){
        Connection conn = AWSConnection.establishDatabaseConnection();

        try{
            Statement st = conn.createStatement();
            st.execute("insert into Password (hash, userID) values ('" + inputHash + "', " + user.getUserID() + ");");
            conn.close();
        }catch(Exception e){
            System.out.println(e);
        }
    }


    public String retrieveHash(GeneralUser user){

        String hash = null;
        Connection conn = AWSConnection.establishDatabaseConnection();

        try{
            Statement st = conn.createStatement();
            ResultSet rs;

            rs = st.executeQuery("select * from Password where userID=" + user.getUserID());
            while (rs.next()){
                hash = rs.getString("hash");
            }
            conn.close();

        }catch(Exception e){
            System.out.println(e);
        }

        return hash;
    }


    public boolean compareHash(GeneralUser user, String inputHash){

        boolean correctMatch = false;

        //retrieve the users hash from retrieveHash() above
        String dbHash = retrieveHash(user);

        //compare to input Hash
        if(dbHash.equals(inputHash)){
            correctMatch = true;
        }

        //return boolean result
        return correctMatch;
    }


    public void deleteHash(int userID){

        Connection conn = AWSConnection.establishDatabaseConnection();

        try{
            Statement st = conn.createStatement();
            st.execute("delete from Password where userID=" + userID);

            conn.close();
        }catch(Exception e){
            System.out.println(e);
        }
    }



    //FORGOT PASSWORD

    public void saveMessage(int userID, int orgID){
        Connection conn = AWSConnection.establishDatabaseConnection();

        try{
            Statement st = conn.createStatement();
            st.execute("insert into Message (userID, orgID) values (" + userID + ", " + orgID + ");");
            conn.close();
        }catch(Exception e){
            System.out.println(e);
        }
    }


    public ArrayList<GeneralUser> retrieveMessages(int orgID, ArrayList<GeneralUser> employees){

        Connection conn = AWSConnection.establishDatabaseConnection();
        ArrayList<GeneralUser> employeeMessages = new ArrayList();

        try{
            Statement st = conn.createStatement();
            ResultSet rs;

            rs = st.executeQuery("select * from Message where orgID=" + orgID);
            while (rs.next()){

                //for each employee search for matching message
                for(int i = 0; i < employees.size(); i++){
                    if(rs.getInt("userID") == employees.get(i).getUserID()){
                        //add the employee to the list
                        employeeMessages.add(employees.get(i));
                    }
                }

            }
            conn.close();

        }catch(Exception e){
            System.out.println(e);
        }

        return employeeMessages;
    }


    public void deleteMessage(int userID){

        Connection conn = AWSConnection.establishDatabaseConnection();

        try{
            Statement st = conn.createStatement();
            st.execute("delete from Message where userID=" + userID);

            conn.close();
        }catch(Exception e){
            System.out.println(e);
        }
    }


}
