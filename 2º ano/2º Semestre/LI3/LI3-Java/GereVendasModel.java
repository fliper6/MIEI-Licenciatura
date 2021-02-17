import java.util.*;
import java.io.*;
import static java.lang.System.out;
import java.util.stream.Collectors;

/**
 * Classe responsável por gerar todos os dados
 */
public class GereVendasModel implements IGereVendasModel, Serializable{
    //Variaveis de Instancia
    private ICatProds catProds;
    private ICatClis catClis;
    private IFaturacao faturacao;
    private IFilial filial;
    private double tempo;
    private String fich;//nome ficheiro lido
    private int nrVI;//nr vendas invalidas
    private double fat;//fat total
    private int vZero;// vendas com valor 0.0
    private final int nrFil = 3;
    
    //Getters e Setters
    /**
     * Método que retorna variavel catClis.
     * @return Catalogo de clientes
     */
    public ICatClis getCatClis() {return this.catClis;}
    /**
     * Método que retorna variavel catProds.
     * @return Catalogo de produtos.
     */
    public ICatProds getCatProds() {return this.catProds;}
    /**
     * Método que retorna variavel faturacao.
     * @return Faturacao.
     */
    public IFaturacao getFaturacao() {return this.faturacao;}
    /**
     * Método que retorna variavel filial.
     * @return Filial.
     */
    public IFilial getFilial() {return  this.filial;}
    /**
     * Método que retorna variavel tempo.
     * @return tempo de execuçao.
     */
    public double getTempo() {return this.tempo;}
    /**
     * Método que retorna variavel fich.
     * @return nome do ficheiro de txt de vendas lido.
     */
    public String getFich() {return this.fich;}
    /**
     * Método que retorna variavel fat.
     * @return Faturaçao total.
     */
    public double getFat() {return this.fat;}

    /**
     * Método que inicia o model(as estruturas de dados).
     */
    public GereVendasModel() {
        this.catProds = new CatProds();
        this.catClis = new CatClis();
        this.filial = new Filial(nrFil);
        this.faturacao = new Faturacao();
    }

    // Leitura dos Produtos2
    /**
     * Método que lê o ficheiro de produtos e carrega no catalogo de produtos.
     */
    public void lerProds(String fichtxt) {
        BufferedReader inFile; String linha;
        try {
            inFile = new BufferedReader(new FileReader(fichtxt));
            while ((linha = inFile.readLine()) != null) {
                if(CatProds.validaProduto(linha)) this.catProds.insereProd(linha);  
            }
        }
        catch (IOException exc) {out.println(exc);}
    }
    
    // Leitura dos Clientes
    /**
     * Método que lê o ficheiro de clientes e carrega no catalogo de clientes.
     */
    public void lerClis(String fichtxt) {
        BufferedReader inFile; String linha;
        try {
            inFile = new BufferedReader(new FileReader(fichtxt));
            while ((linha = inFile.readLine()) != null) {
                if(CatClis.validaCliente(linha)) this.catClis.insereCli(linha);  
            }
        }
        catch (IOException exc) {out.println(exc);}
    }
    
    // Leitura das vendas
    /**
     * Método que lê o ficheiro de vendas e carrega/altera as estruturas.
     */
    public void lerVendas(String fichtxt) {
        int nrV, nrVV,vZero;
        nrV = nrVV=vZero = 0;
        double fat;
        fat = 0.0;

        IVenda vd;  // os métodos de validaçao não suportam IVenda - so suportam Venda porque sao metodos de classe
        BufferedReader inFile; String linha;
        try {
            inFile = new BufferedReader(new FileReader(fichtxt));
            while ((linha = inFile.readLine()) != null) {
                vd = Venda.linhaToVenda(linha);
                //Valida a venda e verifica se o produto e o cliente da venda existem nos respetivos catalogo 
                if(Venda.validaVenda(vd) && this.catProds.containsProd(vd.getCodProd()) && this.catClis.containsCli(vd.getCodCli())) {
                   //Muda a flag do produto da Venda
                   this.catProds.mudarFlag(vd.getCodProd(),1);
                   //Muda a flag do produto da Venda
                   this.catClis.mudarFlag(vd.getCodCli(),1);
                    
                   //Insere os dados necessarios na Filial
                   filial.insereVenda(vd);
                   //Insere os dados necessarios na Faturacao
                   faturacao.insereVenda(vd);
                   fat += vd.getPreco()*vd.getUnidades();
                   if(vd.getPreco()*vd.getUnidades() == 0){vZero++;}
                   nrVV++;
                }
                nrV++;
            }
            this.vZero = vZero;
            this.fat = fat;
            this.nrVI=nrV-nrVV;
        }
        catch (IOException exc) {out.println(exc);}
    }
    /**
     * Método que invoca a leituras de todos os ficheiros e total carregamento das estruturas de dados na execucçao do programa.
     */
    public void createData() {
        crono.start(); // ---> para verificar o tempo que demora
        //Leitura dos txt
        lerProds("Ficheiros/Produtos.txt");
        lerClis("Ficheiros/Clientes.txt");
        lerVendas("Ficheiros/Vendas_1M.txt");
        this.fich = "/Ficheiros/Vendas_1M.txt";
        this.tempo=crono.stop();
    }

    /**
     * Método que invoca a leituras de todos os ficheiros(que o user escolhe) e total carregamento das estruturas de dados .
     */
    public void lerTxt(String fich) {
        //Inicializar Variaveis de Instancia

        this.catProds = null;
        this.catClis = null;
        this.filial = null;
        this.faturacao = null;

        this.catProds = new CatProds();
        this.catClis = new CatClis();
        this.filial = new Filial(nrFil);
        this.faturacao = new Faturacao();

        StringBuilder sb =new StringBuilder();
        sb.append("Ficheiros/").append(fich);

        //Leitura do txt
        crono.start(); // ---> para verificar o tempo que demora
        lerProds("Ficheiros/Produtos.txt");
        lerClis("Ficheiros/Clientes.txt");
        lerVendas(sb.toString());
        this.fich = sb.toString();
        this.tempo= crono.stop();
    }
    
    /*Consultas Estatisticas*/
    //1.1
    /**
     * Método que devolve estrutura com dados estatisticos para as consultas.
     * @return ArrayList de valores estatisticos.
     */
    public List<Integer> getEstatisticas() {
        int pc,cc,pNC,cNC;
        pc = cc = pNC = cNC = 0;
        List<Integer> arr = new ArrayList<>();

        arr.add(this.nrVI);

        for(Map.Entry<String,Integer> m : catProds.getMProds().entrySet())
            if(m.getValue() == 0) pNC++;

        pc = this.getCatProds().getValidos();
        arr.add(pc);
        arr.add(pc-pNC);
        arr.add(pNC);

        for(Map.Entry<String,Integer> m : catClis.getMClis().entrySet())
            if(m.getValue() == 0) cNC++;
        cc = this.getCatClis().getValidos();
        arr.add(cc);
        arr.add(cc-cNC);
        arr.add(cNC);

        arr.add(this.vZero);

        return arr;
    }


    //1.2
    /**
     * Método que devolve nº total de compras por mes
     * @return ArrayList de compras por mes.
     */
    public List<Integer> TotalComprasM() {
        return this.faturacao.getTotalComprasMes();
    }

    public List<List<Double>> fatTotalMesFilial() {
        List<List<Double>> lista = new ArrayList<>();
        for (Map<String,Set<Fat>> m : this.faturacao.getFats()) {
            List<Double> mapa = new ArrayList<>();
            mapa.add(0.0);
            mapa.add(0.0);
            mapa.add(0.0);
            for (Map.Entry<String,Set<Fat>> ct : m.entrySet()) {
                for (Fat f : ct.getValue()){
                    mapa.set(f.getFilial() - 1, mapa.get(f.getFilial() - 1) + f.getPreco() * f.getUnidades());
                }
            }
            mapa.add(mapa.get(0)+mapa.get(1)+mapa.get(2));
            lista.add(mapa);
        }
        return lista;
    }
    /**
     * Método que devolve nº de clientes distintos por mes e filial.
     * @return ArrayList de clientes distintos por mes e filial.
     */
    public List<List<Integer>> clientesDifMesFilial() {
        List<List<Integer>> lista = new ArrayList<>();
        for (Map<String,Set<Fat>> m : this.faturacao.getFats()) {
            List<Integer> mapa = new ArrayList<>();
            Map<String,List<Integer>> clis = new HashMap<>();
            mapa.add(0);
            mapa.add(0);
            mapa.add(0);
            for (Map.Entry<String,Set<Fat>> ct : m.entrySet()) {
                for (Fat f : ct.getValue()){
                    if(clis.containsKey(f.getCliente()) == false){
                        List<Integer> arr = new ArrayList<>();
                        arr.add(f.getFilial());
                        clis.put(f.getCliente(),arr);
                        mapa.set(f.getFilial() - 1, mapa.get(f.getFilial() - 1) + 1);
                    }
                    else if(clis.get(f.getCliente()).contains(f.getFilial()) == false){
                        List<Integer> arr = clis.get(f.getCliente());
                        arr.add(f.getFilial());
                        clis.replace(f.getCliente(),arr);
                        mapa.set(f.getFilial() - 1, mapa.get(f.getFilial() - 1) + 1);
                    }
                }
            }
            lista.add(mapa);
        }
        return lista;
    }


    /*Consultas Interativas*/
    /*1 - Lista ordenada alfabeticamente com os códigos dos produtos nunca comprados e o seu respectivo total*/
    /**
     * Método que executa querie 1.
     * @return ArrayList de codigos.
     */
    public List<String> query1() {
        List<String> l = new ArrayList<>();
        for(Map.Entry<String,Integer> m : catProds.getMProds().entrySet())
            if(m.getValue() == 0) l.add(m.getKey());
        l = l.stream().sorted().collect(Collectors.toList());
        return l; //o total vai ser o tamanho de l
    }

    /*2 - Dado um mês válido, determinar o número total global de vendas realizadas e o número total de clientes distintos que as fizeram; Fazer o mesmo mas para cada uma das filiais;*/
    /**
     * Método que executa querie 2.
     * @param mes Mes.
     * @param modo Global ou filial.
     * @return ArrayList nr de vendas.
     */
    public List<Integer> query2(int mes,String modo) {
        Set<String> C0 = new TreeSet<>(); //nao vai adicionar codCli se ja existir
        Set<String> C11 = new TreeSet<>();
        Set<String> C12 = new TreeSet<>();
        Set<String> C13 = new TreeSet<>();
        int nrV0, nrV11, nrV12, nrV13;
        nrV0 = nrV11 = nrV12 = nrV13 = 0;
        List<Integer> l2 = new ArrayList<>();
        if(modo.equals("G")) { //Global
            for(Set<Fat> sf : this.faturacao.getFats().get(mes-1).values())
                for(Fat f: sf) {
                    nrV0++; C0.add(f.getCliente());
                }
            l2.add(nrV0); l2.add(C0.size());
        } else if(modo.equals("F")) { //Por Filial
            for(Set<Fat> sf : this.faturacao.getFats().get(mes-1).values())
                for(Fat f: sf) {
                    if(f.getFilial()==1) {nrV11++; C11.add(f.getCliente()); }
                    if(f.getFilial()==2) {nrV12++; C12.add(f.getCliente()); }
                    if(f.getFilial()==3) {nrV13++; C13.add(f.getCliente()); }
                }
            l2.add(nrV11); l2.add(C11.size());
            l2.add(nrV12); l2.add(C12.size());
            l2.add(nrV13); l2.add(C13.size());
        }
        return l2;
    }

    /*3 - Dado um código de cliente, determinar, para cada mês, quantas compras fez, quantos produtos distintos comprou e quanto gastou no total. ;*/
    /**
     * Método que executa querie 3.
     * @param cod Codigo.
     * @return HashMap com dados da q3.
     */
    public Map<Integer,List<Double>> query3(String cod) {
        Map<Integer,List<Double>> dadosCli = new HashMap<>();
        List<Double> auxMes = new ArrayList<>();
        String s = ""; int mes = 0;
        for(int i = 0; i < 3; i++)  auxMes.add(0.0); //0 - numero de compra | 1 - numero de produtos distintos | 2 - preco total
        for(int i = 0; i < 12; i++) dadosCli.put(i,auxMes);
        for(Map<String,Set<Fil>> m : this.filial.getFils()) {
            if(m.containsKey(cod)) {
                for(Fil f : m.get(cod)) {
                    List<Double> aux = new ArrayList<>();
                    for(Double d : dadosCli.get(f.getMes()-1)) aux.add(d);
                    Double nc = aux.get(0) + f.getUnidades(); aux.set(0,nc);
                    if(!s.equals(f.getProduto()) || !(mes == f.getMes())) { // os Set<Fil> estao organizados pelo codigo do Produto logo para ver se ha repetidos e so preciso verificar com o anterior
                        Double np = aux.get(1) + 1.0; aux.set(1,np);
                    }
                    s = f.getProduto(); mes = f.getMes();
                    Double pt = aux.get(2) + (f.getPreco()*f.getUnidades()); aux.set(2,pt);
                    dadosCli.put(f.getMes()-1,aux);
                }
            }
        }
        return dadosCli;
    }

    /*4. Dado o código de um produto existente, determinar, mês a mês, quantas vezes foi comprado, por quantos clientes diferentes e o total facturado;*/
    /**
     * Método que executa querie 4.
     * @param cod Codigo.
     * @return HashMap com dados da q4.
     */
    public Map<Integer,List<Double>> query4(String cod) {
        Map<Integer,List<Double>> dadosProd = new HashMap<>() ;
        List<Double> auxMes = new ArrayList<>();
        String s = ""; int mes = 0;
        for(int i = 0; i < 3; i++)  auxMes.add(0.0); //0 - quantidades de vezes que foi comprado | 1 - numero de produtos distintos | 2 - preco total
        for(int i = 0; i < 12; i++) dadosProd.put(i,auxMes);
        for(Map<String,Set<Fat>> m : faturacao.getFats()) {
            List<Double> aux = new ArrayList<>();
            for(int i = 0; i < 3; i++) aux.add(0.0);
            s = "";
            if(m.containsKey(cod)) {
                for(Fat f :  m.get(cod)) {
                    Double nc = aux.get(0) + f.getUnidades(); aux.set(0,nc);
                    if(!s.equals(f.getCliente())) {
                        Double np = aux.get(1) + 1.0; aux.set(1,np);
                    }
                    s = f.getCliente();
                    Double pt = aux.get(2) + f.getPreco()*f.getUnidades(); aux.set(2,pt);
                }
            }
            dadosProd.put(mes,aux);
            mes++;
        }
        return dadosProd;
    }

    /*5. Dado o código de um cliente determinar a lista de códigos de produtos que mais comprou (e quantos), ordenada por ordem decrescente de quantidade e, para quantidades iguais, por ordem alfabética dos códigos; */
    /**
     * Método que executa querie 5.
     * @param cod Codigo.
     * @return Arraylist de filiais.
     */
    public List<Fil> query5(String cod) {
        List<Fil> list = new ArrayList<>();
        Map<String,Integer> map = new HashMap<>();
        for(Map<String,Set<Fil>> m : this.filial.getFils())
            if(m.containsKey(cod))
                for(Fil f : m.get(cod)) {
                    if(map.containsKey(f.getProduto())) map.put(f.getProduto(), map.get(f.getProduto()) + f.getUnidades());
                    else map.put(f.getProduto(),f.getUnidades());
                }
        for(Map.Entry<String,Integer> ct : map.entrySet()) {
            Fil fil = new Fil(ct.getKey(),0.0,ct.getValue(),"N",0);
            list.add(fil);
        }
        list.sort(new CompFils());
        return list;
    }

    /*6. Determinar o conjunto dos X produtos mais vendidos em todo o ano (em número de unidades vendidas) indicando o número total de distintos clientes que o compraram (X é um inteiro dado pelo utilizador); */
    public Map<String,List<Integer>> query6(int x) {
        List<Fil> list = new ArrayList<>();
        Map<String,Integer> map = new HashMap<>();
        Map<String,Set<String>> clis = new HashMap<>();
        Map<String,List<Integer>> ret = new LinkedHashMap<>(); //Linked para preservar a ordem de inserçao
        //Cria um Map com os produtos e as respetivas unidades compradas
        for(Map<String,Set<Fat>> m : this.faturacao.getFats())
            for (Map.Entry<String,Set<Fat>> ct : m.entrySet())
                for(Fat f : ct.getValue()) {
                    if(map.containsKey(ct.getKey())) map.put(ct.getKey(), map.get(ct.getKey()) + f.getUnidades());
                    else map.put(ct.getKey(),f.getUnidades());
                    if (clis.containsKey(ct.getKey())) clis.get(ct.getKey()).add(f.getCliente());
                    else {
                        Set<String> s = new HashSet<>();
                        s.add(f.getCliente());
                        clis.put(ct.getKey(),s);
                    }
                }
        //Passa de um Map para uma List para podermos dar sort e limit
        for(Map.Entry<String,Integer> ct : map.entrySet())
            list.add(new Fil(ct.getKey(),0.0,ct.getValue(),"N",0));
        list = list.stream().sorted(new CompFils()).limit(x).collect(Collectors.toList());
        //Numero de clientes distintos
        for(Fil fi : list) {
            List<Integer> nums = new ArrayList<>();
            nums.add(fi.getUnidades()); nums.add(clis.get(fi.getProduto()).size());
            ret.put(fi.getProduto(),nums);
        }
        return ret;
    }

    /*7. Determinar, para cada filial, a lista dos três maiores compradores em termos de dinheiro facturado; */
    public Map<Integer,List<Fat>> query7() {
        Map<Integer,List<Fat>> mf = new HashMap<>();
        int i = 1;
        for(Map<String,Set<Fil>> m : this.filial.getFils()) {
            List<Fat> comp = new ArrayList();
            for(Map.Entry<String,Set<Fil>> ct : m.entrySet()) {
                Fat fat = new Fat();
                fat.setCliente(ct.getKey());
                for(Fil fi : ct.getValue())
                    fat.setPreco(fat.getPreco() + (fi.getPreco() * fi.getUnidades())); //na verdade, aqui o preco = preco * unidades
                comp.add(fat);
            }
            comp.sort(new CompFats());
            List<Fat> comp2 = new ArrayList();
            comp2 = comp.stream().limit(3).collect(Collectors.toList());
            mf.put(i,comp2);
            i++;
        }
        return mf;
    }

    /*8. Determinar os códigos dos X clientes (sendo X dado pelo utilizador) que compraram mais produtos diferentes (não interessa a quantidade nem o valor), indicando quantos, sendo o critério de ordenação a ordem decrescente do número deprodutos;*/
    public List<Fil> query8(int x) {
        Map<String,Set<String>> mC = new HashMap<>();
        List<Fil> lC = new ArrayList<>();
        for(Map<String,Set<Fil>> m : this.filial.getFils()) {
            for(Map.Entry<String,Set<Fil>> ct : m.entrySet()) {
                for(Fil fi : ct.getValue()) {
                    if(mC.containsKey(ct.getKey())) mC.get(ct.getKey()).add(fi.getProduto());
                    else {
                        Set<String> sC = new TreeSet<>();
                        sC.add(fi.getProduto());
                        mC.put(ct.getKey(),sC);
                    }
                }
            }
        }
        for(Map.Entry<String,Set<String>> cC : mC.entrySet())
            lC.add(new Fil(cC.getKey(),0,cC.getValue().size(),"",0));
        lC = lC.stream().sorted(new CompFils()).limit(x).collect(Collectors.toList());
        return lC;
    }

    /*9. Dado o código de um produto que deve existir, determinar o conjunto dos X clientes que mais o compraram e, para cada um, qual o valor gasto (ordenação cf. 5);*/
    public Map<String,List<Double>> query9(String cod, int x) {
        Map<String,List<Double>> res = new LinkedHashMap<>();
        Map<String,List<Double>> map = new HashMap<>();//key: Cliente | values: 0 - Unidades | 1 - Valor Gasto
        List<Fil> lista = new ArrayList<>();
        for(Map<String,Set<Fat>> m : this.faturacao.getFats()) {
            if(m.containsKey(cod)) {
                for(Fat fa : m.get(cod)) {
                    if(!map.containsKey(fa.getCliente())) {
                        List<Double> l = new ArrayList<>();
                        l.add(0.0 + fa.getUnidades()); l.add(fa.getUnidades() * fa.getPreco());
                        map.put(fa.getCliente(),l);
                    } else {
                        List<Double> l = map.get(fa.getCliente());
                        l.set(0,l.get(0) + fa.getUnidades()); l.set(1,l.get(1) + (fa.getUnidades() * fa.getPreco()));
                        map.put(fa.getCliente(),l);
                    }
                }
            }
        }
        for(Map.Entry<String,List<Double>> entry : map.entrySet())
            lista.add(new Fil(entry.getKey(),0,entry.getValue().get(0).intValue(),"",0));
        lista = lista.stream().sorted(new CompFils()).limit(x).collect(Collectors.toList());
        for(Fil f : lista)
            res.put(f.getProduto(),map.get(f.getProduto()));
        return res;
    }

    /*10*/
    public List<Map<String,List<Double>>> query10() {
        List<Map<String,List<Double>>> lista = new ArrayList<>();
        for (Map<String,Set<Fat>> m : this.faturacao.getFats()) {
            Map<String,List<Double>> mapa = new HashMap<>();
            for (Map.Entry<String,Set<Fat>> ct : m.entrySet()) {
                List<Double> l = new ArrayList<>();
                l.add(0.0); l.add(0.0); l.add(0.0);
                for (Fat f : ct.getValue())
                    l.set(f.getFilial()-1, l.get(f.getFilial()-1) + f.getPreco() * f.getUnidades());
                mapa.put(ct.getKey(),l);
            }
            lista.add(mapa);
        }
        return lista;
    }
}