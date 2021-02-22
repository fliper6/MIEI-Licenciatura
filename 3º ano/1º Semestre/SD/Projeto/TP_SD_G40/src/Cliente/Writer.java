package Cliente;

// Imports
import java.io.*;
import java.net.Socket;
import Cliente.Menu.State;

public class Writer implements Runnable {

    // Variáveis de Instância
    private final int MAXSIZE = 500*1024; // 500kb max
    private Menu menu;
    private BufferedWriter output;
    private Socket sk;

    // Construtor por Parâmetros
    public Writer(Menu m, BufferedWriter o, Socket s) {
        this.output = o;
        this.menu = m;
        this.sk = s;
    }

    // Está constantemente a ler a escolha do user (menu.choice())
    public void run() {
        int choice;
        menu.show();
        while (((choice = menu.choice()) != -1)) {
            try {
                parse(choice);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // Dependendo da escolha, executa a ação correspondente do menu atual
    private void parse(Integer choice) throws Exception {
        switch (menu.getState()) {
            case NOTLOGGED:
                if (choice == 0)
                    leave();
                if (choice == 1)
                    login_signup(1);
                if (choice == 2)
                    login_signup(2);
                break;
            case LOGGED:
                if (choice == 0)
                    logout();
                if (choice == 1)
                    upload();
                if (choice == 2)
                    download();
                if (choice == 3)
                    search();
                break;
            case REGISTERING:
                break;
            case SEARCHING:
                break;
            case UPLOADING:
                break;
            case DOWNLOADING:
                break;
        }
    }

    // Login / Signup
    private void login_signup(int i) throws IOException {
        String username = menu.lerDadosUser("Username: ");
        String password = menu.lerDadosUser("Password: ");
        String query;

        if (i == 1)
            query = "LOGIN" + "-" + username + "," + password;
        else
            query = "REGISTER" + "-" + username + "," + password;

        output.write(query);
        output.newLine();
        output.flush();
    }

    // Logout
    private void logout() throws IOException{
        String userAtual = menu.getUser();
        output.write("LOGOUT-"+userAtual); 
        output.newLine();
        output.flush();
        menu.setState(State.NOTLOGGED);
        menu.show(); 
    }

    // Pedido de download de um ficheiro dado o seu id
    private void download() {
        try {
            //String nrFile = menu.lerDadosUser("Nº File: ");
            int nrFile = menu.lerIntUser();
            output.write("DOWNLOAD-" + nrFile);
            output.newLine();
            output.flush();
        } catch (IOException e) {
            System.err.println("File does not exist!");
        }
    }

    // Upload de um ficheiro, dados os seus metadados
    private void upload(){

            String nome = menu.lerDadosUser("Nome: ");
            String artista = menu.lerDadosUser("Artista: ");
            String ano = menu.lerDadosUser("Ano: ");
            String tags = menu.lerTags();
            String file = menu.lerDadosUser("Filename: ");
            String fileName = "./effects/" + file + ".mp3";
            String query = nome+","+artista+","+ano+","+tags;

            File myFile = new File(fileName);
            FileInputStream fis;
            try{
                 fis= new FileInputStream(myFile);
            }catch (FileNotFoundException EX) {
                System.out.println("Ficheiro inválido!");
                menu.setState(State.LOGGED);
                menu.show();
                return;
            }
            try {
                long filesize = myFile.length();
                int stop = 0;

                byte[] mybytearray = new byte[MAXSIZE];
                output.write("UPLOAD-");
                output.newLine();
                output.flush();

                BufferedInputStream bis = new BufferedInputStream(fis);

                OutputStream os = sk.getOutputStream();
                DataOutputStream dos = new DataOutputStream(os);
                DataInputStream dis = new DataInputStream(bis);
                dos.writeUTF(query);
                dos.writeLong(filesize);
                while (filesize > 0 && (stop = dis.read(mybytearray, 0, (int) Math.min(MAXSIZE, filesize))) != -1) {
                    dos.write(mybytearray, 0, stop);
                    filesize -= stop;
                }
                dos.flush();
            }
            catch (Exception e) {
                e.printStackTrace();
             }
    }

    // pedido de sair do sistema para nao causar crash
    private void leave(){
        try{
            output.write("LEAVE-");
            output.newLine();
            output.flush();
        }
        catch(Exception e) {
            e.printStackTrace();
        }
    }

    // pedido de search serializado
    private void search(){
        String tags = menu.tags();
        if(tags==null){
            System.out.println("Não foram inseridas tags");
            menu.show();
            return;
        }
        String query = "SEARCH-"+tags;
        try {
            output.write(query);
            output.newLine();
            output.flush();
        }
        catch(Exception e) {
            e.printStackTrace();
        }
    }

}
