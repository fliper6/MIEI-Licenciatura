package Servidor;

// Imports
import Cloud.*;
import java.net.*;
import java.util.*;

public class Server {
    // Server multithreaded, uma para cada cliente.
    public static void main(String[] args) throws Exception{

        ServerSocket sSocket = new ServerSocket(12345);
        ServerSocket notific = new ServerSocket(54321);
        SoundCloud sc = new SoundCloud();

        while(true){
            Socket clSock = sSocket.accept();
            Socket clNotif = notific.accept();
            Worker worker = new Worker(clSock,sc,clNotif);
            System.out.println("CONNECTED: " + clSock.getRemoteSocketAddress());
            Thread parallelClient = new Thread(worker);
            parallelClient.start();
        }
    }
}