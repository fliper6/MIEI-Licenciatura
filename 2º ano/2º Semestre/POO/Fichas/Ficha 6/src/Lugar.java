public class Lugar implements Comparable <Lugar>
{
    private String matricula;

    private String nome;

    private int minutos;

    private boolean permanente;

    public Lugar() {
        this.matricula = "";
        this.nome = "";
        this.minutos = 0;
        this.permanente = false;
    }

    public Lugar(String matricula, String nome, int minutos, boolean permanente) {
        this.matricula = matricula;
        this.nome = nome;
        this.minutos = minutos;
        this.permanente = permanente;
    }


    public Lugar(Lugar umLugar) {
        this.matricula = umLugar.getMatricula();
        this.nome = umLugar.getNome();
        this.minutos = umLugar.getMinutos();
        this.permanente = umLugar.getPermanente();
    }


    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public int getMinutos() {
        return minutos;
    }

    public void setMinutos(int minutos) {
        this.minutos = minutos;
    }

    public boolean getPermanente() {
        return permanente;
    }

    public void setPermanente(boolean permanente) {
        this.permanente = permanente;
    }

    public String toString() {

        StringBuffer sb = new StringBuffer();

        sb.append("Matricula = "+this.getMatricula());
        sb.append("Nome = "+this.getNome());
        sb.append("Minutos = "+this.getMinutos());
        sb.append("Permanente = "+this.getPermanente());

        return sb.toString();

    }

    public boolean equals(Object o) {
        if (this == o)
            return true;

        if((o == null) || (this.getClass() != o.getClass()))
            return false;

        Lugar umLugar = (Lugar) o;
        return (this.matricula.equals(umLugar.getMatricula()) && this.nome.equals(umLugar.getNome())
                && this.minutos == umLugar.getMinutos() && this.permanente == umLugar.getPermanente());
    }

    public Lugar clone() {
        return new Lugar(this);
    }

    public int compareTo (Lugar l) {
        return  this.matricula.compareTo(l.getMatricula());
    }

}