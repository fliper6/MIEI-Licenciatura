public class LuzSala
{
    private Lampada[] luzes;

    public LuzSala ()
    {
        this.luzes = new Lampada[15];
        for (int i = 0; i < 15; i++)
            luzes[i] = new Lampada(false);
    }

    public void ligarTodas ()
    {
        for (int i = 0; i < 15; i++)
            this.luzes[i].setLigada(true);
    }

    public void ligarMetade ()
    {
        for (int i = 0; i < 15; i+=2)
            this.luzes[i].setLigada(true);
    }

    public void desligarTodas ()
    {
        for (int i = 0; i < 15; i++)
            this.luzes[i].setLigada(false);
    }

    public String toString () {
        String str = "";
        for (int i = 0; i < 15; i++)
            str += this.luzes[i].toString() + "\n";
        return str;
    }
}
