package Presentation.Controller;

import Business.Gestor_Media.*;
import Business.Gestor_Contas.*;
import Presentation.View.*;

import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Iterator;

public class Controller implements BooleanChangeObserver {
    private MediaCenterLN model;
    private MediaCenterGUI view;
    private Utente userAtual;

    public Controller(MediaCenterLN m, MediaCenterGUI v) {
        model = m;
        v.register(this);
        view = v;
    }

    public void initController() {
        view.criarLogin();
    }

    public void notifyLogin(String username, String password) {
        boolean login = model.login(username,password);
        userAtual = model.getUserAtual();
        if (login) {
            if (userAtual instanceof Administrador) view.criarAdmin();
            else view.criarMenu();
        }
        else view.criarAviso(0,true);
    }

    public void notifyLogout() {
        userAtual = null;
        model.logout();
    }
    
    public void notifyUpload(List<Media> m, int size, String nome, Boolean inutil) {
        String categoria = m.get(0).getCategoria();
        for (Media media: m) {
            if (!categoria.equals(media.getCategoria())) categoria = "Mix";
        }
        if (size > 1) {
            Playlist pl = new Playlist(1, nome, categoria, userAtual.getId());
            model.upload(m,userAtual.getEmail(),pl);
        }
        else
            model.uploadM(m.get(0),userAtual.getEmail());
    }
    
    public List<String> notifyDisplayPlay() {
        List<String> nomes = new ArrayList<>();
        if (model.getPlays().keySet().size() == 0) 
            return null;
        else {
            List<Playlist> listaPlays = new ArrayList<>(model.getPlays().keySet());
            for(int i = 0; i < listaPlays.size(); i++) {
                nomes.add(listaPlays.get(i).getNome());
            }
            return nomes;
        }
    }

    public List<String> notifyDisplayPlayEsp(String nomePlay, Boolean isUser) {
        List<String> nomes = new ArrayList<>();
        List<Media> medias = new ArrayList<>();
        Iterator it =  model.getPlays().entrySet().iterator();
        while(it.hasNext()) {
            Map.Entry pair = (Map.Entry)it.next();
            Playlist p = (Playlist)pair.getKey();
            if (p.getNome().equals(nomePlay)) {
                medias = (List<Media>)pair.getValue();
            }  
            it.remove();
        }
        for(int j = 0; j < medias.size(); j++) 
            nomes.add(medias.get(j).getNomeFicheiro()); 
        return nomes;
    }

    public List<String> notifyDisplayRep(String ctg, Boolean isUser) {
        List<String> nomes = new ArrayList<>();
        List<Media> medias;
        int id = 0;

        if (isUser) id = userAtual.getId();
        if ((medias = model.getMediaPC(id,ctg,isUser)).size() == 0)
            return null;
        else {
            for(int i = 0; i < medias.size(); i++) {
                nomes.add(medias.get(i).getNomeFicheiro());
            }
        }
        return nomes;
    }

    public void notifyNovaCategoria(String musica, String categoria) {
        model.alterarCategoria(userAtual.getId(),musica,categoria);
    }

    public void notifyPlay(String musica) throws IOException {
        Desktop.getDesktop().open(new File(model.getDiretoriaMedia(musica)));
    }

    public void notifyUltimo() {}
    public void notifyNomePlaylist(String nome) {}
}
