public class Lampada
{
    //parâmetros que caracterizam a classe
    private boolean ligada;

    //construtores da classe
    // 1 - construtor vazio
    public Lampada()
    { this.ligada = false; }

    // 2 - construtor por parâmetros
    public Lampada (boolean estado)
    { this.ligada = estado; }

    // 3 - construtor por cópia
    public Lampada (Lampada l)
    { this.ligada = l.getLigada(); }

    //outros métodos necessários
    public boolean getLigada()
    { return this.ligada; }

    public void setLigada (boolean estado)
    { this.ligada = estado; }

    public String toString1()
    { return "Lampada: " + (this.ligada? "ou" : "off"); }

    public Lampada clone1()
    { return (new Lampada(this)); }

    public boolean equals1 (Object o) //queremos comparar não só com outras Lampadas, mas também outros objetos
    {
        if (o == this) return true; //aponta para o mesmo sítio que o this, logo são iguais
        if ((o == null) || (o.getClass() != this.getClass())) return false;
        //se chegarmos a este ponto, verifica-se que o 'o' é uma Lampada

        Lampada l = (Lampada) o;
        return (this.ligada = l.getLigada());
    }
}
