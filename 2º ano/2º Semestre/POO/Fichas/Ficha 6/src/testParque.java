import java.util.HashMap;

public class testParque
{
    private Parque p;

    public testParque()
    {
    }

    public void setUp()
    {
        Lugar l1 = new Lugar ("AA-11-11","user 1",10,true);
        Lugar l2 = new Lugar ("AA-11-12","user 2",50,true);
        Lugar l3 = new Lugar ("AA-11-13","user 3",30,false);

        p = new Parque("Parque1", new HashMap<>());
        p.registaLugar(l1);
        p.registaLugar(l2);
        p.registaLugar(l3);

    }

    public void tearDown()
    {

    }

    //import.junit ??
    public void test1(){
        int m = p.ordenaLugar().first().getMinutos();
        assertequals 150;
    }
}