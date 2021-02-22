public class Counter {
    public int count;

    public Counter(){
        this.count = 0;
    }

    public synchronized void increment(){
        this.count++;
    }

    public int get(){
        return this.count;
    }
}
