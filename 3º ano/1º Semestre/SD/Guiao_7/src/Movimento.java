public class Movimento {
    private int opid;
    private String description;
    private double valor;
    private double saldo;

    public Movimento(int opid, String description, double saldo, double valor){
        this.opid = opid;
        this.saldo = saldo;
        this.description = description;
        this.valor = valor;
    }

    public int getOpid() {return opid;}
    public String getDescription() {return description;}
    public double getValor() {return valor;}
    public double getSaldo() {return saldo;}
}
