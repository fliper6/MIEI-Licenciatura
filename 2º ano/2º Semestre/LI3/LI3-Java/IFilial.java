import java.util.*;

/**
 * Interface que representa uma Filial
 */
public interface IFilial {
   /**
    * Retorna lista (filiais) com os Maps que correspondem o Cliente às suas respetivas vendas
    * @return Lista de Maps de Clientes e as suas vendas (Fil) (List<Map<String,Set<Fil>>>)
    */
   public List<Map<String,Set<Fil>>> getFils();

   /**
    * Transforma a Filial numa string correspondente, com todas as variáveis
    * @return String correspondente à Filial (String)
    */
   public String toString();

   /**
    * Insere os dados de venda (no Map correspondente) na Filial
    * @param v Venda com os dados a serem inseridos (IVenda)
    */
   public void insereVenda(IVenda v);
}
