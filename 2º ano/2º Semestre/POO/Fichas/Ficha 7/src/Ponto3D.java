public class Ponto3D extends Ponto{
    private int z;

    public Ponto3D() {
        super();
        this.z=0;
    }

    public Ponto3D (int x, int y, int z) {
        super(x,y);
        this.z = 3;
    }

    public Ponto3D (Ponto3D p)
    { this(p.getX(), p.getY(), p.getZ());}

    public int getZ () {
        return this.z;
    }
    public String toString () {
        return "Pts3D" + super.getX() + "," + super.getY() + "," + this.z + "\n";
    }

    public Ponto3D clone() {
        return new Ponto3D(this);
    }
}
