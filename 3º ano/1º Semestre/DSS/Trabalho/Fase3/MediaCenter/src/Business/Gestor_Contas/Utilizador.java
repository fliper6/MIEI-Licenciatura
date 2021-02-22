package Business.Gestor_Contas;

public class Utilizador extends Utente{
    public Utilizador(int id, String nome, String email, String password) {
        super(id, nome, email, password);
    }

    public Utilizador(Utente ut) {
        super(ut);
    }

    public Utilizador() { super(); }
}
