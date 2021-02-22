public class ContaInvalida extends Exception {
    public ContaInvalida(int id) {
        super(Integer.toString(id));
    }
}
