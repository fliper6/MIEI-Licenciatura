import java.util.Comparator;

public class ComparadorPrecoNoite implements Comparator<Hotel>{
    //Compara por preço
    public int compare(Hotel h1, Hotel h2){
        if(h1.getPreco() < h2.getPreco()) return -1;
        if(h1.getPreco() > h2.getPreco()) return 1;
        return 0;
    }
}
