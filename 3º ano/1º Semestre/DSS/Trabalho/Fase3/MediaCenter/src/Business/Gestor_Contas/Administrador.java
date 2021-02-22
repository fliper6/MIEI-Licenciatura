package Business.Gestor_Contas;

public class Administrador extends Utente {
    public Administrador(int id, String nome, String email, String password) {
        super(id, nome, email, password);
    }

    public Administrador(Utente ut) {
        super(ut);
    }

    public Administrador() { super(); }
}
