import java.io.*;
import java.util.*;

/**
 * Classe que representa um Catálogo de Clientes
 */
public class CatClis implements ICatClis, Serializable {

   private int validos;
   private Map<String,Integer> clis;

   /**
    * Construtor vazio de um Catálogo de Cliente
    */
   public CatClis() {
       this.validos = 0;
       this.clis = new HashMap<>();
   }

    /**
     * Construtor parametrizado de um Catálogo de Clientes
     */
    public CatClis(int validos, Map<String,Integer> p) {
       this.validos = validos;
       this.clis = new HashMap<>();
       for(Map.Entry<String,Integer> e : p.entrySet())
          this.clis.put(e.getKey(),e.getValue());
   }

   /**
    * Construtor por cópia de um Catálogo de Clientes
    */
   public CatClis(CatClis catc) {
       this.validos = catc.getValidos();
       this.clis = new HashMap<>();
       for(Map.Entry<String,Integer> e : catc.getMClis().entrySet())
          this.clis.put(e.getKey(),e.getValue());
   }

   /**
    * Retorna o número de clientes válidos
    * @return Número de clientes válidos (int)
    */
   public int getValidos() { 
       return this.validos;
   }

   /**
    * Retorna o map com os códigos de cliente e a respetiva flag (que indica se o cliente comprou algo ou não)
    * @return Map com clientes (String) e a sua flag (Integer) (Map<String,Integer>)
    */
   public Map<String,Integer> getMClis() {
       Map<String,Integer> ps = new HashMap<>();
       for(Map.Entry<String,Integer> e : this.clis.entrySet()) {
          ps.put(e.getKey(),e.getValue());
       }
       return ps;
   }

   /**
    * Realiza a cópia da instância do Catálogo de Clientes atual
    * @return Cópia do Catálogo de Clientes atual (CatClis)
    */
   public CatClis clone() {
       return new CatClis(this);
   }

   /**
    * Insere um novo cliente no Catálogo de Clientes atual
    * @param s Código do novo cliente (String)
    */
   public void insereCli(String s) {
       this.clis.put(s,0); 
       this.validos += 1; 
   }

   /**
    * Transforma o Catálogo de Clientes numa string correspondente, com todas as variáveis
    * @return String correspondente ao Catálogo (String)
    */
   public String toString() {
       StringBuffer sb = new StringBuffer();
       for(Map.Entry<String,Integer> e: this.clis.entrySet()) {
           sb.append(e.getKey()).append(" --> flag: ").append(e.getValue()).append("\n");
       }
       return sb.toString();
   }

   /**
    * Verifica se o Catálogo de Clientes contém um certo produto
    * @param s Código do novo cliente (String)
    * @return Valor lógico (True se já existir esse cliente, False caso contrário) (boolean)
    */
   public boolean containsCli(String s) {
       return this.clis.containsKey(s);
   }

   /**
    * Muda a flag do cliente correspondente, quando é efetuada uma compra
    * @param cod Código do Cliente (String)
    * @param f Novo valor da Flag (int)
    */
   public void mudarFlag(String cod, int f) {
       this.clis.put(cod,f);
   }

   /**
    * Muda a flag do cliente correspondente, quando é efetuada uma compra
    * @param s Código do Cliente (String)
    * @return Valor lógico (True se o cliente for válido, False caso contrário) (boolean)
    */
   public static boolean validaCliente(String s) {
       String[] campos = s.split("(?!^)"); 
       for (int i = 0; i < 1; i++) 
           if (!Character.isUpperCase(campos[i].charAt(0))) return false;
       for (int i = 1; i < 5; i++) 
           if (!Character.isDigit(campos[i].charAt(0))) return false;
       if (campos[1] == "0") return false;  
  
       return true;
   }
}
