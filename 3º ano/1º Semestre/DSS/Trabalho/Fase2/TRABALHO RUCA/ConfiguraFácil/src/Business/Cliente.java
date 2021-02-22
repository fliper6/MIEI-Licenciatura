package Business;

public class Cliente {
    private int nif;
    private String nome;
    private String morada;
    private int telefone;
    private float saldo;
    
    public Cliente(int nif, String nome, String morada, int telefone) {
        this.nif = nif;
        this.nome = nome;
        this.morada = morada;
        this.telefone = telefone;
    }
    
    public Cliente (int nif, String nome, String morada, int telefone, float saldo) {
        this.nif=nif;
        this.nome=nome;
        this.morada=morada;
        this.telefone=telefone;
        this.saldo=saldo;
    }
    
    public int getNIF() {
        return nif;
    }
    
    public String getNome() {
        return nome;
    }
    
    public String getMorada() {
        return morada;
    }
    
    public int getTelefone() {
        return telefone;
    }
    
    public float getSaldo() {
        return saldo;
    }
    
    public void setNIF(int nif) {
        this.nif = nif;
    }
    
    public void setNome(String nome) {
        this.nome = nome;
    }
    
    public void setMorada(String morada) {
        this.morada = morada;
    }
    
    public void setTelefone(int telefone) {
        this.telefone = telefone;
    }
    
    public void setSaldo(float saldo) {
        this.saldo=saldo;
    }
    
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder ();
        sb.append("NIF: ").append(nif).append("\n");
        sb.append("Nome: ").append(nome).append("\n");
        sb.append("Morada: ").append(morada).append("\n");
        sb.append("Telefone: ").append(nome).append("\n");
        return sb.toString();
    }
    
    public String toString1() {
        StringBuilder sb = new StringBuilder();
        sb.append("Nome:").append(nome).append("  NIF:").append(nif).append("  Morada:").append(morada).append("  Telefone:").append(telefone).append("  Saldo:").append(saldo+"\n");
        return sb.toString();
    }
}
