import java.io.Serializable;
import java.lang.reflect.Array;
import java.util.*;

public class Cliente extends Pessoa implements Serializable {
    private Ponto posicao;
    private int estadoAlug;//0 pode fazer alugueres,1 aluguer pedente,2 aluguer aceite

    public Cliente(String email,int estado, String nome, String password, String morada, String nascimento, String nif, List<Integer> rating, List<Aluguer> aluguer, Ponto posicao) {
        super(email,nome,password,morada,nascimento,nif,rating,aluguer);
        this.posicao = posicao.clone();
        this.estadoAlug = estado;

    }

    public Cliente(Cliente cliente) {
        super(cliente);
        this.posicao = cliente.getPosicao();
        this.estadoAlug = cliente.getEstadoAlug();
    }

    public Cliente() {
        super();
        this.posicao = new Ponto();
        this.estadoAlug = 0;
    }

    public Ponto getPosicao() {
        return this.posicao.clone();
    }

    public void setPosicao(Ponto ponto) {
        this.posicao = ponto.clone();
    }

    public int getEstadoAlug() {
        return estadoAlug;
    }

    public void setEstadoAlug(int estadoAlug) {
        this.estadoAlug = estadoAlug;
    }

    public boolean equals(Object o){
        if(this == o) return true;
        if(o == null || this.getClass() != o.getClass())
            return false;
        Cliente that = (Cliente) o;
        return super.equals(that);
    }

    public String toString(){
        return super.toString() + "\nPosição: " + this.posicao.toString() +
                                  "\nEstado Aluguer:" +this.estadoAlug+"\n";
    }

    public String toString2(){
        return super.toString2() + "\nPosição: " + this.posicao.toString() +
                                  "\nEstado Aluguer:" +this.estadoAlug+"\n";
    }

    public Cliente clone(){
        return new Cliente(this);
    }
}
