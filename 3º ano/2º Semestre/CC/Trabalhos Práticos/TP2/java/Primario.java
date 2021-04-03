import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;



public class Primario implements Runnable{
    String   Target; 
    int   Porta;
    String[] Peers;  
    ConcurrentHashMap<Integer, Socket> hmap;
    ConcurrentHashMap<Integer, Integer> hmapPedidos ; //map IdSessao-Socket
    ConcurrentHashMap<Integer, Integer> hmapDados ; //map IdSessao-Socket
    byte[] key = { 0x74, 0x68, 0x69, 0x73, 0x49, 0x73, 0x41, 0x53, 0x65, 0x63, 0x72, 0x65, 0x74, 0x4b, 0x65, 0x79 };
    
    
    
    public Primario (String  t, String port, String[] P,  ConcurrentHashMap< Integer, Socket> m, ConcurrentHashMap<Integer, Integer> p, ConcurrentHashMap<Integer, Integer> d) {
        this.Target = t;
        this.Peers = P;
        this.Porta = Integer.valueOf(port);
        this.hmap = m;
        this.hmapDados=d;
        this.hmapPedidos=p;
    }
    
    
    @Override
    public void run () {
        System.console().writer().println("Primario - A arrancar");
        
        try {
            int i=0; //para ir correndo os peers
            ServerSocket server = new ServerSocket(Porta);
            Socket socket;

            while(true){  
                
                socket = server.accept();
                int uniqueID = (int)(Math.random()*  (99999999 + 1) +1); //uniqueid
                System.console().writer().println("Primario - Sessao com id  "+uniqueID+" inciada");
                hmap.put(uniqueID,socket);
                PrimarioWorker prim = new PrimarioWorker(socket,this.Target,this.Porta,this.Peers[i],uniqueID,this.hmapPedidos,this.hmapDados); 
                Thread t = new Thread(prim);                   
                t.start(); 
                i++;
                if (i==Peers.length) i=0;
            }
        } catch (IOException ex) {
            Logger.getLogger(Primario.class.getName()).log(Level.SEVERE, null, ex);
            System.console().writer().println("Primario - A falecer");  
        }
          
    }
     
    

    
}

