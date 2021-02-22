package Presentation.Controller;

import Business.Gestor_Media.Media;

import java.io.IOException;
import java.util.List;

public interface BooleanChangeObserver {
    /**
     * Called whenever the variable is changed.
     */
    void notifyLogin(String username, String password);
    void notifyLogout();
    void notifyUpload(List<Media> medias, int i, String nome, Boolean typeFile);
    List<String> notifyDisplayRep(String ctg, Boolean isUser);
    List<String> notifyDisplayPlay();
    List<String> notifyDisplayPlayEsp(String nomePlaylist, Boolean isUser);
    void notifyUltimo();
    void notifyNomePlaylist(String nome);
    void notifyNovaCategoria(String musica, String categoria);
    void notifyPlay(String musica) throws IOException;
}
