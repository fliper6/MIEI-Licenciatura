import java.util.*;
import java.io.*;

/**
 * Classe que gere o programa dependendo do Input, usando para tal a View e o Model
 */
public class GereVendasController implements IGereVendasController, Serializable {

    private IGereVendasModel model; 
    private IGereVendasView view; 

    /**
     * Método que altera a variavel de instancia model.
     */
    public void setModel(IGereVendasModel model){
        this.model = model;
    }

    /**
     * Método que altera a variavel de instancia view.
     */
    public void setView(IGereVendasView view){
        this.view = view;
    }

    /**
     * Método que inicia o menu principal.
     */
    public void startController() {
        boolean i = true;
        view.printTempo(model.getTempo());
        while(i) {
            view.printMP();
            int in = Input.lerInt();
            if(in == 0) i = false;
            else if(in == 1) cI();
            else if(in == 2) cV();
            else if(in == 3) gI();
            else if(in == 4) cS();
            else if(in == 5) queriesInterativas();
            else view.printErroInput();
        }
    }

    /**
     * Método que inicia o menu de consultas.
     */
    public void cS() {
        boolean i = true;
        if(this.model.getFaturacao().getFatTotal() == 0) {
            view.printCondicao(55);
            i= false;
        }
        while (i) {
            view.printMC();
            int in = Input.lerInt();
            if (in == 0) i = false;
            else if (in == 1) cS1();
            else if (in == 2) cS2();
            else view.printErroInput();
        }
    }

    /**
     * Método que inicia o menu de queries.
     */
    public void queriesInterativas() {
        boolean i = true;
        if(this.model.getFaturacao().getFatTotal() == 0) {
            view.printCondicao(55);
            i = false;
        }
        while(i) {
            view.printMQ();
            int in = Input.lerInt();
            if(in == 0) i = false;
            else if(in == 1) c1();
            else if(in == 2) c2();
            else if(in == 3) c3();
            else if(in == 4) c4();
            else if(in == 5) c5();
            else if(in == 6) c6();
            else if(in == 7) c7();
            else if(in == 8) c8();
            else if(in == 9) c9();
            else if(in == 10) c10();
            else view.printErroInput();
        }
    }

    /**
     * Método que guarda o estado da app em binario.
     */
    public void guardaInfo() throws IOException {
        ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("gestVendas.dat"));
        oos.writeObject(this.model);
        oos.flush();
        oos.close();
    }

    /**
     * Método que carrerga o estado da app em binario para as estruturas.
     */
    public void carregarInfo(String fich) throws IOException, ClassNotFoundException {
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(fich));
        this.model = (IGereVendasModel) ois.readObject();
        ois.close();
    }

    /**
     * Método que guarda o estado da app em binario e printa o tempo.
     */
    public void gI() {
        crono.start();
        try {
            guardaInfo();
        } catch (IOException e) {view.printCondicao(60);}
        view.printTempo(crono.stop());
    }

    /**
     * Método que carrega para o model o ficheiro em binario dado pelo user.
     */
    public void cI() {
        crono.start();
        String fich="";
        view.printCondicao(50);
        fich = Input.lerString();
        try {
            carregarInfo(fich);
        } catch (ClassNotFoundException | IOException e) {view.printCondicao(61);}
        view.printTempo(crono.stop());
    }

    /**
     * Método que lê o ficheiro de txt de vendas , com nome dado pelo user.
     */
    public void cV() {
        String fich="";
        view.printCondicao(50);
        fich = Input.lerString();
        if (fich.equals("Vendas_1M.txt") || fich.equals("Vendas_3M.txt") || fich.equals("Vendas_5M.txt")){
            model.lerTxt(fich);
            view.printTempo(model.getTempo());
        }
    }

    /**
     * Método que executa a consulta estatistica do ficheiro lido anteriormente.
     */
    public void cS1() {
        String fich = model.getFich();
        Double fat = model.getFat();
        List<Integer> arr = model.getEstatisticas();
        view.printConsulta1(fich,arr,fat);
        view.printSeguir();
    }

    /**
     * Método que printa os valores da consulta estatistica das estruturas atualmente carregadas.
     */
    public void cS2() {
        crono.start();
        List<Integer> c = model.TotalComprasM();
        List<List<Double>> tf = model.fatTotalMesFilial();
        List<List<Integer>> cd = model.clientesDifMesFilial();
        view.printConsulta2(c,tf,cd);
        view.printSeguir();
    }

    /**
     * Método que executa a querie 1 e printa valores e tempos de execução.
     */
    public void c1() {
        crono.start();
        List<String> l = model.query1();
        Double t = crono.stop();
        view.print1(l, t);
    }

    /**
     * Método que executa a querie 2 e printa valores e tempos de execução.
     */
    public void c2() {
        int mes = 1;
        String modo = "";
        boolean v = true, v2 = false;
        while(v) {
            view.printCondicao(2);
            mes = Input.lerInt();
            if (mes == 0) break;
            if (mes >= 1 && mes <= 12) v = false;
            else view.printErroInput();
        }
        while(!v) {
            view.printCondicao(21);
            modo = Input.lerString();
            if (modo.equals("0")) break;
            if (modo.equals("G") || modo.equals("F")) v2 = v = true;
            else view.printErroInput();
        }
        if(v2) {
            crono.start();
            List<Integer> l = model.query2(mes,modo);
            Double t = crono.stop();
            view.print2(l, mes, modo, t);
            view.printSeguir();
        }
    }

    /**
     * Método que executa a querie 3 e printa valores e tempos de execução.
     */
    public void c3() {
        String cli = "";
        boolean v = true;
        while(v) {
            view.printCondicao(3);
            cli = Input.lerString();
            if (cli.equals("0")) break;
            else if (!CatClis.validaCliente(cli)) view.printErroInput();
            else if (!model.getCatClis().containsCli(cli)) view.printNCli();
            else v = false;
        }
        if(!v) {
            crono.start();
            Map<Integer,List<Double>> m = model.query3(cli);
            Double t = crono.stop();
            view.print3(m, cli, t);
            view.printSeguir();
        }
    }

    /**
     * Método que executa a querie 4 e printa valores e tempos de execução.
     */
    public void c4() {
        String prod = "";
        boolean v = true;
        while(v) {
            view.printCondicao(4);
            prod = Input.lerString();
            if (prod.equals("0")) break;
            else if (!CatProds.validaProduto(prod)) view.printErroInput();
            else if (!model.getCatProds().containsProd(prod)) view.printNProd();
            else v = false;
        }
        if(!v) {
            crono.start();
            Map<Integer,List<Double>> m = model.query4(prod);
            Double t = crono.stop();
            view.print4(m, prod, t);
            view.printSeguir();
        }
    }
    /**
     * Método que executa a querie 5 e printa valores e tempos de execução.
     */
    public void c5() {
        String cli = "";
        boolean v = true;
        while(v) {
            view.printCondicao(5);
            cli = Input.lerString();
            if (cli.equals("0")) break;
            else if (CatClis.validaCliente(cli)) v = false;
            else view.printErroInput();
        }
        if(!v) {
            crono.start();
            List<Fil> l = model.query5(cli);
            Double t = crono.stop();
            view.print5(l, cli, t);
        }
    }
    /**
     * Método que executa a querie 6 e printa valores e tempos de execução.
     */
    public void c6() {
        int x = 0;
        boolean v = true;
        while(v) {
            view.printCondicao(6);
            x = Input.lerInt();
            if (x == 0) break;
            else if (x > 0) v = false;
            else view.printErroInput();
        }
        if(!v) {
            crono.start();
            Map<String,List<Integer>> m = model.query6(x);
            Double t = crono.stop();
            view.print6(m, x, t);
        }
    }

    /**
     * Método que executa a querie 7 e printa valores e tempos de execução.
     */
    public void c7() {
        crono.start();
        Map<Integer,List<Fat>> m = model.query7();
        Double t = crono.stop();
        view.print7(m, t);
        view.printSeguir();
    }

    /**
     * Método que executa a querie 8 e printa valores e tempos de execução.
     */
    public void c8() {
        int x = 0;
        boolean v = true;
        while(v) {
            view.printCondicao(8);
            x = Input.lerInt();
            if (x == 0) break;
            else if (x > 0) v = false;
            else view.printErroInput();
        }
        if(!v) {
            crono.start();
            List<Fil> l = model.query8(x);
            Double t = crono.stop();
            view.print8(l, x, t);
        }
    }

    /**
     * Método que executa a querie 9 e printa valores e tempos de execução.
     */
    public void c9() {
        int x = 0;
        String prod = "";
        boolean v = true, v2 = false;
        while(v) {
            view.printCondicao(91);
            prod = Input.lerString();
            if (prod.equals("0")) break;
            else if (!CatProds.validaProduto(prod)) view.printErroInput();
            else if (!model.getCatProds().containsProd(prod)) view.printNProd();
            else v = false;
        }
        while(!v) {
            view.printCondicao(92);
            x = Input.lerInt();
            if (x == 0) break;
            else if (x > 0) v2 = v = true;
            else view.printErroInput();
        }
        if(v2) {
            crono.start();
            Map<String,List<Double>> m = model.query9(prod,x);
            Double t = crono.stop();
            view.print9(m, prod, x, t);
        }
    }

    /**
     * Método que executa a querie 10 e printa valores e tempos de execução.
     */
    public void c10() {
        crono.start();
        List<Map<String,List<Double>>> l = model.query10();
        Double t = crono.stop();
        view.print10(l,t);
    }
}