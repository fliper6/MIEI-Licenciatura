package Business.Gestor_Contas;

public abstract class Utente {
    private int id;
    private String nome;
    private String password;
    private String email;

    public Utente(int id,String nome, String email,String password) {
        this.id = id;
        this.nome = nome;
        this.password = password;
        this.email = email;
    }

    public Utente(Utente ut) {
        this.id = ut.getId();
        this.nome = ut.getNome();
        this.password = ut.getPassword();
        this.email = ut.getEmail();
    }

    public Utente() {
        this.id = -1;
        this.nome = "default";
        this.password = "default";
        this.email = "default";

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String toString() {
        StringBuilder ret = new StringBuilder("Nome: " + nome + ", email: " + email);
        return ret.toString();
    }

    public Utente getUtente() {
        Utente u;
        if (this instanceof Administrador) u = new Administrador();
        else u = new Utilizador();
        u.setEmail(this.getEmail());
        u.setId(this.getId());
        u.setNome(this.getNome());
        u.setPassword(this.getPassword());
        return u;
    }
}
