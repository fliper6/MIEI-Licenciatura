public class IncrementerRunnable implements Runnable {
    //Estado a que a thread terá acesso
    private int maxInc;

    public IncrementerRunnable(int i) { this.maxInc = i;}

    //Método que representa o comportamento da thread
    public void run() {
        for (int i = 0; i < this.maxInc; i++)
            System.out.println(i);
    }
}

