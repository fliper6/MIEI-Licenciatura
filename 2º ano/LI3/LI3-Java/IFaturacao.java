import java.util.*;

/**
 * Interface que representa uma Faturação
 */
public interface IFaturacao {

   /**
    * Retorna lista (meses) com os Maps que correspondem o Produto às suas respetivas vendas
    * @return Lista de Maps de Produtos e as suas vendas (Fat) (List<Map<String,Set<Fat>>>)
    */
   public List<Map<String,Set<Fat>>> getFats();

   /**
    * Transforma a Faturacao numa string correspondente, com todas as variáveis
    * @return String correspondente à Faturação (String)
    */
   public String toString();

   /**
    * Insere os dados de venda (no Map correspondente) na Faturação
    * @param v Venda com os dados a serem inseridos (IVenda)
    */
   public void insereVenda(IVenda v);

   /**
    * Calcula a faturação total de todas as compras
    * @return Faturação total (int)
    */
   public int getFatTotal();

   /**
    * Calcula o total de compras efetuadas por mês
    * @return Número de compras efetuadas em cada mês (ArrayList<Integer>)
    */
   public ArrayList<Integer> getTotalComprasMes();
}