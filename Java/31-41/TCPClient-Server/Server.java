import java.io.*;
import java.net.*;

public class Server {
    public static void main(String[] args) throws Exception {

        ServerSocket server = new ServerSocket(5000);
        System.out.println("Waiting for client...");

        Socket socket = server.accept();

        BufferedReader br =
                new BufferedReader(
                        new InputStreamReader(socket.getInputStream()));

        System.out.println("Client: " + br.readLine());

        socket.close();
        server.close();
    }
}