package Dataaccess;

import Exceptions.FuncionarioInexistenteException;
import Exceptions.PasswordIncorrectaException;
import Business.*;
import java.sql.*;
import java.util.ArrayList;


public class ClienteDAO {
    
    public Connection conn;
    
    public ClienteDAO () {         
    try {
            Class.forName("com.mysql.jdbc.Driver");
            this.conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?useSSL=false", "root", "root");
            //this.conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?useSSL=false", "root", "1234");
            //this.conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "1234");
        }
        catch (ClassNotFoundException | SQLException e) {}
    }
    // recebe o nif do cliente a retornar e o mesmo é retornado caso exista, caso contrário null é retornado
    public Cliente getCliente(int nif) throws Exception{
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("SELECT * FROM cliente WHERE nif = "+nif+"");
        if (!rs.isBeforeFirst()) return null;
        rs.next();
        return new Cliente(Integer.parseInt(rs.getString(1)),rs.getString(2),rs.getString(3),Integer.parseInt(rs.getString(4)),Float.parseFloat(rs.getString(5)));
    }
    
    public boolean existemClientes() {
        try {
            Statement stm = conn.createStatement();
            ResultSet rs = stm.executeQuery("SELECT nome FROM cliente");
            return rs.isBeforeFirst();
        }
        catch (Exception e) {throw new NullPointerException(e.getMessage());}
    }
    // recebe os detalhes de um cliente e insere-o na base de dados
    public void inserirCliente(int nif, String nome, String morada, int telefone) throws Exception {
        Statement stm = conn.createStatement();
        stm.executeUpdate("INSERT INTO CLIENTE VALUES ( "+nif+", '"+nome+"', '"+morada+"', "+telefone+", 50000)");
    }
    // recebe o nif do cliente a remover e remove-o
    public void removerCliente(int nif) throws Exception{
        Statement stm = conn.createStatement();
        //ConfiguracaoDAO c = new ConfiguracaoDAO();
        //ArrayList<Integer> cs = c.getConfiguracoesCliente(nif);
        //for(Integer i : cs)
        //    c.removerConfiguracoes(i);
        stm.executeUpdate("delete from cliente where nif = "+nif+"");
    }
    // retorna um ArrayList com todos os clientes registados
    public ArrayList<Cliente> getClientes() throws Exception{
        ArrayList<Cliente> clientes = new ArrayList<>();
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("select * from cliente");
        while(rs.next())
            clientes.add(new Cliente(Integer.parseInt(rs.getString(1)),rs.getString(2),rs.getString(3),Integer.parseInt(rs.getString(4)),Float.parseFloat(rs.getString(5))));
        return clientes;
    }

    // recebe o nif do cliente e retorna true caso o mesmo esteja registado, false caso contrário
    public boolean clienteExiste(int key) throws Exception{
            Statement stm = conn.createStatement();
            ResultSet rs = stm.executeQuery("select nome from cliente where nif="+key+"");
            return rs.next();
    }
    
    public int size() {
        try {
            int i = 0;
            Statement stm = conn.createStatement();
            ResultSet rs = stm.executeQuery("SELECT nome FROM cliente");
            for (;rs.next();i++);
            return i;
        }
        catch (Exception e) {throw new NullPointerException(e.getMessage());}
    }
    
    // recebe username e password do funcionario a ser autenticado
    // caso o username nao exista FuncionarioInexistenteException é lançada
    // caso o username exista mas a password nao seja a correcta PasswordIncorrectaException é lançada
    // caso o username exista e a password seja a correcta, retorna true caso o tipo seja stand, false caso contrário
    public Boolean login (String username, String password)  throws PasswordIncorrectaException, FuncionarioInexistenteException, Exception{
            Statement stm = conn.createStatement();
            ResultSet rs = stm.executeQuery("SELECT * FROM funcionario");
            while(rs.next()) {
                if (rs.getString(1).equals(username))
                    if (!rs.getString(2).equals(password)) throw new PasswordIncorrectaException("Password Incorrecta");
                    else return rs.getString(3).equals("stand");
            }
        throw new FuncionarioInexistenteException("Funcionario inexistente");
    }
    // recebe o username de um funcionario e retorna true caso esteja registado, false caso contrário
    public Boolean existeFuncionario (String username) throws Exception{
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("SELECT username FROM funcionario");
        while(rs.next())
            if (rs.getString(1).equals(username)) return true;
        return false;
    }
    
    public ArrayList<Funcionario> getFuncionarios () throws Exception {
        Statement stm = this.conn.createStatement();
        ArrayList<Funcionario> funcionarios = new ArrayList<>();
        ResultSet rs = stm.executeQuery("select * from funcionario");
        while (rs.next())
            funcionarios.add(new Funcionario(rs.getString(1),rs.getString(2),rs.getString(3)));
        return funcionarios;
    }
    // recebe o nif do cliente e o custo da configuraçao criada e actualiza o saldo do mesmo
    public void actualizaSaldo (int idCliente, int custo) throws Exception {
        Statement stm = conn.createStatement();
        Cliente c = getCliente(idCliente);
        int saldo = (int)c.getSaldo();
        stm.executeUpdate("update cliente set saldo = "+(saldo-custo)+" where nif="+idCliente+"");
    }
    
}


