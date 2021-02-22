import java.io.Serializable;
import java.util.*;

public abstract class Pessoa implements Serializable {

    /** Variáveis de Instância */

    private String email;
    private String nome;
    private String password;
    private String morada;
    private String nascimento;
    private String NIF;
    private List<Integer> rating;
    private List<Aluguer> aluguer;


    /** Construtores */

    public Pessoa(String email, String nome, String password, String morada, String nascimento, String nif, List<Integer> rating, List<Aluguer> aluguer) {
        this.email = email;
        this.nome = nome;
        this.password = password;
        this.morada = morada;
        this.nascimento = nascimento;
        this.NIF = nif;
        this.rating = new ArrayList<>(rating);
        this.aluguer = new ArrayList<>();
        for(Aluguer s: aluguer){
            this.aluguer.add(s.clone());
        }
    }

    public Pessoa(Pessoa pessoa) {
        this.email = pessoa.getEmail();
        this.nome = pessoa.getNome();
        this.password = pessoa.getPassword();
        this.morada = pessoa.getMorada();
        this.nascimento = pessoa.getNascimento();
        this.NIF = pessoa.getNIF();
        this.rating = pessoa.getRating();
        this.aluguer = pessoa.getAluguer();
    }

    public Pessoa(){
        this.email = "";
        this.nome = "";
        this.password = "";
        this.morada = "";
        this.nascimento = "1/1/1999";
        this.NIF = "";
        this.rating = new ArrayList<>();
        this.aluguer = new ArrayList<>();
    }



    /** Metodos de Instância */

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }



    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }



    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }



    public String getMorada() {
        return morada;
    }

    public void setMorada(String morada) {
        this.morada = morada;
    }


    public String getNascimento() {
        return nascimento;
    }

    public void setNascimento(String nascimento) {
        this.nascimento = nascimento;
    }


    public String getNIF() {
        return NIF;
    }

    public void setNIF(String NIF) {
        this.NIF = NIF;
    }


    public List<Integer> getRating(){
        return new ArrayList<>(this.rating);
    }

    public void setRating(List<Integer> rating) {
        this.rating = new ArrayList<>(rating);
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
        for (Aluguer s : aluguer) {
            this.aluguer.add(s.clone());
        }
    }

    public void addRating(int rating){
        this.rating.add(rating);
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

    public void addAluguer(Aluguer alug){
        this.aluguer.add(alug);
    }

    public String toString(){
        StringBuilder sb = new StringBuilder();
        sb.append("\nTipo: ").append(this.getClass());
        sb.append("\nUtilizador: ").append(this.nome);
        sb.append("\nEmail: ").append(this.email);
        sb.append("\nPassword: ").append(this.password);
        sb.append("\nMorada: ").append(this.morada);
        sb.append("\nData de nascimento: ").append(this.nascimento);
        sb.append("\nNIF: ").append(this.NIF);
        sb.append("\nRating: ").append(this.mediaRating());
        sb.append("\nAlugueres: ").append(this.aluguer);
        return sb.toString();
    }

    public String toString2(){
        StringBuilder sb = new StringBuilder();
        sb.append("\nTipo: ").append(this.getClass());
        sb.append("\nUtilizador: ").append(this.nome);
        sb.append("\nEmail: ").append(this.email);
        sb.append("\nPassword: ").append(this.password);
        sb.append("\nMorada: ").append(this.morada);
        sb.append("\nData de nascimento: ").append(this.nascimento);
        sb.append("\nNIF: ").append(this.NIF);
        sb.append("\nRating: ").append(this.mediaRating());
        return sb.toString();
    }

    public boolean equals(Pessoa pessoa){
        return this.NIF.equals(pessoa.getNIF());
    }

    public abstract Pessoa clone();
}
