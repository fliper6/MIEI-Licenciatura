public class BancoNovo {
    private Conta contas[];

    public BancoNovo(int n) {
        this.contas = new Conta[n];
        for (int i = 0; i < n; i++) {
            contas[i] = new Conta();
        }
    }

    public double consultar (int conta) {
        return this.contas[conta].consultar();
    }

    public void depositar (int conta, double valor) { this.contas[conta].depositar(valor); }

    public void levantar (int conta, double valor) { this.contas[conta].levantar(valor); }

    /*
    Tentativa 1: Synchronized no método transferir()
    - não funciona porque bloqueia o Banco
    - isto nem sequer resolve o problema de consultas a meio de transferências
    - porque o transferir() dá lock ao Banco mas o consultar() não acede ao lock do Banco, acede ao da conta:

        T1              T2
     lock(Banco)     lock(c0)
     lock(c0)        c0.consultar()
     c0.levantar()      ou
     unlock(c0)      lock(c1)
     lock(c1)        c1.consultar()
     c1.depositar()
     unlock(c1)
     unlock(Banco)

     Tentativa 2: Synchronizeds encadeados de contas sem ordem
        synch(c0){
            synch(c1){
            c0.levantar();
            c1.depositar();
         }}

     - resolve o problema de consultas a meio de transferências
     - problema:

        T1              T2
     lock(c0)         lock(c1)
     lock(c1)         lock(c0)

     - Deadlock! a T1 tenta obter o lock da c1 depois de a T2 o obter e vice-versa com a c0

     Solução: - fazer locks às contas por uma ordem específica
              - por exemplo primeiro à conta com id mais baixo ou a mais alto
              - assim as threads vão tentar obter os locks pela mesma ordem, logo nunca há locks cruzados

        T1              T2              ou              T1              T2
     lock(c0)                                                         lock(c0)
     lock(c1)                                                         lock(c1)
                      lock(c0)                        lock(c0)
                      lock(c1)                        lock(c1)

     - Também é importante a ordem pela qual damos unlock às contas
     - Neste caso, como estamos a usar locks não explícitos, está subentendido que a última conta locked
     é a primeira a ser unlocked
     */
    public void transferir(int cO, int cD, double valor) {
        int conta_min = cO < cD ? cO : cD;
        int conta_max = cO > cD ? cO : cD;
        synchronized(this.contas[conta_min]){
            synchronized(this.contas[conta_max]){
                this.contas[cO].levantar(valor);
                this.contas[cD].depositar(valor);
            }
        }
    }
}
