import java.lang.*;
import java.io.*;
import java.util.*;

public class Main {
    //método setName para threads útil para debug
    public static void main(String[] args) {
        int NUM_CONTAS = 10;
        Banco b = new Banco(NUM_CONTAS);
        Thread t1 = new Thread(new Cliente1(b));
        Thread t2 = new Thread(new Cliente2(b));

        t1.start();
        t2.start();

        try{
            t1.join();
            t2.join();
        }
        catch (InterruptedException e) {e.printStackTrace();}

        System.out.println("Valor na Conta 0 é: " + b.consultar(0));

    }
}
