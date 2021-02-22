import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

public class Cliente {

    public static void main(String[] args) throws Exception{
        //criar socket e ligação com o servidor
        Socket socket = new Socket("127.0.0.1",12345);

        //abrir canais de escrita e leitura no socket
        BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        PrintWriter out = new PrintWriter(socket.getOutputStream());

        String input;
        while((input = in.readLine()) != null) {
            out.println(input);
            out.flush();
            if (input.equals("q")) break;
            System.out.println("Received response from server: " + in.readLine());
        }

        socket.shutdownOutput();
        socket.shutdownInput();
        socket.close();
    }
}
