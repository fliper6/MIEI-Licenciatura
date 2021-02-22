package Business.Gestor_Media;

import java.awt.*;
import java.io.File;
import java.io.IOException;

public class Media {
    private int id;
    private String nomeFicheiro;
    private String categoria;
    private String artista;
    private String diretoria;

    public Media(int id,String nomeFicheiro, String categoria, String artista,String diretoria) {
        this.diretoria = diretoria;
        this.id = id;
        this.nomeFicheiro = nomeFicheiro;
        this.categoria = categoria;
        this.artista = artista;
    }

    public Media() {
        this.diretoria = "/home/dir";
        this.id = -1;
        this.nomeFicheiro = null;
        this.categoria = null;
        this.artista = null;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNomeFicheiro() {
        return nomeFicheiro;
    }

    public void setNomeFicheiro(String nomeFicheiro) {
        this.nomeFicheiro = nomeFicheiro;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getArtista() {
        return artista;
    }

    public void setArtista(String artista) {
        this.artista = artista;
    }

    public String getDiretoria() {
        return diretoria;
    }

    public void setDiretoria(String diretoria) {
        this.diretoria = diretoria;
    }

    public void play(){
        try {
            Desktop.getDesktop().open(new File(diretoria));
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }

    public String toString(){
        return "/Artista: " + this.artista + " - Nome: " + this.nomeFicheiro + " - Categoria: " + this.categoria;
    }
}
