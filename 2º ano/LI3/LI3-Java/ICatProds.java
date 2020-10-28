import java.util.*;

/**
 * Interface que representa um Catálogo de Produtos
 */
public interface ICatProds {
   /**
    * Retorna o número de produtos válidos
    * @return Número de produtos válidos (int)
    */
   public int getValidos();

   /**
    * Retorna o map com os códigos de produto e a respetiva flag (que indica se o produto foi comprado ou não)
    * @return Map com produtos (String) e a sua flag (Integer) (Map<String,Integer>)
    */
   public Map<String,Integer> getMProds();

   /**
    * Realiza a cópia da instância do Catálogo de Produtos atual
    * @return Cópia do Catálogo de Produtos atual (CatProds)
    */
   public ICatProds clone();

   /**
    * Insere um novo produto no Catálogo de Produtos atual
    * @param s Código do novo produto (String)
    */
   public void insereProd(String s);

   /**
    * Transforma o Catálogo de Produtos numa string correspondente, com todas as variáveis
    * @return String correspondente ao Catálogo (String)
    */
   public String toString();

   /**
    * Verifica se o Catálogo de Produtos contém um certo produto
    * @param s Código do novo produto (String)
    * @return Valor lógico (True se já existir esse produto, False caso contrário) (boolean)
    */
   public boolean containsProd(String s);

   /**
    * Muda a flag do produto correspondente, quando é efetuada uma compra
    * @param s Código do Produto (String)
    * @param f Novo valor da Flag (int)
    */
   public void mudarFlag(String s, int f);
}
