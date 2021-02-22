import java.io.Serializable;
import java.util.*;

public class Hibrido extends Veiculo implements Serializable {

    public Hibrido(Ponto posicao, Double velocidade, String prop, Double preco, Double consumo, int autonomia,int autmax, String matricula, String marca, List<Integer> rating, List<Aluguer> aluguer) {
        super(posicao,velocidade,prop,preco,consumo,autonomia,autmax,matricula,marca,rating,aluguer);
    }

    public Hibrido(Hibrido hibrido) {
        super(hibrido);
    }

    public Hibrido() {
        super();
    }

    public boolean equals(Object o){
        if(this == o) return true;
        if(o == null || this.getClass() != o.getClass())
            return false;
        Hibrido that = (Hibrido) o;
        return super.equals(that);
    }

    public Hibrido clone(){
        return new Hibrido(this);
    }
}
