package Business;

public class Pacote {
    
    private String nome;
    private int preco;
    private Boolean desconto;
    private float valorDesconto;
    private int nComps;
    
    public Pacote (String nome, int preco, Boolean desconto, float valorDesconto) {
        this.nome=nome;
        this.preco=preco;
        this.desconto=desconto;
        this.valorDesconto=valorDesconto;
    }
    
    public Pacote (String nome, int preco) {
        this.nome=nome;
        this.preco=preco;
    }
    
    public String getNome () {
        return nome;
    }
    
    public int getPreco () {
        return preco;
    }
    
    public Boolean desconto () {
        return desconto;
    }
    
    public float getValorDesconto () {
        return valorDesconto;
    }
    
    public int getnComps () {
        return nComps;
    }
    
    public void setNome (String nome) {
        this.nome=nome;
    }
    
    public void setPreco (int preco) {
        this.preco=preco;
    }
    
    public void setDesconto (Boolean desconto) {
        this.desconto=desconto;
    }
    
    public void setValorDesconto (float valorDesconto) {
        this.valorDesconto=valorDesconto;
    }
    
    public void setnComps (int nComps) {
        this.nComps=nComps;
    }
    
    @Override
    public String toString () {
        StringBuilder sb = new StringBuilder();
        sb.append("Nome: ").append(nome).append("\n");
        sb.append("Preco: ").append(preco).append("\n");
        if (desconto) {sb.append("Desconto: Sim\nValor do desconto: ").append(valorDesconto).append("\n");        
        }
        sb.append("Numero de componentes: ").append(nComps).append("\n");
        return sb.toString();
    }
    
    public String toString1(){
        StringBuilder sb = new StringBuilder();
        /*sb.append("Nome: ")*/sb.append(this.nome).append("  Preço: ").append(this.preco).append("  Desconto: Sim  Valor do desconto: 10%");
        return sb.toString();
    }
    
}
