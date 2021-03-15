package dal;

import bll.PasswordImage;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.Buffer;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

public class ImageHash {

    //******************************************************************************
    //******************************************************************************

    // This code was adapted from these sources:
    // Hashing Creation: https://howtodoinjava.com/java/java-security/how-to-generate-secure-password-hash-md5-sha-pbkdf2-bcrypt-examples/
    // Image to Byte Array: https://www.tutorialspoint.com/How-to-convert-Image-to-Byte-Array-in-java
    // IO Error Handling: https://stackoverflow.com/questions/18309868/imageio-iioexception-cant-read-input-file
    //Convert to bufferedImage: https://stackoverflow.com/questions/30751964/how-to-convert-blob-to-image-to-display-it-on-a-jlabel-in-java
    //Image 'cutting' code adapted from: https://gist.github.com/madan712/3672616
    //Combining images in Array: http://jens-na.github.io/2013/11/06/java-how-to-concat-buffered-images/
    //******************************************************************************
    //******************************************************************************

    public String generateImageHash(String tileArray, PasswordImage passImage){

        //String to hold hash value
        String outputHash = "Kevin's Test";

        //An array of all the tile segments
        BufferedImage[] allTiles = getImageTiles(tileArray, passImage);

        //Concat of all tiles
        BufferedImage concatImage = concatTiles(allTiles);

        //Hash Value generated
        outputHash = createHash(concatImage);
        return outputHash;
    }




    public BufferedImage[] getImageTiles(String tileArray, PasswordImage passImage) {

        //get the image as a Blob
        Blob blob = passImage.getImageFile();
        BufferedImage image = null;

        //convert Blob to a BufferedImage
        try{
            InputStream inpStr = blob.getBinaryStream();
            image = ImageIO.read(inpStr);

        }catch (IOException | SQLException ex){
            System.out.println(ex.toString());
        }

        //Get dimensions of image
        int imageWidth = image.getWidth();
        int imageHeight = image.getHeight();

        //number of rows and columns
        int rows = 16;
        int columns = 16;

        //dimensions of each tile
        int tileWidth = imageWidth / columns;
        int tileHeight = imageHeight / rows;

        //tile positioning variables
        int x = 0;
        int y = 0;

        //List of individually selected tiles co-ordinates
        List<String> list = Arrays.asList(tileArray.split(","));
        int arrayCount = list.size(); //total number of selections

        //Buffered Image Array to hold the image tiles
        BufferedImage[] bImgArray = new BufferedImage[arrayCount];

        //Loop through all the tiles
        for (int i = 0; i < arrayCount; i++){
            String[] tileLocation;
            tileLocation = list.get(i).split("-");

            //identify the row/column of the current tile
            int tileRow = Integer.parseInt(tileLocation[0]);
            int tileColumn = Integer.parseInt(tileLocation[1]);

            //get the pixels of the upper left corner of each tile
            //i.e. this tiles upper corner could be positioned at 260x440px
            x = (tileColumn - 1) * tileWidth;
            y = (tileRow - 1) * tileHeight;

            //get the entire tile as its own BufferImage
            BufferedImage subImage = image.getSubimage(x, y, tileWidth, tileHeight);
            bImgArray[i] = subImage; //add tile to an array
        }

        return  bImgArray;
    }





    public BufferedImage concatTiles(BufferedImage[] tiles){

        //all the images tiles (segments) will be combined
        //into a single larger image, this will then be hashed.

        //variable to hold the 'concatenated' image adn width
        BufferedImage concatImage = null;
        int tileWidth = tiles[0].getWidth();

        //find the total height
        int combinedHeights = 0;
        for(int x = 0; x < tiles.length; x++) {
            combinedHeights += tiles[x].getHeight();
        }

        //incremental height variable
        int heightCurr = 0;

        //new image dimensions
        concatImage = new BufferedImage(tileWidth, combinedHeights, BufferedImage.TYPE_INT_RGB);

        //add images from the array into new concatenated image
        Graphics2D g2d = concatImage.createGraphics();
        for(int i = 0; i < tiles.length; i++) {
            g2d.drawImage(tiles[i], 0, heightCurr, null);
            heightCurr += tiles[i].getHeight();
        }
        g2d.dispose();

        return concatImage;
    }







    public String createHash(BufferedImage bImage){

        byte[] data;
        String generatedHash = null;

        try {
            //take the input image and put its bytes into the 'data' array
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            ImageIO.write(bImage, "jpg", bos);
            data = bos.toByteArray();

            try {
                // Create MessageDigest instance
                MessageDigest md = MessageDigest.getInstance("SHA-256");
                //Add image bytes to the digest and get the hash's bytes
                byte[] bytes = md.digest(data);
                //This bytes[] has bytes in decimal format;
                //Convert it to hexadecimal format
                StringBuilder sb = new StringBuilder();
                for(int i=0; i< bytes.length ;i++)
                {
                    sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
                }
                //Get complete hashed image in hex format
                generatedHash = sb.toString();

            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
                System.out.println("***************Hashing Error*************");
            }

        }catch (Exception e){
            System.out.println(e);
            System.out.println("***************Image Input Error*************");
        }

        return generatedHash; //Return the completed Hash of the image
    }

}
