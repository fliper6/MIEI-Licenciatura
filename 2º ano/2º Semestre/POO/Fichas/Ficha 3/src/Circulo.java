public class Circulo {
    private int x;
    private int y;
    private int raio;

    //construtores da classe
    // 1 - construtor vazio
    public Circulo() {
        this.x = 0;
        this.y = 0;
        this.raio = 0;
    }

    // 2 - construtor por parâmetros
    public Circulo(int a, int b, int r) {
        this.x = a;
        this.y = b;
        this.raio = r;
    }

    // 3 - construtor por cópia
    public Circulo(Circulo c) {
        this.x = c.getX();
        this.y = c.getY();
        this.raio = c.getRaio();
    }

    //outros métodos necessários
    public int getX()
    { return this.x; }

    public int getY()
    { return this.y; }

    public int getRaio()
    { return this.raio; }

    public String toStringCirculo()
    { return "Circulo de abcissa " + (this.x) + ", de coordenada " + (this.y) + "e de raio" + (this.raio); }

    public Circulo cloneCirculo()
    { return (new Circulo(this)); }

    public boolean equals1 (Object o)
    {
        if (o == this) return true;
        if ((o == null) || (o.getClass() != this.getClass())) return false;

        Circulo c = (Circulo) o;
        return (this.x == c.getX() && this.y == c.getY() && this.raio == c.getRaio() );
    }
}
