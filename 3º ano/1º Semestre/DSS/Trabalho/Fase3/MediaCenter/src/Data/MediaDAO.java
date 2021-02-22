package Data;

import Business.Gestor_Contas.Utilizador;
import Business.Gestor_Media.Media;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.*;

public class MediaDAO implements Map<String, Media> {
    private Connection con;

    @Override
    public int size() {
        try {
            int ret = 0;
            con = Connector.connect();
            String sql = "SELECT count(*) from DSS.Media;";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                ret = Integer.parseInt(rs.getString(1));
            }
            Connector.close(con);
            return ret;
        }
        catch(Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }

    @Override
    public boolean isEmpty() {
        return this.size()==0;
    }

    public boolean containsKey(Object key) {
        try {
            boolean r;
            con = Connector.connect();
            String sql = "SELECT * from DSS.Media where nomeMedia = '"+key+"'";
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
        try {
            boolean r = false;
            con = Connector.connect();
            Media media = (Media) value;
            String sql = "SELECT count(*) from DSS.Media m, DSS.Categoria cat where m.idCategoria = cat.idCategoria and nomeMedia = '"
                    + media.getNomeFicheiro() +
                    "' and artista = '"
                    + media.getArtista() +
                    "' and designacao = '"
                    + media.getCategoria() +
                    "';";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                r = rs.getInt(1) == 1;
            }
            Connector.close(con);
            return r;
        } catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }

    public Media get(Object key) {
        try {
            Media ut = new Media();
            con = Connector.connect();
            String sql = "SELECT * from DSS.Media where nomeMedia = '"+key+"'";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery(sql);
            if(rs.next()) {
                ut= new Media(rs.getInt(1),rs.getString(2),rs.getString(4),rs.getString(3),rs.getString(5));
            }
            Connector.close(con);
            return ut;
        }catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }

    public Media getPorId(Object key) {
        try {
            Media ut = new Media();
            con = Connector.connect();
            String sql = "SELECT * from DSS.Media where idMedia = '"+key+"'";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery(sql);
            if(rs.next()) {
                ut= new Media(rs.getInt(1),rs.getString(2),rs.getString(4),rs.getString(3),rs.getString(5));
            }
            Connector.close(con);
            return ut;
        }catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }

    @Override
    public Media put(String key, Media value) {
        try {
            String sql;
            con = Connector.connect();
            Statement s = con.createStatement();
            s.executeUpdate("DELETE from DSS.Media where nomeMedia='"+key+"';");
            String values = "('" + key + "','" + value.getArtista() + "','" + value.getCategoria() + "','"+value.getDiretoria()+"');";
            sql = "INSERT into DSS.Media (nomeMedia,artista,categoria,diretoria) values " + values;
            PreparedStatement ps = con.prepareStatement(sql);
            ps.executeUpdate();
            Connector.close(con);
            return value;
        } catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }

    @Override
    public Media remove(Object key) {
        try {
            Media media = null;
            con = Connector.connect();
            String sql = "DELETE from DSS.Media where nomeMedia='" + key + "';";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.executeUpdate();
            Connector.close(con);
            return media;
        } catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }

    @Override
    public void putAll(Map<? extends String, ? extends Media> m) {
        m.entrySet().stream().
                forEach(entry -> this.put(entry.getKey(),entry.getValue()));
        return;
    }

    @Override
    public void clear() {
        try {
            con = Connector.connect();
            String sql = "DELETE from DSS.Media";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.executeUpdate();
            Connector.close(con);
        } catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }

    @Override
    public Set<String> keySet() {
        try {
            Set<String> ret = new TreeSet<>();
            con = Connector.connect();
            String sql = "SELECT nomeMedia from DSS.Media;";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ret.add(rs.getString(1));
            }
            Connector.close(con);
            return ret;
        } catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }

    @Override
    public Collection<Media> values() {
        try {
            List<Media> ret = new ArrayList<>();
            con = Connector.connect();
            String sql = "SELECT nomeMedia,artista,idCategoria from DSS.Media;";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ret.add(new Media(rs.getInt(1),rs.getString(2),rs.getString(4),rs.getString(3),rs.getString(5)));
            }
            Connector.close(con);
            return ret;
        } catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }

    @Override
    public Set<Entry<String, Media>> entrySet() {
        throw new NullPointerException("Não necessário, portanto, não implementado.");
    }

    public void putMediaInUser(Utilizador ut, Media med) {
        try {
            con = Connector.connect();
            Statement s = con.createStatement();
            s.executeUpdate("DELETE from DSS.Utilizador_Media where idUser = "+ut.getId()+" and idMedia = "+med.getId()+";");
            String sql = "INSERT into DSS.Utilizador_Media VALUES (" + ut.getId() + "," + med.getId() +",'"+med.getCategoria()+"');";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.executeUpdate();
            Connector.close(con);
        } catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }

    public void atualizaCategoria(int iduser,int idmedia, String cat) {
        try {
            String sql;
            con = Connector.connect();
            Statement s = con.createStatement();
            s.executeUpdate("DELETE from DSS.Utilizador_Media where idUser=" + iduser + " and idMedia = "+idmedia+";");
            String values = "('" + iduser + "','" + idmedia + "','A" + cat + "');";
            sql = "INSERT into DSS.Utilizador_Media (idUser,idMedia,categoria) values " + values;
            PreparedStatement ps = con.prepareStatement(sql);
            ps.executeUpdate();
            Connector.close(con);
        } catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }

    public int estaNaLista(List<Media> m, int id) {
        for (int i = 0; i < m.size(); i++) {
            if (m.get(i).getId() == id) return i;
        }
        return -1;
    }

    public List<Media> getMediaPorCategoriaUser(int idUser, String categoria){
        try {
            List<Media> mediasUser = new ArrayList<>();
            List<Media> medias = new ArrayList<>();
            List<Media> ret = new ArrayList<>();

            con = Connector.connect();
            String sql = "SELECT * from DSS.Utilizador_Media where idUser = "+idUser+";";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Media m = getPorId(rs.getInt(2));
                String cat = rs.getString(3);
                if (cat.charAt(0) == 'A') cat = cat.substring(1);
                mediasUser.add(new Media(m.getId(),m.getNomeFicheiro(),cat,m.getArtista(),m.getDiretoria()));
            }
            Connector.close(con);

            con = Connector.connect();
            sql = "SELECT * from DSS.Media where categoria = '"+categoria+"';";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next())
                medias.add(new Media(rs.getInt(1),rs.getString(2),rs.getString(4),rs.getString(3),rs.getString(5)));
            Connector.close(con);

            for (Media m: mediasUser)
                if (m.getCategoria().equals(categoria)) ret.add(m);
            for (Media m: medias)
                if (estaNaLista(mediasUser,m.getId()) == -1) ret.add(m);

            ret.sort(new MediaComparator());
            return ret;
        } catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }

    public List<Media> getMediaPessoal(int idUser, String categoria){
        try {
            List<Media> mediasUser = new ArrayList<>();
            con = Connector.connect();

            String sql;
            if (categoria.equals("Vídeo Pessoal"))
                sql = "SELECT * from DSS.Utilizador_Media where idUser = "+idUser+" and categoria = 'Vídeo';";
            else
                sql = "SELECT * from DSS.Utilizador_Media where idUser = "+idUser+";";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Media m = getPorId(rs.getInt(2));
                if ((categoria.equals("Música Pessoal") && !m.getCategoria().equals("Vídeo") && rs.getString(3).charAt(0) != 'A')
                        || categoria.equals("Vídeo Pessoal"))
                    mediasUser.add(new Media(m.getId(),m.getNomeFicheiro(),rs.getString(3),m.getArtista(),m.getDiretoria()));
            }
            Connector.close(con);

            mediasUser.sort(new MediaComparator());
            return mediasUser;
        } catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }

    public List<Media> getMediaPorCategoriaConvidado(String categoria){
        try {
            List<Media> ret = new ArrayList<>();
            con = Connector.connect();
            String sql = "SELECT * from DSS.Media where categoria = '"+categoria+"';";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ret.add(new Media(rs.getInt(1),rs.getString(2),rs.getString(4),rs.getString(3),rs.getString(5)));
            }
            Connector.close(con);
            return ret;
        } catch (Exception e) {
            throw new NullPointerException(e.getMessage());
        }
    }
}