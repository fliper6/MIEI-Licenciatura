import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.ObjectOutputStream;
import java.io.OutputStreamWriter;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class SecundarioWorker2 implements Runnable {

//fala com o target server, processa o ficheiro e envia de volta por udp
    PDU pdu;
    private BufferedWriter out;
    private InputStream in;
    ConcurrentHashMap<Integer, Integer> hmapPedidos ; //map IdSessao-Socket
    ConcurrentHashMap<Integer, Integer> hmapDados ; //map IdSessao-Socket    
    int UID;
    InetAddress tip;
    InetAddress peer;
    byte[] key = { 0x74, 0x68, 0x69, 0x73, 0x49, 0x73, 0x41, 0x53, 0x65, 0x63, 0x72, 0x65, 0x74, 0x4b, 0x65, 0x79 };
    
    public SecundarioWorker2(PDU  pu,ConcurrentHashMap<Integer, Integer> p, ConcurrentHashMap<Integer, Integer> d) {
        this.pdu = pu;
        this.hmapDados=d;
        this.hmapPedidos=p; 
    }       
                
    
    
    @Override
    public void run() { //isto "executa" o comando e manda de volta por udp, é preciso

        try {
            InetAddress ip = this.pdu.targetIp;      
            this.tip=ip;
            this.peer=pdu.peerIp;
            Socket socket = new Socket (ip,pdu.port);                                                               
            this.out = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));          
            this.in = socket.getInputStream(); 
            this.UID = pdu.uniqueid;         
            out.write(new String(pdu.data));                                                          
            out.flush();  
            
            enviarACKpedido(pdu);
  
            if(pdu.pos==0){
                System.console().writer().println("SecundarioWorker2 - Vou tratar da sessão " + pdu.uniqueid);
            }
            
            if(pdu.last==1){ // se for o last entao temos que ler a resposta do target server, pacotify e enviar 1 a 1 ao anon1               
                hmapDados.put(this.UID, -1);
                DatagramSocket ds = new DatagramSocket();  
                InetAddress iporigem = pdu.originalIp;
                ArrayList<PDU> pacotes=pacotify(in);         
                
                
                for (int a=0;a<pacotes.size();a++){
                    byte[] send = objtobytes (pacotes.get(a)) ;
                    byte[] sendSneaky= Encrypt(send);
                    DatagramPacket dp = new DatagramPacket(sendSneaky, sendSneaky.length, iporigem, 6666);
                    ds.send(dp);     
                    while(hmapDados.get(pacotes.get(a).uniqueid) != a){ //esperar pelos ack
                        //TimeUnit.MILLISECONDS.sleep(10);                          
                    }
                }
                hmapDados.remove(pacotes.get(0).uniqueid);
                System.console().writer().println("SecundarioWorker2 - Enviei os pacotes todos por UDP da sessao " + pdu.uniqueid);
            }         

        } catch (Exception e) {
            Logger.getLogger(SecundarioWorker2.class.getName()).log(Level.SEVERE, null, e);
        }
    }
    
    public static byte[] objtobytes(Object obj) throws IOException {
    ByteArrayOutputStream asd = new ByteArrayOutputStream();
    ObjectOutputStream os = new ObjectOutputStream(asd);
    os.writeObject(obj);
    return asd.toByteArray();
}
    
    
    
    
    public void enviarACKpedido(PDU pdu){
        try {
            DatagramSocket ds = new DatagramSocket();
            InetAddress ip = pdu.originalIp;
            PDU pduAck = new PDU();
            pduAck.ack=1;
            pduAck.dados=0;
            pduAck.pos=pdu.pos;
            pduAck.uniqueid=pdu.uniqueid;
            byte[] byteAck = objtobytes(pduAck);
            byte[] byteAckSneaky = Encrypt(byteAck);
            DatagramPacket dp = new DatagramPacket(byteAckSneaky, byteAckSneaky.length, ip, 6666);
            ds.send(dp);
            
            
        } catch (Exception ex) {Logger.getLogger(SecundarioWorker2.class.getName()).log(Level.SEVERE, null, ex);}
        
    }
    
 public ArrayList<PDU> pacotify (InputStream in) throws IOException, InterruptedException{
        
        ArrayList<PDU> lista = new ArrayList<>() ;
        int control = 0;
        int poss = 0;
        byte [] buffer = new byte[869];      
        int read = in.read(buffer,0,869);      
        while ( control ==0){

            PDU pdu = new PDU();
            pdu.dados=1;
            pdu.targetIp=tip;
            pdu.peerIp=this.peer;
            
            pdu.data = buffer;
            pdu.setUniqueid(this.UID);
            pdu.pos = poss;
            poss++;
            TimeUnit.MILLISECONDS.sleep(1);  
            if(read!= 869) {
                    pdu.last = 1;
                    control=-1;
                    
                    byte[] slice =  Arrays.copyOfRange(buffer, 0, read);
                    pdu.data = slice;
            }
            else{
                buffer = new byte[869];
                read = in.read(buffer,0,869);
            }

            
            
            lista.add(pdu);
        }
        return lista;   
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
