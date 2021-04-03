import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.Socket;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class SecundarioWorker1 implements Runnable {

//fala com o target server, processa o ficheiro e envia de volta por udp
    PDU pdu;
    ConcurrentHashMap<Integer, Socket> hmap;       
    byte[] key = { 0x74, 0x68, 0x69, 0x73, 0x49, 0x73, 0x41, 0x53, 0x65, 0x63, 0x72, 0x65, 0x74, 0x4b, 0x65, 0x79 };
    
    
    
    public SecundarioWorker1(PDU  pu,ConcurrentHashMap<Integer, Socket> m) {
        this.pdu = pu;
        this.hmap = m;   
    }       
                
    
    @Override
    public void run() {        
        try {
            int a = pdu.uniqueid;
            Socket s = hmap.get(a);
            OutputStream out =  s.getOutputStream();
            
            
            out.write( pdu.data);
            out.flush();
            
            enviaACKdados(pdu);
            if(this.pdu.last ==1){
                hmap.remove(pdu.uniqueid);
                System.console().writer().println("Secundario 1 - Sessao com id "+pdu.uniqueid+" terminada");
            }
       
        } catch (IOException ex) {
            Logger.getLogger(SecundarioWorker1.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    

    public void enviaACKdados(PDU pdu){
        try {
            DatagramSocket ds = new DatagramSocket();
            InetAddress ip = pdu.peerIp;
            PDU pduAck = new PDU();
            pduAck.ack=1;
            pduAck.dados=1;
            pduAck.pos=pdu.pos;
            pduAck.uniqueid=pdu.uniqueid;
            byte[] byteAck = objtobytes(pduAck);
            
            byte[] byteAckSneaky = Encrypt(byteAck);

            DatagramPacket dp = new DatagramPacket(byteAckSneaky, byteAckSneaky.length, ip, 6666);
            ds.send(dp);
        } catch (Exception ex) {Logger.getLogger(SecundarioWorker2.class.getName()).log(Level.SEVERE, null, ex);}  
    }
      
    public static byte[] objtobytes(Object obj) throws IOException {
    ByteArrayOutputStream asd = new ByteArrayOutputStream();
    ObjectOutputStream os = new ObjectOutputStream(asd);
    os.writeObject(obj);
    return asd.toByteArray();
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
