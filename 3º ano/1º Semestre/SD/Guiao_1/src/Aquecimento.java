import java.io.*;

public class Aquecimento {
    public void main () {
        BufferedReader input = new BufferedReader(new InputStreamReader(System.in));
        String line;
        try {
            System.out.print("> ");
            while ((line = input.readLine()) != null) {
                System.out.println("Echo " +  line);
                System.out.print("> ");
            }
        }
        catch (IOException e) {
            System.err.println("Error reading line from System.in");
            e.printStackTrace();
        }
    }
}
