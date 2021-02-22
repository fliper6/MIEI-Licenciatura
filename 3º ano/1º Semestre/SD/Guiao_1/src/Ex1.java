public class Ex1{
    public static void main (String args[]) throws Exception {
        //mudar parâmetros
        int N = 10;
        int I = 100;
        Thread[] threads = new Thread[N]; //também dava ArrayList

        //Criar instâncias de Thread
        for ( int i = 0; i < N; i++) {
            IncrementerRunnable inc = new IncrementerRunnable(I);
            threads[i] = new Thread(inc);
        }

        //Iniciar threads
        for (int i = 0; i < N; i++) {
            threads[i].start();
        }

        //Espera pela finalidade das threads
        for (int i = 0; i < N; i++) {
            threads[i].join();
        }
    }
}