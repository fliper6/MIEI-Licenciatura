package Servidor;

import java.io.PrintWriter;
import java.net.Socket;

public class SendNotification implements Runnable {
    private PrintWriter out;
    private String notif;

    public SendNotification(PrintWriter out, String s){
        this.out = out;
        this.notif = s;
    }

    public void run(){
        out.println(notif);
        out.flush();
    }
}
