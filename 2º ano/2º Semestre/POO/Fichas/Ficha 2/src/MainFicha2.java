import java.util.Scanner;
public class MainFicha2
{
    public static void main (String[] args)
    {
        Scanner sc = new Scanner (System.in);
        int [] array = new int[4];
        for (int i=0; i<array.length; i++)
            array[i] = sc.nextInt();

        Ex1Ficha2 e1 = new Ex1Ficha2();
        System.out.println (e1.minArray (array));

        Ex1Ficha2 e2 = new Ex1Ficha2();
        int [] output = (e2.arrayEntreInts (array,1,2));
        int n = (2-1)+1;
        for (int i=0; i < n; i++) System.out.println (output[i]);
        //aqui não podia ser output.length porque vai imprimir o resto do array que nao foi preenchido
        //logo temos de fazer (j-i)+1 aka n

       /*
        int [][] turma = {{1,2,3,4},
                          {5,6,7,8},
                          {8,7,6,5},
                          {4,3,2,1}
                         };
        TurmaFicha2 t = new TurmaFicha2(turma);
        System.out.println (t.somaNotas(3));
        */
    }
}
