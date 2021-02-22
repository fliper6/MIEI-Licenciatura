import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

public class RWLockFairAll {
    private ReentrantLock lock;
    private Condition readersCond;
    private Condition writersCond;
    int readers = 0;
    int writer = 0;

    int writersRequest;
    int readersRequest;
    int MAXPRIORITY = 3;
    int readersPriority;
    int writersPriority;

    public RWLockFairAll(){
        lock = new ReentrantLock();
        readersCond = lock.newCondition();
        writersCond = lock.newCondition();
        readers = writer = 0;
        writersPriority = readersPriority = 0;
        readersRequest = writersRequest = 0;
    }

    public void readLock(){
        //é preciso proteger os acessos aos contadores para evitar escritas cncorrentes
        lock.lock();
        try{
            //esperar enquanto houver algum escritor dentro da secção científica
            //ou se o máximo de leitores permitidos já estiverem a executar
            readersRequest++;

            while(writer == 1 || (writersRequest > 0 && readersPriority >= MAXPRIORITY)){
                readersCond.await();
                //System.out.println("readers priority " + readersPriority + ", writersPriority " + writersPriority);
            }
            readersRequest--;
            readers++;

            readersPriority++;
            //atualizar contadores de prioridade
            if (readersPriority == MAXPRIORITY){
                writersPriority = 0;
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        finally{
            lock.unlock();
        }
    }

    public void writeLock(){
        lock.lock();
        try{
            //esperar enquanto tiver algum leitor ou escritor na secção crítica
            //ou se leitores tiverem prioridade
            writersRequest++;

            while(readers > 0 || (readersRequest > 0 && writersPriority >= MAXPRIORITY)){
                //System.out.println("writers priority " + writersPriority + ", readers priority " + readersPriority);
                try {
                    writersCond.await();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            //entrar na secção crítica e indicar que há um escritor a executar (flag
            writersRequest--;
            writer = 1;

            writersPriority++;
            //atualizar contadores de prioridade
            if (writersPriority == MAXPRIORITY){
                readersPriority = 0;
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }
}
