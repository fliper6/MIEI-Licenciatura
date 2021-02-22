import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class Shuttle {
    Lock lock = new ReentrantLock();
    Condition espera_entrar, espera_sair;
    private int terminal = 1; // 5 terminais (1-2-3-4-5-1)
    private int nr_passageiros = 0; //maximo 30
    Condition passageiros_a_entrar, passageiros_a_sair;
    int pDestino[] = new int[5];
    int pEspera[] = new int[5];
    int bilhetesVendidos[] = new int[5];
    int bilhetesUsados[] = new int[5];

    public Shuttle() {
        for (int i = 0; i < 5; i++){
            pDestino[i] = 0;
            pEspera[i] = 0;
            bilhetesVendidos[i] = 1;
            bilhetesUsados[i] = 0;
        }
    }

    public void requisita_viagem(int origem, int destino) throws InterruptedException {
        lock.lock();
        pEspera[origem]++;
        int meuBilhete = bilhetesVendidos[origem]++;
        while (!(terminal == origem && nr_passageiros < 30 && meuBilhete <= bilhetesVendidos[origem] + 30 - nr_passageiros)){
            espera_entrar.await();
        }
        bilhetesUsados[origem]--;
        pDestino[destino]++;
        nr_passageiros++;
        passageiros_a_entrar.signalAll();
        pEspera[origem]--;
        lock.unlock();
    }

    public void espera(int destino) throws InterruptedException {
        lock.lock();
        while(terminal != destino){
            espera_sair.await();
        }
        pDestino[destino]--;
        nr_passageiros--;
        passageiros_a_sair.signalAll();
        lock.unlock();
    }

    public void partida() throws InterruptedException {
        lock.lock();
        passageiros_a_sair.signalAll();
        while(pDestino[terminal] != 0){
            passageiros_a_sair.await();
        }
        passageiros_a_entrar.signalAll();
        while(nr_passageiros < 30 && !(nr_passageiros > 10 && pEspera[terminal] == 0)){
            passageiros_a_entrar.await();
        }
        wait(5*60*1000);
        if (terminal == 5) terminal = 1;
        else terminal++;
        lock.unlock();
    }
}
