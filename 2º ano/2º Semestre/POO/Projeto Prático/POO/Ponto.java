import java.io.Serializable;

public class Ponto implements Serializable {
    private double x;
    private double y;

    public Ponto() {
        this.x = 0.0;
        this.y = 0.0;
    }

    public Ponto(double cx, double cy) {
        this.x = cx;
        this.y = cy;
    }

    public Ponto(Ponto umPonto) {
        this.x = umPonto.getX();
        this.y = umPonto.getY();
    }


    public double getX() {
        return this.x;
    }

    public double getY() {
        return this.y;
    }

    public void setX(double novoX) {
        this.x = novoX;
    }

    public void setY(double novoY) {
        this.y = novoY;
    }


    public void deslocamento(double deltaX, double deltaY) {
        this.x += deltaX;
        this.y += deltaY;
    }

    public void somaPonto(Ponto umPonto) {
        this.x += umPonto.getX();
        this.y += umPonto.getY();
    }


    public void movePonto(double cx, double cy) {
        this.x = cx;  // ou setX(cx)
        this.y = cy;  // ou this.setY(cy)
    }


    public boolean ePositivo() {
        return (this.x > 0 && this.y > 0);
    }


    public double distancia(Ponto umPonto) {

        return Math.sqrt(Math.pow(this.x - umPonto.getX(), 2) +
                Math.pow(this.y - umPonto.getY(), 2));
    }



    public boolean iguais(Ponto umPonto) {
        return (this.x == umPonto.getX() && this.y == umPonto.getY());
    }



    private boolean xIgualAy() {
        return (Math.abs(this.x) == Math.abs(this.y));
    }
    
    public String toString(){
        return "(" + this.getX() + "," + this.getY() + ")";
    }


    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || this.getClass() != o.getClass())
            return false;
        Ponto p = (Ponto) o;
        return (this.x == p.getX() && this.y == p.getY());

    }

    public Ponto clone() {
        return new Ponto(this);
    }
}
