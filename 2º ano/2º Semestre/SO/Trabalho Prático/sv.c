#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <stdio.h>
#include <time.h>
#include "writes.h"
#include "cod_partilhado.h"

/* Definição de uma estrutura destinada a manter os preços dos produtos
mais populares em memória, para evitar o acesso constante ao artigos. */
typedef struct caching {
    double* preco; // Array com os preços dos artigos mais populares.
    int* cod; // Array com os códigos dos artigos mais populares.
    int* qtd; // Array com as quantidades vendidas até ao momento dos artigos mais populares.
    int  num; // Número de artigos guardados na cache.
    int  min; // Índice da posição do array de quantidades com o menor valor.
} *cache;

/* Inicializa a estrutura cache. */
cache inicializarCache () {
    cache c = malloc(sizeof(struct caching));
    c -> preco = malloc(CACHE * sizeof(double));
    c -> cod = malloc(CACHE * sizeof(int));
    c -> qtd = malloc(CACHE * sizeof(int));
    
    c -> num = 0;
    c -> min = 0;

    return c;
}

/* Liberta a memória alocada pela cache. */
void freeCache (cache c) {
    free(c->cod);
    free(c->qtd);
    free(c->preco);
    free(c);
}

/* Verifica se um certo código existe no array de códigos da cache. */
int existeCodigo (cache c, int codigo) {
    for (int i = 0; i < c->num; i++)
        if (c->cod[i] == codigo) return i;
    return CACHE;
}

/* Atualiza o campo da cache que guarda o índice da posição
do array de preços da cache com o menor preço. */
cache atualizaMin (cache c) {
    int min = 0;
    for (int i = 1; i < c->num; i++)
        if (c->qtd[i] < c->qtd[min]) min = i;

    c->min = min;
    return c;
}

/* Devolve o preço de um artigo de certo código, caso esse código exista na cache. */
double precoCache (cache c, int codigo) {
    int indice = existeCodigo(c,codigo);

    if (indice == CACHE) return -1;
    return c->preco[indice];
}

/* Altera o preço referente ao código dado na cache. */
cache alterarPreco (cache c, char* cod, char* preco) {
    int indice = existeCodigo(c,atoi(cod));
    double p = atof(preco);

    if (indice != CACHE) c->preco[indice] = p;
    return c;
}

/* - Atualiza a informação da cache, caso os arrays não estejam cheios.
     - Consulta ou entrada de stock - código já existe na cache?
        - Sim: não faz nada.
        - Não: adiciona a informação do artigo às próximas posições livres.
     - Venda - código já existe na cache?
        - Sim: atualiza a quantidade vendida desse artigo e o campo min da cache.
        - Não: adiciona a informação do artigo e atualiza o campo min da cache. */
cache inserirCache (cache c, int codigo, int qtd, double preco) {
    int indice = existeCodigo(c,codigo);

    if (indice == CACHE) {
        c->cod[c->num] = codigo;
        c->qtd[c->num] = qtd;
        c->preco[c->num] = preco;
        c->num++;
    }
    else c->qtd[indice] += qtd;

    c = atualizaMin(c);
    return c;
}

/* - Atualiza informação da cache, caso os arrays estejam cheios.
     - Consulta ou entrada de stock - não faz nada.
     - Venda - código já existe na cache?
        - Sim: atualiza a quantidade vendida do artigo e o campo min da cache.
        - Não: a quantidade desta venda é superior à quantidade do artigo menos popular na cache?
            - Sim: substitui a informação desse artigo pelo novo e atualiza o campo min.
            - Não: não faz nada. */
cache alterarCache (cache c, int codigo, int qtd, double preco) {
    int indice = existeCodigo(c,codigo);

    if (indice != CACHE) c->qtd[indice] += qtd;

    else if (qtd > c->qtd[c->min]) {
            c->cod[c->min] = codigo;
            c->qtd[c->min] = qtd;
            c->preco[c->min] = preco;
    }

    c = atualizaMin(c);
    return c;
}

/* - Cria a diretoria dos ficheiros, caso ainda não exista, bem como os ficheiros em questão.
   - Verifica a validade do comando fornecido.
   - Atualiza a cache.
   - Se se tratar de uma venda:
        - altera o stock no stocks.
        - regista os dados da venda no vendas.
   - Se for uma entrada de stock, apenas altera o stock no stocks. */
cache mudarStock (cache c, char* string, char* codigo, char* quantidade) {
    criarPasta();
    int fdSto = open(STOCKS  ,O_CREAT | O_RDWR, 0666);
    if (fdSto < 0) crash(0);

    int cod = atoi(codigo) - 1;
    int qtd = atoi(quantidade);
    int stock = readStock(fdSto,cod);
    char* result = NULL;

    double preco = precoCache(c,cod+1);
    if (preco < 0) preco = readPreco(cod);

    if (isInt(codigo) && isInt(quantidade) && cod+1 > 0 && cod+1 < MAXCODIGO) {
        if (qtd < 0 && qtd > -MAXSTOCK && -qtd <= stock) {
            result = writeNewStock(fdSto,cod,qtd);
            writeVenda(cod,-qtd,preco);

            if (c->num != CACHE) c = inserirCache(c,cod+1,-qtd,preco);
            else c = alterarCache(c,cod+1,-qtd,preco);
        }

        else if (qtd > 0 && qtd < MAXSTOCK && qtd+stock < MAXSTOCK) {
            result = writeNewStock(fdSto,cod,qtd);
            if (c->num != CACHE) c = inserirCache(c,cod+1,0,preco);
        }
        
        else result = strdup(COMANDO);
    }
    else result = strdup(COMANDO);

    strcpy(string,result);
    free(result);

    close(fdSto);
    return c;
}

/* - Cria a diretoria dos ficheiros, caso ainda não exista, bem como os ficheiros em questão.
   - Atualiza a cache, caso ainda não esteja cheia.
   - Cria uma string com o stock atual de um artigo para imprimir no stdout
ou uma mensagem de erro para o stderr. */
cache consultarStock (cache c, char* string, char* codigo) {
    criarPasta();
    int fdSto = open(STOCKS, O_CREAT | O_RDWR, 0666);
    if (fdSto < 0) crash(0);

    int cod = atoi(codigo) - 1;
    char* result = NULL;

    double preco = precoCache(c,cod+1);
    if (preco < 0) preco = readPreco(cod);

    if (isInt(codigo) && cod+1 > 0 && cod+1 < MAXCODIGO) {
        result = writeStock(fdSto,cod,preco);
        if (c->num != CACHE) c = inserirCache(c,cod+1,0,preco);
    }
    else result = strdup(COMANDO);

    strcpy(string,result);
    free(result);

    close(fdSto);
    return c;
}

/* Envia as vendas a agregar para o agregador. */
void enviarVendas () {
    int fdV = open(VENDAS, O_RDONLY, 0666);

    if (fdV > 0) {
        char* buf = malloc(STRING);
        readline(fdV,buf); // Se o vendas não existisse ainda, não há nada para agregar
    
        int fim = lseek(fdV,0,SEEK_END);
        int pos = lseek(fdV,atoi(buf),SEEK_SET); // Move o apontador para essa posição

        if (pos != fim) {
            writeToPipe(PIPESVAG,buf); // Envia a posição a partir da qual começa a agregar

            while (readline(fdV,buf))
                writeToPipe(PIPESVAG,buf); // Envia as vendas ao agregador
        }
        free(buf);
    }

    writeToPipe(PIPESVAG,ENDOFFILE); // Envia uma flag para o agregador parar de tentar ler do stdin

    close(fdV);
    unlink(PIPESVAG);
}

/* Escreve o nome do ficheiro a criar que reflete a data e hora atuais. */
char* nomeFicheiro () {
    char* buf = malloc(STRING);
    time_t t = time(NULL);
    struct tm tm = *localtime(&t);

    struct stat st = {0};
    if (stat(DIRAGREG, &st) == -1) mkdir(DIRAGREG, 0700);

    sprintf(buf,"%s/%d-%d-%dT%d:%d:%d", DIRAGREG, tm.tm_year+1900, tm.tm_mon+1, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec);
    return buf;
}

/* - Cria um ficheiro cujo nome reflete a data e hora atuais.
   - Recebe as vendas agregadas da pipe e escreve-as no ficheiro. */
void ficheiroAgregado (int pipe) {
    char* buf = malloc(STRING);
    readline(pipe,buf);

    if (strcmp(buf,ENDOFFILE)) {
        char* nome = nomeFicheiro();
        int fdAg = open(nome, O_CREAT | O_WRONLY, 0666);

        if (write(fdAg,buf,strlen(buf)) < 0) crash(0);
        while (readline(pipe,buf)) {
            if (!strcmp(buf,ENDOFFILE)) break;
            if (write(fdAg,buf,strlen(buf)) < 0) crash(0);
        }

        close(fdAg);
    }
    free(buf);
}

/* - Cria um processo filho para correr o agregador, de maneira a não interromper
a execução do sv.
   - Recebe os resultados agregados e escreve-os unm ficheiro. */
void correrAgregador (int pipe) {
    if (!fork()) {
        mkfifo(PIPESVAG, 0666);

        int pipeSVAG = open(PIPESVAG, O_RDWR);
        dup2(pipeSVAG,0);
        close(pipeSVAG);
        
        enviarVendas();
        execlp("make", "make", "run_ag", NULL);
        _exit(0);
    }

    ficheiroAgregado(pipe);
}

/* - Caso a diretoria das pipes ainda não existir, cria-a.
   - Cria a pipe principal de comunicação com os cv e a ma.
   - Recebe o input do cv/ma e, caso aparente ser válido pelo seu formato,
invoca a função que realiza a operação correspondente. */
int main () {
    struct stat st = {0};
    if (stat("Pipes", &st) == -1) mkdir("Pipes", 0700);

    writeMensagem(0);
    mkfifo(DIRPIPES, 0666);

    cache c = inicializarCache();
    int pipe = open(DIRPIPES, O_RDWR);

    while (1) {
        int n;
        char* string = malloc(STRING);
        char* buf = malloc(STRING);
        
        readline(pipe,buf);
        
        char** comando = separarComando(buf,&n);

        if (!strcmp(comando[0],"a")) { correrAgregador(pipe); string = NULL; }
        else if (n == 2) {
            if (isInt(comando[0])) { c = alterarPreco(c,comando[0],comando[1]); string = NULL; }
            else c = consultarStock(c,string,comando[1]);
        } 
        else if (n == 3) c = mudarStock(c,string,comando[1],comando[2]);
        else string = strdup(COMANDO);

        if (n && string) writeToPipe(comando[0],string);

        freeComando(comando,n);
        free(string);
        free(buf);
    }

    freeCache(c);
    close(pipe);
    return 0;
}