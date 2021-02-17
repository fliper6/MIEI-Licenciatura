import java.io.*;

/**
 * Classe que representa as informações respetivas a uma venda de um Produto, para a Faturacao
 */
public class Fat implements Comparable<Fat>, Serializable{
   //Variaveis de Instancia 
   private String   cliente;
   private double   preco;   
   private int      unidades; 
   private String   tipo;      
   private int      filial;

   /**
    * Construtor vazio de um Fat
    */
   public Fat() {
       this.cliente  = "";
       this.preco    = 0.0;
       this.unidades = 0;
       this.tipo     = ""; 
       this.filial   = 0; 
   }

   /**
    * Construtor parametrizado de um Fat
    */
   public Fat(String cli, double pre, int uni, String tip, int fil) {
       this.cliente  = cli;
       this.preco    = pre;
       this.unidades = uni;
       this.tipo     = tip; 
       this.filial   = fil; 
   }

   /**
    * Construtor por cópia de um Fat
    */
   public Fat(Fat f) {
       this.cliente  = f.getCliente();
       this.preco    = f.getPreco();
       this.unidades = f.getUnidades();
       this.tipo     = f.getTipo();
       this.filial   = f.getFilial();
   }

   /**
    * Retorna o código de cliente da compra
    * @return Código de cliente (String)
    */
   public String getCliente() { 
       return this.cliente;
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
    * Retorna a filial da compra
    * @return Filial (int)
    */
   public int getFilial() { 
       return this.filial;
   }

   /**
    * Altera o código de cliente da compra para o dado
    * @param s Código de cliente novo (String)
    */
   public void setCliente(String s) { 
       this.cliente = s;
   }

   /**
    * Altera o preço da compra para o dado
    * @param p Preço novo (String)
    */
   public void setPreco(Double p) { 
       this.preco = p;
   }

   /**
    * Realiza a cópia da instância da Fat atual
    * @return Cópia da Fat (Fat)
    */
   public Fat clone() {
       return new Fat(this);
   }

   /**
    * Determina a igualdade de duas Fat's
    * @param fa1 1ª fat a comparar (Fat)
    * @param fa2 2ª fat a comparar (Fat)
    * @return Valor Lógico (True se forem iguais, False caso contrário) (boolean)
    */
   public boolean equals(Fat fa1, Fat fa2) {
       return (fa1.getCliente().equals(fa2.getCliente()) && (fa1.getPreco() == (fa2.getPreco())) && (fa1.getUnidades() == (fa2.getUnidades())) && fa1.getTipo().equals(fa2.getTipo())  && (fa1.getFilial() == (fa2.getFilial())));
   }

   /**
    * Determina a ordenação de duas Fat's
    * @param f Fat a ser comparada com a atual
    * @return -1 se o cliente da "this" vier primeiro (alfabeticamente) que de a "f", 1 caso contrário
    */
   public int compareTo(Fat f) {
       if(this.cliente.compareTo(f.getCliente()) == 0) return 1;
       else return this.cliente.compareTo(f.getCliente());
   }
}
