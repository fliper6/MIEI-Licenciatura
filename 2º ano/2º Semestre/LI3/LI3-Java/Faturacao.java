import java.io.*;
import java.util.*;

/**
 * Classe que representa uma Faturação
 */
public class Faturacao implements IFaturacao, Serializable {

   private List<Map<String,Set<Fat>>> fats;

   /**
    * Construtor vazio de uma Faturacao
    */
   public Faturacao() {
       this.fats = new ArrayList<>();
       for(int i = 0; i < 12; i++) {
           Map <String,Set<Fat>> novoMap = new HashMap<>(); 
           this.fats.add(novoMap); 
       }
   }

   /**
    * Retorna lista com os Maps que correspondem o Produto às suas respetivas vendas
    * @return Lista de Maps de Produtos e as suas vendas (Fat) (List<Map<String,Set<Fat>>>)
    */
   public List<Map<String,Set<Fat>>> getFats() {
       List<Map<String,Set<Fat>>> novoArray = new ArrayList<>();
       for(Map<String,Set<Fat>> m : this.fats) {
           Map<String,Set<Fat>> novoMap = new HashMap<>();
           for(Map.Entry<String,Set<Fat>> ct : m.entrySet()) {
                Set<Fat> novaTree = new TreeSet<>();   
                for(Fat f : ct.getValue())
                   novaTree.add(f.clone());
                novoMap.put(ct.getKey(),novaTree);
           }
           novoArray.add(novoMap);
       }
       return novoArray;
   }

   /**
    * Transforma a Faturacao numa string correspondente, com todas as variáveis
    * @return String correspondente à Faturação (String)
    */
   public String toString() {
       int fat = 1;
       StringBuffer sb = new StringBuffer();
       for(Map<String,Set<Fat>> m : this.fats) {
           sb.append(fat).append(": \n");
           for(Map.Entry<String,Set<Fat>> ct : m.entrySet()) {
               sb.append(ct.getKey()).append(": \n");
               for(Fat f : ct.getValue()) {
                   sb.append(f.getCliente() + " ").append(f.getPreco() + " ").append(f.getUnidades() + " ").append(f.getTipo() + " ").append(f.getFilial()).append(" \n");
               }
           }
           fat++;
       }
       return sb.toString();
   }

   /**
    * Insere os dados de venda (no Map correspondente) na Faturação
    * @param v Venda com os dados a serem inseridos (IVenda)
    */
   public void insereVenda(IVenda v) {
       Fat fat = new Fat(v.getCodCli(),v.getPreco(),v.getUnidades(),v.getTipo(),v.getFilial());   
       if(this.fats.get(v.getMes()-1).containsKey(v.getCodProd())) 
           this.fats.get(v.getMes()-1).get(v.getCodProd()).add(fat); 
       else{
           Set<Fat> fd2 = new TreeSet<>();  
           fd2.add(fat);
           this.fats.get(v.getMes()-1).put(v.getCodProd(),fd2);
       }
   }

   /**
    * Calcula a faturação total de todas as compras
    * @return Faturação total (int)
    */
    public int getFatTotal() {
        int i=0;
        for(Map<String,Set<Fat>> m : this.fats) {
            for(Set<Fat> ct : m.values()) {
                i += ct.size();
            }
        }
        return i;
    }

    /**
     * Calcula o total de compras efetuadas por mês
     * @return Número de compras efetuadas em cada mês (ArrayList<Integer>)
     */
    public ArrayList<Integer> getTotalComprasMes() {
        int i=0;
        ArrayList<Integer> arr = new ArrayList<>();
        for(Map<String,Set<Fat>> m : this.fats) {
            for(Set<Fat> ct : m.values()) {
                i += ct.size();
            }
            arr.add(i);
            i=0;
        }
        return arr;
    }
}