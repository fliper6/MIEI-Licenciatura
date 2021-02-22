public class main_2 {
    public static void main(String[] args) throws InterruptedException {
        BoundedBuffer_1 buffer = new BoundedBuffer_1(10);
        int tc = 50; //tempo de consumir, em ms
        int tp = 50; //tempo de produzir
        int total_ops = 100; //total de operações
        int N = 10; //número de threads
        int P; //número de produtores
        int C; //número de consumidores
        double maxDebito = 0;
        int maxProd = 0; //número de produtores referente ao débito máximo observado

        for (P = 1; P <= 9; P++) {
            C = N - P;
            Thread[] produtores = new Thread[P];
            Thread[] consumidores = new Thread[C];

            System.out.println("==== "+P+" PRODUTORES, "+C+" CONSUMIDORES ====");

            //acertar o número de operações caso a divisão não tenha resto 0
            int opsprod = total_ops/P;
            int rest = total_ops%P;
            for (int i = 0; i < P; i++) {
                //criar threads produtos
                if (i < C-1) {
                    produtores[i] = new Thread(new Produtor_2(buffer, tc, opsprod));
                } else
                    produtores[i] = new Thread(new Produtor_2(buffer, tc, opsprod+rest));
                produtores[i].setName(String.valueOf(i + 1));
            }

            //acertar o número de operações caso a divisão não tenha resto 0
            int opscons = total_ops/C;
            rest = total_ops%C;
            for (int i = 0; i < C; i++) {
                //criar threads consumidores
                if (i < C-1) {
                    consumidores[i] = new Thread(new Consumidor_2(buffer, tc, opscons));
                } else
                    consumidores[i] = new Thread(new Consumidor_2(buffer, tc, opscons+rest));
                consumidores[i].setName(String.valueOf(i+1));
            }

            try {
                //iniciar cronómetro e threads
                long startTime = System.currentTimeMillis() / 1000;
                for (int i = 0; i < P; i++) {
                    //iniciar threads produtores
                    produtores[i].start();
                }

                for (int i = 0; i < C; i++) {
                    //iniciar threads consumidores
                    consumidores[i].start();
                }

                for (int i = 0; i < P; i++) {
                    //aguardar que produtores finalizem
                    produtores[i].join();
                }

                for (int i = 0; i < C; i++) {
                    //aguardar que consumidores finalizem
                    consumidores[i].join();
                }

                //parar cronómetro e calcular débito = total_op / (tempo_final - tempo_inicial)
                long endTime = System.currentTimeMillis() / 1000;
                double debito = (double) total_ops / (endTime - startTime);
                System.out.println("[P= " + P + ", C= " + C + ", Tp= " + (double) tp / 1000 + "s, Tc=" + (double) tc / 1000);

                //se o débito obtido for maior do que o máximo observado até agora, atualizar o máximo
                if (debito > maxDebito) {
                    maxDebito = debito;
                    maxProd = P;
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println("\n ## Débito máximo é "+maxDebito+" ops/s, para "+maxProd+" produtores");
    }
}