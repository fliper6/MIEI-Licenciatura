package Data;

import Business.Gestor_Media.Media;
import Business.Gestor_Media.Playlist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.*;

public class PlaylistDAO implements Map<Integer, Playlist>{
    private Connection con;

    @Override
    public Playlist put(Integer key, Playlist value) {
        try {
            String sql;
            con = Connector.connect();
            String values = "('" + value.getNome() + "','" + value.getCategoria() + "',"+ value.getIdUser() +");";
            sql = "INSERT into DSS.Playlist (nomePlaylist,categoria,idUser) values " + values;
            PreparedStatement ps = con.prepareStatement(sql);
            ps.executeUpdate();
            Connector.close(con);
            return value;
        } catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }
    @Override
    public Playlist get(Object key) {
        try {
            Playlist ut = new Playlist();
            con = Connector.connect();
            String sql = "SELECT * from DSS.Playlist where idPlaylist = '"+key+"'";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery(sql);
            if(rs.next()) {
                ut= new Playlist(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getInt(4));
            }
            Connector.close(con);
            return ut;
        }catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }

    @Override
    public Playlist remove(Object key) {
        return null;
    }

    @Override
    public void putAll(Map<? extends Integer, ? extends Playlist> m) {}

    @Override
    public void clear() {}

    @Override
    public Set<Integer> keySet() {
        return null;
    }

    @Override
    public Collection<Playlist> values() {
        return null;
    }

    @Override
    public Set<Entry<Integer, Playlist>> entrySet() {
        return null;
    }

    @Override
    public int size() {
        return 0;
    }

    @Override
    public boolean isEmpty() {
        return false;
    }

    public boolean containsKey(Object key) {
        try {
            boolean r;
            con = Connector.connect();
            String sql = "SELECT * from DSS.Playlist where idPlaylist = '"+key+"'";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            r = rs.next();
            Connector.close(con);
            return r;
        } catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }

    @Override
    public boolean containsValue(Object value) {
        return false;
    }

    public int getMax() {
        try {
            int r=0;
            con = Connector.connect();
            String sql = "SELECT MAX(idPlaylist) from DSS.Playlist";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                r = rs.getInt(1);
            }
            Connector.close(con);
            return r;
        } catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }


    public void putMediaInPlaylist(Media med, Playlist pl) {
        try {
            con = Connector.connect();
            Statement s = con.createStatement();
            s.executeUpdate("DELETE from DSS.Media_Playlist where idMedia = "+med.getId()+" and idPlaylist = "+pl.getIdPlaylist()+";");
            String sql = "INSERT into DSS.Media_Playlist VALUES (" + med.getId() + "," + pl.getIdPlaylist() +");";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.executeUpdate();
            Connector.close(con);
        } catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }

    public Map<Playlist, List<Media>> getPlaylists(){
        try {
            Map<Playlist, List<Media>> stru = new HashMap<>();
            con = Connector.connect();
            String sql = "SELECT * from DSS.Playlist";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                List<Media> arr = new ArrayList<>();

                Playlist play = new Playlist(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getInt(4));
                String sql1 = "SELECT * from DSS.Media_Playlist where idPlaylist = "+rs.getInt(1)+";";
                ps = con.prepareStatement(sql1);
                ResultSet rs1 = ps.executeQuery();

                while(rs1.next()){
                    int id = rs1.getInt(1);

                    String sql2 = "SELECT * from DSS.Media where idMedia = "+id+";";
                    ps = con.prepareStatement(sql2);
                    ResultSet rs2 = ps.executeQuery();
                    if(rs2.next()){
                        Media med = new Media(rs2.getInt(1),
                                              rs2.getString(2),
                                              rs2.getString(4),
                                              rs2.getString(3),
                                              rs2.getString(5));
                        arr.add(med);
                    }
                }
                stru.put(play,arr);
            }
            Connector.close(con);
            return stru;
        } catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }
}
