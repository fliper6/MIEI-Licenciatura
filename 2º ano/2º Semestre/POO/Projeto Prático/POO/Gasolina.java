import java.io.Serializable;
import java.util.*;

public class Gasolina extends Veiculo implements Serializable {

    public Gasolina(Ponto posicao, Double velocidade, String prop, Double preco, Double consumo, int autonomia, int autmax, String matricula, String marca, List<Integer> rating, List<Aluguer> aluguer) {
        super(posicao,velocidade,prop,preco,consumo,autonomia,autmax,matricula,marca,rating,aluguer);
    }

    public Gasolina(Gasolina gasol){
        super(gasol);
    }

    public Gasolina(){
        super();
    }

    public boolean equals(Object o){
        if(this == o) return true;
        if(o == null || this.getClass() != o.getClass())
            return false;
        Gasolina that = (Gasolina) o;
        return super.equals(that);
    }

    public Gasolina clone(){
        return new Gasolina(this);
    }
}
