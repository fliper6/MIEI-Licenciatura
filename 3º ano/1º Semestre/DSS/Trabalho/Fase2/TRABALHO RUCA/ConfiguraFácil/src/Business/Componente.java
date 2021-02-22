package Business;

public class Componente {
    
    private String nome;
    private String categoria;
    private int preco;
    
    public Componente (String nome, String categoria, int preco) {
        this.nome = nome;
        this.categoria = categoria;
        this.preco = preco;
    }
    
    public String getNome () {
        return nome;
    }
    
    public String getCategoria () {
        return categoria;
    }
    
    public int getPreco () {
        return preco;
    }
    
    public void setNome (String nome) {
        this.nome = nome;
    }
    
    public void setCategoria (String categoria) {
        this.categoria = categoria;
    }
    
    public void setPreco (int preco) {
        this.preco = preco;
    }
    
    public boolean equals(Object c) {
        return (this.nome.equals(((Componente)c).getNome()));
    }
    
    @Override
    public String toString () {
        StringBuilder sb = new StringBuilder ();
        sb.append("Nome: ").append(this.nome).append("   Categoria: ").append(this.categoria).append("    Preço: ").append(preco).append("\n");
        return sb.toString();
    }
    
    public String toString1 () {
        StringBuilder sb = new StringBuilder ();
        sb.append("Nome: ").append(this.nome).append("   Categoria: ").append(categoria).append("\n");
        return sb.toString();
    }
    
    public String toString2() {
        StringBuilder sb = new StringBuilder();
        sb.append("Nome: ").append(this.nome).append("   Preço: ").append(this.preco).append("\n");
        return sb.toString();
    }
}
