import java.util.*;

public class BoundedBuffer_1 {

    private int values[];
    int poswrite;

    public BoundedBuffer_1(int n){
        poswrite = 0;
        this.values = new int[n];
    }

    synchronized int get() {
        int res;
        try {
            //se estou a tentar ir buscar algo ao buffer mas a posição de escrita é 0, o buffer está vazio
            while (this.poswrite == 0) {
                this.wait();
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        res = values[--poswrite];
        this.notifyAll(); //avisa as outras threads que já podem mexer no buffer
        return res;
    }

    synchronized void put(int v) {
        try {
            //buffer cheio, tem de esperar que espaço seja libertado
            while (this.poswrite == values.length) {
                wait();
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        values[poswrite++] = v;
        this.notifyAll();
    }
}
