import java.util.*;
import java.io.*;
import static java.lang.System.out;

public class GereVendasAppMVC implements Serializable{
    public static void main(String[] args) {
        IGereVendasModel model = new GereVendasModel();
        model.createData();
        if(model == null) { out.println("ERRO INICIALIZACAO"); System.exit(-1); }
        IGereVendasView view = new GereVendasView();
        IGereVendasController control = new GereVendasController();
        control.setModel(model);
        control.setView(view); 
        control.startController();
        System.exit(0);
    }  
}