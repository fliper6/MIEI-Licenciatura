public class Incrementer2 implements Runnable {

    private Counter counter;
    private int maxInc;

    public Incrementer2(int i, Counter c){
        this.counter = c;
        this.maxInc = i;
    }

    public void run(){
        //synchronized(this.counter);
        //diferença entre chamar synch aqui ou dentro do ciclo?
        //aqui nao funciona pq cada thread executa o ciclo inteiro
        //logo e uma execuçao sequencial, e como se nao houvesse threads
        //mais valia ter dois ciclos encadeados

        for (int i = 0 ; i < this.maxInc ; i++){
            synchronized (this.counter){
                this.counter.increment(); //this.count++ não funciona
            }
            //synchronized no this ou this.counter
            //o this nao funciona porque neste codigo em especifico cria
            //para cada threas uma instancia do contador (main)
            //- a regiao critica nao esta protegida porque como se nao es
            //com o this.counter todas as threads tem a referencia para
        }
    }
}