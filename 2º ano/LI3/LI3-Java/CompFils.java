import java.util.*;
import java.io.*;

public class CompFils implements Comparator<Fil>, Serializable { //ordem descrescente (returns contrarios)
    public int compare(Fil f1, Fil f2) {
        if(f1.getUnidades() == f2.getUnidades()) return f1.compareTo(f2);
        else if (f1.getUnidades() > f2.getUnidades()) return -1;
        else return 1;
    }
}
