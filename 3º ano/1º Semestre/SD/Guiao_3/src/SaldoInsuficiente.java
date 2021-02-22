public class SaldoInsuficiente extends Exception {
    public SaldoInsuficiente(int id) {
        super(Integer.toString(id));
    }
}
