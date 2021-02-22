public class Cliente2 implements Runnable{
    private Banco banco;

    public Cliente2 (Banco b) {
        this.banco = b;
    }

    public void run() {
        int i;
        for(i=0; i<10000; i++)
            this.banco.levantar(0,50);
    }
}
