import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;

public class Servidor {
    public static void main(String[] args) throws IOException {
        ServerSocket sSock = new ServerSocket(12345);
        Shuttle s = new Shuttle();

        while(true){
            Socket cSock = sSock.accept();
            ServerWorker worker = new ServerWorker(cSock,s);
            Thread t = new Thread(worker);
            t.start();
        }
    }
}
