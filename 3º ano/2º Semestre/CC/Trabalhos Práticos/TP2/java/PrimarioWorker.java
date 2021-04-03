import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.ObjectOutputStream;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.Socket;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;


public class PrimarioWorker implements Runnable {
    private BufferedReader in;
    String Target; 
    String Peer; 
    int uniqueid;
    int porta;
    ConcurrentHashMap<Integer, Integer> hmapPedidos ; //map IdSessao-Socket
    ConcurrentHashMap<Integer, Integer> hmapDados ; //map IdSessao-Socket
    byte[] key = { 0x74, 0x68, 0x69, 0x73, 0x49, 0x73, 0x41, 0x53, 0x65, 0x63, 0x72, 0x65, 0x74, 0x4b, 0x65, 0x79 };
    
    public PrimarioWorker (Socket s, String t,int port, String peer, int id,ConcurrentHashMap<Integer, Integer> p, ConcurrentHashMap<Integer, Integer> d) throws IOException{
        this.in = new BufferedReader(new InputStreamReader(s.getInputStream()));
        this.Target = t;
        this.Peer = peer;
        this.uniqueid = id;
        this.hmapDados=d;
        this.hmapPedidos=p;
        this.porta=port;

    }
    
    
    @Override
    public void run() {

        try {        
            hmapPedidos.put(uniqueid, -1);
            ArrayList<PDU> pacotes=pacotify(in);
            DatagramSocket ds = new DatagramSocket();
            InetAddress PeerIp = InetAddress.getByName(this.Peer);
                       
            for(int a=0;a<pacotes.size();a++){
                byte[] temp;
                temp = objtobytes(pacotes.get(a));
                byte[] sneakyTemp = Encrypt(temp);

                DatagramPacket dp = new DatagramPacket(sneakyTemp, sneakyTemp.length, PeerIp, 6666);
                ds.send(dp);
                while(hmapPedidos.get(pacotes.get(a).uniqueid) != a){
                    //TimeUnit.MILLISECONDS.sleep(10);   
                }
            }
            System.console().writer().println("PrimarioWorker - Enviei os pacotes todos por UDP para o anonGW peer");
            hmapPedidos.remove(pacotes.get(0).uniqueid);
            
            ds.close();
             
            
        } catch (Exception ex) {
            Logger.getLogger(PrimarioWorker.class.getName()).log(Level.SEVERE, null, ex);
        }   
    }      


    public ArrayList<PDU> pacotify (BufferedReader in) throws IOException, InterruptedException{
        
        ArrayList<PDU> lista = new ArrayList<>() ;
        int control = 0;
        int poss = 0;
        char [] buffer = new char[869];
        int read = in.read(buffer,0,869);        
        while ( control ==0){
            PDU pdu = new PDU();
            pdu.port=this.porta;
            pdu.peerIp = InetAddress.getByName (this.Peer);
            pdu.data = new String(buffer).getBytes();
            pdu.originalIp = InetAddress.getByName(getMyIp());
            pdu.setUniqueid(this.uniqueid);
            pdu.setTargetIp(InetAddress.getByName(this.Target));
            pdu.pos = poss;
            poss++;
            buffer = new char[869];
            TimeUnit.MILLISECONDS.sleep(1); 
            if(read!=869) {
                    pdu.last = 1;
                    control=-1;
            }
            else{
                read = in.read(buffer,0,869);
                buffer = new char[869];
            }
            lista.add(pdu);
        }
        return lista;   
    }

    public static String getMyIp() throws SocketException {
        return Collections.list(NetworkInterface.getNetworkInterfaces()).stream()
            .flatMap(i -> Collections.list(i.getInetAddresses()).stream())
            .filter(ip -> ip instanceof Inet4Address && ip.isSiteLocalAddress())
            .findFirst().orElseThrow(RuntimeException::new)
            .getHostAddress();
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





