public class Produtor_2 implements Runnable{
    private BoundedBuffer_1 buffer;
    private int tempoEspera;
    private int numOps;

    public Produtor_2(BoundedBuffer_1 b, int tempoEspera, int numOps) {
        this.buffer = b;
        this.tempoEspera = tempoEspera;
        this.numOps = numOps;
    }

    public void run(){
        for(int i = 0; i < numOps; i++) {
            System.out.println("Produtor " + Thread.currentThread().getName());
            int val = this.buffer.get();
            try {
                Thread.sleep(tempoEspera);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}