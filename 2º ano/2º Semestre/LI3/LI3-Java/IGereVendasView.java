import java.util.*;
import java.io.*;

public interface IGereVendasView{
    public void printCondicao(int q);
    public void printTempo(Double tempo);
    public void printErroInput();
    public void printNCli();
    public void printNProd();
    public void printMQ();
    public void printMP();
    public void printMC();
    public void printSeguir();
    public void printConsulta1(String fich,List<Integer> arr, Double fat);
    public void printConsulta2(List<Integer> c,List<List<Double>> tf, List<List<Integer>> cd);
    public void print1(List<String> l, Double t);
    public void print2(List<Integer> l, int mes, String modo, Double t);
    public void print3(Map<Integer,List<Double>> m, String cli, Double t);
    public void print4(Map<Integer,List<Double>> m, String prod, Double t);
    public void print5(List<Fil> l, String cli, Double t);
    public void print6(Map<String,List<Integer>> m, int x, Double t);
    public void print7(Map<Integer,List<Fat>> m, Double t);
    public void print8(List<Fil> l, int x, Double t);
    public void print9(Map<String,List<Double>> m, String cod, int x, Double t);
    public void print10(List<Map<String,List<Double>>> l, Double t);
}
