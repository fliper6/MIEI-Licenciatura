import java.util.*;
import java.io.*;
import static java.lang.System.out;

/**
 * Classe que trata de tudo que seja o Output do Programa, para o utilizador
 */
public class GereVendasView implements IGereVendasView, Serializable{
    private List<String> menuQ;
    private List<String> menuP;
    private List<String> menuC;

    /**
     * Método que inicia as variaveis de instancia com as respetivas Strings.
     */
    public GereVendasView() {
        this.menuQ = new ArrayList<>();
        this.menuP = new ArrayList<>();
        this.menuC = new ArrayList<>();

        this.menuC.add("Consultas Estatisticas:");
        this.menuC.add("1 - Consulta de dados referentes ao último ficheiro.");
        this.menuC.add("2 - Consulta de dados nas estruturas atuais.");
        this.menuC.add("0 - Retroceder.");
        this.menuC.add("Selecione uma opçao: ");

        this.menuP.add("Menu Principal: ");
        this.menuP.add("1 - Carregar estado.");
        this.menuP.add("2 - Carregar ficheiro de vendas.");
        this.menuP.add("3 - Gravar estruturas/estado.");
        this.menuP.add("4 - Consultas estatisticas.");
        this.menuP.add("5 - Consultas interativas.");
        this.menuP.add("0 - Terminar o programa.");
        this.menuP.add("Selecione uma opçao: ");

        this.menuQ.add("Queries: ");
        this.menuQ.add(" 1 - Lista ordenada alfabeticamente com os códigos dos produtos nunca comprados e o respectivo total.");
        this.menuQ.add(" 2 - Numero total de vendas num dado mes e de clientes que as realizaram, globalmente ou por filial.");
        this.menuQ.add(" 3 - Numero de compras e de produtos distintos adquiridos por um dado cliente e o total gasto, por mes.");
        this.menuQ.add(" 4 - Numero de vezes que um dado produto foi comprado, por quantos clientes distintos e o total faturado com ele, por mes.");
        this.menuQ.add(" 5 - Lista ordenada, por quantidade, de codigos dos produtos comprados por um dado cliente.");
        this.menuQ.add(" 6 - X produtos mais vendidos durante o ano (em quantidade) e numero total de clientes distintos que os compraram.");
        this.menuQ.add(" 7 - Lista dos três maiores compradores em termos de dinheiro facturado, por filial.");
        this.menuQ.add(" 8 - Lista dos X clientes que compraram mais produtos diferentes e quantidade comprada de cada um.");
        this.menuQ.add(" 9 - X clientes que mais compraram um dado produto e total gasto.");
        this.menuQ.add("10 - Facturaçao total com cada produto, por mes e filial.");
        this.menuQ.add("Escolha a query que deseja realizar [0 para retroceder]:");
    }

    /**
     * Método que retorna variavel menuQ.
     */
    public List<String> getMenuQ() {
        return this.menuQ;
    }

    /**
     * Método que retorna variavel menuP.
     */
    public List<String> getMenuP() {
        return this.menuP;
    }

    /**
     * Método que retorna variavel menuC.
     */
    public List<String> getMenuC() {
        return this.menuC;
    }

    /**
     * Método que conforme inteiro dado printa a String correspondente.
     * @param q Inteiro que está associado a uma String especifica (int).
     */
    public void printCondicao(int q) {
        if (q == 2 || q == 10)  out.print("\nInsira um mes: ");
        if (q == 21) out.print("\nGlobal (G) ou por Filial (F)? ");
        if (q == 3 || q == 5)  out.print("\nInsira um codigo de Cliente: ");
        if (q == 4 || q == 91)  out.print("\nInsira um codigo de Produto: ");
        if (q == 6 || q == 8 || q == 92)  out.print("\nInsira um numero: ");
        if (q == 50) out.print("\nInsira o nome do ficheiro pretendido: ");
        if (q == 55) out.println("\nAinda não foi carregada nenhuma informação!");
        if (q == 60) out.println("\nInformação não guardada!");
        if (q == 61) out.println("\nInformação não carregada!");
    }

    /**
     * Método que retorna variável menuQ.
     * @param tempo tempo de execução de certo método.
     */
    public void printTempo(Double tempo) {
        out.println("Tempo: "+ tempo);
    }

    /**
     * Método que printa mensagem de erro "input inválido".
     */
    public void printErroInput() {
        out.println("\n** Input Invalido **");
    }

    /**
     * Método que printa mensagem de erro "Cliente não existe".
     */
    public void printNCli() {
        out.println("\n** Cliente Nao Existe **");
    }

    /**
     * Método que printa mensagem de erro "Produto não existe".
     */
    public void printNProd() {
        out.println("\n** Produto Nao Existe **");
    }

    /**
     * Método que printa Strings do menu menuQ.
     */
    public void printMQ() {
        out.println(" ");
        for(String s : this.menuQ) out.println(s);
    }

    /**
     * Método que printa Strings do menu menuP.
     */
    public void printMP() {
        out.println(" ");
        for(String s : this.menuP) out.println(s);
    }
    /**
     * Método que printa Strings do menu menuC.
     */
    public void printMC() {
        out.println(" ");
        for(String s : this.menuC) out.println(s);
    }
    /**
     * Método que verifica se a tecla "c" foi pressionada.
     */
    public void printSeguir() {
        out.print("\nDigite (c) para continuar: ");
        String s = Input.lerString();
        while (!s.equals("c")){
            out.print("Digite (c) para continuar: ");
            s = Input.lerString();
        }
    }

    /**
     * Método que printa valores da consulta estatistica do ficheiro lido anteriormente
     * @param fich Nome do ficheiro.
     * @param arr ArrayList com valores estatisticos.
     * @param fat Faturação total.
     */
    public void printConsulta1(String fich,List<Integer> arr, Double fat) {
        StringBuilder sb = new StringBuilder();
        sb.append("\nÚltimo ficheiro lido: "+ fich);
        sb.append("\n\nNumero de vendas inválidas: " + arr.get(0));
        sb.append("\n\nNumero total de produtos: "+ arr.get(1));
        sb.append("\n   > Comprados: " + arr.get(2));
        sb.append("\n   > Não comprados: " + arr.get(3));
        sb.append("\n\nNumero de clientes diferentes: " + arr.get(4));
        sb.append("\n   > Que compraram: " + arr.get(5));
        sb.append("\n   > Que não compraram: " + arr.get(6));
        sb.append("\n\nNumero total de compras com valor total igual a 0.0: "+ arr.get(7));
        sb.append("\n\nFaturação total: " + String.format("%.2f", fat));
        out.println(sb.toString());

    }
    /**
     * Método que printa valores da consulta estatistica do ficheiro lido anteriormente.
     * @param c Nº total de compras.
     * @param tf ArrayList com a faturações dos diversos meses.
     * @param cd ArrayList com o nº de clientes distintos dos diversos meses.
     */
    public void printConsulta2(List<Integer> c,List<List<Double>> tf, List<List<Integer>> cd) {
        int i;
        for (i = 0; i < 12; i++) {
            StringBuilder sb = new StringBuilder();
            sb.append("\n\n------ Mes " + (i+1) +" ------" );
            sb.append("\n\nNumero de compras: " + c.get(i));
            sb.append("\n\nFaturação:");
            sb.append("\n   > Filial 1: " + String.format("%.2f",tf.get(i).get(0)));
            sb.append("\n   > Filial 2: " + String.format("%.2f",tf.get(i).get(1)));
            sb.append("\n   > Filial 3: " + String.format("%.2f",tf.get(i).get(2)));
            sb.append("\n   > Total: " + String.format("%.2f",tf.get(i).get(3)));
            sb.append("\n\nNumero de clientes diferentes:");
            sb.append("\n   > Filial 1: " + cd.get(i).get(0));
            sb.append("\n   > Filial 2: " + cd.get(i).get(1));
            sb.append("\n   > Filial 3: " + cd.get(i).get(2));
            out.println(sb.toString());
        }
    }
    /**
     * Método que manda para o navegador os valores da querie 1 .
     * @param l ArrayList com codigos de produtos.
     * @param t tempo de execução.
     */
    public void print1(List<String> l, Double t) {
        navegarLista(l,t,20,"\nCodigos dos "+l.size()+" produtos nunca comprados");
    }

    /**
     * Método que printa os valores da querie 2 .
     * @param l ArrayList com codigos de produtos.
     * @param mes Mes.
     * @param modo Global ou Filial.
     * @param t Tempo de execução.
     */
    public void print2(List<Integer> l, int mes, String modo, Double t) {
        if (modo.equals("G")) {
            out.println("\nTempo: " + t);
            out.println("\nPara o mes " + mes + ", globalmente: ");
            out.println("> Numero de vendas realizadas: " + l.get(0));
            out.println("> Numero de clientes distintos que efetuaram compras: " + l.get(1));
        }
        else if (modo.equals("F")) {
            int j = 0;
            out.println("\nTempo: " + t);
            for(int i = 1; i < 4; i++) {
                out.println("\nPara o mes " + mes + ", na filial " + i + ": ");
                out.println("> Numero de vendas realizadas: " + l.get(j)); j++;
                out.println("> Numero de clientes distintos que efetuaram compras: " + l.get(j)); j++;
            }
        }
    }
    /**
     * Método que printa os valores da querie 3.
     * @param m HashMap com dados da querie 3.
     * @param cli Cliente.
     * @param t Tempo de execução.
     */
    public void print3(Map<Integer,List<Double>> m, String cli, Double t) {
        int i = 1;
        out.println("\nTempo: " + t);
        out.println("\nPara o cliente " + cli + ":");
        for(Map.Entry<Integer,List<Double>> ct : m.entrySet()) {
            out.println("\nMes " + i + ": ");
            out.println("> Numero de vendas realizadas: " + (ct.getValue().get(0)).intValue());
            out.println("> Numero de produtos distintos que comprou: " + (ct.getValue().get(1)).intValue()) ;
            out.println("> Quantia total gasta: " + String.format("%.2f",ct.getValue().get(2))) ;
            i++;
        }
    }
    /**
     * Método que printa os valores da querie 4.
     * @param m HashMap com dados da querie 4.
     * @param prod Cliente.
     * @param t Tempo de execução.
     */
    public void print4(Map<Integer,List<Double>> m, String prod, Double t) {
        int i = 1;
        out.println("\nTempo: " + t);
        out.println("\nPara o produto " + prod + ":");
        for(Map.Entry<Integer,List<Double>> ct : m.entrySet()) {
            out.println("\nMes " + i + ": ");
            out.println("> Numero de vendas realizadas: " + (ct.getValue().get(0)).intValue());
            out.println("> Numero de clientes distintos: " + (ct.getValue().get(1)).intValue()) ;
            out.println("> Total faturado: " + String.format("%.2f",ct.getValue().get(2)));
            i++;
        }
    }
    /**
     * Método que printa os valores da querie 5.
     * @param l ArrayList de codigos de produtos.
     * @param cli Cliente.
     * @param t Tempo de execução.
     */
    public void print5(List<Fil> l, String cli, Double t) {
        List<String> lista = new ArrayList<>();
        for(Fil f : l)
            lista.add("Produto: " + f.getProduto() + " - unidades: " + f.getUnidades());
        navegarLista(lista,t,20,"\nLista dos "+l.size()+" produtos que o cliente "+cli+" comprou");
    }
    /**
     * Método que printa os valores da querie 6.
     * @param m HashMap com dados da querie 6.
     * @param x nº de produtos mais vendidos.
     * @param t Tempo de execução.
     */
    public void print6(Map<String,List<Integer>> m, int x, Double t) {
        List<String> lista = new ArrayList<>();
        for(Map.Entry<String,List<Integer>> ct : m.entrySet()) {
            StringBuilder sb = new StringBuilder();
            sb.append("Produto " + ct.getKey() + ": ");
            sb.append(ct.getValue().get(0) + " unidades, ");
            sb.append(ct.getValue().get(1) + " clientes distintos");
            lista.add(sb.toString());
        }
        navegarLista(lista,t,20,"\nOs "+x+" produtos mais comprados, em quantidade");
    }
    /**
     * Método que printa os valores da querie 7.
     * @param m HashMap com dados da querie 7.
     * @param t Tempo de execução.
     */
    public void print7(Map<Integer,List<Fat>> m, Double t) {
        out.println("\nTempo: " + t);
        for(Map.Entry<Integer,List<Fat>> ct : m.entrySet()) {
            out.println("\nFilial " + ct.getKey() + ":");
            for(Fat f : ct.getValue())
                out.println("Cliente " + f.getCliente() + ": " + String.format("%.2f",f.getPreco()));
        }
    }
    /**
     * Método que printa os valores da querie 8.
     * @param l HashMap com dados da querie 8.
     * @param x nº de clientes pretendidos.
     * @param t Tempo de execução.
     */
    public void print8(List<Fil> l, int x, Double t) { 
        List<String> lista = new ArrayList<>();
        for(Fil f : l) {
            StringBuilder sb = new StringBuilder();
            sb.append("Cliente " + f.getProduto() + ": "); //na verdade aqui o getProduto vai ser um Cliente
            sb.append(f.getUnidades() + " produtos diferentes"); 
            lista.add(sb.toString());
        }
        navegarLista(lista,t,20,"\nOs "+x+" clientes que compraram mais produtos diferentes");
    }
    /**
     * Método que printa os valores da querie 9.
     * @param m HashMap com dados da querie 9.
     * @param cod Código de produto.
     * @param t Tempo de execução.
     */
    public void print9(Map<String,List<Double>> m, String cod, int x, Double t) { 
        List<String> lista = new ArrayList<>();
        for(Map.Entry<String,List<Double>> ct : m.entrySet()) {
            StringBuilder sb = new StringBuilder();
            sb.append("Cliente " + ct.getKey() + ": "); //na verdade aqui o getProduto vai ser um Cliente
            sb.append(ct.getValue().get(0).intValue() + " unidades, ");
            sb.append("total faturado: " + String.format("%.2f",ct.getValue().get(1)));
            lista.add(sb.toString());
        }
        navegarLista(lista,t,20,"\nOs "+x+" clientes que mais compraram o produto " + cod + ":");
    }
    /**
     * Método que printa os valores da querie 10.
     * @param l Estrutura de dados com dados da querie 10.
     * @param t Tempo de execução.
     */
    public void print10(List<Map<String,List<Double>>> l, Double t) {
        int mes = 1;
        while (mes != 0) {
            printCondicao(10);
            mes = Input.lerInt();
            List<String> lista = new ArrayList<>();
            if (mes > 0 && mes < 13) {
                for(Map.Entry<String,List<Double>> ct : l.get(mes-1).entrySet()) {
                    StringBuilder sb = new StringBuilder();
                    sb.append("Produto " + ct.getKey() + ":\n");
                    sb.append("     >Filial 1: " + String.format("%.2f",ct.getValue().get(0)) + "\n");
                    sb.append("     >Filial 2: " + String.format("%.2f",ct.getValue().get(1)) + "\n");
                    sb.append("     >Filial 3: " + String.format("%.2f",ct.getValue().get(2)));
                    lista.add(sb.toString());
                }
                navegarLista(lista,t,5,"\nMes "+mes);
            }            
        }
    }
    /**
     * Método responsável pelo navegador de Strings.
     * @param l Arraylist de Strings(codigos).
     * @param t Tempo de execução.
     * @param n nº de Strings de cada vez.
     * @param frase Titulo do navegador
     */
    public void navegarLista(List<String> l, Double t, int n, String frase) {
        int pos = 0;
        int pagina = 1;
        int num = l.size();
        Boolean end = false;

        while (!end){
            out.println("\nTempo: " + t);
            out.println(frase + " (Pagina " + pagina + "):");
            for (int i = pos; i < num && i < pos+n; i++)
                out.println(l.get(i));
            out.println("\n(s)Página seguinte   (w)Página anterior   (a)Primeira página   (d)Última Página   (q)Sair do navegador\n");
            out.print("Escolha uma opção: ");

            String s = Input.lerString();
            if (s.equals("s") && pos + n < num) pos += n;
            if (s.equals("w") && pos - n >= 0) pos -= n;
            if (s.equals("a")) pos = 0;
            if (s.equals("d") && num-n > 0 && num%n != 0) pos = num - num%n;
            if (s.equals("d") && num-n > 0 && num%n == 0) pos = num - n;
            if (s.equals("q")) end = true;
            pagina = pos/n + 1;
        }
    }
}