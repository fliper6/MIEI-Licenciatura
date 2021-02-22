package Business;

public class Configuracao {
    
    private int id;
    private int preco;
    private String estado;
    private int idCliente;
    
    public Configuracao (int id, int preco, int idCliente, String estado) {
        this.id=id;
        this.preco=preco;
        this.idCliente=idCliente;
        this.estado=estado;
    }
    
    public int getId () {
        return this.id;
    }
    
    public int getPreco () {
        return this.preco;
    }
    
    public void setId (int id) {
        this.id=id;
    }
    
    public void setPreco (int preco) {
        this.preco=preco;
    }
    
    public int getIdCliente () {
        return this.idCliente;
    }
    
    public String getEstado () {
        return this.estado;
    }
    
    public void setEstado (String estado) {
        this.estado=estado;
    }
    
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Configuração: ").append(this.id).append("  Estado: ").append(this.estado).append("  Preço: ").append(this.preco).append("  Cliente: ").append(this.idCliente).append("\n");
        return sb.toString();
    }
}
