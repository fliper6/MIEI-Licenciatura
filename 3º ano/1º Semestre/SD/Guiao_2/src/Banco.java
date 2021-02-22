public class Banco {
    private double contas[];

    public Banco (int n) {
        this.contas = new double[n];
        for (int i = 0; i < n; i++) {
            contas[i] = 0;
        }
    }

    public synchronized double consultar (int conta) {
        return this.contas[conta];
    }

    /* Com os synchronized, garantimos que a ação de depositar e levantar são blocos com exclusão mútua.
       Também é garantido que as duas operações são executadas ordenadamente porque, mesmo que uma
        thread T1 comece a levantar, se uma thread T2 quiser depositar, o lock impedir enquanto a
                                    T1 estiver a levantar.
    */

    public synchronized void depositar (int conta, double valor) {
        this.contas[conta] = this.contas[conta] + valor;
    }

    public synchronized void levantar (int conta, double valor) {
        this.contas[conta] = this.contas[conta] - valor;
    }

    /*
    - o método transferir() obtém o lock do Banco
    - dentro dele chama o método levantar() que também é synchronized (precisa do lock)
    - isto funciona porque os locks em Java são reentrantes
    - ao obter o lock, o sistema verifica o id da thread
    - como a thread do levantar() vai ser a mesma do transferir(), o sistema fornece o lock de novo
    - internamente isto funciona como um iterador

    Exemplo:

        transferir()
        lock(Banco) T1 1
            levantar()
            lock(Banco) T1 2
            unlock(Banco) T1 1
            depositar()
            lock(Banco) T1 2
            unlock(Banco) T1 1
        unlock(Banco) T1 0
     */
    public synchronized void transferir(int cO, int cD, double valor) {
        this.levantar(cO,valor);
        this.depositar(cD,valor);
    }
}
