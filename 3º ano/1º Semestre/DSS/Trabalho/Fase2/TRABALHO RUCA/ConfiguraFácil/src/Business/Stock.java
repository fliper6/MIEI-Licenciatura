package Business;


public class Stock {
    
    private String nome;
    private String categoria;
    private int preco;
    private int unidades;
    
    public Stock (String nome, String categoria, int unidades) {
        this.nome = nome;
        this.categoria = categoria;
        this.unidades = unidades;
    }
    
    public Stock (String nome, String categoria, int preco, int unidades) {
        this.nome=nome;
        this.categoria=categoria;
        this.unidades=unidades;
        this.preco=preco;
    }
    
    public Stock (String nome, int unidades) {
        this.nome=nome;
        this.unidades=unidades;
    }
    
    public String getNome () {
        return this.nome;
    }
    
    public String getCategoria () {
        return categoria;
    }
    
    public int getUnidades () {
        return unidades;
    }
    
    public void setNome (String nome) {
        this.nome=nome;
    }
    
    public void setCategoria (String categoria) {
        this.categoria=categoria;
    }
    
    public void setUnidades (int unidades) {
        this.unidades=unidades;
    }
    
    @Override
    public String toString () {
        StringBuilder sb = new StringBuilder();
        sb.append("Nome: ").append("+nome+").append("\n");
        sb.append("Categoria ").append("+categoria+").append("\n");
        sb.append("Unidades: ").append("+unidades+").append("\n");
        return sb.toString();
    }
    
    public String toString1 () {
        StringBuilder sb = new StringBuilder();
        sb.append("Nome: ").append(this.nome).append("    Unidades: ").append(this.unidades);
        return sb.toString();
    }
    
}
