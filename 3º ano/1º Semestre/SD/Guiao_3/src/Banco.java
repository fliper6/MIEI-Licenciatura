import java.util.HashMap;
import java.util.concurrent.locks.ReentrantLock;

public class Banco {
    private HashMap<Integer,Conta> contas;
    private ReentrantLock lockBanco;
    private int lastId = 0;

    public Banco() {
        this.contas = new HashMap<Integer,Conta>();
        this.lockBanco = new ReentrantLock();
    }

    //uma versão melhor era ter um lock diferente para o id e só dar lock ao banco ao fazer o put
    //neste caso, o banco está locked enquanto se incrementa o id, cria a conta e faz o put
    //mas os dois primeiros passos são independentes das outras operações de levantar, depositar, e transferir
    public int criarConta(double saldo){
        this.lockBanco.lock(); //estamos a alterar a estrutura do hashmap logo é preciso bloquear o acesso de outras threads
        int id = lastId++; //novo id tem de ser obtido dentro da secção crítica, senão duas threads podem criar 2x a mesma conta
        Conta c = new Conta(id,saldo);
        this.contas.put(id, c);
        this.lockBanco.unlock();

        return id;
    }

    public double fecharConta(int id) throws ContaInvalida{
        this.lockBanco.lock();
        if (contas.containsKey(id)) {
            Conta c = this.contas.get(id);
            c.lock(); /*é necessário dar lock à conta senão podia apagá-la enquanto outra thread tentava fazer outra
            operação e dava null pointer*/
            double saldo = c.consultar();
            this.contas.remove(id);
            c.unlock();
            this.lockBanco.unlock();
            return saldo;
        } else {
            this.lockBanco.unlock();
            throw new ContaInvalida(id);
        }
    }

    public double consultar(int id) throws ContaInvalida{
        this.lockBanco.lock();
        if(!contas.containsKey(id)) {
            this.lockBanco.unlock();
            throw new ContaInvalida(id);
        } else {
            Conta c = this.contas.get(id);
            c.lock();
            this.lockBanco.unlock();
            double saldo = c.consultar();
            c.unlock();
            return saldo;
        }
    }

    public void levantar(int id, double valor) throws SaldoInsuficiente, ContaInvalida{
        this.lockBanco.lock();
        if(!contas.containsKey(id)){
            //conta não existe
            this.lockBanco.unlock();
            throw new ContaInvalida(id);
        }
        //caso exista adquirir lock
        Conta c = this.contas.get(id);
        c.lock();
        this.lockBanco.unlock();

        if(c.consultar() < valor) {
            //saldo insuficiente
            c.unlock();
            throw new SaldoInsuficiente(id);
        } else {
            c.levantar(valor);
            c.unlock();
        }

    }

    public void depositar(int id, double valor) throws ContaInvalida{
        //garantir que outra thread concorrente não fecha a conta enquanto estamos a verificar se existe
        //lock ao banco - esta parte do código não permite concorrência

        //não se pode dar logo lock à conta porque primeiro é preciso verificar se a conta existe
        //tentar dar lock a um objeto inexistente dava erro!!
        this.lockBanco.lock();
        if(!contas.containsKey(id)){
            //conta não existe
            //se a exceção for lançada, o código seguinte nunca é executado, logo é necessário ter um unlock ao banco
            //aqui também, senão fica bloqueado perpetuamente
            this.lockBanco.unlock();
            throw new ContaInvalida(id);
        }
        //caso exista, é fundamental dar lock à conta antes de dar unlock ao banco
        Conta c = this.contas.get(id);
        c.lock();
        this.lockBanco.unlock();

        //depositar valor - esta operação só necessita do lock à conta, o banco já está livre - concorrência
        c.depositar(valor);
        c.unlock();
    }

    public void transferir(int conta_origem, int conta_destino, double valor) throws ContaInvalida, SaldoInsuficiente {
        Integer conta_min = Math.min(conta_origem, conta_destino);
        Integer conta_max = Math.max(conta_origem, conta_destino);

        this.lockBanco.lock();
        if(this.contas.containsKey(conta_min)) {
            this.contas.get(conta_min).lock();
        }
        else{
            this.lockBanco.unlock();
            throw new ContaInvalida(conta_min);
        }

        if(this.contas.containsKey(conta_max)) {
            this.contas.get(conta_max).lock();
        } else {
            //se conta_max não existir, libertar lock da conta_min já adquirido para evitar deadlocks
            this.contas.get(conta_min).unlock();
            this.lockBanco.unlock();
            throw new ContaInvalida(conta_max);
        }

        this.lockBanco.unlock();
        if(this.contas.get(conta_origem).consultar() < valor) {
            //saldo insuficiente
            this.contas.get(conta_origem).unlock();
            this.contas.get(conta_destino).unlock();
            throw new SaldoInsuficiente(conta_origem);
        } else {
            this.contas.get(conta_origem).levantar(valor);
            this.contas.get(conta_destino).depositar(valor);
            //a ordem dos unlocks é irrelevante
            this.contas.get(conta_min).unlock();
            this.contas.get(conta_max).unlock();
        }
    }

}
