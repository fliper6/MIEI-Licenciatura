package Dataaccess;

import Business.*;
import java.sql.*;
import java.util.ArrayList;

public class QueueDAO {
    
    public Connection conn;
    
    public QueueDAO () {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            //this.conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","1234");
            this.conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?useSSL=false", "root", "root");
        }
        catch (ClassNotFoundException e) {}
        catch (SQLException e) {}
    }
    // recebe o id da configuração que se quer inserir na fila de espera(fazer pedido) e caso esteja já lá se encontre ou não
    // não esteja na queue mas já se encontra em produção retorna true, caso nao esteja na fila nem esteja em produção
    // retorna false
    public Boolean configuracaoNaFila (int idConf) throws Exception {
        Statement stm = conn.createStatement();
        ArrayList<Integer> ids = new ArrayList<>();
        ResultSet rs = stm.executeQuery("select * from queue");
        while(rs.next())
            ids.add(Integer.parseInt(rs.getString(1)));
        ResultSet rs1 = stm.executeQuery("select estado from configuracao where id="+idConf+"");
        rs1.next();
        return (ids.contains(idConf)||rs1.getString(1).equals("EmProducao"));
    }
    // recebe o id da configuraçao relativa ao pedido efectuado(inserção na fila de espera) e insere-a na tabela queue
    public void inserirConfiguracao (int idConfiguracao) throws Exception {
        Statement stm = conn.createStatement();
        stm.executeUpdate("insert into queue values ("+idConfiguracao+")");
    }
    // devolve um objecto queue com os ids de todas as configuraçoes referentes aos pedidos
    public Queue getPedidos () throws Exception {
        Statement stm = conn.createStatement();
        ArrayList<Integer> pedidos = new ArrayList<>();
        ResultSet rs = stm.executeQuery("select * from queue");
        if (!rs.isBeforeFirst()) return null;
        while (rs.next())
            pedidos.add(Integer.parseInt(rs.getString(1)));
        return new Queue(pedidos);
    }
    // recebe o id da configuração à qual o pedido em questão é referente e remove da tabela queue a linha em que o id é
    // igual ao recebido como parâmetro
    public void removerPedido (int idConf) throws Exception {
        Statement stm = conn.createStatement();
        stm.executeUpdate("delete from queue where configuracao_id="+idConf+"");
    }
    // recebe os ids das configurações às quais os pedidos em questão são referentes e remove-os da queue
    public void removerPedidos(ArrayList<Integer> ids) throws Exception {
        for(Integer i : ids)
            removerPedido(i);
    }
    // recebe o id da configuração a iniciar fase de produção e remove-a da tabela queue
    public void iniciarProducao (int idPedido) throws Exception {
        Statement stm = conn.createStatement();
        stm.executeUpdate("delete from queue where configuracao_id="+idPedido+"");
    }
}