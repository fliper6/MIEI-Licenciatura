package Dataaccess;

import Business.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ConfiguracaoDAO {
    
    public Connection conn;
    
    public ConfiguracaoDAO () {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            //this.conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","1234");
            this.conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?useSSL=false", "root", "root");
        }
        catch (ClassNotFoundException e) {}
        catch (SQLException e) {}
    }
    
    public Configuracao getConfiguracao (int idConf) throws Exception {
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("select * from configuracao where id="+idConf+"");
        rs.next();
        return new Configuracao(Integer.parseInt(rs.getString(1)),Integer.parseInt(rs.getString(2)),Integer.parseInt(rs.getString(3)),rs.getString(4));
    }
    
    public int precoComponentes (ArrayList<Componente> componentes) {
        int s=0;
        for (Componente c : componentes)
            s +=c.getPreco();
        return s;
    }
    // Recebe id da configuração a ser inserida, juntamente com os componentes que lhe estão associados, o id do cliente que
    // a criou e o preço total dos componentes constituintes
    public void criarConfiguracao (int id, ArrayList<Componente> componentes, int idCliente,int preco) throws Exception {
        Statement stm = conn.createStatement();
        stm.executeUpdate("insert into configuracao values ("+id+","+preco+","+idCliente+",'pendente')");
        for (Componente c : componentes)
            stm.executeUpdate("insert into configuracao_has_componente values ("+id+",'"+c.getNome()+"')");
    }
    // recebe o id da configuraçao e o estado ao qual a mesma vai ser actualizada
    public void alterarEstado (int idConfiguracao, String estado) throws Exception {
        Statement stm = conn.createStatement();
        stm.executeUpdate("update configuracao set estado='"+estado+"' where id="+idConfiguracao+"");
    }
    // Recebe o id de uma configuração e retorna uma lista com os nomes dos componentes da mesma
    public ArrayList<String> getCompsConf (int idConf) throws Exception {
        Statement stm = conn.createStatement();
        ArrayList<String> componentes = new ArrayList<>();
        ResultSet rs = stm.executeQuery("select componente_nome from configuracao_has_componente where configuracao_id="+idConf+"");
        while (rs.next())
            componentes.add(rs.getString(1));
        return componentes;
    }
    // Devolve todas as configurações e as respectivas listas de componentes(nomes)
    public HashMap<Configuracao, ArrayList<String>> getConfiguracoes () throws Exception {
        Statement stm = conn.createStatement();
        ArrayList<Configuracao> configuracoes = new ArrayList<>();
        HashMap<Configuracao, ArrayList<String>> cC = new HashMap<>();
        ResultSet rs = stm.executeQuery("select * from configuracao");
        if (!rs.isBeforeFirst()) return null;
        while(rs.next())
            configuracoes.add(new Configuracao(Integer.parseInt(rs.getString(1)),Integer.parseInt(rs.getString(2)),Integer.parseInt(rs.getString(3)),rs.getString(4)));
        for (Configuracao c : configuracoes)
            cC.put(c,getCompsConf(c.getId()));
        return cC;
    }
    // Devolve todas as configurações e as respectivas listas de componentes(nomes) de um dado cliente
    public HashMap<Configuracao, ArrayList<String>> getConfiguracoes(int idCliente) throws Exception {
        Statement stm = conn.createStatement();
        ArrayList<Configuracao> configuracoes = new ArrayList<>();
        HashMap<Configuracao, ArrayList<String>> cC = new HashMap<>();
        ResultSet rs = stm.executeQuery("select * from configuracao where cliente_nif= "+idCliente+"");
        if (!rs.isBeforeFirst()) return null;
        while(rs.next())
            configuracoes.add(new Configuracao(Integer.parseInt(rs.getString(1)),Integer.parseInt(rs.getString(2)),Integer.parseInt(rs.getString(3)),rs.getString(4)));
        for (Configuracao c : configuracoes)
            cC.put(c,getCompsConf(c.getId()));
        return cC;
    }
    //getCompsConf(int idConf)
    // recebe os ids das configuraçoes referentes aos pedidos e devolve as configuraçoes e para cada uma um ArrayList de 
    // string com os nomes dos componentes da configuraçao
    public HashMap<Configuracao, ArrayList<String>> getConfiguracoes(ArrayList<Integer> idsConfs) throws Exception {
        Statement stm = conn.createStatement();
        HashMap<Configuracao, ArrayList<String>> cC = new HashMap<>();
        for (Integer i : idsConfs)
            cC.put(getConfiguracao(i),getCompsConf(i));
        return cC;
    }
    // recebe o nif de um cliente e retorna os ids das suas configurações
    public ArrayList<Integer> getConfiguracoesCliente(int nif) throws Exception {
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("select id from configuracao where cliente_nif = "+nif+"");
        ArrayList<Integer> ids = new ArrayList<>();
        while(rs.next())
            ids.add(Integer.parseInt(rs.getString(1)));
        return ids;
    }
    
    // recebe o nif de um cliente e remove todas as suas configurações
    public void removerConfiguracoes(int nif) throws Exception {
        ArrayList<Integer> ids = getConfiguracoesCliente(nif);
        Statement stm = conn.createStatement();
        for(Integer id : ids){
            stm.executeUpdate("delete from configuracao_has_componente where configuracao_id="+id+"");
            stm.executeUpdate("delete from configuracao_has_pacote where configuracao_id="+id+"");
            stm.executeUpdate("delete from configuracao where id="+id+"");
        }
            
    }
    
}
