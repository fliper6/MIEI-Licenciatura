public class HotelPremium extends Hotel{

    private double taxaLuxo;

    /**
     * Construtor para objetos da classe HotelPremium
     */
    public HotelPremium(){
        super();
        this.taxaLuxo = 0.0;
    }
    public HotelPremium (int codigo, String nome, String localidade, double precoBaseQuarto, double taxaLuxo, int nquartos, String estrelas){
        super(codigo, nome, localidade, estrelas, nquartos, (double) precoBaseQuarto);
        this.taxaLuxo = taxaLuxo;
    }
    public HotelPremium(HotelPremium h){
        super(h);
        this.taxaLuxo = h.getTaxaLuxo();
    }

    public double getTaxaLuxo(){
        return this.taxaLuxo;
    }
    public double precoQuarto(){
        return getPreco() * (1 + getTaxaLuxo());
    }
    public String toString(){

        StringBuffer sb = new StringBuffer();

        sb.append(super.toString());
        sb.append("Taxa Luxo = ").append(this.getTaxaLuxo());
        sb.append("Preco Final = ").append(precoQuarto()).append("$");

        return sb.toString();

    }

    public boolean equals(Object o) {
        if (this == o)
            return true;

        if((o == null) || (this.getClass() != o.getClass()))
            return false;

        HotelPremium uHP = (HotelPremium) o;

        return ( super.equals(o) && this.taxaLuxo == uHP.getTaxaLuxo());

    }

    public HotelPremium clone() {
        return new HotelPremium(this);
    }

}