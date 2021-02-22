public class Cliente1 implements Runnable {
    private Banco banco;

    public Cliente1 (Banco b) {
        this.banco = b;
    }

    public void run() {
        int i;
        for(i=0; i<10000; i++)
            this.banco.depositar(0,50);
    }
}
