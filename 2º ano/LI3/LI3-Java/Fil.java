import java.io.*;

/**
 * Classe que representa as informações respetivas a uma venda de um Cliente, para a Filial
 */
public class Fil implements Comparable<Fil>, Serializable {

   private String   produto;   
   private double   preco;   
   private int      unidades; 
   private String   tipo;      
   private int      mes;

   /**
    * Construtor vazio de um Fil
    */
   public Fil() {
       this.produto  = "";
       this.preco    = 0.0;
       this.unidades = 0;
       this.tipo     = ""; 
       this.mes      = 0; 
   }

   /**
    * Construtor parametrizado de um Fil
    */
   public Fil(String pro,double pre, int uni, String tip, int mes) {
       this.produto  = pro;
       this.preco    = pre;
       this.unidades = uni;
       this.tipo     = tip; 
       this.mes      = mes; 
   }

   /**
    * Construtor por cópia de um Fil
    */
   public Fil(Fil f) {
       this.produto  = f.getProduto();
       this.preco    = f.getPreco();
       this.unidades = f.getUnidades();
       this.tipo     = f.getTipo();
       this.mes      = f.getMes();
   }

   /**
    * Retorna o código de produto da compra
    * @return Código de produto (String)
    */
   public String getProduto() { 
       return this.produto;
   }

   /**
    * Retorna o preço da compra
    * @return Preço (double)
    */
   public double getPreco() { 
       return this.preco;
   }

   /**
    * Retorna as unidades da compra
    * @return Unidades (int)
    */
   public int getUnidades() {
       return this.unidades;
   }

   /**
    * Retorna o tipo da compra
    * @return Tipo (String)
    */
   public String getTipo() { 
       return this.tipo;
   }

   /**
    * Retorna o mes da compra
    * @return Mes (int)
    */
   public int getMes() { 
       return this.mes;
   }

   /**
    * Realiza a cópia da instância da Fil atual
    * @return Cópia da Fil (Fil)
    */
   public Fil clone() {
       return new Fil(this);
   }

   /**
    * Determina a igualdade de duas Fils's
    * @param fi1 1ª fat a comparar (Fil)
    * @param fi2 2ª fat a comparar (Fil)
    * @return Valor Lógico (True se forem iguais, False caso contrário) (boolean)
    */
   public boolean equals(Fil fi1, Fil fi2) {
       return (fi1.getProduto().equals(fi2.getProduto()) && (fi1.getPreco() == (fi2.getPreco())) && (fi1.getUnidades() == (fi2.getUnidades())) && fi1.getTipo().equals(fi2.getTipo())  && (fi1.getMes() == (fi2.getMes())));
   }

   /**
    * Determina a ordenação de duas Fat's
    * @param f Fat a ser comparada com a atual
    * @return -1 se o produto da "this" vier primeiro (alfabeticamente) que de a "f", 1 caso contrário
    */
   public int compareTo(Fil f) {
       if(this.produto.compareTo(f.getProduto()) == 0) return 1;
       else return this.produto.compareTo(f.getProduto());
   }
}
