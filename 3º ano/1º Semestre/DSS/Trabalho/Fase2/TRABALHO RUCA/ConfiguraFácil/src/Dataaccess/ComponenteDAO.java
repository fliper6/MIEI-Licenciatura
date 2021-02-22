package Dataaccess;

import Business.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import javax.swing.JOptionPane;

public class ComponenteDAO {
    
    public Connection conn;
    
    public ComponenteDAO () {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            //this.conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
            this.conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?useSSL=false", "root", "root");
        }
        catch (ClassNotFoundException e) {}
        catch (SQLException e) {}
    }
    // recebe o nome do pacote e retorna true caso o mesmo exista, false caso contrário
    public Boolean existePacote (String nome) throws Exception{
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("select nome from pacote where nome = '"+nome+"'");
        return rs.isBeforeFirst();
    }  
    // retorna um ArrayList com todos os componentes
    public ArrayList<Componente> getComponentes () throws Exception {
        Statement stm = conn.createStatement();
        ArrayList<Componente> componentes = new ArrayList<>();
        ResultSet rs = stm.executeQuery("select * from componente");
        while (rs.next())
            componentes.add(new Componente(rs.getString(1),rs.getString(2),Integer.parseInt(rs.getString(3))));
        return componentes;
    }
    // recebe um ArrayList de componentes e retorna true caso no mínimo 2 deles sejam incompatíveis
    public Boolean existemIncompatibilidades (ArrayList<Componente> componentes) throws Exception {
        Statement stm = conn.createStatement();
        int n=0;
        ArrayList<String> incompativeis = new ArrayList<>();
        ResultSet rs;
        for(Componente c : componentes) {
            rs = stm.executeQuery("select nome from incompativeis where componente_nome='"+c.getNome()+"'");
            while (rs.next())
                incompativeis.add(rs.getString(1));
            for(Componente c1 : componentes)
                if (incompativeis.contains(c1.getNome())) return true;
            incompativeis.clear();
            for(;n>0;n--)
                rs.previous();
        }
        return false;
    }
    // recebe um ArrayList de componentes e devolve a lista desses componentes que geram incompatibilidades entre si
    public HashSet<String> listaIncompatibilidades (ArrayList<Componente> componentes) throws Exception {
        Statement stm = conn.createStatement();
        int n=0;
        ArrayList<String> incompativeis = new ArrayList<>();
        HashSet<String> incompativeis1 = new HashSet<>();
        ResultSet rs;
        for(Componente c : componentes) {
            rs = stm.executeQuery("select nome from incompativeis where componente_nome='"+c.getNome()+"'");
            while (rs.next()){
                incompativeis.add(rs.getString(1));
                n++;
            }
            for(Componente c1 : componentes)
                if (incompativeis.contains(c1.getNome())) {
                    incompativeis1.add(c.getNome()+" "); 
                    incompativeis1.add(c1.getNome()+" ");
                }
            incompativeis.clear();
            for(;n>0;n--)
                rs.previous();
        }
        return incompativeis1;
    }
    // recebe o nome do pacote e um ArrayList dos componentes constituintes do pacote e insere na tabela pacote uma linha
    // com o nome do pacote, o seu preço, se tem desconto(que será sempre true(1)) e o valor do mesmo e na tabela 
    // pacote_has_componente insere, para cada componente constituinte do pacote, uma linha com o nome do pacote e nome do
    // componente
    public void criarPacote (String nome, ArrayList<Componente> componentes) throws Exception {
        Statement stm = conn.createStatement();
        int precoComponentes=precoComponentes(componentes);
        int precoPacote=precoComponentes-=precoComponentes*(0.1);
        stm.executeUpdate("insert into pacote values ('"+nome+"',"+precoPacote+", 1,10)");
        for (Componente c : componentes)
            stm.executeUpdate("insert into pacote_has_componente values ('"+nome+"','"+c.getNome()+"')");   
    }
    // Devolve o somatório dos preços dos componentes recebidos como argumento
    public int precoComponentes (ArrayList<Componente> componentes) {
        int preco=0;
        for (Componente c : componentes)
            preco += c.getPreco();
        return preco;
    }
    // Recebe o nome do componente e devolve o Componente 
    public Componente getComponente (String nome) throws Exception {
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("select * from componente where nome = '"+nome+"'");
        rs.next();
        return new Componente(rs.getString(1),rs.getString(2),Integer.parseInt(rs.getString(3)));
    }
    // Recebe o nome do componente e devolve a categoria a que pertence
    public String getCategoria (String nome) throws Exception {
        return getComponente(nome).getCategoria();
    }
    
    // Recebe o nome do pacote e devolve um ArrayList com os componentes associados ao mesmo
    public ArrayList<Componente> getPacote (String nome) throws Exception {
        Statement stm = conn.createStatement();
        ArrayList<Componente> componentes = new ArrayList<>();
        ResultSet rs = stm.executeQuery("select componente_nome from pacote_has_componente where pacote_nome = '"+nome+"'");
        while (rs.next())
            componentes.add(getComponente(rs.getString(1)));
        return componentes;
    }
    // recebe o nome de um pacote e devolve o pacote
    public Pacote getPacote1 (String nome) throws Exception {
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("select * from pacote where nome='"+nome+"'");
        rs.next();
        return new Pacote(rs.getString(1),Integer.parseInt(rs.getString(2)),rs.getBoolean(3),Float.parseFloat(rs.getString(4)));
    }
    // retorna um HashMap com os pacotes e os respectivos componentes
    public HashMap<Pacote, ArrayList<Componente>> getpacotes () throws Exception {
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("select nome from pacote");
        if (!rs.isBeforeFirst()) return null;
        HashMap<Pacote, ArrayList<Componente>> pacotes = new HashMap<>();
        while (rs.next())
            pacotes.put(getPacote1(rs.getString(1)),getPacote(rs.getString(1)));
        return pacotes;
    }
    
    // retorna um ArrayList com os pacotes existente
    public ArrayList<Pacote> getPacotes() throws Exception {
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("select * from pacote");
        ArrayList<Pacote> pacotes = new ArrayList<>();
        if (!rs.isBeforeFirst()) return null;
        while(rs.next())
            pacotes.add(new Pacote(rs.getString(1),Integer.parseInt(rs.getString(2)), rs.getBoolean(3),Float.parseFloat(rs.getString(4))));
        return pacotes;
    }
    
    // Devolve num Map os nomes dos pacotes e os componentes a eles associados, respectivamente
    /*public HashMap<String, ArrayList<Componente>> getPacotes () throws Exception {
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("select nome from pacote");
        if (!rs.isBeforeFirst()) return null;
        HashMap<String, ArrayList<Componente>> pacotes = new HashMap<>();
        while (rs.next())
            pacotes.put(rs.getString(1),getPacote(rs.getString(1)));
        return pacotes;
    }*/
    // recebe o nome de um pacote e remove-o
    public void removerPacote (String nome) throws Exception {
        Statement stm = conn.createStatement();
        stm.executeUpdate("delete from pacote_has_componente where pacote_nome = '"+nome+"'");
        stm.executeUpdate("delete from pacote where nome = '"+nome+"'");
    }
    
    public ArrayList<String> getListaCategorias () throws Exception {
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("select categoria from componente");
        ArrayList<String> categorias = new ArrayList<>();
        while (rs.next())
            categorias.add(rs.getString(1));
        return categorias;
    }
    
    public ArrayList<Componente> getCompsGuiada () throws Exception {
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("select * from componente where categoria='chassi' or categoria='pintura' or categoria='jante' or categoria='pneu' or categoria='motor' or categoria='detalheInterior' or categoria='detalheExterior'");
        ArrayList<Componente> componentes = new ArrayList<>();
        while (rs.next())
            componentes.add(new Componente(rs.getString(1),rs.getString(2),Integer.parseInt(rs.getString(3))));
        return componentes;
    }
    // Recebe o nome de um componente e uma lista de nomes de componentes e devolve os componentes da segunda lista
    // compatíveis com o componente com o nome "escolhido"
    public Set<Componente> getCompativeis(String escolhido, ArrayList<String> comps) throws Exception {
        Statement stm = conn.createStatement();
        ArrayList<String> incompativeis = new ArrayList<>();
        Set<Componente> compativeis = new HashSet<>();
        ResultSet rs = stm.executeQuery("select nome from incompativeis where componente_nome = '"+escolhido+"'");
        while (rs.next())
            incompativeis.add(rs.getString(1));
        for (String s : comps)
            if (!incompativeis.contains(s))
                compativeis.add(getComponente(s));
        return compativeis;
    }
    // Recebe os nomes dos componentes escolhidos e nomes de outros componentes e devolve os componentes pertencentes
    // à segunda lista que são compatíveis com os da primeira lista
    public Set<Componente> getCompativeis (ArrayList<String> escolhidos, ArrayList<String> comps) throws Exception {
        Set<Componente> compativeis = new HashSet<>();
        for (String e : escolhidos) {
            compativeis.addAll(getCompativeis(e,comps));
        }
        return compativeis;
    }
    // Recebe uma colecção de componentes e indica se os mesmos não cumprem as dependências uns dos outros
    public Boolean existemDependencias (ArrayList<Componente> componentes) throws Exception {
        Statement stm = conn.createStatement();
        ArrayList<String> necessarios = new ArrayList<>();
        ArrayList<String> nomes = new ArrayList<>();
        ResultSet rs;
        for (Componente c : componentes)
            nomes.add(c.getNome());
        for (Componente c : componentes) {
            rs = stm.executeQuery("select nome from necessarios where componente_nome = '"+c.getNome()+"'");
            while (rs.next())
                necessarios.add(rs.getString(1));
            for (String s : necessarios)
                if (!nomes.contains(s)) return true;
            necessarios.clear();
        }
        return false;
    }
    // Recebe uma lista de componentes e o índice do componente do qual se quer saber as dependências não cumpridas pelos 
    // outros componentes da lista
    public HashSet<String> listaDependencias1 (ArrayList<Componente> componentes, int i) throws Exception {
        Statement stm = conn.createStatement();
        ArrayList<String> nomes = new ArrayList<>();
        ArrayList<String> necessarios = new ArrayList<>();
        HashSet<String> emFalta = new HashSet<>();
        for (Componente c : componentes)
            nomes.add(c.getNome());
        ResultSet rs = stm.executeQuery("select nome from necessarios where componente_nome = '"+componentes.get(i).getNome()+"'");
        while (rs.next())
            necessarios.add(rs.getString(1));
        for (String s : necessarios)
            if (!nomes.contains(s)) emFalta.add(s);
        return emFalta;
    }
    // Recebe uma lista de componentes e devolve um map em que cada key é um (nome)componente dos da lista e os objectos 
    // correspondentes são os nomes das dependências não satisfeitas
    public HashMap<String, HashSet<String>> listaDependencias (ArrayList<Componente> componentes) throws Exception {
        Statement stm = conn.createStatement();
        HashSet<String> emFalta1 = new HashSet<String>();
        HashMap<String, HashSet<String>> emFalta = new HashMap<>();
        int i=0;
        for (Componente c : componentes) {
            emFalta1=listaDependencias1(componentes, i);
            if (!emFalta1.isEmpty())
                emFalta.put(c.getNome(),emFalta1);
            i++;
        }
        return emFalta;
    }
    // Devolve o número de componentes que constituem o pacote cujo nome foi recebido como parâmetro
    public int nCompsPacote(String pacote) throws Exception {
        Statement stm = conn.createStatement();
        int i=0;
        ResultSet rs = stm.executeQuery("select pacote_nome from pacote_has_componentes where pacote_nome='"+pacote+"'");
        while (rs.next()) i++;
        return i;
    }
    
    // Recebe nome do pacote e devolve lista com os nomes dos componentes que compõem o pacote
    public ArrayList<String> getCompsPac(String nome) throws Exception {
        Statement stm = conn.createStatement();
        ArrayList<String> comps = new ArrayList<>();
        ResultSet rs = stm.executeQuery("select componente_nome from pacote_has_componente where pacote_nome='"+nome+"'");
        while (rs.next())
            comps.add(rs.getString(1));
        return comps;
    }
    
    // Recebe o nome de um pacote e uma lista com os nomes de componentes e retorna true caso os componentes do pacote estejam
    // contidos nos componentes, caso contrário retorna false
    public Boolean constituemPacote(String nome, ArrayList<String> componentes) throws Exception {
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("select componente_nome from pacote_has_componente where pacote_nome='"+nome+"'");
        while (rs.next())
            if (!componentes.contains(rs.getString(1))) return false;
        return true;
    }
    // Recebe uma lista de nomes de componentes e retorna o/os pacotes que os mesmos constituem, caso os componentes nao sejam
    // necessarios para formar nenhum pacote retorna null
    public HashMap<Pacote, ArrayList<String>> verificaPacotes(ArrayList<String> componentes) throws Exception {
        Statement stm = conn.createStatement();
        ArrayList<String> componentes1 = componentes;
        HashMap<Pacote, ArrayList<String>> pcts = new HashMap<>();
        ResultSet rs = stm.executeQuery("select nome from pacote");
        while (rs.next()) {
            if (componentes1.isEmpty()) break;
            if (constituemPacote(rs.getString(1),componentes1)) {
                pcts.put(getPacote1(rs.getString(1)),getCompsPac(rs.getString(1)));
                componentes1=removeLista(componentes1,getCompsPac(rs.getString(1)));
            }
        }
        if (componentes1.size()==componentes.size()) return null;
        return pcts;
    }
    
    // Retorna a primeira lista em que todas as ocorrencias de elementos da segunda foram removidas
    public ArrayList<String> removeLista (ArrayList<String> l1, ArrayList<String> l2) {
        int i;
        for (i=0;i<l1.size();i++)
            if (l2.contains(l1.get(i)))
                l1.remove(i);
        return l1;
    }
    
    // Recebe uma lista de nomes de componentes e retorna o/os pacotes que os mesmos constituem, caso os componentes nao sejam
    // necessarios para formar nenhum pacote retorna null
    public HashMap<Pacote, ArrayList<Componente>> verificaPacotes1(ArrayList<Componente> componentes) throws Exception {
        ArrayList<Componente> componentes1=new ArrayList<>(); int i=0;
        for(Componente c : componentes)
            componentes1.add(c);
        HashMap<Pacote,ArrayList<Componente>> pacotes=new HashMap<>();
        HashMap<Pacote,ArrayList<Componente>> pacoteAuxiliar;
        while(auxiliar(componentes1)!=null/*componentes1.size()>1*/){
            pacoteAuxiliar=auxiliar(componentes1);
            for(Pacote p : pacoteAuxiliar.keySet()){
                pacotes.put(p,pacoteAuxiliar.get(p));
                
                
                    for(Componente c : pacoteAuxiliar.get(p))
                        if(/*!*/contains(componentes1,c))
                            componentes1.remove(c);
                
                pacoteAuxiliar=new HashMap<>();
            }
        }
        return pacotes;
    }
    
    public HashMap<Pacote, ArrayList<Componente>> auxiliar (ArrayList<Componente> componentes) throws Exception {
        if(componentes.size()==1) return null;
        HashMap<Pacote,ArrayList<Componente>> pacotes = getpacotes();
        HashMap<Pacote,ArrayList<Componente>> pacotesEncontrados = new HashMap<>();
        Pacote maior=null; int nE=0;
        boolean contem;
        for(Pacote p : pacotes.keySet()){
            contem=true;
            for(Componente c : pacotes.get(p))
                if(!(contains(componentes,c))){
                    contem=false; break;
                }
            if(contem==true) pacotesEncontrados.put(p, pacotes.get(p));
        }
        if(pacotesEncontrados.size()>0){
            for(Pacote p1 : pacotesEncontrados.keySet()){
                maior=p1; nE=pacotesEncontrados.get(p1).size();break;
            }
            for(Pacote pacote : pacotesEncontrados.keySet())
                if(pacotesEncontrados.get(pacote).size()>nE){
                    maior=pacote; nE=pacotesEncontrados.get(pacote).size(); //pacotes.clear();
                    //pacotes.put(pacote,pacotesEncontrados.get(pacote));
                }
        }
        if(pacotesEncontrados.size()>0){
        HashMap<Pacote,ArrayList<Componente>> r = new HashMap<>();
        r.put(maior,pacotesEncontrados.get(maior));
        return r;
        }
        return null;    
    }
    
    public boolean contains(ArrayList<Componente> c1, Componente c2) {
        for(Componente c : c1)
            if(c.getNome().equals(c2.getNome())) return true;
        return false;
    }
}
