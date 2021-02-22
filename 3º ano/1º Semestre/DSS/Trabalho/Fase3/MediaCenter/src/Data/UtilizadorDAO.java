package Data;

import Business.Gestor_Contas.Utilizador;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import java.util.Map;
import java.util.Set;

public class UtilizadorDAO implements Map<String, Utilizador> {
    private Connection con;

    @Override
    public int size() {
        return 0;
    }

    @Override
    public boolean isEmpty() {
        return false;
    }

    public boolean containsKey(Object key) throws NullPointerException{
        boolean r;
        try {
            con = Connector.connect();
            String sql = "SELECT * from DSS.Utilizador where emailUser = '"+key+"'";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                r = true;
            }
            else r = false;
            Connector.close(con);
        } catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
        return r;
    }

    public Utilizador contemChave(Object key) throws NullPointerException{
        Utilizador user = null;
        try {
            con = Connector.connect();
            String sql = "SELECT * from DSS.Utilizador where emailUser = '"+key+"'";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new Utilizador(rs.getInt("idUser"),
                                      rs.getString("nomeUser"),
                                      rs.getString("emailUser"),
                                      rs.getString("pwUser"));
            }
            Connector.close(con);
        } catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
        return user;
    }

    @Override
    public boolean containsValue(Object value) {
        return false;
    }

    public Utilizador get(Object key) {
        try {
            Utilizador ut = new Utilizador();
            con = Connector.connect();
            String sql = "SELECT * from DSS.Utilizador where emailUser = '"+key+"'";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery(sql);
            if(rs.next()) {
               ut= new Utilizador(rs.getInt("idUser"),
                                  rs.getString("nomeUser"),
                                  rs.getString("emailUser"),
                                  rs.getString("pwUser"));
            }
            Connector.close(con);
            return ut;
        }catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }

    @Override
    public Utilizador put(String key, Utilizador value) {
        return null;
    }

    @Override
    public Utilizador remove(Object key) {
        return null;
    }

    @Override
    public void putAll(Map<? extends String, ? extends Utilizador> m) {}

    @Override
    public void clear() {}

    @Override
    public Set<String> keySet() {
        return null;
    }

    @Override
    public Collection<Utilizador> values() {
        return null;
    }

    @Override
    public Set<Entry<String, Utilizador>> entrySet() {
        return null;
    }
}
