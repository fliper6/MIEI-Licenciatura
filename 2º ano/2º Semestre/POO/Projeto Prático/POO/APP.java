import jdk.swing.interop.SwingInterOpUtils;
import java.io.*;
import java.sql.SQLOutput;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;


public class APP implements Serializable {
    private static Logs logs;
    private static Menu menuPrincipal;
    private static Menu menuCliProp;
    private static Menu menuProprietario;
    private static Menu menuCliente;
    private static Menu menuAbastecimento;
    private static Menu menuPedidos;
    private static Menu menuAluguer;


    public static void guardaInfo() throws IOException {
        ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("Info.dat"));
        oos.writeObject(logs);
        oos.flush();
        oos.close();
    }

    public static void carregarInfo() throws IOException, ClassNotFoundException {
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream("Info.dat"));
        logs = (Logs) ois.readObject();
        ois.close();
    }

    public static void gravarInfo() {
        try {
            guardaInfo();
        } catch (IOException e) {
            System.out.println("Estado não guardado");
        }
    }

    public static void menuOpcoes() {
        String[] opcoes = {"Iniciar Sessão", "Registar", "Total faturado por determinado veiculo, entre datas", "Listagem dos 10 clientes que mais utilizam a APP por nº de alugueres","Listagem dos 10 clientes que mais utilizam a APP por nº de km's percorridos"};
        menuPrincipal = new Menu(opcoes);
        String[] opcoes1 = {"Cliente", "Proprietários"};
        menuCliProp = new Menu(opcoes1);
        String[] opcoes2 = {"Inserir Viatura", "Abastecimento", "Alterar Preço por km de uma viatura", "Alugueres Efetuados", "Pedidos de Aluguer"};
        menuProprietario = new Menu(opcoes2);
        String[] opcoes3 = {"Abastecer todos os veiculos", "Abastecer apenas um veiculo"};
        menuAbastecimento = new Menu(opcoes3);
        String[] opcoes4 = {"Alugar Carro", "Alugueres Efetuados"};
        menuCliente = new Menu(opcoes4);
        String[] opcoes5 = {"Aceitar Pedido", "Rejeitar Pedido"};
        menuPedidos = new Menu(opcoes5);
        String[] opcoes6 = {"Veiculo mais barato", "Veiculo mais perto", "Mais barato a x km", "Veiculo Especifico"};
        menuAluguer = new Menu(opcoes6);


    }

    public static void menuPrincipal() {
        do {
            menuPrincipal.executa("Principal");
            switch (menuPrincipal.getOpcao()) {
                case 1:
                    menuLogin();
                    break;
                case 2:
                    menuRegistar();
                    break;
                case 3:
                    menuTotalFaturado();
                    break;
                case 4:
                    System.out.println("\n--------Clientes que utilizam mais a APP(em nº de alugueres)--------\n");
                    System.out.println(logs.clientesVezestoString());
                    break;
                case 5:
                    System.out.println("\n--------Clientes que utilizam mais a APP(em nº de Km's percorridos):--------\n");
                    System.out.println(logs.clientesKmstoString());
                    break;
                case 0:
                    gravarInfo();
                    break;
            }
        } while (menuPrincipal.getOpcao() != 0);
        System.out.println("End");
    }

    public static void menuLogin() {
        do {
            menuCliProp.executa("Iniciar Sessão");
            switch (menuCliProp.getOpcao()) {
                case 1:
                    loginCliente();
                    break;
                case 2:
                    loginProprietario();
                    break;
                case 0:
                    gravarInfo();
                    break;
            }
        } while (menuCliProp.getOpcao() != 0);

    }

    public static void menuRegistar() {
        do {
            menuCliProp.executa("Registar");
            switch (menuCliProp.getOpcao()) {
                case 1:
                    registarCliente();
                    break;
                case 2:
                    registarProprietario();
                    break;
                case 0:
                    gravarInfo();
                    break;
            }
        } while (menuCliProp.getOpcao() != 0);

    }


    public static void loginCliente() {
        String inp, nif;
        Scanner is = new Scanner(System.in);
        int r = 0;
        do {
            System.out.println("---Login Cliente---\n");
            System.out.print("Insere NIF: ");
            nif = is.nextLine();
            if (logs.getClientes().containsKey(nif) == false) {
                System.out.println("Cliente não existe!");
            } else {
                do {
                    System.out.print("\nInsere Password: ");
                    inp = is.nextLine();
                    if (inp.equals("q")) {
                        break;
                    }
                    ;
                    if (logs.getClientes().get(nif).getPassword().equals(inp) == false) {
                        System.out.println("Password Errada!");
                    } else {
                        System.out.println("Login Correto!");
                    }

                } while (logs.getClientes().get(nif).getPassword().equals(inp) == false);

                do {
                    menuCliente.executa("Cliente");
                    switch (menuCliente.getOpcao()) {
                        case 1:
                            menuAluguer(nif);
                            break;
                        case 2:
                            menuListaAlugueres(nif, 2);
                            break;
                        case 0:
                            gravarInfo();
                            break;
                    }
                } while (menuCliente.getOpcao() != 0);
            }
            r = 1;
        } while (r == 0);

    }

    public static void loginProprietario() {
        String inp, nif;
        Scanner is = new Scanner(System.in);
        int r = 0;
        do {
            System.out.println("---Login Proprietário---\n");
            System.out.print("Insere NIF: ");
            nif = is.nextLine();
            if (logs.getProprietarios().containsKey(nif) == false) {
                System.out.println("Proprietário não existe!");
            } else {
                do {
                    System.out.print("\nInsere Password: ");
                    inp = is.nextLine();
                    if (inp.equals("q")) {
                        break;
                    }
                    ;

                    if (logs.getProprietarios().get(nif).getPassword().equals(inp) == false) {
                        System.out.println("Password Errada!");
                    } else {
                        System.out.println("Login Correto!");
                    }

                } while (logs.getProprietarios().get(nif).getPassword().equals(inp) == false);

                do {
                    menuProprietario.executa("Proprietario");
                    switch (menuProprietario.getOpcao()) {
                        case 1:
                            menuInsereViatura(nif);
                            break;
                        case 2:
                            menuAbastecimento(nif);
                            break;
                        case 3:
                            menuAlteraPreco();
                            break;
                        case 4:
                            menuListaAlugueres(nif, 1);
                            break;
                        case 5:
                            menuPedidos(nif);
                            break;
                        case 0:
                            gravarInfo();
                            break;
                    }
                } while (menuProprietario.getOpcao() != 0);

            }
            r = 1;
        } while (r == 0);
    }


    public static void registarCliente() {
        String email, nif, nome, password, morada;
        double x, y;
        Ponto ponto;
        Cliente cli = new Cliente();
        Scanner is = new Scanner(System.in);
        int r = 0;
        do {
            System.out.println("---Registar Cliente---\n");
            System.out.print("Insere NIF: ");
            nif = is.nextLine();
            if (logs.getClientes().containsKey(nif)) {
                System.out.println("\nCliente já existe!");
            } else {

                System.out.println("NIF válido!");
                System.out.print("\nInsere Nome: ");
                nome = is.nextLine();
                if (nif.equals("q")) {
                    break;
                }
                System.out.print("Insere Password: ");
                password = is.nextLine();
                System.out.print("Insere email: ");
                email = is.nextLine();
                System.out.print("Insere morada: ");
                morada = is.nextLine();
                System.out.print("Insere coordenada X: ");
                try {
                    x = Double.parseDouble(is.nextLine());
                } catch (NumberFormatException | NullPointerException e) {
                    System.out.println("\nValor invalido");
                    break;
                }
                System.out.print("Insere coordenada Y: ");
                try {
                    y = Double.parseDouble(is.nextLine());
                } catch (NumberFormatException | NullPointerException e) {
                    System.out.println("\nValor invalido!");
                    break;
                }
                ponto = new Ponto(x, y);
                cli.setNome(nome);
                cli.setPassword(password);
                cli.setNIF(nif);
                cli.setEstadoAlug(0);
                cli.setEmail(email);
                cli.setMorada(morada);
                cli.setPosicao(ponto);
                logs.addCliente(nif, cli);

                System.out.println("\nCliente Registado!");
                //}
            }
            r = 1;
        } while (r == 0);
    }

    public static void registarProprietario() {
        String email, nif, nome, password, morada, nascimento;
        Proprietario prop = new Proprietario();
        Scanner is = new Scanner(System.in);
        int r = 0;
        do {
            System.out.println("---Registar Proprietário---\n");
            System.out.print("Insere NIF: ");
            nif = is.nextLine();
            if (logs.getProprietarios().containsKey(nif) == true) {
                System.out.println("Proprietário já existe!");
            } else {
                // while(is.nextLine().equals("q")==false) {
                System.out.println("NIF válido!");
                System.out.print("\nInsere Nome: ");
                nome = is.nextLine();
                if (nif.equals("q")) {
                    break;
                }
                System.out.print("Insere Password: ");
                password = is.nextLine();
                System.out.print("Insere email: ");
                email = is.nextLine();
                System.out.print("Insere morada: ");
                morada = is.nextLine();

                prop.setNome(nome);
                prop.setPassword(password);
                prop.setNIF(nif);
                prop.setEmail(email);
                prop.setMorada(morada);
                logs.addProprietario(nif, prop);

                System.out.println("\nProprietário Registado!");
                //}
            }
            r = 1;
        } while (r == 0);
    }

    public static void menuTotalFaturado() {
        String inicio, fim, mat;
        LocalDate localdateI, localdateF;
        double fat;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        Scanner is = new Scanner(System.in);
        int r = 0;
        do {
            System.out.println("\n---------Total faturado---------\n");
            System.out.print("Insere Matricula: (Formato XX-XX-XX) ");
            mat = is.nextLine();
            if (logs.getVeiculos().containsKey(mat) == false) {
                System.out.println("Veiculo não existe!");
                if (mat.equals("q")) {
                    break;
                }
            } else {
                System.out.println("Matricula válida!\n");
                System.out.print("Insere Data inicial: (Formato DD-MM-YYYY , q para sair) ");
                inicio = is.nextLine();
                if (inicio.equals("q")) {
                    break;
                }
                if (validarData(inicio)) {
                    localdateI = LocalDate.parse(inicio, formatter);
                    System.out.print("Insere Data final: (Formato DD-MM-YYYY , q para sair) ");
                    fim = is.nextLine();
                    if (fim.equals("q")) {
                        break;
                    }
                    if (validarData(fim)) {
                        localdateF = LocalDate.parse(fim, formatter);
                        fat = logs.totalFaturado(mat, localdateI, localdateF);
                        System.out.println("\nTotal faturado:" + fat);
                        r = 1;
                    } else {
                        System.out.println("Data invalida!");
                    }
                } else {
                    System.out.println("Data invalida!");
                }
            }
        } while (r == 0);
    }


    //menus do prop

    public static void menuInsereViatura(String prop) {
        String tipo, mat, marca;
        int autonomia;
        double x, y, vel, preco, consumo;
        Ponto posicao;
        Scanner is = new Scanner(System.in);
        Veiculo veic;
        int r = 0;
        do {
            System.out.println("---Insere Viatura---\n");
            System.out.print("Insere Matricula: (Formato XX-XX-XX, q para sair) ");
            mat = is.nextLine();
            if (mat.equals("q")) break;
            if (logs.getVeiculos().containsKey(mat) == true) {
                System.out.println("Veiculo já existe!");
                if (mat.equals("q")) {
                    break;
                }
            } else {
                System.out.println("Matricula válida!");
                do {
                    System.out.println("\nInsere Tipo do Carro: Eletrico, Hibrido ou Gasolina (Escreva exatamente um dos nomes anteriores)");
                    tipo = is.nextLine();
                    if (tipo.equals("q")) break;
                } while (!tipo.equals("Eletrico") && !tipo.equals("Hibrido") && !tipo.equals("Gasolina"));
                System.out.print("\nInsere Marca: ");
                marca = is.nextLine();
                System.out.print("Insere Velocidade Média: ");
                vel = parseDouble(is.nextLine());
                System.out.print("Insere Preço: ");
                preco = parseDouble(is.nextLine());
                System.out.print("Insere Consumo: ");
                consumo = parseDouble(is.nextLine());
                System.out.print("Insere Autonomia: ");
                autonomia = parseInt(is.nextLine());
                System.out.print("Insere coordenada X do veiculo: ");
                x = parseDouble(is.nextLine());
                System.out.print("Insere coordenada Y do veiculo: ");
                y = parseDouble(is.nextLine());

                if (tipo.equals("Gasolina")) {
                    veic = new Gasolina();
                } else if (tipo.equals("Hibrido")) {
                    veic = new Hibrido();
                } else {
                    veic = new Eletrico();
                }

                posicao = new Ponto(x, y);

                veic.setMarca(marca);
                veic.setMatricula(mat);
                veic.setProp(prop);
                veic.setVelocidade(vel);
                veic.setPreco(preco);
                veic.setConsumo(consumo);
                veic.setAutonomia(autonomia);
                veic.setAutonomiaMax(autonomia);
                veic.setPosicao(posicao);

                logs.addCarroListaProp(prop, veic);
                logs.addVeiculo(mat, veic);

                System.out.println("\nVeiculo adicionado!");
            }
            r = 1;
        } while (r == 0);
    }

    public static void menuAlteraPreco() {
        String mat;
        double preco;
        Scanner is = new Scanner(System.in);
        int r = 0;
        do {
            System.out.println("---Altera Preço em Veiculo---\n");
            System.out.print("Insere Matricula: (Formato XX-XX-XX, q para sair) ");
            mat = is.nextLine();
            if (mat.equals("q")) break;
            if (!logs.getVeiculos().containsKey(mat)) {
                System.out.println("Veiculo não existe!");
            } else {
                System.out.println("Matricula válida!");
                System.out.print("\nInsere Preço: ");
                preco = parseDouble(is.nextLine());
                logs.mudarPreco(mat, preco);
                r = 1;
            }
        } while (r == 0);
    }

    public static boolean validarData(String data) {
        try {
            DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
            df.setLenient(false);
            df.parse(data);
            return true;
        } catch (ParseException e) {
            return false;
        }
    }

    public static void menuListaAlugueres(String prop, int x) {
        String inicio, fim;
        LocalDate localdateI, localdateF;
        List<Aluguer> lista;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        Scanner is = new Scanner(System.in);
        int r = 0;
        do {
            System.out.println("---Listagem dos Algueres(entre datas)---\n");
            System.out.print("Insere Data inicial: (Formato DD-MM-YYYY) ");
            inicio = is.nextLine();
            if (inicio.equals("q")) {
                break;
            }
            if (validarData(inicio)) {
                localdateI = LocalDate.parse(inicio, formatter);
                System.out.print("Insere Data final: (Formato DD-MM-YYYY) ");
                fim = is.nextLine();
                if (fim.equals("q")) {
                    break;
                }
                if (validarData(fim)) {
                    localdateF = LocalDate.parse(fim, formatter);
                    lista = logs.alugueresLista(prop, localdateI, localdateF, x);
                    System.out.println(lista.toString());
                } else {
                    System.out.println("Data invalida!");
                }
            } else {
                System.out.println("Data invalida!");
            }
            r = 1;
        } while (r == 0);
    }

    public static void menuAbastecimento(String prop) {
        List<Veiculo> lista;
        int val;
        lista = logs.carrosAbastecimento(prop);
        Scanner is = new Scanner(System.in);
        String mat;
        if (lista.size() == 0) {
            System.out.println("Não há veiculos que necessitem de abastecimento");
        } else {
            do {
                lista = logs.carrosAbastecimento(prop);
                System.out.println("\nVeiculos que necessitam de abastecimento(autonomia<10%):");
                System.out.print(lista);
                menuAbastecimento.executa("Abastecimento");
                switch (menuAbastecimento.getOpcao()) {
                    case 1:
                        logs.abastecerTodos(prop, lista);
                        System.out.println("Carros abastecidos!");
                        break;
                    case 2:
                        do{
                        val = 0;
                        System.out.println("Insere Matricula(q para sair)");
                        mat = is.nextLine();
                        if (mat.equals("q")) break;
                            for (Veiculo v : lista) {
                                if (v.getMatricula().equals(mat)) val = 1;
                            }

                        }while(val==0);
                            logs.abastecerUm(prop, lista, mat);
                            System.out.println("\nCarro abastecido!");
                            break;
                    case 0:
                        gravarInfo();
                        break;
                }
            } while (menuAbastecimento.getOpcao() != 0);
        }
    }

    //menus de gestao de pedidos do prop
    public static void menuPedidos(String prop) {
        ArrayList<Aluguer> lista;
        lista = logs.getProprietarios().get(prop).getQueue();
        if (lista.size() == 0) {
            System.out.println("Não há Pedidos de aluguer");
        } else {
            do {
                System.out.println("\nPedidos de Aluguer pendentes:");
                for (int i = 0; i < lista.size(); i++) {
                    System.out.print(i + 1);
                    System.out.print(" - ");
                    System.out.println(lista.get(i));
                }


                menuPedidos.executa("Pedidos de Aluguer");
                switch (menuPedidos.getOpcao()) {
                    case 1:
                        menuAceitarPedido(prop, lista);
                        break;
                    case 2:
                        menuRejeitarPedido(prop, lista);
                        break;
                    case 0:
                        gravarInfo();
                        break;
                }
            } while (menuPedidos.getOpcao() != 0);
        }
    }

    public static void menuAceitarPedido(String prop, ArrayList<Aluguer> lista) {
        int mat, rating;
        Scanner is = new Scanner(System.in);
        int r = 0;
        do {
            System.out.print("Insere ID do aluguer que deseja aceitar(-1 para sair):");
            mat = is.nextInt();
            if (mat == -1) break;
            if (mat < 1 || mat > lista.size()) {
                System.out.println("Aluguer não existe!");
            } else {
                System.out.println("Aluguer aceite!");
                System.out.println("Rating do Cliente(0 a 100)");
                rating = is.nextInt();

                Aluguer alug = lista.get(mat - 1);
                logs.setEstadoAlug(alug.getID(), 2);
                logs.addHistoricoCli(prop, alug, rating);
                logs.addHistoricoVeic(alug);
                lista.remove(mat - 1);
                logs.addHistoricoProp(prop, alug, lista);
                r = 1;
            }
        } while (r == 0);
    }

    public static void menuRejeitarPedido(String prop, ArrayList<Aluguer> lista) {
        int mat;
        Scanner is = new Scanner(System.in);
        int r = 0;
        do {
            System.out.print("Insere ID do aluguer que deseja rejeitar(-1 para sair):");
            mat = is.nextInt();
            if (mat == -1) break;
            if (mat < 1 || mat > lista.size()) {
                System.out.println("Aluguer não existe!");
            } else {
                System.out.println("\nAluguer rejeitado!\n");

                Aluguer alug = lista.get(mat - 1);
                logs.setEstadoAlug(alug.getID(), 3);
                lista.remove(mat - 1);
                logs.atualizaQueue(prop, lista);
                r = 1;
            }
        } while (r == 0);
    }


    public static Double parseDouble(String linha) {
        double doub;
        try {
            doub = Double.parseDouble(linha);
        } catch (NumberFormatException | NullPointerException e) {
            return null;
        }
        return doub;
    }

    public static Integer parseInt(String linha) {
        int x;
        try {
            x = Integer.parseInt(linha);
        } catch (NumberFormatException | NullPointerException e) {
            return null;
        }

        return x;
    }

    //menus de algueres

    public static void menuAluguer(String cli) {
        List<Aluguer> arr = logs.getClientes().get(cli).getAluguer();
        Scanner is = new Scanner(System.in);
        int ratv, ratp;
        if (logs.getClientes().get(cli).getEstadoAlug() == 3) {
            System.out.println("\nAluguer foi rejeitado!");
            logs.setEstadoAlug(cli, 0);
        }
        if (logs.getClientes().get(cli).getEstadoAlug() == 1) System.out.println("\nTem um aluguer pendente!");
        else if (logs.getClientes().get(cli).getEstadoAlug() == 2) {
            Aluguer alug = arr.get(arr.size() - 1);
            logs.alteraPosCli(cli, alug.getFim());
            logs.alteraAutonomiaVeic(alug.getMatricula(), alug.getInicio().distancia((alug.getFim())));
            logs.alteraPosVeic(alug.getMatricula(), alug.getFim());

            System.out.println("Aluguer aceite!");
            System.out.println("Rating do Carro(0 a 100):");
            ratv = is.nextInt();
            System.out.println("Rating do Proprietario(0 a 100):");
            ratp = is.nextInt();
            logs.addRatingProp(alug.getID(), ratp);
            logs.addRatingVeic(alug.getMatricula(), ratv);
            logs.alteraCarroProp(alug.getID(), logs.getVeiculos().get(alug.getMatricula()));
            System.out.println("Aluguer Completo!");
            logs.setEstadoAlug(cli, 0);
        }
        else {
            do {
                if(logs.getClientes().get(cli).getEstadoAlug() == 1) break;
                menuAluguer.executa("Aluguer");
                switch (menuAluguer.getOpcao()) {
                    case 1:
                        menuMaisBarato(cli);
                        break;
                    case 2:
                        menuMaisPerto(cli);
                        break;
                    case 3:
                        menuMaisBaratoaXkm(cli);
                        break;
                    case 4:
                        menuVeiculoEspecifico(cli);
                        break;
                    case 0:
                        gravarInfo();
                        break;
                }
            } while (menuAluguer.getOpcao() != 0);
        }

    }

    public static void menuMaisBarato(String cli) {
        String mat;
        int id;
        double x, y;
        Ponto posCli, posDest;
        LocalDate data = LocalDate.now();
        Veiculo veic;
        ArrayList<Veiculo> arr;
        Aluguer alug = new Aluguer();
        Scanner is = new Scanner(System.in);
        int r = 0;
        do {
            System.out.println("---Menu Mais Barato---\n");
            System.out.print("Insira sua posição X: ");
            x = is.nextDouble();
            System.out.print("Insira sua posição Y: ");
            y = is.nextDouble();
            posCli = new Ponto(x, y);
            System.out.print("Insira seu destino X: ");
            x = is.nextDouble();
            System.out.print("Insira seu destino Y: ");
            y = is.nextDouble();
            posDest = new Ponto(x, y);
            System.out.println("\nVeiculos disponiveis:");
            arr = logs.maisBaratoAluguer(posDest);
            for (int i = 0; i < arr.size(); i++) {
                System.out.print(i + 1);
                System.out.print(" - ");
                if (arr.get(i) == null) {
                    System.out.println("Carro não existente");
                } else {
                    System.out.println(arr.get(i).toString2());
                }
            }
            do {
                System.out.printf("\nInsira Nº do carro que pretende(-1 para voltar para tras):");
                id = is.nextInt();
                if (id == -1) break;
                if (id < 1 || id > arr.size()) System.out.println("Nº invalido");
            } while (id < 1 || id > arr.size());
            if (id == -1) break;

            veic = arr.get(id - 1);
            double tempo = logs.tempoEstimado(veic.getPosicao(), posDest, veic.getVelocidade());
            double preco = logs.calculaPrecoAluguer(veic.getPreco(), posCli.distancia(posDest));

            alug.setTempo(tempo);
            alug.setInicio(veic.getPosicao());
            alug.setFim(posDest);
            alug.setPreco(preco);
            alug.setMatricula(veic.getMatricula());
            alug.setID(cli);
            alug.setTipo("MaisBarato");
            alug.setData(data);

            logs.setEstadoAlug(cli, 1);
            logs.addQueue(veic.getProp(), alug);
            System.out.println("\nPreço estimado:" + preco);
            System.out.println("\nAluguer solicitado!");


            r = 1;
        } while (r == 0);

    }

    public static void menuMaisBaratoaXkm(String cli) {
        String mat;
        int id;
        double x, y, tol;
        Ponto posCli, posDest;
        LocalDate data = LocalDate.now();
        Veiculo veic;
        ArrayList<Veiculo> arr;
        Aluguer alug = new Aluguer();
        Scanner is = new Scanner(System.in);
        int r = 0;
        do {
            System.out.println("---Menu Mais Barato---\n");
            System.out.print("Insira sua posição X: ");
            x = is.nextDouble();
            System.out.print("Insira sua posição Y: ");
            y = is.nextDouble();
            posCli = new Ponto(x, y);
            System.out.print("Insira seu destino X: ");
            x = is.nextDouble();
            System.out.print("Insira seu destino Y: ");
            y = is.nextDouble();
            System.out.print("Distancia disposta a caminhar: ");
            tol = is.nextDouble();

            posDest = new Ponto(x, y);
            arr = logs.maisBaratoaXKm(posDest, posCli, tol);
            if (arr.stream().allMatch(v->v==null)) {
                System.out.println("Não veiculos disponiveis a essa distancia!");
                break;
            }
            System.out.println("\nVeiculos disponiveis:");
            for (int i = 0; i < arr.size(); i++) {
                System.out.print(i + 1);
                System.out.print(" - ");
                if (arr.get(i) == null) {
                    System.out.println("Carro não existente");
                } else {
                    System.out.println(arr.get(i).toString2());
                }
            }
            do {
                System.out.printf("\nInsira Nº do carro que pretende(-1 para voltar para tras):");
                id = is.nextInt();
                if (id == -1) break;
                if (id < 1 || id > arr.size()) System.out.println("Nº invalido");
            } while (id < 1 || id > arr.size());
            if (id == -1) break;

            veic = arr.get(id - 1);
            double tempo = logs.tempoEstimado(veic.getPosicao(), posDest, veic.getVelocidade());
            double preco = logs.calculaPrecoAluguer(veic.getPreco(), posCli.distancia(posDest));

            alug.setTempo(tempo);
            alug.setInicio(veic.getPosicao());
            alug.setFim(posDest);
            alug.setPreco(preco);
            alug.setMatricula(veic.getMatricula());
            alug.setID(cli);
            alug.setTipo("MaisBaratoaXKm");
            alug.setData(data);

            logs.setEstadoAlug(cli, 1);
            logs.addQueue(veic.getProp(), alug);
            System.out.println("\nPreço estimado:" + preco);
            System.out.println("\nAluguer solicitado!");


            r = 1;
        } while (r == 0);
    }

    public static void menuMaisPerto(String cli) {
        String mat;
        int id;
        double x, y;
        Ponto posCli, posDest;
        LocalDate data = LocalDate.now();
        Veiculo veic;
        ArrayList<Veiculo> arr;
        Aluguer alug = new Aluguer();
        Scanner is = new Scanner(System.in);
        int r = 0;
        do {
            System.out.println("---Menu Mais Perto---\n");
            System.out.print("Insira sua posição X: ");
            x = is.nextDouble();
            System.out.print("Insira sua posição Y: ");
            y = is.nextDouble();
            posCli = new Ponto(x, y);
            System.out.print("Insira seu destino X: ");
            x = is.nextDouble();
            System.out.print("Insira seu destino Y: ");
            y = is.nextDouble();
            posDest = new Ponto(x, y);
            System.out.println("\nVeiculos disponiveis:");
            arr = logs.maisPertoAluguer(posCli, posDest);
            for (int i = 0; i < arr.size(); i++) {
                System.out.print(i + 1);
                System.out.print(" - ");
                if (arr.get(i) == null) {
                    System.out.println("Carro não existente");
                } else {
                    System.out.println(arr.get(i).toString2());
                }
            }
            do {
                System.out.printf("\nInsira Nº do carro que pretende(-1 para voltar para tras):");
                id = is.nextInt();
                if (id == -1) break;
                if (id < 1 || id > arr.size()) System.out.println("Nº invalido");
            } while (id < 1 || id > arr.size());
            if (id == -1) break;

            veic = arr.get(id - 1);
            double tempo = logs.tempoEstimado(veic.getPosicao(), posDest, veic.getVelocidade());
            double preco = logs.calculaPrecoAluguer(veic.getPreco(), posCli.distancia(posDest));

            alug.setTempo(tempo);
            alug.setInicio(veic.getPosicao());
            alug.setFim(posDest);
            alug.setPreco(preco);
            alug.setMatricula(veic.getMatricula());
            alug.setID(cli);
            alug.setTipo("MaisPerto");
            alug.setData(data);

            logs.setEstadoAlug(cli, 1);
            logs.addQueue(veic.getProp(), alug);
            System.out.println("\nPreço estimado:" + preco);
            System.out.println("\nAluguer solicitado!");


            r = 1;
        } while (r == 0);

    }

    public static void menuVeiculoEspecifico(String cli) {
        String mac;
        double x, y,a,b;
        Ponto posCli, posDest;
        LocalDate data = LocalDate.now();
        Veiculo veic;
        Aluguer alug = new Aluguer();
        Scanner is = new Scanner(System.in);
        int r = 0;
        System.out.println("---Menu Veiculo Especifico---\n");
        System.out.print("Insira sua posição X: ");
        x = is.nextDouble();
        System.out.print("Insira sua posição Y: ");
        y = is.nextDouble();

        posCli = new Ponto(x, y);

        System.out.print("Insira seu destino X: ");
        a = is.nextDouble();
        System.out.print("Insira seu destino Y: ");
        b = is.nextDouble();
        posDest = new Ponto(a, b);
        double dist = posCli.distancia(posDest);
        do {
            System.out.print("Insira matricula veiculo pretendido(Formato XX-XX-XX , q para sair):");
            mac = is.nextLine();
            if (mac.equals("q")) break;

            if (!logs.getVeiculos().containsKey(mac)) {
                System.out.println("Veiculo não existe!");
            }
            else if(logs.getVeiculos().get(mac).getAutonomia()<dist){
                System.out.println("Veiculo não tem autonomia suficiente!");
            }
            else {
                System.out.println("Matricula válida!");

                veic = logs.getVeiculos().get(mac);
                double tempo = logs.tempoEstimado(veic.getPosicao(), posDest, veic.getVelocidade());
                double preco = logs.calculaPrecoAluguer(veic.getPreco(), posCli.distancia(posDest));

                alug.setTempo(tempo);
                alug.setInicio(veic.getPosicao());
                alug.setFim(posDest);
                alug.setPreco(preco);
                alug.setMatricula(veic.getMatricula());
                alug.setID(cli);
                alug.setTipo("VeiculoEspecifico");
                alug.setData(data);

                logs.setEstadoAlug(cli, 1);
                logs.addQueue(veic.getProp(), alug);
                System.out.println("\nPreço estimado:" + preco);
                System.out.println("\nAluguer solicitado!");

                r = 1;
            }
            if (mac.equals("q")) {
                break;
            }
        } while (r == 0);
    }


    public static void main(String[] args) {
            logs = new Logs();

        try {
            carregarInfo();
        } catch (FileNotFoundException e) {
            logs.lerLogs("logsPOO.bak");
        } catch (ClassNotFoundException | IOException e1) {
            e1.printStackTrace();
            return;
        }

        menuOpcoes();
        menuPrincipal();

        gravarInfo();
    }
}
