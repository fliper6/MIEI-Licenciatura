import java.net.Socket;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;


public class anonGW {
    String[] TargetSv; //[0]=target server [1] target port 
    String[] Peers;  // peers, um por posição, tamanho variável
    ConcurrentHashMap<Integer, Socket> hmap ; //map IdSessao-Socket
    ConcurrentHashMap<Integer, Integer> hmapPedidos ; //map IdSessao-Socket
    ConcurrentHashMap<Integer, Integer> hmapDados ; //map IdSessao-Socket
    
    
    
    public anonGW(int n) {     
        this.TargetSv = new String[2];
        this.Peers = new String[n];
        this.hmap = new ConcurrentHashMap<>();
        this.hmapPedidos = new ConcurrentHashMap<>();
        this.hmapDados = new ConcurrentHashMap<>();
    }
    
    
    
    public static void main(String[] args){   
        try{
            anonGW obj = new anonGW(args.length - 5); 
            obj.TargetSv[0] = args[1];  //ip                   
            obj.TargetSv[1] = args[3];  //porta             
            for(int i =0;i<obj.Peers.length; i++){
                obj.Peers[i] = args[i+5];
            }
            obj.abc (args);
        }
        catch (Exception e){
            System.console().writer().println("What args thoooooose");
        }
    }    

    
    
    public void abc (String[] args) throws Exception{
        
        System.console().writer().println("AnonGW - A arrancar");
        
        //arrancar uma thread de primário
        Primario prim = new Primario(this.TargetSv[0],  this.TargetSv[1], this.Peers, this.hmap, this.hmapPedidos, this.hmapDados); 
        Thread p = new Thread(prim);  
        p.start();                      
             
        
        //arrancar uma thread de secundario
        Secundario sec = new Secundario( this.hmap, this.hmapPedidos, this.hmapDados); 
        Thread s = new Thread(sec);   
        s.start();

        
        
      
        //esperar que as childs morram, ou seja, nunca
        p.join();
        System.console().writer().println("AnonGW - Primario is dead");
        
        s.join();
        System.console().writer().println("AnonGW - Long live the king");
        
        
        System.console().writer().println("AnonGW - A falecer");
        
    } 
}