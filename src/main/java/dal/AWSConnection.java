package dal;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;

import java.sql.Connection;
import java.sql.DriverManager;

public class AWSConnection {

    //Establish connection with the remote Amazon Web Services MySQL Database
    //Code adapted from 3rd year Java Project
    public static Connection establishDatabaseConnection(){

        Connection conn = null;

        try{
            String driver = "com.mysql.cj.jdbc.Driver";
            String path = "jdbc:mysql://test.cxhq3iwt6hbg.eu-west-1.rds.amazonaws.com:3306/test?useTimeZone=true&serverTimezone=UTC&autoReconnect=true&useSSL=false";
            //Arguments appended to the AWS url above prevent "file tampering / password changed" error.
            //Solution found on: https://stackoverflow.com/questions/51586401/glassfish-keystore-error-after-adding-mysql-connector
            Class.forName(driver);

            conn = DriverManager.getConnection(path, "admin", "kevin2020");


        }catch(Exception e){
            System.out.println(e);
        }

        return conn; //return database connection
    }









    //OBSOLETE S3 CODE, must be removed


    //Establish a connection to AWS S3
    public AmazonS3 connectToS3(){

        AmazonS3 s3 = AmazonS3ClientBuilder.defaultClient();

        //OR

        //Establish connection to S3
//        AmazonS3 s3 = AmazonS3ClientBuilder
//                .standard()
//                .withRegion(Regions.EU_WEST_1)
//                .build();

        //OR

//        AWSCredentials credentials = new BasicAWSCredentials("public-key","secret-key");
//        AmazonS3 s3 = AmazonS3ClientBuilder
//                .standard()
//                .withCredentials(new AWSStaticCredentialsProvider(credentials))
//                .withRegion(Regions.EU_WEST_1)
//                .build();

        return s3;
    }
}
