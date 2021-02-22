public class Ex2e3 {

    public static void main(String[] args) throws Exception {
        int N = 10;
        Counter c = new Counter();
        Thread[] threads = new Thread[N];

        for(int j= 0; j < N; j++) {
            threads[j] = new Thread(new Incrementer2(10000,c));
            threads[j].start();

        }

        for(int j = 0; j < N;  j++) {
            threads[j].join();
        }

        System.out.println(c.get());
    }

}