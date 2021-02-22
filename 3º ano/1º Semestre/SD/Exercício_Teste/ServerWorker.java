import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;

public class ServerWorker extends Thread implements Runnable {
    private BufferedReader in;
    private PrintWriter out;
    private Socket socket;
    private Shuttle shuttle;

    public ServerWorker(Socket cSocket, Shuttle s) throws IOException {
        this.in = new BufferedReader(new InputStreamReader(cSocket.getInputStream()));
        this.out = new PrintWriter(new OutputStreamWriter(cSocket.getOutputStream()));
        shuttle = s;
        socket = socket;
    }

    public void run() {
        String mensagem = null;
        while (true) {
            try {
                mensagem = in.readLine();
                if (mensagem == null || mensagem == "q") {
                    socket.shutdownOutput();
                    socket.shutdownInput();
                    socket.close();
                }

                String[] split = mensagem.split("-", 1);
                int origem = Integer.parseInt(split[1]);
                int destino = Integer.parseInt(split[2]);
                shuttle.requisita_viagem(origem, destino);
                shuttle.partida();
                shuttle.espera(destino);

            } catch (IOException | InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
