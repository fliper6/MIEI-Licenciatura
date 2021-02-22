package Servidor;

// Imports
import Cloud.*;
import java.io.*;
import java.net.Socket;
import java.nio.file.*;
import java.util.*;
import java.util.concurrent.locks.Condition;

public class Worker implements Runnable {

    // Variáveis de Instância
    private final String temp = "./files/servidor/";
    private final int MAXSIZE = 500*1024; // 500kb max
    private BufferedReader in;
    private PrintWriter out;
    private Socket s;
    private SoundCloud app;
    private Socket notifier;
    private PrintWriter outNotifier;

    // Construtor
    public Worker(Socket s, SoundCloud sc,Socket notifier) throws IOException {
        this.in = new BufferedReader(new InputStreamReader(s.getInputStream()));
        this.out = new PrintWriter(s.getOutputStream());
        this.s = s;
        this.app = sc;
        this.notifier = notifier;
        this.outNotifier = new PrintWriter(notifier.getOutputStream());
    }

    // fica a ler input até a conexao fechar
    public void run() {
        String input;
        while(true) {
            try {
                input=in.readLine();
                if(input == null || input.equals("q")) {
                    s.shutdownInput();
                    s.shutdownOutput();
                    s.close();
                    break;
                }
                System.out.println(s.getRemoteSocketAddress() +" >> " + input);
                parse(input);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    // dá pattern match a mensagens enviadas pelos clientes e faz operaçoes consoante a mensagem
    private void parse(String input){
        String[] partes = input.split("-",2);
        switch(partes[0]){
            case "LOGIN":
                login(partes[1]);
                break;
            case "LOGOUT":
                logout(partes[1]);
                break;
            case "REGISTER":
                register(partes[1]);
                break;
            case "UPLOAD":
                receiveFile();
                break;
            case "DOWNLOAD":
                sendFile(partes[1]);
                break;
            case "SEARCH":
                search(partes[1]);
                break;
            case "LEAVE":
                leave();
                break;
            default:
                System.out.println("Erro na mensagem: " + input);
                break;
        }
    }

    // Login: vai mandar para o "Client" se o login feito foi um sucesso ou não (username/password certas ou não)
    private void login(String s){
        String[] auth = s.split(",");
        if(app.isLogged(auth[0])) {
            out.println("DENIED_3");
            out.flush();
            return;
        }
        boolean b = app.login(auth[0],auth[1]);
        if(b) {
            out.println("LOGGEDIN-"+auth[0]);
            this.app.insertLogged(auth[0],this);
        } else
            out.println("DENIED_1-");
        out.flush();
    }

     // logout do client
    private void logout(String s){
        this.app.removeLogged(s);
    }

    // Signup: vai mandar para o "Client" se o signup feito foi um sucesso ou não (username já existia ou não)
    private void register(String s){
        String[] reg = s.split(",");
        boolean br = app.register(reg[0],reg[1]);
        if(br)
             out.println("SIGNEDUP-");
        else 
             out.println("DENIED_2-");  
        out.flush();
    }

    // Notificar users de Uploads (enviam nome + artista)
    public void notifica(String string) {
        Thread notifier = new Thread(new SendNotification(outNotifier,string));
        notifier.start();
    }

    // Envia o resultado do pedido de search para o cliente
    private void search(String s) {
        ArrayList<String> search = new ArrayList<>();
        String[] tags = s.split(",");
        for(String tag: tags){
            search.add(tag);
        }
        Set<Musica> musicas = app.filterTag(search);
        Iterator<Musica> it = musicas.iterator();
        out.println("SEARCHING-");
        out.flush();
        while(it.hasNext()) {
            Musica m = it.next();
            out.println(m.toString() + " {" +m.getDownloads()+"}");
        }
        out.println("end");
        out.flush();
    }

    // cria uma diretoria para colocar ficheiros
    private void createTempDirectory(){
        Path path1 = Paths.get(temp);
        if (!Files.exists(path1)) {
            try {
                Files.createDirectories(path1);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    // Recebe o ficheiro dado pelo cliente e os seus metadados, gerando um ID e colocando em /files/servidor/ID.mp3
    private void receiveFile(){
        createTempDirectory();
        try {
            int bytesRead;
            DataInputStream clientData = new DataInputStream(s.getInputStream());

            String fileName = clientData.readUTF();

            out.println("UPLOADING-");
            out.flush();

            String partes[] = fileName.split(",",4);
            String tags[] = partes[3].split("%");
            ArrayList<String> tagsA = new ArrayList<>();
            for (String tag : tags) {
                tagsA.add(tag);
            }

            int id = app.addMusica(new Musica(partes[0],partes[1],Integer.valueOf(partes[2]),tagsA));
            String nome = temp+id+".mp3";

            OutputStream output = new FileOutputStream(nome);
            long size = clientData.readLong();
            byte[] buffer = new byte[MAXSIZE];
            while (size > 0 && (bytesRead = clientData.read(buffer, 0, (int) Math.min(buffer.length, size))) != -1) {
                output.write(buffer, 0, bytesRead);
                size -= bytesRead;
            }

            output.close();
            app.allowMusica(id); // unlock
            out.println("UPLOADED-");
            out.flush();
        } catch (IOException ex) {
            System.err.println("Client error. Connection closed.");
        }
    }

    // Envia o ficheiro pedido pelo cliente (ID) com o nome dado pelo toString da Musica na SoundCloud
    private void sendFile(String input){
        createTempDirectory();
        try {
            String filename = app.getMusicaString(Integer.valueOf(input));
            System.out.println(filename);
            if(filename==null) {
                out.println("INVALID_ID-");
                out.flush();
                return;
            }
            out.println("DOWNLOADING-");
            out.flush();

            app.downloadMusica(Integer.valueOf(input));
            File myFile = new File(temp+input+".mp3");
            long filesize = myFile.length();
            int stop;
            byte[] mybytearray = new byte[MAXSIZE];

            FileInputStream fis = new FileInputStream(myFile);
            BufferedInputStream bis = new BufferedInputStream(fis);

            DataInputStream dis = new DataInputStream(bis);
            OutputStream os = s.getOutputStream();
            DataOutputStream dos = new DataOutputStream(os);

            dos.writeUTF(app.getMusicaString(Integer.valueOf(input)));
            dos.writeLong(filesize);
            while (filesize > 0 && (stop = dis.read(mybytearray, 0, (int) Math.min(MAXSIZE, filesize))) != -1) {
                dos.write(mybytearray, 0, stop);
                filesize -= stop;
            }
            dos.flush();
            dis.close();
            app.finished();
            out.println("DOWNLOADED-");
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // indica que o cliente tem permissao de sair do programa
    private void leave(){
        out.println("LEAVE-");
        out.flush();
        outNotifier.println("STOP");
        outNotifier.flush();
    }


}
