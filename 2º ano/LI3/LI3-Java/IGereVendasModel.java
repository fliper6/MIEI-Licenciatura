import java.util.*;
import java.io.*; 

public interface IGereVendasModel{
    //Getters e Setters
    public ICatClis getCatClis();
    public ICatProds getCatProds();
    public IFaturacao getFaturacao();
    public IFilial getFilial();
    public double getTempo();
    public String getFich();
    public double getFat();

    //Ler ficheiros
    public void lerProds(String fichtxt);
    public void lerClis(String fichtxt);
    public void lerVendas(String fichtxt);
    public void createData();
    public void lerTxt(String fich);

    //Consultas Estatisticas
    public List<Integer> getEstatisticas();
    public List<Integer> TotalComprasM();
    public List<List<Double>> fatTotalMesFilial();
    public List<List<Integer>> clientesDifMesFilial();
    
    //Queries 
    public List<String> query1();
    public List<Integer> query2(int mes,String modo);
    public Map<Integer,List<Double>> query3(String cod);
    public Map<Integer,List<Double>> query4(String cod);
    public List<Fil> query5(String cod);
    public Map<String,List<Integer>> query6(int x);
    public Map<Integer,List<Fat>> query7();
    public List<Fil> query8(int x);
    public Map<String,List<Double>> query9(String cod, int x);
    public List<Map<String,List<Double>>> query10();
}
