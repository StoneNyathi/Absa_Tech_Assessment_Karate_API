package karatepoc.bolt;
import java.io.*;

public class AutheticationTokenManager {
    private String tokenFileLocation = "src/test/feature/api/TokenStore/api.security.token.txt";

    public void saveAuthToken(String tokenFromGetSecurityToken) {
        try {
            FileOutputStream fileOS = new FileOutputStream(tokenFileLocation);
            fileOS.write(tokenFromGetSecurityToken.getBytes());
            fileOS.close();
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
    }
}
