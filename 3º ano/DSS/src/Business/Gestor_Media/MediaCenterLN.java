package Business.Gestor_Media;

import Business.Gestor_Contas.*;
import Data.*;

import java.util.List;
import java.util.Map;

public class MediaCenterLN {
    private UtilizadorDAO utilizadores;
    private AdministradorDAO administrador;
    private MediaDAO medias;
    private PlaylistDAO playlists;
    private Utente userAtual = null;

    public MediaCenterLN (){
        this.utilizadores = new UtilizadorDAO();
        this.administrador = new AdministradorDAO();
        this.medias = new MediaDAO();
        this.playlists = new PlaylistDAO();
    }

    public boolean login(String email,String pw){
        Utente utente;
        if ((utente = administrador.containsKey(email)) != null){
            userAtual = utente.getUtente();
            return administrador.get(email).getPassword().equals(pw);
        }
        if ((utente = utilizadores.contemChave(email)) != null){
            userAtual = utente.getUtente();
            return utilizadores.get(email).getPassword().equals(pw);
        }
        else {
            userAtual = null;
            return false;
        }
    }

    public void logout() { userAtual = null; }

    public void upload(List<Media> media,String user,Playlist pl){//se so tiver uma media na list -> nao é playlist
        int x = media.size();
        Utilizador ut = utilizadores.get(user);
        Playlist play = new Playlist();
        Media md;
        pl.setIdUser(ut.getId());
        if (x==1){
            md = media.get(0);
            md = uploadM(md,user);
        } else {
            int i;
            play = playlists.put(-1,pl);//id não interessa aqui
            i = playlists.getMax();
            pl.setIdPlaylist(i);
            while (x>0) {
                md = media.get(x - 1);
                md = uploadM(md, user);
                playlists.putMediaInPlaylist(md,pl);
                --x;
            }
        }
    }

    public Media uploadM(Media md,String user) {
        Utilizador ut = utilizadores.get(user);
        Media mede;
        if (medias.containsKey(md.getNomeFicheiro())) {
            mede = medias.get(md.getNomeFicheiro());
            medias.putMediaInUser(ut, mede);
        } else {
            String line = md.getDiretoria();
            String[] str = line.split("\\\\");

            StringBuilder str1 = new StringBuilder();
            str1.append(str[0]);
            int i = str.length;
            int l = 1;
            while(l<i){
                str1.append("\\\\"+str[l++]);
            }

            md.setDiretoria(str1.toString());
            mede = medias.put(md.getNomeFicheiro(), md);
            mede = medias.get(md.getNomeFicheiro());
            medias.putMediaInUser(ut,mede);
        }
        return mede;
    }

    public void alterarCategoria(int user,String media,String categoria){
        medias.atualizaCategoria(user,medias.get(media).getId(),categoria);
    }

    public List<Media> getMediaPC(int user, String categoria, Boolean isUser){
        if (isUser) {
            if (categoria.equals("Música Pessoal") || categoria.equals("Vídeo Pessoal")) {
                return medias.getMediaPessoal(user,categoria);
            }
            return medias.getMediaPorCategoriaUser(user,categoria);
        }
        return medias.getMediaPorCategoriaConvidado(categoria);
    }

    public Utente getUserAtual() {
        Utente u;
        if (userAtual instanceof Utilizador) { u = new Utilizador(); }
        else if (userAtual instanceof Administrador) { u = new Administrador(); }
        else { return null; }
        u.setEmail(userAtual.getEmail());
        u.setId(userAtual.getId());
        u.setNome(userAtual.getNome());
        u.setPassword(userAtual.getPassword());
        return u;
    }

    public String getDiretoriaMedia(String nome){
        return medias.get(nome).getDiretoria();
    }

    public Map<Playlist,List<Media>> getPlays(){
        return playlists.getPlaylists();
    }
}

