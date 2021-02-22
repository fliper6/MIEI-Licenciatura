package Dataaccess;

import Business.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

public class StockDAO {
    
    private Connection conn;
    
    public StockDAO () {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            //this.conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
            this.conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?useSSL=false", "root", "root");
        }
        catch (ClassNotFoundException e) {}
        catch (SQLException e) {}
    }
    // retorna num ArrayList de string as categorias dos componente existentes
    public HashSet<String> getListaCategorias () throws Exception {
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("select categoria from stock");
        HashSet<String> categorias = new HashSet<>();
        while (rs.next())
            categorias.add(rs.getString(1));
        return categorias;
    }
    // recebe a designação de uma categoria e devolve um ArrayList dos objectos do tipo stock referentes a componentes do 
    // tipo da categoria recebida
    public ArrayList<Stock> getStockCategoria (String categoria) throws Exception {
        Statement stm = conn.createStatement();
        ArrayList<Stock> stocks = new ArrayList<>();
        ResultSet rs = stm.executeQuery("select * from stock where categoria = '"+categoria+"'");
        while (rs.next())
            stocks.add(new Stock(rs.getString(1),rs.getString(2),Integer.parseInt(rs.getString(4))));
        return stocks;
    }
    // Retorna false caso não existam unidades suficientes dos componentes recebidos como argumento
    public Boolean verificaStock(ArrayList<String> componentes) throws Exception {
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("select nome, unidades from stock");
        HashMap<String,Integer> stock = new HashMap<>();
        while (rs.next())
            stock.put(rs.getString(1),Integer.parseInt(rs.getString(2)));
        for (String s : stock.keySet())
            if (componentes.contains(s)) 
                if (stock.get(s)==0) return false;
        return true;
    }
    // recebe um arraylist com os nomes dos componentes da configuração a iniciar fase de produção e os que estiverem 
    // esgotados são adicionados à lista que é retornada
    public ArrayList<String> listaEsgotados(ArrayList<String> componentes) throws Exception {
        Statement stm = conn.createStatement();
        ArrayList<Stock> stocks = new ArrayList<>();
        ArrayList<String> esgotados = new ArrayList<>();
        ResultSet rs = stm.executeQuery("select nome, categoria, unidades from stock");
        while (rs.next())
            stocks.add(new Stock(rs.getString(1),rs.getString(2),Integer.parseInt(rs.getString(3))));
        for (Stock s : stocks)
            if (componentes.contains(s.getNome()))
                if (s.getUnidades()==0)
                    esgotados.add("Nome: "+s.getNome()+" Categoria: "+s.getCategoria()+"\n" );
        return esgotados;
    }
    // recebe um arraylist com os nomes dos componentes da configuração a iniciar fase de produção e decrementa o número de 
    // unidades disponíveis dos mesmos
    public void actualizarStock (ArrayList<String> componentes) throws Exception {
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("select nome, unidades from stock");
        ArrayList<Stock> stock=new ArrayList<>();
        while (rs.next())
            stock.add(new Stock(rs.getString(1),Integer.parseInt(rs.getString(2))));
        for(Stock s : stock)
            if(componentes.contains(s.getNome()))
                stm.executeUpdate("update stock set unidades="+(s.getUnidades()-1)+" where nome ='"+s.getNome()+"'");
    }
    // recebe o nome do componente cujo stock pretende-e aumentar e o número de unidades em que o stock vai ser aumentado
    public void encomendar (String nomeComp, int unidades) throws Exception {
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("select unidades from stock where nome='"+nomeComp+"'");
        rs.next();
        int units = Integer.parseInt(rs.getString(1));
        stm.executeUpdate("update stock set unidades="+(units+unidades)+" where nome='"+nomeComp+"'");
    }
    
}
