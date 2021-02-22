package Cliente;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;

public class Notifier implements Runnable {

    private Socket socket;

    public Notifier(Socket s) {
        this.socket = s;
    }

    public void run(){
        String s;
        try {
            BufferedReader input = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            while ((s = input.readLine()) != null) {
                if (s.equals("STOP")) break;
                System.out.println();
                System.out.println(s);
                System.out.println();
            }
            socket.shutdownInput();
            socket.shutdownOutput();
            socket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
