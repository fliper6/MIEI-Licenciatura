import java.util.ArrayList;
import java.util.List;

public class Reta {
    private List<Ponto> reta;

    public Reta () {
        this.reta = new ArrayList<>();
    }

    public void addPonto (Ponto p) {
        this.reta.add(p.clone());
    }

    public String toString () {
        return this.reta.toString();
    }

    //o (int) atrás serve para dar return a um int, já que o count devolve um double
    public int altura () {
        return (int)this.reta.stream().map(p -> p.getY()).count();
    }

    public int profundidade () {
        int a = 0;
        for (Ponto p:this.reta)
            // ou if (p.getClass():getSimpleName().equals("Ponto3D")); <-- menos eficaz
            if (p instanceof Ponto3D)
                a += ((Ponto3D) p).getZ();
        return a;
    }

}

