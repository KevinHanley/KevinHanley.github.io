package dal;
import bll.GeneralUser;
import bll.PasswordImage;
import com.amazonaws.services.s3.model.S3Object;
import com.amazonaws.services.s3.model.S3ObjectInputStream;
import dal.AWSConnection;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.SdkClientException;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;
import java.sql.*;
import java.util.Base64;

public class AWSImageAccess {

    //******************************************************************************************************************
    //******************************************************************************************************************
    // Connect to AWS MySQL
    //******************************************************************************************************************
    //******************************************************************************************************************


    public void uploadImageToMySQL(String fileName, BufferedImage uploadedImage, GeneralUser user) throws IOException {

        // InputStream Code: https://stackoverflow.com/questions/7645068/how-can-i-convert-a-bufferedimage-object-into-an-inputstream-or-a-blob
        // Prepared Statement: https://www.codeproject.com/Questions/1136841/JSP-how-to-convert-BLOB-from-mysql-into-bufferedim

        Connection conn = AWSConnection.establishDatabaseConnection();

        //Get user id for Database
        int userID = user.getUserID();


        //get file as inputStream
        ByteArrayOutputStream outStream = new ByteArrayOutputStream();
        ImageIO.write(uploadedImage, "jpg", outStream);
        InputStream inStream = new ByteArrayInputStream(outStream.toByteArray());

        //Send SQL to database
        try{
            String mySQL = "insert into Image (imageName, imageFile, userID) values (?,?,?)";
            PreparedStatement prepStat = conn.prepareStatement(mySQL);

            prepStat.setString(1, fileName);
            prepStat.setBlob(2, inStream);
            prepStat.setInt(3, userID);

            prepStat.execute();

            conn.close();

        }catch(Exception e){
            System.out.println(e);
        }

    }




    public void uploadUnsplashImageToMySQL(String imageID, String base64String, GeneralUser user) throws IOException {

        //Base64 String to ByteArray: https://www.baeldung.com/java-base64-image-string
        //Error "Illegal base64: https://www.prostdev.com/post/understanding-the-illegal-base64-character-error-java-groovy-and-mule-4-dw-2-0
        //Oracle getDecoder(): https://docs.oracle.com/javase/8/docs/api/java/util/Base64.html#getUrlEncoder--
        //How Base64 Works: https://stackabuse.com/encoding-and-decoding-base64-strings-in-java/
        
        Connection conn = AWSConnection.establishDatabaseConnection();

        //Get user id for Database
        int userID = user.getUserID();

        //convert base64 String to input stream
        byte[] decodedBytes = Base64.getDecoder().decode(base64String);
        InputStream inputStream = new ByteArrayInputStream(decodedBytes);


        //Send SQL to database
        try{
            String mySQL = "insert into Image (imageName, imageFile, userID) values (?,?,?)";
            PreparedStatement prepStat = conn.prepareStatement(mySQL);

            prepStat.setString(1, imageID);
            prepStat.setBlob(2, inputStream);
            prepStat.setInt(3, userID);

            prepStat.execute();

            conn.close();

        }catch(Exception e){
            System.out.println(e);
        }

    }




    public PasswordImage retrieveImageFromMySQL(int userID){

        //SQL: https://www.codeproject.com/Questions/1136841/JSP-how-to-convert-BLOB-from-mysql-into-bufferedim
        //Base64 Code: https://stackoverflow.com/questions/2438375/how-to-convert-bufferedimage-to-image-to-display-on-jsp

        //Image Object
        PasswordImage passImg = new PasswordImage();

        //Get connection
        Connection conn = AWSConnection.establishDatabaseConnection();

        try{
            Statement statement = conn.createStatement();
            ResultSet rs;

            rs = statement.executeQuery("select * from Image where userID=" + userID);

            while (rs.next()){
                //Assign database values to the image object
                passImg.setImageID(rs.getInt("imageID"));
                passImg.setImageName(rs.getString("imageName"));
                passImg.setImageFile(rs.getBlob("imageFile"));
                passImg.setUserID(rs.getInt("userID"));

                //Convert the BLOB to a Base64 Image
                Blob blob = rs.getBlob("imageFile");
                InputStream inputStream = blob.getBinaryStream();
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead = -1;

                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }

                byte[] imageBytes = outputStream.toByteArray();
                String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                //Close the streams
                inputStream.close();
                outputStream.close();

                //Assign the string to the image object
                passImg.setBase64Image(base64Image);

            }

            conn.close();

            //InputStream imgStream = resultSet.getBinaryStream(3); //add blob into InputStream
        }catch (SQLException | IOException e){
            System.out.println(e);
        }

        return passImg;
    }





    public void deleteImageFromMySQL(int userID){

        Connection conn = AWSConnection.establishDatabaseConnection();

        try{
            Statement st = conn.createStatement();
            st.execute("delete from Image where userID=" + userID);

            conn.close();
        }catch(Exception e){
            System.out.println(e);
        }
    }

}
