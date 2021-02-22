import java.util.Comparator;

public class ComparadorQuartos implements Comparator<Hotel>{
    //Compara por numero de quartos
    public int compare(Hotel h1, Hotel h2){
        if(h1.getNQuartos() < h2.getNQuartos()) return -1;
        if(h1.getNQuartos() > h2.getNQuartos()) return 1;
        return 0;
    }

}