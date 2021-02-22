import static java.lang.System.out;

public class Consumidor_1 implements Runnable {
    private BoundedBuffer_1 buffer;

    public Consumidor_1(BoundedBuffer_1 b) {
        this.buffer = b;
    }

    public void run(){
        for(int i = 0; i < 20; i++) {
            this.buffer.get();
            out.println("Took no "+i + ".");
            // nao faço notifyAll porque isto é uma thread e nao um objeto de zona critica
        }
    }
}