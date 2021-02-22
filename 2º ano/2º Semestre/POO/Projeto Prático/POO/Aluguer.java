import java.io.Serializable;
import java.time.LocalDate;

public class Aluguer implements Serializable {
    private double tempo;
    private Ponto inicio;
    private Ponto fim;
    private double preco;
    private String matricula;
    private String ID;//id cliente ou proprietario
    private String tipo;//tipo de aluguer
    private LocalDate data;

    public Aluguer(Double tempo, Ponto inicio, Ponto fim, double preco, String matricula, String id, String tipo, LocalDate data) {
        this.tempo = tempo;
        this.inicio = inicio.clone();
        this.fim = fim.clone();
        this.preco = preco;
        this.matricula = matricula;
        this.ID = id;
        this.tipo = tipo;
        this.data = LocalDate.of(data.getYear(), data.getMonth(), data.getDayOfMonth());
    }

    public Aluguer(Aluguer aluguer){
        this.tempo = aluguer.getTempo();
        this.inicio = aluguer.getInicio();
        this.fim = aluguer.getFim();
        this.preco = aluguer.getPreco();
        this.matricula = aluguer.getMatricula();
        this.ID = aluguer.getID();
        this.tipo = aluguer.getTipo();
        this.data = aluguer.getData();
    }

    public Aluguer(){
        this.tempo = 0.0;
        this.inicio = new Ponto();
        this.fim = new Ponto();
        this.preco = 0.0;
        this.matricula = "";
        this.ID = "";
        this.tipo = "";
        this.data = LocalDate.MIN;
    }


    public Double getTempo() {
        return tempo;
    }

    public void setTempo(double tempo) {
        this.tempo = tempo;
    }


    public Ponto getInicio() {
        return this.inicio.clone();
    }

    public void setInicio(Ponto ponto) {
        this.inicio = ponto.clone();
    }


    public Ponto getFim() {
        return this.fim.clone();
    }

    public void setFim(Ponto ponto) {
        this.fim = ponto.clone();
    }


    public Double getPreco() {
        return preco;
    }

    public void setPreco(double preco) {
        this.preco = preco;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }


    public LocalDate getData() {
        return data;
    }

    public void setData(LocalDate data) {
        this.data = data;
    }



    public String toString(){
        StringBuilder sb = new StringBuilder();
        sb.append("\n   Viagem de ").append(this.inicio).append(" ---> ").append(this.fim);
        sb.append("\n   Data: ").append(this.data);
        sb.append("\n   Tempo de viagem: ").append(this.tempo);
        sb.append("\n   Preço: ").append(this.preco);
        sb.append("\n   Matricula veiculo: ").append(this.matricula);
        sb.append("\n   Tipo de aluguer: ").append(this.tipo);
        sb.append("\n   Id: ").append(this.ID).append("\n");
        return sb.toString();
    }

    public Aluguer clone(){
        return new Aluguer(this);
    }
}
