import java.util.*;
import java.io.*;

public class CompFats implements Comparator<Fat>, Serializable { //ordem descrescente (returns contrarios)
    public int compare(Fat f1, Fat f2) {
        if(f1.getPreco() == f2.getPreco()) return f1.compareTo(f2);
        else if (f1.getPreco() > f2.getPreco()) return -1;
        else return 1;
    }
}
