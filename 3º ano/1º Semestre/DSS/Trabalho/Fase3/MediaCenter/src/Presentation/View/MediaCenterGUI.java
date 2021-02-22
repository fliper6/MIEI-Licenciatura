package Presentation.View;

import Presentation.Controller.*;
import Business.Gestor_Contas.*;
import Business.Gestor_Media.*;

import javax.swing.*;
import java.awt.*;
import java.io.IOException;
import java.util.List;

public class MediaCenterGUI implements BooleanChangeObserver{
    private JLogin frameLogin;
    private BooleanChangeObserver observer;
    public static final Color VERY_LIGHT_BLUE = new Color(204,229,255);

    public void criarAviso(int aviso, Boolean isUser) {
        JAviso frame = new JAviso(this,aviso,isUser);
        setFrame(frame,400,100);
    }

    public void criarMenu() {
        JMain frame = new JMain(this);
        setFrame(frame,450,200);
    }

    public void criarAdmin() {
        JAdmin frame = new JAdmin(this);
        setFrame(frame,450,200);
    }

    public void criarLogin() {
        frameLogin = new JLogin(this);
        setFrame(frameLogin,400,200);
    }

    public void criarUpload(JSubMain2 main, int i, String diretoria, Boolean typeFile) {
        JUpload frame = new JUpload(main,i,diretoria,typeFile);
        setFrame(frame,400,200);
    }

    public void criarSubMain1(Boolean isUser) {
        JSubMain1 frame = new JSubMain1(this,isUser);
        setFrame(frame,520,200);
    }

    public void criarSubMain2() {
        JSubMain2 frame = new JSubMain2(this);
        setFrame(frame,450,200);
    }

    public void criarRepGen(String g, String nomePlaylist, Boolean isUser, int aviso) {
        String nome;
        List<String> lista;
        if (g.equals("Playlist")) {
            lista = observer.notifyDisplayPlay();
            nome = g;
            aviso = 3;
        } 
        else if (g.equals("Playlist_Específica")) {
            lista = observer.notifyDisplayPlayEsp(nomePlaylist,isUser);
            nome = "Playlist " + nomePlaylist;
        } else {
            lista = observer.notifyDisplayRep(g,isUser);
            nome = g;
        }
        if (lista != null) {
            JRepGen frame = new JRepGen(nome,this,lista,isUser);
            setFrame(frame,450,200);
        }
        else
            criarAviso(aviso,isUser);
    }

    public void criarRepMus(Boolean isUser) {
        JRepMus frame = new JRepMus(this,isUser);
        setFrame(frame,550,200);
    }

    public void criarNomePlaylist(JSubMain2 main) {
        JNomePlaylist frame = new JNomePlaylist(main);
        setFrame(frame,400,120);
    }

    public void criarAltCat(String musica, Boolean isUser) {
        JAltCategoria frame = new JAltCategoria(this,musica,isUser);
        setFrame(frame,400,150);
    }

    public void setFrame(JFrame frame, int width, int height) {
        frame.setSize(width,height);
        frame.setVisible(true);
        frame.setResizable(false);
    }

    public void notifyPlay(String musica) {
        try {
            observer.notifyPlay(musica);
        } catch (Exception e) {
            try {
                throw new IOException(e.getMessage());
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }

    public void notifyLogin(String u, String p) {observer.notifyLogin(u,p);}
    public void notifyLogout() {observer.notifyLogout();}
    public void notifyUpload(List<Media> m, int size, String nome, Boolean inutil) {observer.notifyUpload(m,m.size(),nome,inutil);}
    public List<String> notifyDisplayRep(String ctg, Boolean isUser) {return observer.notifyDisplayRep(ctg,isUser);}
    public List<String> notifyDisplayPlay() {return observer.notifyDisplayPlay();}
    public List<String> notifyDisplayPlayEsp(String np, Boolean isUser) {return observer.notifyDisplayPlayEsp(np,isUser);}
    public void notifyNovaCategoria(String musica, String categoria) {observer.notifyNovaCategoria(musica,categoria);}
    public void notifyUltimo() {}
    public void notifyNomePlaylist(String nome) {}

    public void register(BooleanChangeObserver obs) {observer = obs;}
}
