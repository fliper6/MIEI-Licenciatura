public class Barreira_3 {
    int N = 10;
    int counter = 0;
    int etapa = 0;

    /*
    Problema:

        T1              T2

    esperar()
    wait()
    counter = 1
    etapa = 0
                      esperar()
                      lock()
                      etapa = 1
                      counter = 2
                      notifyAll()
                      counter = 0
                      etapa++
                      unlock()
    vai dormir de novo
     */

    synchronized public void esperar() throws InterruptedException{
        this.counter++;
        int myEtapa = this.etapa;

        //a primeira vez que passar neste ciclo vai bloquear
        //da próxima vez só vai bloquear se tiver sido acordada por algum motivo estranho
        //ou seja, nunca mais deve bloquear
        while(this.counter < N && myEtapa == this.etapa){
            this.wait();
        }

        if (this.counter == N){
            this.etapa++;
            this.notifyAll();
            this.counter = 0;
        }
    }
}
