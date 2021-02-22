import java.io.Serializable;
import java.util.*;

public class Eletrico extends Veiculo implements Serializable {

    public Eletrico(Ponto posicao, Double velocidade, String prop, Double preco, Double consumo, int autonomia, int autmax, String matricula, String marca, List<Integer> rating, List<Aluguer> aluguer) {
        super(posicao,velocidade,prop,preco,consumo,autonomia,autmax,matricula,marca,rating,aluguer);
    }

    public Eletrico(Eletrico elet) {
        super(elet);
    }

    public Eletrico() {
        super();
    }

    public boolean equals(Object o){
        if(this == o) return true;
        if(o == null || this.getClass() != o.getClass())
            return false;
        Eletrico that = (Eletrico) o;
        return super.equals(that);
    }

    public Eletrico clone(){
        return new Eletrico(this);
    }
}
