public class HotelStandard extends Hotel implements CartaoHoteis{

    private boolean epocaAlta;

    //AULA
    private int pontos;

    public void setPontosEuro (int pts)
    { this.pontos = pts;}

    public int getPontosEuro ()
    { return this.pontos; }
    //AULA


    /**
     * Construtor para objetos da classe HotelStandard
     */
    public HotelStandard(){
        super();
        this.epocaAlta = false;
    }

    public HotelStandard (int codigo, String nome, String localidade
            , double precoBaseQuarto, boolean epocaAlta, int nquartos, String estrelas){
        super(codigo, nome, localidade, estrelas, nquartos, (double) precoBaseQuarto);
        this.epocaAlta = epocaAlta;
    }

    public HotelStandard(HotelStandard c){
        super(c);
        this.epocaAlta = c.getEpoca();
    }

    public boolean getEpoca(){
        return this.epocaAlta;
    }

    public void setEpoca(boolean epoca){
        this.epocaAlta = epoca;
    }

    public double precoQuarto(){
        return getPreco() + (epocaAlta ? 20 : 0);
    }

    public String toString() {

        StringBuffer sb = new StringBuffer();

        sb.append(super.toString());
        sb.append("Epoca Alta= ").append(this.getEpoca());
        sb.append("Preco final = ").append(precoQuarto()).append("$");

        return sb.toString();

    }

    //AULA
    public boolean equalsAULA(Object o) {
        if (this == o)
            return true;

        if((o == null) || (this.getClass() != o.getClass()))
            return false;

        HotelStandard h = (HotelStandard) o;

        return super.equals(h) && this.pontos == h.getPontosEuro();
    }
    //AULA

    public boolean equals(Object o) {
        if (this == o)
            return true;

        if((o == null) || (this.getClass() != o.getClass()))
            return false;

        HotelStandard uHS = (HotelStandard) o;

        return ( super.equals(o) && this.epocaAlta == uHS.getEpoca());

    }

    public HotelStandard clone() {
        return new HotelStandard(this);
    }


    public double precoNoite(){
        return getPreco() + (this.epocaAlta? 20:0);
    }

    /*
    public double precoMedio(){
        double sum;
        for(Hotel h:this.hoteis.values()) sum += h.precoNoite();
        return sum/this.hoteis.size();
    }
    */
}
