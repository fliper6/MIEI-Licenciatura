public class Conta {
    /*
    - ter cuidado com tipos mutáveis, nomeadamente Integer e Double
    - estes criam um objeto novo cada vez que se altera o valor de um objeto
    - isso gera uma nova entidade com um lock diferente
     */
    public double saldo;

    public Conta(){
        this.saldo = 0;
    }
    public synchronized void depositar(double valor){
        this.saldo -= valor;
    }

    /*
    Equivalente a ter, na classe Banco:
        levantar(int idConta){
            synchronized(this.contas[idConta]){
                this.contas[idConta].levantar();
        }}
     */
    public synchronized void levantar(double valor){
        this.saldo += valor;
    }

    public synchronized double consultar(){
        return saldo;
    }
}
