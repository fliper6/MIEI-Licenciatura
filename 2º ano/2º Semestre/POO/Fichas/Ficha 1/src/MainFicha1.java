import java.util.Scanner;
public class MainFicha1 {
        public static void main (String [] args)
        {
            Scanner sc = new Scanner(System.in);
            ExFicha1 f = new ExFicha1();

            System.out.println ("Insira nome e saldo:");
            String nome = sc.nextLine();
            float saldo = sc.nextFloat();

            String str = f.criaDescricaoConta (nome,saldo);
            System.out.println("Resposta=" + str);
            System.out.println("Insira 2 valores:");
            int valor1 = sc.nextInt();
            int valor2 = sc.nextInt();

            String str2 = f.doisValores(valor1,valor2);
            System.out.println("Resposta=" + str2);

            System.out.println("Insira 1 valores:");
            int fati = sc.nextInt();
            long fat = f.factorial(fati);
            System.out.println("Fatorial=" + fat);
            System.out.println("Tempo que demora fatorial de 5000 = " + f.tempoGasto());
        }
}
