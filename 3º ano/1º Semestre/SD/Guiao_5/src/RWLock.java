import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

public class RWLock {
    private ReentrantLock lock;
    private Condition waitread;
    private Condition waitwrite;
    int readers = 0;
    int writer = 0;

    public void readLock() {
        lock.lock();
        while(writer > 0){
            try {
                this.waitread.await();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        readers++;
        lock.unlock();
    }

    public void readUnlock() {
        lock.lock();
        readers--;
        if (readers == 0){
            this.waitwrite.signal();
        }
        lock.unlock();
    }

    public void writeLock() {
        lock.lock();
        while (writer > 0 || readers > 0) {
            this.waitwrite.await();
        }
        writer = 1;
        lock.unlock();
    }

    public void writeUnlock() {
        lock.lock();
        writer = 0;
        this.waitwrite.signal();
        this.waitread.signalAll();
        lock.unlock();
    }
}
