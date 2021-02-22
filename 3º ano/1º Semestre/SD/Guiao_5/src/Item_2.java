import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

public class Item_2 {
    private ReentrantLock lock;
    private Condition isEmpty;
    private int quantity;

    public Item_2() {
        this.lock = new ReentrantLock();
        this.isEmpty = this.lock.newCondition();
        this.quantity = 0;
    }

    void supply(int quantity) {
        lock.lock();
        //acrescentar quantidade e notificar consumidores
        this.quantity += quantity;
        //não pode ser um signal porque podemos estar a adicionar quantidade > 1 a um item e podemos ter
        //várias threads a tentar consumir o mesmo item
        isEmpty.signalAll();
        lock.unlock();
    }

    void consume() {
        lock.lock();
        try {
            while(quantity==0){
                System.out.println("Consumer_2; não há unidades suficientes");
                isEmpty.await();
            }
            this.quantity--;
        } catch (InterruptedException e) {
            e.printStackTrace();;
        } finally {
            lock.unlock();
        }
    }
}
