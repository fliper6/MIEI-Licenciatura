import java.util.Comparator;

public class ComparadorLugarTempo implements Comparator<Lugar> {

    public int compare(Lugar l1, Lugar l2){
        if(l1.getMinutos() >l2.getMinutos())
            return -1;
        else
            return 1;
    }
}
