package Business;

import Exceptions.ClienteExistenteException;
import Exceptions.ClienteNaoTemConfiguracoesException;
import Exceptions.ClienteInexistenteException;
import Exceptions.ConfiguracaoJaNaFilaException;
import Exceptions.FilaDeEsperaEstaVaziaException;
import Exceptions.NaoExistemUnidadesSuficientesException;
import Exceptions.NaoExistemConfiguracoesException;
import Exceptions.NaoExistemPacotesException;
import Exceptions.NaoExistemClientesException;
import Dataaccess.*;
import Exceptions.FuncionarioInexistenteException;
import Exceptions.PasswordIncorrectaException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import javax.swing.JOptionPane;

public class Facade{
	
        private static String tipo=null;
        private static int idConf = 0;
        
        // recebe username e password do funcionario a ser autenticado
        // caso o username nao exista FuncionarioInexistenteException é lançada
        // caso o username exista mas a password nao seja a correcta PasswordIncorrectaException é lançada
        // caso o username exista e a password seja a correcta, a variável tipo assume o valor "stand" caso o tipo do 
        // funcionário autenticado seja "stand", caso contrário, a variável tipo assume o valor "fabrica"
        public static void login (String username, String password) throws PasswordIncorrectaException, FuncionarioInexistenteException, Exception {
            ClienteDAO clientes = new ClienteDAO();
            if (clientes.login(username, password)) tipo="stand";
            else tipo = "fabrica";
        }
        // recebe os dados do cliente a ser registado e caso o mesmo já esteja registadocaso ClienteExistenteExceptin é lançada
        public static void registarCliente (int nif, String nome, String morada, int telefone) throws ClienteExistenteException, Exception {
            ClienteDAO clientes = new ClienteDAO();
            if (clientes.clienteExiste(nif)) throw new ClienteExistenteException("Não foi possível registar cliente pois já está registado");
            else clientes.inserirCliente(nif, nome, morada, telefone);
	}
        // recebe o nif do cliente a remover e lança ClienteInexistenteException caso o cliente não exista, caso contrário
        // o cliente é removido
	public static void removerCliente (int nif) throws ClienteInexistenteException, Exception {
            ClienteDAO clientes = new ClienteDAO();
            if (!clientes.clienteExiste(nif)) throw new ClienteInexistenteException("Cliente não existe");
            else {
                ConfiguracaoDAO configuracoes = new ConfiguracaoDAO();
                QueueDAO queue = new QueueDAO();
                try{
                    ArrayList<Integer> ids = configuracoes.getConfiguracoesCliente(nif);
                    queue.removerPedidos(ids);
                    configuracoes.removerConfiguracoes(nif);
                    clientes.removerCliente(nif);
                }
                catch(Exception e){}
            }
	}
        // recebe o nif do cliente e remove-o
	public static void removerCliente1 (int nif) throws Exception {
            ClienteDAO clientes = new ClienteDAO();
            QueueDAO queue = new QueueDAO();
            ConfiguracaoDAO configuracoes = new ConfiguracaoDAO();
            ArrayList<Integer> ids = configuracoes.getConfiguracoesCliente(nif);
            queue.removerPedidos(ids);
            configuracoes.removerConfiguracoes(nif);
            clientes.removerCliente(nif);
	}
        // recebe o nif do cliente e remove as suas configurações
        public static void removerConfiguracoes(int nif) throws Exception {
            ConfiguracaoDAO configuracoes=new ConfiguracaoDAO();
            ArrayList<Integer> ids = configuracoes.getConfiguracoesCliente(nif);
            QueueDAO queue = new QueueDAO();
            queue.removerPedidos(ids);
            configuracoes.removerConfiguracoes(nif);
        }
        
        // retorna um ArrayList de clientes caso estes existam, caso contrário, NaoExistemClienteException é lançada
	public static ArrayList<Cliente> getClientes () throws NaoExistemClientesException, Exception {
            ClienteDAO clientes = new ClienteDAO();
            ArrayList<Cliente> clients = new ArrayList<>();
            clients = clientes.getClientes();
            if (clients.isEmpty()) throw new NaoExistemClientesException("Não existem clientes registados");
            return clients;
	}
        // recebe o nome do pacote e retorna true caso o mesmo exista, false caso contrário
        public static Boolean existePacote (String nome) throws Exception {
            ComponenteDAO componentes = new ComponenteDAO();
            return componentes.existePacote(nome);
        }
	// retorna um ArrayList com todos os componentes
        public static ArrayList<Componente> getComponentes () throws Exception {
            ComponenteDAO componentes = new ComponenteDAO();
            return componentes.getComponentes();
        }
        // recebe um ArrayList de componentes e retorna true caso no mínimo 2 deles sejam incompatíveis
        public static Boolean existemIncompatibilidades (ArrayList<Componente> components) throws Exception {
            ComponenteDAO componentes = new ComponenteDAO();
            return componentes.existemIncompatibilidades(components);
        }
        // recebe um ArrayList de componentes e devolve a lista desses componentes que geram incompatibilidades entre si
        public static HashSet<String> listaIncompatibilidades (ArrayList<Componente> components) throws Exception{
            ComponenteDAO componentes = new ComponenteDAO();
            return componentes.listaIncompatibilidades(components);
        }
        // recebe o nome do pacote e um ArrayList dos componentes constituintes do pacote e insere na tabela pacote uma linha
        // com o nome do pacote e o seu preço, e na tabela pacote_has_componente insere, para cada componente constituinte do 
        // pacote uma linha com o nome do pacote e nome do componente
        public static void criarPacote (String nome, ArrayList<Componente> components) throws Exception {
            ComponenteDAO componentes = new ComponenteDAO();
            componentes.criarPacote(nome, components);
        }
        // retorna um HashMap com os pacotes existentes e os respectivos componentes, caso não existam pacotes
        // NaoExistemPacoteException é lançada
        public static HashMap<Pacote, ArrayList<Componente>> getpacotes () throws Exception {
            ComponenteDAO componentes = new ComponenteDAO();
            HashMap<Pacote, ArrayList<Componente>> pacotes = componentes.getpacotes();
            if (pacotes==null) throw new NaoExistemPacotesException("Não existem pacotes");
            else return pacotes;
        }
        
        // retorna um ArrayList com os pacotes existentes
        public static ArrayList<Pacote> getPacotes() throws NaoExistemPacotesException, Exception {
            ComponenteDAO componentes = new ComponenteDAO();
            ArrayList<Pacote> pacotes = componentes.getPacotes();
            if (pacotes==null) throw new NaoExistemPacotesException("Não existem pacotes");
            else return pacotes;
        }
        // recebe o nome de um pacote e remove-o
        public static void removerPacote (String nome) throws Exception {
            ComponenteDAO componentes = new ComponenteDAO();
            componentes.removerPacote(nome);
        }
        // retorna um ArrayList de string com as categorias dos componentes existentes
        public static HashSet<String> getListaCategorias () throws Exception {
            StockDAO stock = new StockDAO();
            //ComponenteDAO componentes = new ComponenteDAO();
            return stock.getListaCategorias();
        }
        // recebe a designação de uma categoria e devolve um ArrayList dos objectos do tipo stock referentes a componentes do 
        // tipo da categoria recebida
        public static ArrayList<Stock> getStockCategoria (String categoria) throws Exception {
            StockDAO stock = new StockDAO();
            return stock.getStockCategoria(categoria);
        }
        // recebe o nif do cliente a ser retornado e o mesmo é retornado caso exista, 
        //caso contrário ClienteInexistenteException é lançada 
        public static Cliente getCliente (int nif) throws ClienteInexistenteException, Exception {
            ClienteDAO clientes = new ClienteDAO();
            Cliente c = clientes.getCliente(nif);
            if (c==null) throw new ClienteInexistenteException("Cliente não existe");
            return c;
        }
        
        public static ArrayList<Componente> getCompsGuiada () throws Exception {
            ComponenteDAO componentes = new ComponenteDAO();
            return componentes.getCompsGuiada();
        }
        
        public static Set<Componente> getCompativeis (ArrayList<String> escolhidos, ArrayList<String> comps) throws Exception {
            ComponenteDAO componentes = new ComponenteDAO();
            return componentes.getCompativeis(escolhidos, comps);
        }
        // recebe um ArrayList de componentes e devolve true caso existam dependências de pelo menos um desses componentes
        // por cumprir, false caso contrário
        public static Boolean existemDependencias (ArrayList<Componente> components) throws Exception {
            ComponenteDAO componentes = new ComponenteDAO();
            return componentes.existemDependencias(components);
        }
        // recebe um ArrayList de componentes  e devolve um map em que as keys são os nomes dos componentes da lista cujas
        // dependências não são todas satisfeitas e os values são os nomes das dependêcias não satisfeitas
        public static HashMap<String, HashSet<String>> listaDependencias (ArrayList<Componente> components) throws Exception {
            ComponenteDAO componentes = new ComponenteDAO();
            return componentes.listaDependencias(components);
        }
        // Recebe os componentes referentes à configuração, o id do cliente que a criou e o preço total
        public static void criarConfiguracao (ArrayList<Componente> componentes, int idCliente, int preco) throws Exception {
            ConfiguracaoDAO configuracoes = new ConfiguracaoDAO();
            configuracoes.criarConfiguracao(++idConf, componentes, idCliente,preco);
        }
        // recebe o id da configuração e caso esta já esteja na fila de espera ConfiguracaoJaNaFilaException é lançada
        public static void configuracaoNaFila (int idConf) throws Exception {
            QueueDAO queue = new QueueDAO();
            if (queue.configuracaoNaFila(idConf))
                throw new ConfiguracaoJaNaFilaException("Configuração já foi adicionada à fila ou encontra-se em produção");
        }
        // recebe o nif do cliente e o custo da configuraçao criada e actualiza o saldo do mesmo
        public static void actualizaSaldoCliente (int idCliente, int custo) throws Exception {
            ClienteDAO clientes = new ClienteDAO();
            clientes.actualizaSaldo(idCliente,custo);
        }
        // recebe o id da configuraçao relativa ao pedido efectuado(inserção na fila de espera) e insere-a na tabela queue
        // e acede à tabela configuracao para alterar o seu estado para "EmEspera"
        public static void inserirConfiguracao (int idConfiguracao) throws Exception {
            ConfiguracaoDAO configuracoes = new ConfiguracaoDAO();
            QueueDAO queue = new QueueDAO();
            queue.inserirConfiguracao(idConfiguracao);
            configuracoes.alterarEstado(idConfiguracao, "EmEspera");
        }
         // Devolve todas as configurações e as respectivas listas de componentes(nome)
        public static HashMap<Configuracao,ArrayList<String>> getConfiguracoes () throws Exception {
            ConfiguracaoDAO configuracoes = new ConfiguracaoDAO();
            HashMap<Configuracao,ArrayList<String>> configs = new HashMap<>();
            configs = configuracoes.getConfiguracoes();
            if (configs==null)
                throw new NaoExistemConfiguracoesException("Não existem configurações");
            return configs;
        }
        // Devolve todas as configurações e as respectivas listas de componentes(nome) de um dado cliente
        public static HashMap<Configuracao,ArrayList<String>> getConfiguracoes (int idCliente) throws Exception {
            ConfiguracaoDAO configuracoes = new ConfiguracaoDAO();
            HashMap<Configuracao,ArrayList<String>> configs = new HashMap<>();
            configs=configuracoes.getConfiguracoes(idCliente);
            if (configs==null)
                throw new ClienteNaoTemConfiguracoesException("O Cliente não tem configurações");
            return configs;
        }
        // devolve um objecto queue com os ids de todas as configuraçoes referentes aos pedidos
        public static HashMap<Configuracao,ArrayList<String>> getPedidos () throws Exception {
            QueueDAO fila = new QueueDAO();
            ConfiguracaoDAO configuracoes = new ConfiguracaoDAO();
            Queue queue = fila.getPedidos();
            if (queue==null) throw new FilaDeEsperaEstaVaziaException("Fila de espera está vazia");
            HashMap<Configuracao,ArrayList<String>> pedidos = configuracoes.getConfiguracoes(queue.getConfiguracoes());
            return pedidos;
        }
        // recebe o id da configuração à qual o pedido em questão é referente e remove da tabela queue a linha em que o 
        // configuracao_id é igual ao recebido como parâmetro  e altera o estado da respectiva configuração para "pendente"
        public static void removerPedido (int idConf) throws Exception {
            ConfiguracaoDAO configuracoes = new ConfiguracaoDAO();
            QueueDAO queue = new QueueDAO();
            queue.removerPedido(idConf);
            configuracoes.alterarEstado(idConf, "pendente");
        }
        // Recebe os nomes dos componentes da configuração a iniciar fase de produção e caso os mesmos não existam em
        // unidades necessárias NaoExistemUnidadesSuficientesException é lançada em que a mensagem são os componentes
        // "esgotados"
        public static void verificaStock (ArrayList<String> nomeComps) throws Exception {
            StockDAO stock = new StockDAO();
            if (!stock.verificaStock(nomeComps)/*==false*/) {
                ArrayList<String> esgotados = stock.listaEsgotados(nomeComps);
                StringBuilder sb = new StringBuilder();
                sb.append("Os seguintes componentes estão esgotados:\n");
                for (String s : esgotados)
                    sb.append(s).append(" ");
                throw new NaoExistemUnidadesSuficientesException(sb.toString());
             }
        }
        // recebe o id da configuração a iniciar fase de produção e remove-a da tabela queue, altera o seu estado para 
        // "EmProducao" e actualiza o stock dos componentes da configuração
        public static void iniciarProducao (int idPedido) throws Exception {
            ConfiguracaoDAO configuracoes = new ConfiguracaoDAO();
            QueueDAO queue = new QueueDAO();
            StockDAO stock = new StockDAO();
            queue.iniciarProducao(idPedido);
            configuracoes.alterarEstado(idPedido,"EmProducao");
            ArrayList<String> componentes = configuracoes.getCompsConf( idPedido);
            stock.actualizarStock(componentes);
        }
        // recebe o nome do componente cujo stock pretende-se aumentar e o número de unidades em que o stock vai ser aumentado
        public static void encomendar (String nomeComp, int unidades) throws Exception {
            StockDAO stock = new StockDAO();
            stock.encomendar(nomeComp, unidades);
        }
        
        public static HashMap<Pacote,ArrayList<String>> verificaPacotes(ArrayList<String> components) throws Exception {
            ComponenteDAO componentes = new ComponenteDAO();
            return componentes.verificaPacotes(components);
        }
        
        public static ArrayList<Funcionario> getFuncionarios () throws Exception {
            ClienteDAO clientes = new ClienteDAO();
            return clientes.getFuncionarios();
        }
        
        public static String getTipo () {
            return tipo;
        }
        
        
        
        public static HashMap<Pacote,ArrayList<Componente>> verificaPacotes1(ArrayList<Componente> componentes) throws Exception{
            ComponenteDAO cDAO = new ComponenteDAO();
            return cDAO.verificaPacotes1(componentes);
        }
}
