#include <sys/types.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <stdio.h>
#include <ctype.h>
#include "writes.h"
#include "cod_partilhado.h"

/* Verifica se o input do utilizador é de facto um inteiro. */
Boolean isInt (char* x) {
    if (x[0] == '-' || isdigit(x[0])) {
        for (int i = 1; x[i]; i++)
            if (!isdigit(x[i])) return false;
    }
    else return false;
    return true;
}

/* Verifica se o input do utilizador é de facto um double. */
Boolean isDouble (char* x) {
	for (int i = 0, n = 0; x[i]; i++) {
		if (!isdigit(x[i])) {
			if (x[i] == '.') n++;
			else return false;

			if (n > 1) return false;
		}
	}
	return true;
}

/* Converte um int numa string com o número total de bytes reservados ao parâmetro em questão. */
char* intToString (int x, int flag, int len) {
    char* pos = malloc(PARAMETRO);
    sprintf(pos, "%.*d%c", len, x, (flag ? ' ' : '\n'));
    return pos;
}

/* Converte um double numa string com o número total de byte reservados ao parâmetro em questão. */
char* doubleToString (double p, int flag, int len) { //flag: 0 - preço, 1 - receitas
    char* doub = malloc(PARAMETRO);
    int n = sprintf(doub, "%.*lf%c", PARTEFRAC, p, (flag ? '\n' : ' '));
    
    char* doub2 = malloc(PARAMETRO);
    sprintf(doub2,"%.*d%s", len-(n-4), 0, doub);
    strcpy(doub,doub2);
        
    free(doub2);
    return doub;
}

/* Lê o stock do artigo referenciado pelo código dado. */
int readStock (int fdSto, int cod) {
    char* buf = malloc(PARAMETRO);

    lseek(fdSto, cod*LINHASTOCKS + OFFSETSTOCK, SEEK_SET);
    if (read(fdSto,buf,STOCK) < 0) crash(0);
    lseek(fdSto,-STOCK,SEEK_CUR);

    int stock = atoi(buf);
    free(buf);
    return stock;
}

/* Lê o preço do artigo referenciado pelo código dado. */
double readPreco (int cod) {
    int fdArt = open(ARTIGOS, O_CREAT | O_RDWR, 0666);
    char* buf = malloc(PARAMETRO);

    lseek(fdArt, cod*LINHAARTIGOS + OFFSETPRECO, SEEK_SET);
    if (read(fdArt,buf,PRECO) < 0) crash(0);

    double preco = atof(buf);
    free(buf);
    close(fdArt);
    return preco;
}

/* Lê a posição de um artigo ou o contador de um ficheiro. */
int readPos (int fd, int linha, int flag) {
    char* pos = malloc(PARAMETRO);
    lseek(fd, flag ? (linha*LINHAARTIGOS + OFFSETPOS) : OFFSETCONT, SEEK_SET);
    if (read(fd,pos,OFFSETCONT) < 0) crash(0);

    int p = atol(pos);
    free(pos);
    return p;
}

/* Lê uma linha a partir do descritor de ficheiro dado e devolve o número de bytes lidos. */
int readline (int fd, char* buf) {
    int i = 0;
    char* b = buf;

    while (1) {
        if (i == STRING-1) {i++; break;}
        if (read(fd,&b[i],1) <= 0) break;
        if (b[i++] == '\n') break;
    }
    b[i] = '\0';
    return i;
}

/* Separa os parâmetros de um comando de input do utilizador. */
char** separarComando (char* comando, int *ncampos) {
    char** campos = (char**) malloc(3 * sizeof(char*));
    int n = 0;

    for (int i = 0; comando[i]; i++) {
        if (i > 0 && (comando[i] == ' ' || comando[i] == '\n') && comando[i-1] != ' ' && comando[i-1] != '\0') {
            n++;
            if (n == 3) comando[i] = '\0';
        }
        if (comando[i] == '\n') comando[i] = '\0';
    }

    char* token = strtok(comando," ");
    for (int i = 0; i < 3 && i < n; i++) {
        campos[i] = strdup(token);
        token = strtok(NULL," ");
    }

    *ncampos = n;
    free(token);
    return campos;
}

/* Liberta a memória alocada pelo resultado da separarComandos. */
void freeComando (char** comando, int n) {
    for (int i = 0; i < 3 && i < n; i++)
        free(comando[i]);
    free(comando);
}

/* Criar a pasta de ficheiros de texto caso esta ainda não exista. */
void criarPasta () {
    struct stat st = {0};
    if (stat(DIRFILES, &st) == -1) mkdir(DIRFILES, 0700);
}

/* Abre a pipe principal de comunicação com o sv a fim de verificar
se este já foi inicializado. */
int abrirPipeSV () {
    int pipeW = open(DIRPIPES, O_WRONLY);
    
    if (pipeW < 0) {
        writeMensagem(1);
        return 1;
    }
    else close(pipeW);

    return 0;
}