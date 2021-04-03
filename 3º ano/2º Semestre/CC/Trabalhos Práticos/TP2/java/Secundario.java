import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.Socket;
import java.net.SocketException;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class Secundario implements Runnable {
    
    ConcurrentHashMap<Integer, Socket> hmap;
    ConcurrentHashMap<Integer, Integer> hmapPedidos ; //map IdSessao-Socket
    ConcurrentHashMap<Integer, Integer> hmapDados ; //map IdSessao-Socket
    byte[] key = { 0x74, 0x68, 0x69, 0x73, 0x49, 0x73, 0x41, 0x53, 0x65, 0x63, 0x72, 0x65, 0x74, 0x4b, 0x65, 0x79 };
    
    
    public Secundario (ConcurrentHashMap<Integer, Socket> m, ConcurrentHashMap<Integer, Integer> p,  ConcurrentHashMap<Integer, Integer> d) {
        this.hmap = m;
        this.hmapPedidos = p; 
        this.hmapDados= d ;
    }
    
    
    @Override
    public void run() {
        System.console().writer().println("Secundario - A arrancar");
        byte[] buf = new byte[1200];
        DatagramSocket ds = null;
        
        
        try {
            ds = new DatagramSocket(6666);
        } catch (SocketException ex) {
            Logger.getLogger(Secundario.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        
        while(true){                  
            try {
                DatagramPacket dp = new DatagramPacket(buf, 1200);  
                ds.receive(dp);  
                byte [] bufDectipt = Decrypt(buf);
                PDU pdu = (PDU)bytetoobj(bufDectipt);
                
   
            if(pdu.ack==1){ //se for um ack  
                if (pdu.dados==1){ //ack de dados, logo hmap dados
                    hmapDados.put(pdu.getUniqueid(),pdu.getPos());    
                } 
                if (pdu.dados==0){ //ack de pedidos, logo hmap pedidos
                    hmapPedidos.put(pdu.getUniqueid(),pdu.getPos());
                }
            }    
        
            else{ //se nao for ack, é dados ou pedido     
                if(pdu.dados == 1){   // tipo 1 quer dizer que somos o anon ligado ao cliente, logo isto é para enviar ao cliente -  entao é dados
                    SecundarioWorker1 sec1 = new SecundarioWorker1(pdu,hmap);
                    Thread t1 = new Thread(sec1);                     
                    t1.start();   
                }               
                if(pdu.dados == 0){ //tipo 2 quer dizer que somos o anon ligado ao target, entao temos de enviar isto ao target - entao é pedido
                    SecundarioWorker2 sec2 = new SecundarioWorker2(pdu,hmapPedidos, hmapDados);
                    Thread t2 = new Thread(sec2);  //nova thread
                    t2.start();  //run
                }  
            }    
 
            } catch (Exception ex) {
                Logger.getLogger(Secundario.class.getName()).log(Level.SEVERE, null, ex);
                //ds.close();
                System.console().writer().println("Secundario - A falecer");
            } 
        }
    }


    public static Object bytetoobj(byte[] bytes) throws IOException, ClassNotFoundException {
    ByteArrayInputStream byteStream = new ByteArrayInputStream(bytes);
    ObjectInputStream objStream = new ObjectInputStream(byteStream);
    return objStream.readObject();
}
    
    
    public  byte[] Encrypt(byte[] array){
        byte [] encryptedData = null;
        try {
            Cipher c = Cipher.getInstance("AES");
            SecretKeySpec k = new SecretKeySpec(this.key, "AES");
            c.init(Cipher.ENCRYPT_MODE, k);
            encryptedData = c.doFinal(array);
            
        } catch (Exception ex) {
            Logger.getLogger(SecundarioWorker1.class.getName()).log(Level.SEVERE, null, ex);
        }
        return encryptedData;
    }
    
    
    public  byte[] Decrypt(byte[] array){
        byte[] data = null;
        try {
            Cipher c = Cipher.getInstance("AES");
            SecretKeySpec k = new SecretKeySpec(this.key, "AES");
            c.init(Cipher.DECRYPT_MODE, k);
            data = c.doFinal(array);   
        } catch (Exception ex) {
            Logger.getLogger(SecundarioWorker1.class.getName()).log(Level.SEVERE, null, ex);
        } 
        return data;
    }
     
}