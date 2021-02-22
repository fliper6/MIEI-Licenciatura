package Data;

import Business.Gestor_Contas.Administrador;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdministradorDAO {
    private Connection con;

    public Administrador containsKey(Object key) throws NullPointerException{
        Administrador admin = null;
        try {
            con = Connector.connect();
            String sql = "SELECT * from DSS.Administrador where emailAdmin = '"+key+"'";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                admin = new Administrador(rs.getInt("idAdmin"),
                                          rs.getString("nomeAdmin"),
                                          rs.getString("emailAdmin"),
                                          rs.getString("pwAdmin"));
            }
            Connector.close(con);
        } catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
        return admin;
    }
    

    public Administrador get(Object key) {
        try {
            Administrador ut = new Administrador();
            con = Connector.connect();
            String sql = "SELECT * from DSS.Administrador where emailAdmin = '"+(String)key+"'";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery(sql);
            if(rs.next()) {
                ut= new Administrador(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4));
            }
            Connector.close(con);
            return ut;
        }catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }
}
