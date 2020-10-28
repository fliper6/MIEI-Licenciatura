import java.io.*;
import java.util.*;

/**
 * Classe que representa uma Filial
 */
public class Filial implements IFilial, Serializable {

   private List<Map<String,Set<Fil>>> fils;

   /**
    * Construtor "vazio" de uma Filial (tem que ser dado o número de filiais)
    */
   public Filial(int nrFil) {
       this.fils = new ArrayList<>();
       for(int i = 0; i < nrFil; i++) {
           Map <String,Set<Fil>> novoMap = new HashMap<>(); 
           this.fils.add(novoMap); 
       }
   }

   /**
    * Retorna lista (filiais) com os Maps que correspondem o Cliente às suas respetivas vendas
    * @return Lista de Maps de Clientes e as suas vendas (Fil) (List<Map<String,Set<Fil>>>)
    */
   public List<Map<String,Set<Fil>>> getFils() {
       List<Map<String,Set<Fil>>> novoArray = new ArrayList<>();
       for(Map<String,Set<Fil>> m : this.fils) {
           Map<String,Set<Fil>> novoMap = new HashMap<>();
           for(Map.Entry<String,Set<Fil>> ct : m.entrySet()) {
                Set<Fil> novaTree = new TreeSet<>();   
                for(Fil f : ct.getValue())
                   novaTree.add(f.clone());
                novoMap.put(ct.getKey(),novaTree);
           }
           novoArray.add(novoMap);
       }
       return novoArray;
   }

   /**
    * Transforma a Filial numa string correspondente, com todas as variáveis
    * @return String correspondente à Filial (String)
    */
   public String toString() {
       int fil = 1;
       StringBuffer sb = new StringBuffer();
       for(Map<String,Set<Fil>> m : this.fils) {
           sb.append(fil).append(": \n");
           for(Map.Entry<String,Set<Fil>> ct : m.entrySet()) {
               sb.append(ct.getKey()).append(": \n");
               for(Fil f : ct.getValue()) {
                   sb.append(f.getProduto() + " ").append(f.getPreco() + " ").append(f.getUnidades() + " ").append(f.getTipo() + " ").append(f.getMes()).append(" \n");
               }
           }
           fil++;
       }
       return sb.toString();
   }

   /**
    * Insere os dados de venda (no Map correspondente) na Filial
    * @param v Venda com os dados a serem inseridos (IVenda)
    */
   public void insereVenda(IVenda v) { 
       Fil fil = new Fil(v.getCodProd(),v.getPreco(),v.getUnidades(),v.getTipo(),v.getMes());       
       Map<String,Set<Fil>> mapf = this.fils.get(v.getFilial()-1);
       if(mapf.containsKey(v.getCodCli())) 
           mapf.get(v.getCodCli()).add(fil); 
       else{ //nao exista na Filial antes nenhum entrada do codcliente da venda dada
           Set<Fil> fd2 = new TreeSet<>();  
           fd2.add(fil);
           mapf.put(v.getCodCli(),fd2);
       }
       this.fils.set(v.getFilial()-1,mapf);
   }
}

