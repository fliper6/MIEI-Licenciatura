import java.util.concurrent.locks.ReentrantLock;

public class Conta {
    /*
    - ter cuidado com tipos mutáveis, nomeadamente Integer e Double
    - estes criam um objeto novo cada vez que se altera o valor de um objeto
    - isso gera uma nova entidade com um lock diferente
     */
    private int id;
    private double saldo;
    private ReentrantLock lockConta;

    public Conta(int id, double saldo){
        this.id = id;
        this.saldo = saldo;
        this.lockConta = new ReentrantLock();
    }

    public void lock(){ this.lockConta.lock();}

    public void unlock(){ this.lockConta.unlock();}

    public void depositar(double valor){ this.saldo -= valor;}

    public void levantar(double valor){ this.saldo += valor;}

    public double consultar(){ return this.saldo;}
}
