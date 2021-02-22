import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;
import java.util.Set;
import java.util.List;
import java.util.TreeSet;

public class Parque
{
    private String nomeLugar;
    private Map<String,Lugar> lugares;

    public Parque(){
        this.nomeLugar="n/a";
        this.lugares = new HashMap<>();
    }


    public Parque(String nome, Map<String,Lugar> lugs){
        this.nomeLugar=nome;
        this.lugares = new HashMap<>();
        for (Lugar l: lugs.values()){
            this.lugares.put(l.getMatricula(),l.clone());
        }
    }


    public Parque(Parque outroParque){
        this.nomeLugar=outroParque.getNomeLugar();
    }


    public String getNomeLugar(){
        return this.nomeLugar;
    }


    public void registaLugar(Lugar l){
        this.lugares.put(l.getNome(),l.clone());
    }


    public void removeLugar(Lugar l){
        this.lugares.remove(l.getMatricula());
    }


    public int totalMinutos(){
        return this.lugares.values().stream().mapToInt(Lugar :: getMinutos).sum();
    }


    public Map<String,Lugar> getLugares(){
        Map<String,Lugar> res = new HashMap<>();
        res = this.lugares.values().stream()
                .collect(Collectors.toMap(l->l.getMatricula(),l->l.clone()));
        return res;
    }


    public Set<String> getMatriculas(){
        return this.lugares.keySet();
    }


    public List<String> getMatriculasTempo(int x){
        return this.lugares.values().stream()
                .filter(l->l.getMinutos()>x && l.getPermanente())
                .map(Lugar :: getMatricula)
                .collect(Collectors.toList());
    }


    public Set<Lugar> ordenaMinutos(){
        TreeSet<Lugar> ts =  new TreeSet<>(new ComparadorLugarTempo());
        for(Lugar l : this.lugares.values()){
            ts.add(l.clone());
        }
        return ts;
    }


    public TreeSet<Lugar> ordenaLugar(){
        TreeSet<Lugar> ts = new TreeSet<>();
        for(Lugar l: this.lugares.values()){
            ts.add(l.clone());
        }
        return ts;
    }
}