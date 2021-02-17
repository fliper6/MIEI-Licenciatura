import java.io.IOException;

public interface IGereVendasController{
    public void setView(IGereVendasView view);
    public void setModel(IGereVendasModel model);

    public void guardaInfo() throws IOException;
    public void carregarInfo(String fich) throws IOException, ClassNotFoundException;

    public void startController();
    public void cS();
    public void queriesInterativas();
    public void gI();
    public void cI();
    public void cV();
    public void cS2();

    public void c1();
    public void c2();
    public void c3();
    public void c4();
    public void c5();
    public void c6();
    public void c7();
    public void c8();
    public void c9();
    public void c10();
}
