import java.io.Serializable;
import java.lang.reflect.Array;
import java.util.*;

public class Proprietario extends Pessoa implements Serializable {
    private List<Veiculo> carros;
    private List<Aluguer> queue;

    public Proprietario(String email, String nome, String password, String morada, String nascimento, String nif, List<Aluguer> aluguer, List<Integer> rating, List<Veiculo> carros, List<Aluguer> queue) {
        super(email,nome,password,morada,nascimento,nif,rating,aluguer);
        this.carros = new ArrayList<>();
        for(Veiculo s: carros){
            this.carros.add(s.clone());
        }
        this.queue = new ArrayList<>();
        for(Aluguer s: queue){
            this.queue.add(s.clone());
        }
    }

    public Proprietario(Proprietario proprietario) {
        super(proprietario);
        this.carros = proprietario.getCarros();
        this.queue = proprietario.getQueue();
    }

    public Proprietario() {
        super();
        this.carros = new ArrayList<>();
        this.queue = new ArrayList<>();
    }


    public List<Veiculo> getCarros(){
        List<Veiculo> veic = new ArrayList<>();
        for(Veiculo l: this.carros) {
            veic.add(l.clone());
        }
        return veic;
    }

    public void setCarros(List<Veiculo> carros) {
        this.carros = new ArrayList<>();
        for (Veiculo s : carros) {
            this.carros.add(s.clone());
        }
    }


    public ArrayList<Aluguer> getQueue(){
        ArrayList<Aluguer> alug = new ArrayList<>();
        for(Aluguer l: this.queue) {
            alug.add(l.clone());
        }
        return alug;
    }

    public void setQueue(List<Aluguer> queue) {
        this.queue = new ArrayList<>();
        for (Aluguer s : queue) {
            this.queue.add(s.clone());
        }
    }

    public void addQueue(Aluguer alug){
        this.queue.add(alug.clone());
    }

    public void addCarro(Veiculo carro){
        this.carros.add(carro.clone());
    }

    public void alteraCarro(Veiculo veic){
        for (int i=0; i<this.carros.size();i++) {
            if (this.carros.get(i).getMatricula()==veic.getMatricula()) this.carros.set(i,veic);
        }
    }

    public boolean equals(Object o){
        if(this == o) return true;
        if(o == null || this.getClass() != o.getClass())
            return false;
        Proprietario that = (Proprietario) o;
        return super.equals(that);
    }

    public String toString(){
        StringBuilder sb = new StringBuilder();
        sb.append(super.toString());
        sb.append("\nQueue: ").append(this.queue);
        sb.append("\nCarros: ").append(this.carros).append("\n");
        return sb.toString();
    }

    public Proprietario clone(){
        return new Proprietario(this);
    }
}
