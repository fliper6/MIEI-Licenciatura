import javax.swing.*;
import java.io.*;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

import static java.lang.System.out;

public class Logs implements Serializable{
    private Map<String, Proprietario> proprietarios; ///< Proprietarios
    private Map<String, Cliente> clientes; ///< Clientes
    private Map<String, Veiculo> veiculos; ///< Todos os veiculos

    public Logs(){
        this.proprietarios = new HashMap<>();
        this.clientes = new HashMap<>();
        this.veiculos = new HashMap<>();
    }

    public HashMap<String, Proprietario> getProprietarios() {
        HashMap<String,Proprietario> newDrivers = new HashMap<>();
        for (Proprietario d: this.proprietarios.values())
            newDrivers.put(d.getNIF(), d.clone());
        return newDrivers;
    }

    public HashMap<String, Cliente> getClientes() {
        HashMap<String,Cliente> newDrivers = new HashMap<>();
        for (Cliente d: this.clientes.values())
            newDrivers.put(d.getNIF(), d.clone());
        return newDrivers;
    }

    public HashMap<String, Veiculo> getVeiculos() {
        HashMap<String,Veiculo> newDrivers = new HashMap<>();
        for (Veiculo d: this.veiculos.values())
            newDrivers.put(d.getMatricula(), d.clone());
        return newDrivers;
    }



    public void lerLogs(String fichtxt) {
        BufferedReader inFile = null;
        String linha = null;
        try{
            inFile = new BufferedReader(new FileReader(fichtxt));
            while((linha = inFile.readLine()) != null)
                this.filtrarString(linha);
        } catch (IOException e) {out.println(e);}
    }

    public void filtrarString(String fich){
        String[] campos = fich.split("[:,]");
        switch (campos[0]){
            case "NovoProp":
                this.insereProp(parseProp(fich));
                break;
            case "NovoCliente":
                this.insereCliente(parseCliente(fich));
                break;
            case "NovoCarro":
                this.insereVeiculo(parseVeiculo(fich),campos[4]);
                break;
            case "Aluguer":
                this.insereAluguer(fich);
                break;
            case "Classificar":
                this.classifica(fich);
                break;
        }
    }

    public static Proprietario parseProp(String linha){
        String[] campos = linha.split("[:,]");
        Proprietario prop = new Proprietario();
        prop.setNome(campos[1]);
        prop.setNIF(campos[2]);
        prop.setEmail(campos[3]);
        prop.setMorada(campos[4]);
        prop.setPassword(campos[2]);
        return prop;
    }

    public void insereProp(Proprietario prop){
        if(this.proprietarios.containsKey(prop.getNIF())){}
        else {
            this.proprietarios.put(prop.getNIF(), prop);
        }

    }

    public static Cliente parseCliente(String linha){
        String[] campos = linha.split("[:,]");
        Double x,y;
        Cliente cli = new Cliente();
        x=parseDouble(campos[5]);
        y=parseDouble(campos[6]);

        cli.setNome(campos[1]);
        cli.setPassword(campos[2]);
        cli.setEstadoAlug(0);
        cli.setNIF(campos[2]);
        cli.setEmail(campos[3]);
        cli.setMorada(campos[4]);
        cli.setPosicao(new Ponto(x,y));

        return cli;
    }

    public void insereCliente(Cliente cliente){
        if(this.clientes.containsKey(cliente.getNIF())) {}
        else {
            this.clientes.put(cliente.getNIF(), cliente);
        }
    }

    public static Veiculo parseVeiculo(String linha){
        String[] campos = linha.split("[:,]");
        int aut;
        Double x,y,vel,preco,csm;
        Veiculo veic;

        if(campos[1].equals("Gasolina")){ veic = new Gasolina();}
        else if(campos[1].equals("Hibrido")){ veic = new Hibrido();}
        else { veic = new Eletrico();}

        aut=parseInt(campos[8]);
        vel=parseDouble(campos[5]);
        preco=parseDouble(campos[6]);
        csm=parseDouble(campos[7]);
        x=parseDouble(campos[9]);
        y=parseDouble(campos[10]);

        veic.setMarca(campos[2]);
        veic.setMatricula(campos[3]);
        veic.setProp(campos[4]);
        veic.setAutonomia(aut);
        veic.setAutonomiaMax(aut);
        veic.setVelocidade(vel);
        veic.setPreco(preco);
        veic.setConsumo(csm);
        veic.setPosicao(new Ponto(x,y));

        return veic;
    }

    public void insereVeiculo(Veiculo carro,String nif){
        if(this.veiculos.containsKey(nif)){}
        else {
            this.proprietarios.get(nif).addCarro(carro);
            this.veiculos.put(carro.getMatricula(), carro);
        }

    }

    public void classifica(String linha){
        String[] campos=linha.split("[:,]");
        int x;

        try{
            x=Integer.parseInt(campos[2]);
        }catch(NumberFormatException | NullPointerException e){ return;}

        if (campos[1].contains("-")) {
            this.veiculos.get(campos[1]).addRating(x);
        }
        else{
            if (this.clientes.containsKey(campos[1])){this.clientes.get(campos[1]).addRating(x);}
            else {this.proprietarios.get(campos[1]).addRating(x);}
        }
    }

    public double calculaPrecoAluguer(double preco, double distancia){
        Random rand = new Random();
        double n = rand.nextDouble() * 0.5 + 1;
        return distancia * preco * n;
    }

    public void insereAluguer(String linha){
        String[] campos=linha.split("[:,]");

        Veiculo veic;
        Ponto destino = new Ponto(parseDouble(campos[2]),parseDouble(campos[3]));
        Ponto inicio = this.clientes.get(campos[1]).getPosicao();
        double distancia = inicio.distancia(destino);

        if(campos[4].equals("Gasolina")){ veic = new Gasolina();}
        else if(campos[4].equals("Electrico")){
            veic = new Eletrico();
            campos[4]="Eletrico";
        }
        else { veic = new Hibrido();}


        if(campos[5].equals("MaisPerto")){veic = maisPerto(this.clientes.get(campos[1]),veic.getClass(),distancia);}
        else {veic = maisBarato(veic.getClass(),distancia);}

        double tempo = tempoEstimado(inicio,destino,veic.getVelocidade());
        double preco = calculaPrecoAluguer(veic.getPreco(),distancia);
        String matricula = veic.getMatricula();
        LocalDate data = LocalDate.now();
        String nifprop= this.veiculos.get(matricula).getProp();
        Aluguer alug = new Aluguer(tempo,inicio,destino,preco,matricula,campos[1],campos[5],data);

        this.veiculos.get(veic.getMatricula()).addAluguer(alug);
        this.proprietarios.get(nifprop).addAluguer(alug);
        alug.setID(nifprop);
        this.clientes.get(campos[1]).addAluguer(alug);
    }

    public Veiculo maisPerto(Cliente cliente, Class tipo, double distancia){
        double min = Double.MAX_VALUE;
        String maisPerto = null;
        for (Veiculo v : this.veiculos.values()){
            if (v.getPosicao().distancia(cliente.getPosicao()) < min && v.getClass().equals(tipo) && v.getAutonomia() >= distancia){
                min = v.getPosicao().distancia(cliente.getPosicao());
                maisPerto = v.getMatricula();
            }
        }
        return this.veiculos.get(maisPerto);
    }

    public Veiculo maisBarato(Class tipo, double distancia){
        double min = Double.MAX_VALUE;
        String maisBarato = null;
        for (Veiculo v : this.veiculos.values()){
            if (v.getPreco() < min && v.getClass().equals(tipo) && v.getAutonomia() >= distancia){
                min = v.getPreco();
                maisBarato = v.getMatricula();
            }
        }
        return this.veiculos.get(maisBarato);
    }

    public ArrayList<Veiculo> maisBaratoAluguer(Ponto fim){
        double min = Double.MAX_VALUE;
        ArrayList<Veiculo> arr = new ArrayList<>();
        String maisBarato = null;
        for (Veiculo v : this.veiculos.values()){
            if (v.getPreco() < min && v instanceof Eletrico && v.getAutonomia() >= v.getPosicao().distancia(fim)){
                min = v.getPreco();
                maisBarato = v.getMatricula();
            }
        }
        arr.add(this.veiculos.get(maisBarato));
        min = Double.MAX_VALUE;
        for (Veiculo v : this.veiculos.values()){
            if (v.getPreco() < min && v instanceof Hibrido && v.getAutonomia() >= v.getPosicao().distancia(fim)){
                min = v.getPreco();
                maisBarato = v.getMatricula();
            }
        }
        arr.add(this.veiculos.get(maisBarato));
        min = Double.MAX_VALUE;
        for (Veiculo v : this.veiculos.values()){
            if (v.getPreco() < min && v instanceof Gasolina && v.getAutonomia() >= v.getPosicao().distancia(fim)){
                min = v.getPreco();
                maisBarato = v.getMatricula();
            }
        }
        arr.add(this.veiculos.get(maisBarato));
        return arr;
    }

    public ArrayList<Veiculo> maisBaratoaXKm(Ponto fim,Ponto inicio,double tol){
        double min = Double.MAX_VALUE;
        ArrayList<Veiculo> arr = new ArrayList<>();
        String maisBarato = null;
        for (Veiculo v : this.veiculos.values()){
            if (v.getPreco() < min && v instanceof Eletrico && v.getPosicao().distancia(inicio) <= tol && v.getAutonomia() >= v.getPosicao().distancia(fim)){
                min = v.getPreco();
                maisBarato = v.getMatricula();
            }
        }
        arr.add(this.veiculos.get(maisBarato));
        min = Double.MAX_VALUE;
        for (Veiculo v : this.veiculos.values()){
            if (v.getPreco() < min && v instanceof Hibrido && v.getPosicao().distancia(inicio) <= tol && v.getAutonomia() >= v.getPosicao().distancia(fim)){
                min = v.getPreco();
                maisBarato = v.getMatricula();
            }
        }
        arr.add(this.veiculos.get(maisBarato));
        min = Double.MAX_VALUE;
        for (Veiculo v : this.veiculos.values()){
            if (v.getPreco() < min && v instanceof Gasolina && v.getPosicao().distancia(inicio) <= tol && v.getAutonomia() >= v.getPosicao().distancia(fim)){
                min = v.getPreco();
                maisBarato = v.getMatricula();
            }
        }
        arr.add(this.veiculos.get(maisBarato));
        return arr;
    }

    public ArrayList<Veiculo> maisPertoAluguer(Ponto posiCli, Ponto fim){
        ArrayList<Veiculo> arr = new ArrayList<>();
        double min = Double.MAX_VALUE;
        String maisPerto = null;
        for (Veiculo v : this.veiculos.values()){
            if (v.getPosicao().distancia(posiCli) < min &&  v instanceof Eletrico && v.getAutonomia() >= v.getPosicao().distancia(fim)){
                min = v.getPosicao().distancia(posiCli);
                maisPerto = v.getMatricula();
            }
        }
        arr.add(this.veiculos.get(maisPerto));
        min = Double.MAX_VALUE;

        for (Veiculo v : this.veiculos.values()){
            if (v.getPosicao().distancia(posiCli) < min &&  v instanceof Hibrido && v.getAutonomia() >= v.getPosicao().distancia(fim)){
                min = v.getPosicao().distancia(posiCli);
                maisPerto = v.getMatricula();
            }
        }
        arr.add(this.veiculos.get(maisPerto));
        min = Double.MAX_VALUE;

        for (Veiculo v : this.veiculos.values()){
            if (v.getPosicao().distancia(posiCli) < min &&  v instanceof Gasolina && v.getAutonomia() >= v.getPosicao().distancia(fim)){
                min = v.getPosicao().distancia(posiCli);
                maisPerto = v.getMatricula();
            }
        }
        arr.add(this.veiculos.get(maisPerto));


        return arr;
    }

    public double tempoEstimado(Ponto inicio,Ponto fim,double Velocidade) {
        Random rand = new Random();
        double n = rand.nextDouble() * 0.5 + 1;
        return (inicio.distancia(fim) / Velocidade) * n;
    }


    public void addCliente(String nif,Cliente cli){
        this.clientes.put(nif,cli.clone());//é necessario o clonee?????
    }

    public void addProprietario(String nif,Proprietario cli){
        this.proprietarios.put(nif,cli.clone());//é necessario o clonee?????
    }

    public void addVeiculo(String nif,Veiculo cli){
        this.veiculos.put(nif,cli.clone());//é necessario o clonee?????
    }

    public void mudarPreco(String matricula, double preco){
        this.veiculos.get(matricula).setPreco(preco);
        String nif = this.veiculos.get(matricula).getProp();
        List<Veiculo> veiculos = this.proprietarios.get(nif).getCarros();
        for (Veiculo v: veiculos){
            if (v.getMatricula().equals(matricula))
                v.setPreco(preco);
        }
        this.proprietarios.get(nif).setCarros(veiculos);
    }

    public boolean comparaDatas(LocalDate d, LocalDate inicio, LocalDate fim){
        if ((d.isAfter(inicio) || d.isEqual(inicio)) && (d.isBefore(fim) || d.isEqual(fim)))
            return true;
        return false;
    }

    public void addCarroListaProp(String nif, Veiculo veic){
        List<Veiculo> veiculos = this.proprietarios.get(nif).getCarros();
        veiculos.add(veic);
        this.proprietarios.get(nif).setCarros(veiculos);
    }



    public double totalFaturado(String matricula, LocalDate inicio, LocalDate fim){
        return this.veiculos.get(matricula).getAluguer().stream()
                .filter(a -> comparaDatas(a.getData(),inicio,fim))
                .mapToDouble(a -> a.getPreco())
                .sum();
    }



    public List<Cliente> clientesMaisUsuaisKms(){
        List<Cliente> clientes = new ArrayList<>();
        List<Double> distancias = new ArrayList<>();

        for (Cliente c: this.clientes.values()){
            double kms = c.getAluguer().stream().mapToDouble(a->a.getInicio().distancia(a.getFim())).sum();
            if (distancias.size() != 10){
                distancias.add(kms);
                clientes.add(c.clone());
            }
            else {
                int j;
                boolean found = true;
                for (j = 0; found && j < 10; j++){
                    if (distancias.get(j) < kms){
                        distancias.set(j,kms);
                        clientes.set(j,c.clone());
                        found = false;
                    }
                }
            }
        }
        return clientes;
    }

    public List<Cliente> clientesMaisUsuaisVezes(){
        List<Cliente> clientes = new ArrayList<>();
        List<Integer> vezes = new ArrayList<>();

        for (Cliente c: this.clientes.values()){
            int num = c.getAluguer().size();
            if (vezes.size() != 10){
                vezes.add(num);
                clientes.add(c.clone());
            }
            else {
                int j;
                boolean found = true;
                for (j = 0; found && j < 10; j++){
                    if (vezes.get(j) < num){
                        vezes.set(j,num);
                        clientes.set(j,c.clone());
                        found = false;
                    }
                }
            }
        }
        return clientes;
    }

    public List<Veiculo> carrosAbastecimento(String nif){
        return this.proprietarios.get(nif).getCarros().stream()
                .filter(v -> v.getAutonomia() < 0.1*v.getAutonomiaMax())
                .map(Veiculo::clone)
                .collect(Collectors.toList());
    }




    public void abastecerTodos(String nif, List<Veiculo> abastecer){
        List<Veiculo> veiculos = this.proprietarios.get(nif).getCarros();
        for (Veiculo v: abastecer){
            boolean found = true;
            int i;
            for (i = 0; found && i < veiculos.size(); i++){
                Veiculo vv = veiculos.get(i);
                if (vv.equals(v)){
                    vv.setAutonomia(vv.getAutonomiaMax());
                    found = false;
                }
            }
            this.veiculos.get(v.getMatricula()).setAutonomia(v.getAutonomiaMax());
        }
        this.proprietarios.get(nif).setCarros(veiculos);
    }

    public void abastecerUm(String nif, List<Veiculo> abastecer, String matricula){
        List<Veiculo> veiculos = this.proprietarios.get(nif).getCarros();
        if (this.veiculos.containsKey(matricula) && abastecer.contains(this.veiculos.get(matricula))){
            for (Veiculo v: veiculos){
                if (v.getMatricula().equals(matricula)){
                    v.setAutonomia(v.getAutonomiaMax());
                    this.veiculos.get(matricula).setAutonomia(v.getAutonomiaMax());
                }
            }
            this.proprietarios.get(nif).setCarros(veiculos);
        }
    }


    public List<Aluguer> alugueresLista(String nif, LocalDate inicio, LocalDate fim,int x) {//x = 1 proprietarios , x = 2 clientes
        if (x==1) {
            return this.proprietarios.get(nif).getAluguer().stream()
                    .filter(a -> comparaDatas(a.getData(), inicio, fim))
                    .map(Aluguer::clone).collect(Collectors.toList());

        }
        else{
            return this.clientes.get(nif).getAluguer().stream()
                    .filter(a -> comparaDatas(a.getData(), inicio, fim))
                    .map(Aluguer::clone).collect(Collectors.toList());
        }
    }



    public void addHistoricoProp(String prop,Aluguer alug,ArrayList<Aluguer> queue){
        this.proprietarios.get(prop).addAluguer(alug);
        this.proprietarios.get(prop).setQueue(queue);
    }

    public void addHistoricoCli(String prop,Aluguer alug,int rating){
        String id = alug.getID();
        Aluguer alug1 = alug.clone();
        alug1.setID(prop);
        this.clientes.get(id).addRating(rating);
        this.clientes.get(id).addAluguer(alug1);
    }

    public void atualizaQueue(String prop,ArrayList<Aluguer> queue) {
        this.proprietarios.get(prop).setQueue(queue);
    }

    public void addHistoricoVeic(Aluguer alug){
        this.veiculos.get(alug.getMatricula()).addAluguer(alug);
    }

    public void addQueue(String prop,Aluguer alug){
        this.proprietarios.get(prop).addQueue(alug);
    }

    public void setEstadoAlug(String cli,int x){
        this.clientes.get(cli).setEstadoAlug(x);
    }

    public void alteraPosCli(String cli,Ponto ponto){
        this.clientes.get(cli).setPosicao(ponto);
    }

    public void alteraAutonomiaVeic(String veic,double aut){
        int aut1 = (int) aut;
        this.veiculos.get(veic).alteraAutonomia(aut1);
    }

    public void alteraPosVeic(String mat,Ponto pos){
        this.veiculos.get(mat).setPosicao(pos);
    }

    public void addRatingProp(String prop,int rat){
        this.proprietarios.get(prop).addRating(rat);
    }

    public void addRatingVeic(String mat,int rat){
        this.veiculos.get(mat).addRating(rat);
    }

    public void alteraCarroProp(String prop,Veiculo veic){
        this.proprietarios.get(prop).alteraCarro(veic);
    }

    public String toString(){
        StringBuilder sb = new StringBuilder();
        sb.append("\n--------------------Proprietarios--------------------\n");
        for (Proprietario p: this.proprietarios.values()) {
            sb.append(p);
        }
        sb.append("\n--------------------Veiculos--------------------\n");
        for (Veiculo v: this.veiculos.values()) {
            sb.append(v);
        }
        sb.append("\n--------------------Clientes--------------------\n");
        for (Cliente c: this.clientes.values()) {
            sb.append(c);
        }
        return sb.toString();
    }

    public String clientesVezestoString(){
        StringBuilder sb = new StringBuilder();
        for (Cliente c: clientesMaisUsuaisVezes()) {
            sb.append(c.toString2());
        }
    return sb.toString();
    }

    public String clientesKmstoString(){
        StringBuilder sb = new StringBuilder();
        for (Cliente c: clientesMaisUsuaisKms()) {
            sb.append(c.toString2());
        }
        return sb.toString();
    }

    public static Double parseDouble(String linha){
        double doub;
        try{
            doub=Double.parseDouble(linha);
        }catch(NumberFormatException | NullPointerException e){return null;}
        return doub;
    }

    public static Integer parseInt(String linha){
        int x;
        try{
            x=Integer.parseInt(linha);
        }catch(NumberFormatException | NullPointerException e){return null;}

        return x;
    }

}
