import java.io.*;
import java.util.*;

public class HoteisInc {
    private Map<String, Hotel> hoteis;

    public List<CartaoHoteis> classPontos() {
        List<CartaoHoteis> l = new ArrayList<>();
        for (Hotel h : this.hoteis.values())
            if (h instanceof HotelStandard || h instanceof HotelPremium) {
                CartaoHoteis ch = (CartaoHoteis) h.clone();
                l.add(ch);
            }
        return l;
    }

    public void adicionar(Hotel h) throws HotelExisteException {
        if (this.hoteis.containsKey(h.getNome()))
            throw new HotelExisteException(h.getNome());
        else
            this.hoteis.put(h.getNome(), h.clone());
    }
}

    //o mesmo para remover

    /*
    public void graveFicheirotxt (String fich) Hoteis IOExecption {
        PrintWriter pw = new PrintWriter(fich);
        pw.print(this);
        pw.flush();
        pw.clone();
    }

    public void graveObj (String fich) {
        ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(fich));
        oos.writeObject(this);
        oos.flush();
        oos.clone();
    }

    public static HoteisInc lerObj (String fich) throws FileNotFoundException, IOExecption, ClassNotFoundExcepiton {
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(fich));
        HoteisInc hi = (HoteisInc) ois.readObject();
        ois.clone();
        return hi;
    }

*************************************** Versão do Correia ***********************************************
import java.util.*;

public class HoteisInc{
    // variáveis de instância - substitua o exemplo abaixo pelo seu próprio
    // values para iterar um map
    private String nomeCadeia;
    private Map<Integer, Hotel> hoteis;


    //COnstrutor para objetos da classe HoteisInc

    public HoteisInc(){
        // inicializa variáveis de instância
        this.nomeCadeia = "";
        this.hoteis = new HashMap<>();
    }
    public HoteisInc(Map<Integer, Hotel> h, String nome){
        // inicializa variáveis de instância
        this.nomeCadeia = nome;
        this.hoteis = new HashMap<>();

        this.hoteis = h.values().stream().collect(Collectors.toMap((e) -> e.getId(), (e) -> e.clone()));
    }
    public HoteisInc(HoteisInc oHI){
        this.nomeCadeia = oHI.getNomeCadeia();
        this.hoteis = oHI.getHoteis();
    }
    public Map<Integer, Hotel> getHoteis(){
        return this.hoteis.entrySet().stream().collect(Collectors.toMap(e->e.getKey(), e->e.getValue().clone()));
    }
    public void setHoteis(Map<Integer, Hotel> h){
        this.hoteis = h.entrySet().stream().collect(Collectors.toMap(e->e.getKey(), e->e.getValue().clone()));
    }
    public String getNomeCadeia(){
        return this.nomeCadeia;
    }
    public boolean existeHotel(int cod){
        return this.hoteis.containsKey(cod);
    }
    public int quantos(){
        return this.hoteis.size();
    }
    public int quantos(String loc){
        return (int) this.hoteis.values().stream().filter(h->h.getLocalidade().equals(loc)).count();
    }
    public Hotel getHotel(int cod){
        return this.hoteis.get(cod).clone();
    }
    public void adiciona(Hotel h){
        this.hoteis.put(h.getId(),h.clone());
    }
    public List<Hotel> getHoteisList(){
        return this.hoteis.values().stream().map(Hotel:: clone).collect(Collectors.toList());
    }
    public void adiciona(Set<Hotel> hs){
        for(Hotel aux: hs) {
            this.hoteis.put(aux.getId(),aux.clone());
        }
    }
    public int quantosT(String tipo){
        return (int) this.hoteis.values().stream().filter(h -> h.getClass().getSimpleName().equals(tipo)).count();
    }
    public void mudaPara(String epoca){
        for(Hotel h : hoteis.values()){
            if(h instanceof HotelStandard){
                if(epoca.equals("Alta")){
                    ((HotelStandard) h).setEpoca(true);
                }else{
                    ((HotelStandard) h).setEpoca(false);
                }
            }
        }
    }
}
*/
