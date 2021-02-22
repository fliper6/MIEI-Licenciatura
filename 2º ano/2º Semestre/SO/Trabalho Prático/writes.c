#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <stdio.h>
#include "writes.h"
#include "cod_partilhado.h"

/* Crasha o programa e imprime uma mensagem de erro no stderr. */
void crash (int flag) {
    char* erro = malloc(STRING);

    if (flag == 0) sprintf(erro,"Erro I/O.\n");
    if (flag == 1) sprintf(erro,"Ficheiros de texto adulterados. Apague-os ou reverta as alterações.\n");
    if (write(2,erro,strlen(erro)) < 0) exit(1);
    
    free(erro);
    exit(1);
}

/* Escreve uma mensagem de erro com o comando inválido no stderr. */
void writeComando (char* input, int flag) {
    char* erro = malloc(STRINGMAIOR);
    
    sprintf(erro,"Comando inválido: %s%c", input, (flag ? '\n' : '\0'));
    if (write(2,erro,strlen(erro))   < 0) exit(1);

    free(erro);
}

/* Escreve mensagens relativas ao sv no stderr. */
void writeMensagem (int flag) {
    char* msg = malloc(STRING);

    if (flag == 0) sprintf(msg, "Servidor de vendas online.\n");
    if (flag == 1) sprintf(msg, "Servidor de vendas offline.\n");

    if (write(2,msg,strlen(msg)) < 0) exit(1);
    free(msg);
}

/* Escreve para uma pipe. */
void writeToPipe (char* nome, char* buf) {
	int pipe = open(nome, O_WRONLY);
    if (write(pipe,buf,strlen(buf)) < 0) crash(0);
    close(pipe);
}

/* Lê o resultado fornecido pelo sv da pipe e imprime-o no stdout. */
void writeFromPipe (int pipe) {
    char* buf = malloc(STRING);
    readline(pipe,buf);

    if (!strcmp(buf,COMANDO)) { if (write(2,buf,strlen(buf)) < 0) crash(0); }
    else { if (write(1,buf,strlen(buf)) < 0) crash(0); }

    free(buf);
}

/* Adiciona uma entrada ao stocks, com o código do novo artigo e o stock inicial (0). */
void writeInitStock (int fdSto, int cod) {
    lseek(fdSto,0,SEEK_END);
    char* buf = malloc(STRING);

    sprintf(buf, "%.*d %.*d\n", CODIGO, cod, STOCK, 0);
    if (write(fdSto,buf,strlen(buf)) < 0) crash(0);

    free(buf);
}

/* Lê o stock e o preço do artigo em questão a partir dos ficheiros respetivos
e imprime estas informações e devolve uma string com estes parâmetros. */
char* writeStock (int fdS, int cod, double preco) {
    int stock     = readStock(fdS,cod);
    char* string  = malloc(STRING);
    
    sprintf(string,"%d %.2lf\n", stock, preco);
    return string;
}

/* - Lê o stock do artigo em questão, atualiza o mesmo no stocks
e devolve uma string com esta informação para imprimir no stdout mais tarde. */
char* writeNewStock (int fdS, int cod, int qtd) {
    int stock 		= readStock(fdS,cod) + qtd;
    char* stockNovo = intToString(stock,0,STOCK);

    if (write(fdS,stockNovo,strlen(stockNovo)) < 0) crash(0);
    sprintf(stockNovo,"%d\n", stock);

    return stockNovo;
}

/* Navega até ao artigo em questão no artigos e atualiza o seu preço. */
void writePreco (int fdArt, int cod, double preco) {
    char* p = doubleToString(preco,0,PRECOINT);
	lseek(fdArt, cod*LINHAARTIGOS + OFFSETPRECO, SEEK_SET);
	if (write(fdArt,p,strlen(p)) < 0) crash(0);
	free(p);
}

/* Navega até ao artigo em questão no artigos e atualiza a sua posição. */
void writePos (int fdArt, int p, int linha) {
	char* pos = intToString(p,0,POSICAO);
	lseek(fdArt, linha*LINHAARTIGOS + OFFSETPOS, SEEK_SET);
	if (write(fdArt,pos,strlen(pos)) < 0) crash(0);
	free(pos);
}

/* Atualiza o contador de um ficheiro ou inicializa-o, caso ainda não exista. */
int writeContador (int fd, int init, int new, int flag) {
	if (flag) lseek(fd,0,SEEK_SET);
    char* pos = malloc(STRING);
    
    if (read(fd,pos,POSICAO) > 0) {
        init = atoi(pos) + new;
        lseek(fd,-POSICAO,SEEK_CUR);
    }
    sprintf(pos, "%.*d\n", POSICAO, init);
    if (write(fd,pos,strlen(pos)) < 0) crash(0);

    free(pos);
    return init;
}

/* Atualiza a posição no início do vendas com a posição a partir
da qual a próxima agregação deve começar.*/
void writePosAg (int pos) {
	int fdV  = open(VENDAS, O_CREAT | O_WRONLY, 0666);
    if (fdV < 0) crash(0);

    char* buf = intToString(pos,0,POSICAO);
    if (write(fdV,buf,POSICAO+1) < 0) crash(0);

    close(fdV);
    free(buf);
}

/* - Inicializa o contador de bytes do strings caso seja a 1º string do mesmo.
   - Escreve o nome do artigo no fim do ficheiro.
   - Adiciona ao contador o número de bytes da string inserida. */
int writeNome (int fdStr, char* comando, int flag) {
	char* nome = malloc(strlen(comando)+2);
	writeContador(fdStr,0,0,1);

	int p = lseek(fdStr,0,SEEK_END);
	sprintf(nome, "%s\n", comando);
	int n = write(fdStr,nome,strlen(nome));

    int bytes = writeContador(fdStr,0,n,1);

    free(nome);
    if (flag) p = bytes;
    return p;
}

/* Escreve o código, preço e posição de um artigo novo no artigos. */
void writeArtigo (int fdArt, int p, char* cod, double preco) {
	int linha = atoi(cod) - 1;

	if (write(fdArt,cod,strlen(cod)) < 0) crash(0);
	writePreco(fdArt,linha,preco);
	writePos(fdArt,p,linha);

    free(cod);
}

/* - Inicializa o "contador" no início do vendas, com a posição da 1º venda.
   - Calcula a receita gerada da venda.
   - Escreve o código do artigo em questão, a quantidade vendida e a receita gerada no vendas. */
void writeVenda (int cod, int qtd, double preco) {
    int fdV = open(VENDAS, O_CREAT | O_RDWR, 0666);
    if (fdV < 0) crash(0);

    writeContador (fdV,POSICAO+1,0,1);
    lseek(fdV,0,SEEK_END);

    char* string   = malloc(STRING);
    char* codigo   = intToString(cod+1,1,CODIGO);
    char* quantd   = intToString(qtd,1,STOCK);
    double receita = preco * qtd;
    char* receitas = doubleToString(receita,1,RECEITASINT);

    sprintf(string, "%s%s%s", codigo, quantd, receitas);
    if (write(fdV,string,strlen(string)) < 0) crash(0);

    free(quantd);
    free(codigo);
    free(string);
    free(receitas);
    close(fdV);
}

/* - Escreve as vendas agregadas de um código no ficheiro de agregação.
   - Envia a mesma venda para a manutenção de artigos por uma named pipe. */
void writeVendaAg (int fdAg, int cod, int qtd, double montante) {
	char* buf = malloc(STRING);
    
	sprintf(buf,"%.*d %.*d %s", CODIGO, cod, QTDTOTAL, qtd, doubleToString(montante,1,MONTANTEINT));
    if (write(fdAg,buf,strlen(buf)) < 0) crash(0);
  
    sprintf(buf, "%d %d %.2lf\n", cod, qtd, montante);
    writeToPipe(PIPEMAAG,buf);

   	free(buf);
}

/* Copia as strings válidas do strings atual para um ficheiro novo.
    - Inicializa o contador de bytes no início do ficheiro novo.
    - A cada iteração, copia toda a informação entre as linhas com nomes inválidos.
    - Atualiza o contador com o número de bytes das strings válidas apenas.
    - Apaga o strings atual e dá este nome ao ficheiro novo.
    - Devolve um array com os comprimentos das strings removidas, para poder
depois atualizar as posição das válidas no artigos. */
int* writeStringsNovo (int fdStr, int num, int* posicoes) {
    int fdNovo = open(NOVO, O_CREAT | O_RDWR, 0666);
    if (fdNovo < 0) crash(0);
    
    int dif;
    int init = OFFSETCONT, bytes = 0;

    char* buf    = malloc(STRING);
    int* lengths = malloc(num*sizeof(int));

    writeContador(fdNovo,0,0,1);
    lseek(fdStr,init,SEEK_SET);

    for (int i = 0; i < num+1; i++) {
        if (i != num) dif = posicoes[i] - init;
        if (i == num) {
            dif = lseek(fdStr,0,SEEK_END) - init;
            lseek(fdStr,init,SEEK_SET);
        } 
        bytes += dif;
        
        if (dif) {
            char* buffer = malloc(dif+1);
            if (read(fdStr,buffer,dif) < 0) crash(0);
            if (write(fdNovo,buffer,dif) < 0) crash(0);
            free(buffer);
        }

        if (i != num) {
            lengths[i] = readline(fdStr,buf);
            if (i) lengths[i] += lengths[i-1];
            init = lseek(fdStr,0,SEEK_CUR);
        }
    }
    writeContador(fdNovo,0,bytes,1);

    close(fdNovo);
    remove(STRINGS);
    rename(NOVO,STRINGS);
    
    free(buf);
    return lengths;
}