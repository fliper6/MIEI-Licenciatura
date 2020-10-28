import java.util.*;

/**
 * Interface que representa um Catálogo de Clientes
 */
public interface ICatClis {
   /**
    * Retorna o número de clientes válidos
    * @return Número de clientes válidos (int)
    */
   public int getValidos();

   /**
    * Retorna o map com os códigos de cliente e a respetiva flag (que indica se o cliente comprou algo ou não)
    * @return Map com clientes (String) e a sua flag (Integer) (Map<String,Integer>)
    */
   public Map<String,Integer> getMClis();

   /**
    * Realiza a cópia da instância do Catálogo de Clientes atual
    * @return Cópia do Catálogo de Clientes atual (CatClis)
    */
   public ICatClis clone();

   /**
    * Insere um novo cliente no Catálogo de Clientes atual
    * @param s Código do novo cliente (String)
    */
   public void insereCli(String s);

   /**
    * Transforma o Catálogo de Clientes numa string correspondente, com todos as variáveis
    * @return String correspondente ao Catálogo (String)
    */
   public String toString();

   /**
    * Verifica se o Catálogo de Clientes contém um certo produto
    * @param s Código do novo cliente (String)
    * @return Valor lógico (True se já existir esse cliente, False caso contrário) (boolean)
    */
   public boolean containsCli(String s);

   /**
    * Muda a flag do cliente correspondente, quando é efetuada uma compra
    * @param s Código do Cliente (String)
    * @return Valor lógico (True se o cliente for válido, False caso contrário) (boolean)
    */
   public void mudarFlag(String s, int f);
}
