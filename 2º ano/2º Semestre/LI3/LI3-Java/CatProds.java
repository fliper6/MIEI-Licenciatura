import java.io.*;
import java.util.*;

/**
 * Classe que representa um Catálogo de Produtos
 */
public class CatProds implements ICatProds, Serializable {

   private int validos;
   private Map<String,Integer> prods;
   
   /**
    * Construtor vazio de um Catálogo de Produtos
    */
   public CatProds() {
       this.validos = 0;
       this.prods = new HashMap<>();
   }

   /**
    * Construtor parametrizado de um Catálogo de Produtos
    */
   public CatProds(int validos, Map<String,Integer> p) {
       this.validos = validos;
       this.prods = new HashMap<>();
       for(Map.Entry<String,Integer> e : p.entrySet())
          this.prods.put(e.getKey(),e.getValue());
   }

   /**
    * Construtor por cópia de um Catálogo de Produtos
    */
   public CatProds(CatProds catp) {
       this.validos = catp.getValidos();
       this.prods = new HashMap<>();
       for(Map.Entry<String,Integer> e : catp.getMProds().entrySet())
          this.prods.put(e.getKey(),e.getValue());
   }

   /**
    * Retorna o número de produtos válidos
    * @return Número de produtos válidos (int)
    */
   public int getValidos() {
       return this.validos;
   }

   /**
    * Retorna o map com os códigos de produto e a respetiva flag (que indica se o produto foi comprado ou não)
    * @return Map com produtos (String) e a sua flag (Integer) (Map<String,Integer>)
    */
   public Map<String,Integer> getMProds() {
       Map<String,Integer> ps = new HashMap<>();
       for(Map.Entry<String,Integer> e : this.prods.entrySet()) {
          ps.put(e.getKey(),e.getValue());
       }
       return ps;
   }

   /**
    * Realiza a cópia da instância do Catálogo de Produtos atual
    * @return Cópia do Catálogo de Produtos atual (CatProds)
    */
   public CatProds clone() {
       return new CatProds(this);
   }

   /**
    * Insere um novo produto no Catálogo de Produtos atual
    * @param s Código do novo produto (String)
    */
   public void insereProd(String s) {
       this.prods.put(s,0); 
       this.validos += 1; 
   }

   /**
    * Transforma o Catálogo de Produtos numa string correspondente, com todas as variáveis
    * @return String correspondente ao Catálogo (String)
    */
   public String toString() {
       StringBuffer sb = new StringBuffer();
       for(Map.Entry<String,Integer> e: this.prods.entrySet()) {
           sb.append(e.getKey()).append(" --> flag: ").append(e.getValue()).append("\n");
       }
       return sb.toString();
   }

   /**
    * Verifica se o Catálogo de Produtos contém um certo produto
    * @param s Código do novo produto (String)
    * @return Valor lógico (True se já existir esse produto, False caso contrário) (boolean)
    */
   public boolean containsProd(String s) {
       return this.prods.containsKey(s);
   }

   /**
    * Muda a flag do produto correspondente, quando é efetuada uma compra
    * @param cod Código do Produto (String)
    * @param f Novo valor da Flag (int)
    */
   public void mudarFlag(String cod, int f) {
       this.prods.put(cod,f);
   }

   /**
    * Muda a flag do produto correspondente, quando é efetuada uma compra
    * @param s Código do Produto (String)
    * @return Valor lógico (True se o produto for válido, False caso contrário) (boolean)
    */
   public static boolean validaProduto(String s) {
       String[] campos = s.split("(?!^)");
       
       for (int i = 0; i < 2; i++) 
           if (!Character.isUpperCase(campos[i].charAt(0))) return false;
       for (int i = 2; i < 6; i++) 
       if (!Character.isDigit(campos[i].charAt(0))) return false;
       if (campos[2] == "0") return false;  
  
       return true;
   }
}
