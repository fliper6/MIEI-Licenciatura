package Cliente;

// Imports
import java.io.*;
import java.net.Socket;
import java.nio.file.*;

import Cliente.Menu.State;

public class Reader implements Runnable{

    // Variáveis de Instância
    private final String temp2 = "./files/cliente/";
    private final int MAXSIZE = 500*1024;
    private Menu menu;
    private BufferedReader input;
    private Socket sock;

    // Construtor por Parâmetros
    Reader (Menu menu, BufferedReader input,Socket s) {
        this.input = input;
        this.menu = menu;
        this.sock = s;
    }

    // Está constantemente a ler do input do Cliente (BufferedReader input) (à espera do output do Servidor)
    public void run() {
        String s;
        try {
            while ((s = input.readLine()) != null) 
                parseResponse(s);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Dependendo da resposta do Server, muda o estado da classe Menu
    private synchronized void parseResponse(String response){
        String[] partes = response.split("-",2);
        switch(partes[0]) {
            case("DENIED_1"):
                System.out.println("Username/Password inválidos!");
                menu.show();
                break;
            case("DENIED_2"):
                System.out.println("Username já existe!");
                menu.show();
                break;
            case("DENIED_3"):
                System.out.println("Utilizador já está autenticado!");
                menu.show();
                break;
            case("INVALID_ID"):
                System.out.println("ID da música não existe!");
                menu.setState(State.LOGGED);
                menu.show();
                break;
            case ("NOTIFICA"):
                menu.notificaUser(partes[1]);
                menu.show();
                break;
            case ("LOGGEDIN"):
                menu.setUser(partes[1]);
                menu.setState(State.LOGGED);
                menu.show();
                break;
            case("SIGNEDUP"):
                menu.setState(State.NOTLOGGED);
                menu.show();
                break;
            case("UPLOADING"):
                menu.setState(State.UPLOADING);
                menu.show();
                break;
            case("UPLOADED"):
                menu.setState(State.LOGGED);
                menu.show();
                break;
            case("DOWNLOADING"):
                menu.setState(State.DOWNLOADING);
                menu.show();
                recebeFicheiro();
                break;
            case("DOWNLOADED"):
                menu.setState(State.LOGGED);
                menu.show();
                break;
            case("SEARCHING"):
                recebeSearch();
                menu.show();
                break;
            case("LEAVE"):
                leave();
                break;
            default:
                System.out.println("ERRO");
                menu.setState(State.NOTLOGGED);
                menu.show();
                break;
        }
    }

    // abandona o programa sem causar crash
    private void leave(){
        try {
            sock.shutdownOutput();
            sock.shutdownInput();
            sock.close();
        }
        catch(Exception e) {
            e.printStackTrace();
        }
        System.exit(0);
    }

    // Cria uma diretoria temporária
    private void createTempDirectory(){
        Path path2 = Paths.get(temp2);
        if (!Files.exists(path2)) {
            try {
                Files.createDirectories(path2);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    // Recebe o ficheiro enviado pelo server e os seus metadados, guarda em /files/cliente/file.mp3
    private void recebeFicheiro() {
        createTempDirectory();
        try {
            String fileName;
            int bytesRead;
            InputStream in = sock.getInputStream();

            DataInputStream clientData = new DataInputStream(in);

            fileName = clientData.readUTF();
            if(fileName.equals("")) {
                System.out.println("Erro no nome");
                return;
            }
            OutputStream output = new FileOutputStream((temp2 + fileName + ".mp3"));
            long size = clientData.readLong();
            byte[] buffer = new byte[MAXSIZE];

            while (size > 0 && (bytesRead = clientData.read(buffer, 0, (int) Math.min(MAXSIZE, size))) != -1) {
                output.write(buffer, 0, bytesRead);
                size -= bytesRead;
            }

            output.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    // recebe o resultado do pedido de search
    private void recebeSearch(){
        String musica = null;
        try {
            System.out.println("*** RESULTADOS DA PROCURA *** ");
            while(!((musica=input.readLine()) == null)){
                if(musica.equals("end")) break;
                System.out.println(musica);
            }
            System.out.println("*** FIM *** ");
        }
        catch(Exception e) {
            e.printStackTrace();
        }
        menu.setState(State.LOGGED);
    }

}
