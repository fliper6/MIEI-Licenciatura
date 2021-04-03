import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.logging.Level;
import java.util.logging.Logger;


public  class PDU implements java.io.Serializable {                        
    int dados;                            
    int last;                           
    int uniqueid; 
    int port;             
    InetAddress targetIp;                 
    InetAddress originalIp;               
    InetAddress peerIp;
    int ack;                               
    int pos;                                
    byte[] data = new byte[869]  ;        
                                         
      

    
    public PDU() {
        try {
            this.port=0;
            this.dados = 0;
            this.last = 0;
            this.uniqueid =  0;
            this.targetIp = InetAddress.getByName("0.0.0.0");
            this.originalIp = InetAddress.getByName("0.0.0.0");
            this.peerIp = InetAddress.getByName("0.0.0.0");
            this.ack = 0;
            this.pos = 0;
            this.data = new byte[869];
        } catch (UnknownHostException ex) {
            Logger.getLogger(PDU.class.getName()).log(Level.SEVERE, null, ex);
        }     
    }

    public void setDados(int dados) {
        this.dados = dados;
    }

    public void setLast(int last) {
        this.last = last;
    }

    public void setUniqueid(int uniqueid) {
        this.uniqueid = uniqueid;
    }

    public void setTargetIp(InetAddress targetIp) {
        this.targetIp = targetIp;
    }

    public void setOriginalIp(InetAddress originalIp) {
        this.originalIp = originalIp;
    }

    public void setChecksum(int ack) {
        this.ack = ack;
    }

    public void setPos(int pos) {
        this.pos = pos;
    }

    public void setData(byte[] data) {
        this.data = data;
    }

    public int getDados() {
        return dados;
    }

    public int getLast() {
        return last;
    }

    public int getUniqueid() {
        return uniqueid;
    }

    public InetAddress getTargetIp() {
        return targetIp;
    }

    public InetAddress getOriginalIp() {
        return originalIp;
    }

    public int getAck() {
        return ack;
    }

    public int getPos() {
        return pos;
    }

    public byte[] getData() {
        return data;
    }            
}
