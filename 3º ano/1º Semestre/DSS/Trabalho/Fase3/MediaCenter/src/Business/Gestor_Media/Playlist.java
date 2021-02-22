package Business.Gestor_Media;

public class Playlist {
    private int idPlaylist;
    private String nome;
    private String categoria;
    private int idUser;

    public Playlist(int id, String nome, String categoria,int idU) {
        this.idPlaylist = id;
        this.nome = nome;
        this.categoria = categoria;
        this.idUser = idU;
    }

    public Playlist(){
        this.idPlaylist = -1;
        this.nome = "";
        this.categoria = "";
        this.idUser = -1;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public int getIdPlaylist() {
        return idPlaylist;
    }

    public void setIdPlaylist(int idPlaylist) {
        this.idPlaylist = idPlaylist;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    @Override
    public int hashCode() {
        return idPlaylist;
    }

    //Compare only account numbers
    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Playlist other = (Playlist) obj;
        if (idPlaylist != other.idPlaylist)
            return false;
        return true;
    }

    public String toString(){
        return "\nNome: " + this.nome + " , Categoria: " + this.categoria +" ";
    }
}
