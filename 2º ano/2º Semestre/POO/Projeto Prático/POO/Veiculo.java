import java.io.Serializable;
import java.lang.reflect.Array;
import java.util.*;

public abstract class Veiculo implements Serializable {
    private String marca;
    private String matricula;
    private String prop;//nif do prop
    private double velocidade;
    private double preco;
    private double consumo;
    private int autonomia;
    private int autonomiaMax;
    private Ponto posicao;
    private List<Integer> rating;
    private List<Aluguer> aluguer;

    /** Construtores */

    public Veiculo(Ponto posicao, Double velocidade, String prop, Double preco, Double consumo, int autonomia, int autmax, String matricula, String marca, List<Integer> rating, List<Aluguer> aluguer) {
        this.marca = marca;
        this.matricula = matricula;
        this.prop = prop;
        this.velocidade = velocidade;
        this.preco = preco;
        this.consumo = consumo;
        this.autonomia = autonomia;
        this.autonomiaMax = autmax;
        this.posicao = posicao.clone();
        this.rating = new ArrayList<>(rating);
        this.aluguer = new ArrayList<>();
        for(Aluguer s: aluguer){
            this.aluguer.add(s.clone());
        }
    }

    public Veiculo(Veiculo veiculo) {
        this.marca = veiculo.getMarca();
        this.matricula = veiculo.getMatricula();
        this.prop = veiculo.getProp();
        this.velocidade = veiculo.getVelocidade();
        this.preco = veiculo.getPreco();
        this.consumo = veiculo.getConsumo();
        this.autonomia = veiculo.getAutonomia();
        this.autonomiaMax = veiculo.getAutonomiaMax();
        this.posicao = veiculo.getPosicao();
        this.rating = veiculo.getRating();
        this.aluguer = veiculo.getAluguer();
    }

    public Veiculo() {
        this.marca = "";
        this.matricula = "";
        this.prop = "";
        this.velocidade = 0.0;
        this.preco = 0.0;
        this.consumo = 0.0;
        this.autonomia = 0;
        this.autonomiaMax = 0;
        this.posicao = new Ponto();
        this.rating = new ArrayList<>();
        this.aluguer = new ArrayList<>();
    }


    /** Métodos de instância */

    public Ponto getPosicao() {
        return this.posicao.clone();
    }

    public void setPosicao(Ponto ponto) {
        this.posicao = ponto.clone();
    }

    public Double getVelocidade() {
        return velocidade;
    }

    public void setVelocidade(Double velocidade) {
        this.velocidade = velocidade;
    }

    public Double getPreco() {
        return preco;
    }

    public void setPreco(Double preco) {
        this.preco = preco;
    }

    public Double getConsumo() {
        return consumo;
    }

    public void setConsumo(Double consumo) {
        this.consumo = consumo;
    }

    public int getAutonomia() {
        return autonomia;
    }

    public void setAutonomia(int autonomia) {
        this.autonomia = autonomia;
    }

    public String getProp() {
        return prop;
    }

    public void setProp(String prop) {
        this.prop = prop;
    }


    public int getAutonomiaMax() {
        return autonomiaMax;
    }

    public void setAutonomiaMax(int autonomiaMax) {
        this.autonomiaMax = autonomiaMax;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public List<Integer> getRating(){
        return new ArrayList<>(this.rating);
    }

    public void setRating(List<Integer> rating) {
        this.rating = new ArrayList<>(rating);
    }
    
    public int mediaRating(){
        int media = 0;
        for (Integer i: this.rating){
            media += i;
        }
        if (media != 0){
            media /= this.rating.size();
        }
        return media;
    }

    public List<Aluguer> getAluguer(){
        List<Aluguer> alug = new ArrayList<>();
        for(Aluguer l: this.aluguer) {
            alug.add(l.clone());
        }
        return alug;
    }

    public void setAluguer(List<Aluguer> aluguer) {
        this.aluguer = new ArrayList<>();
        for(Aluguer s: aluguer){
            this.aluguer.add(s.clone());
        }
    }

    public void addRating(int rating){
        this.rating.add(rating);
    }

    public void addAluguer(Aluguer alug){
        this.aluguer.add(alug.clone());
    }

    public void alteraAutonomia(int aut){
        this.autonomia = this.autonomia-aut;
    }

    public String toString(){
        StringBuilder sb = new StringBuilder();
        sb.append("\n   Tipo: ").append(this.getClass());
        sb.append("\n   Matricula: ").append(this.matricula);
        sb.append("\n   Marca: ").append(this.marca);
        sb.append("\n   Proprietario: ").append(this.prop);
        sb.append("\n   Posiçao: ").append(this.posicao);
        sb.append("\n   Velocidade: ").append(this.velocidade);
        sb.append("\n   Preço: ").append(this.preco);
        sb.append("\n   Consumo: ").append(this.consumo);
        sb.append("\n   Autonomia: ").append(this.autonomia);
        sb.append("\n   AutonomiaMax: ").append(this.autonomiaMax);
        sb.append("\n   Rating: ").append(this.mediaRating());
        sb.append("\n   Alugueres: ").append(this.aluguer).append("\n");
        return sb.toString();

    }

    public String toString2(){
        StringBuilder sb = new StringBuilder();
        sb.append("\n   Tipo: ").append(this.getClass());
        sb.append("\n   Matricula: ").append(this.matricula);
        sb.append("\n   Marca: ").append(this.marca);
        sb.append("\n   Proprietario: ").append(this.prop);
        sb.append("\n   Posiçao: ").append(this.posicao);
        sb.append("\n   Velocidade: ").append(this.velocidade);
        sb.append("\n   Preço: ").append(this.preco);
        sb.append("\n   Consumo: ").append(this.consumo);
        sb.append("\n   Autonomia: ").append(this.autonomia);
        sb.append("\n   AutonomiaMax: ").append(this.autonomiaMax);
        sb.append("\n   Rating: ").append(this.mediaRating());

        return sb.toString();

    }
    public boolean equals(Veiculo veiculo){
        return this.matricula.equals(veiculo.getMatricula());
    }

    public abstract Veiculo clone();
}
