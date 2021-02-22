#include <sys/types.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <stdio.h>
#include "writes.h"
#include "cod_partilhado.h"

/* Calcula o código do próximo artigo a inserir. */
char* proximoCod (int fdArt) {
    char* cod = malloc(PARAMETRO);

    if (!lseek(fdArt,0,SEEK_END))
        sprintf(cod, "%.*d ", CODIGO, 1);
    else {
        lseek(fdArt,-LINHAARTIGOS,SEEK_END);
        if (read(fdArt,cod,CODIGO+1) < 0) crash(0);
        lseek(fdArt,0,SEEK_END);
        sprintf(cod, "%.*d ", CODIGO, atoi(cod)+1);
    }
    return cod;
}

/* Verifica a validade do comando fornecido para inserir um artigo novo:
	- garante que ainda não foi atingido o máximo de artigos (código) permitido.
	- verifica a validade do preço dado.
	- garantir que a posição da string nova é válida (não ultrapassa o limite estabelecido).
	- averigua se os ficheiros de texto foram alterados por terceiros. */
Boolean validarInputArtigo (int p, int cod, double preco, char** comando) {
	if (cod == MAXCODIGO) return false;
	if (!(isDouble(comando[2]) && preco >= 0 && preco < MAXPRECO)) return false;
	if (p >= MAXPOSICAO) return false;

	return true;
}

/* Insere um artigo novo:
	- Guarda o código, preço e posição do nome no artigos.
	- Adiciona o nome ao fim do strings.
	- Adiciona uma entrada com o código novo ao stocks. */
void inserirArtigo (char* input, char** comando) {
	criarPasta();
	int fdArt = open(ARTIGOS ,O_CREAT | O_RDWR, 0666);
	int fdStr = open(STRINGS ,O_CREAT | O_RDWR, 0666);
	int fdSto = open(STOCKS  ,O_CREAT | O_RDWR, 0666);
	if (fdArt < 0 || fdStr < 0 || fdSto < 0) crash(0);

	int p        = lseek(fdStr,0,SEEK_END);
	char* cod    = proximoCod(fdArt);
	int codigo   = atoi(cod);
	double preco = atof(comando[2]);
	
	if (validarInputArtigo(p,codigo,preco,comando)) {
		p = writeNome(fdStr,comando[1],0);
		writeArtigo(fdArt,p,cod,preco);
		writeInitStock(fdSto,codigo);
	}
	else writeComando(input,0);
	
	close(fdSto);
	close(fdStr);
	close(fdArt);
}

/* Função auxiliar do mergeSort. */
void merge (int arr[], int l, int m, int r) { 
    int i, j, k; 
    int n1 = m - l + 1; 
    int n2 =  r - m; 
    int L[n1], R[n2]; // create temp arrays
  
    //Copiar dados para os arrays temporários
    for (i = 0; i < n1; i++) L[i] = arr[l + i]; 
    for (j = 0; j < n2; j++) R[j] = arr[m + 1+ j]; 
  
    /* Fundir os arrays temporários em arr[l..r]*/
    i = 0, j = 0, k = l; // Índices iniciais do primeiro, segundo e merged subarrays
    while (i < n1 && j < n2) { 
        if (L[i] <= R[j]) arr[k] = L[i++];
        else arr[k] = R[j++]; 
        k++; 
    } 

    while (i < n1) arr[k++] = L[i++]; // Copiar os possíveis elementos restantes de L[]
    while (j < n2) arr[k++] = R[j++]; // Copiar os possíveis elementos restantes de R[]
} 

/* Ordena um array de inteiros através da estratégia "dividir para conquistar". */
void mergeSort (int arr[], int l, int r) { // l/r - índices esquerdo/direito do subarray de arr que vai ser ordenado 
    if (l < r) { 
        int m = l+(r-l)/2; // O mesmo que (l+r)/2 mas evita overflow com l e h grandes
  
        // Ordenar a primeira e segunda metades
        mergeSort(arr, l, m); 
        mergeSort(arr, m+1, r); 

        merge(arr, l, m, r); 
    }
}

/* Atualiza as posições das strings depois de criar um strings novo sem informação inútil. */
void atualizarPosicoes (int fdArt, int num, int* posicoes, int* lengths) {
	int posAtual;
	char* buf = malloc(STRING);	
	lseek(fdArt,OFFSETPOS,SEEK_SET);

	while (read(fdArt,buf,POSICAO) > 0) {
		lseek(fdArt,-POSICAO,SEEK_CUR);
		
		for (int i = num-1; i >= 0; i--) {
			posAtual = atoi(buf);

			if (posAtual > posicoes[i]) {
				sprintf(buf, "%.*d\n", POSICAO, posAtual-lengths[i]);
				if (write(fdArt,buf,strlen(buf)) < 0) crash(0);
				break;
			}
			else if (!i) lseek(fdArt,OFFSETCONT,SEEK_CUR);
		}
		lseek(fdArt,OFFSETPOS,SEEK_CUR);
	}

	free(buf);
}

/* - Copia as strings válidas para um novo ficheiro para substituir o strings atual.
   - Atualiza as posições das strings no artigos.
   - Remove o ficheiro com as informações das strings inválidas visto que foram apagadas. */
void limparNomes (int fdArt, int fdStr, int fdInfo) {
	int num = (int) readPos(fdInfo,0,0);

	char* buf 	  = malloc(STRING);
	int* posicoes = malloc(num*sizeof(int));

	for (int i = 0; readline(fdInfo,buf); i++)
		posicoes[i] = atoi(buf);
	mergeSort(posicoes,0,num-1);

	int* lengths = writeStringsNovo(fdStr,num,posicoes);
	atualizarPosicoes(fdArt,num,posicoes,lengths);

	free(buf);
	free(lengths);
	free(posicoes);

	close(fdInfo);
	unlink(INFO);
}

/* - Guarda a posição e o comprimento da string agora inválida no info.
   - Devolve o número total de bytes inválidos no strings. */
double guardarInfo (int fdArt, int fdStr, int fdInfo, int cod) {
	// Arranja a posição da string agora inútil e move o fp para lá
	int posAntiga = readPos(fdArt,cod,1);
	lseek(fdStr,posAntiga,SEEK_SET);

	char* buf = malloc(STRING);
	int n = readline(fdStr,buf);

	// Inicializa/atualiza contadores de bytes e de número de linhas inválidas no início do ficheiro
	double bytes = (double) writeContador(fdInfo,n,n,1);
	writeContador(fdInfo,1,1,0);

	// Adiciona a posição da nova linha inútil, bem como o código a que se referia ao info
	lseek(fdInfo,0,SEEK_END);
	sprintf(buf, "%.*d\n", POSICAO, posAntiga);
	if (write(fdInfo,buf,strlen(buf)) < 0) crash(0);

	free(buf);
	return bytes;
}

/* - Muda o nome de um artigo.
   - Atualiza a posição para a da nova string.
   - Guarda a informação relativa à string anterior.
   - Faz uma limpeza ao strings caso 20% da sua informação seja inútil.
		- o código fornecido tem de ser válido (existe um artigo com esse código).
		- garantir que a posição da nova string ainda pode ser escrita com o número
	  	  de bytes reservados para as posições. */
void mudarNome (char* input, char** comando) {
	criarPasta();
	int fdArt  = open(ARTIGOS, O_CREAT | O_RDWR, 0666);
	int fdStr  = open(STRINGS, O_CREAT | O_RDWR, 0666);
	int fdInfo = open(INFO,    O_CREAT | O_RDWR, 0666);
	if (fdArt < 0 || fdStr < 0 || fdInfo < 0) crash(0);

	int cod = atoi(comando[1]) - 1;
	int p   = lseek(fdStr,0,SEEK_END);
	
	if (isInt(comando[1]) && p < MAXPOSICAO && cod+1 > 0 && cod+1 < MAXCODIGO) {
		double inutil = guardarInfo(fdArt,fdStr,fdInfo,cod);
		double bytes = (double) writeNome(fdStr,comando[2],1);
		
		lseek(fdArt,0,SEEK_SET);
		writePos(fdArt,p,cod);

		if (inutil >= 0.2*bytes) limparNomes(fdArt,fdStr,fdInfo);
		else close(fdInfo);
	}
	else
		writeComando(input,0);

	close(fdArt);
	close(fdStr);
}

/* Verifica a validade do comando fornecido para mudar o preço de artigo:
	- o código tem de ser válido.
	- o novo preço fornecido também. */
Boolean validarInputPreco (int cod, double preco, char** comando) {
	if (!isInt(comando[1])) return false;
	if (!(cod+1 > 0 && cod+1 < MAXCODIGO)) return false;
	if (!(isDouble(comando[2]) && preco >= 0 && preco < MAXPRECO)) return false;

	return true;
}

/* Infoma o servidor de vendas acerca da alteração de preço. */
void enviarPrecoSV (int cod, double preco) {
	if (!abrirPipeSV()) {
		char* buf = malloc(STRING);
		sprintf(buf, "%d %lf\n", cod, preco);
		writeToPipe(DIRPIPES,buf);
		free(buf);
	}
}

/* - Muda o preço de um artigo referenciado pelo código, ou seja, altera o preço
no ficheiro artigos, caso o comando seja válido.
   - Informa o servidor de vendas desta mudança. */
void mudarPreco (char* input, char** comando) {
	criarPasta();
	int fdArt = open(ARTIGOS, O_CREAT | O_RDWR, 0666);
	if (fdArt < 0) crash(0);

	int cod      = atoi(comando[1]) - 1;
	double preco = atof(comando[2]);
	
	if (validarInputPreco(cod,preco,comando)) {
		writePreco(fdArt,cod,preco);
		enviarPrecoSV(cod+1,preco);
	}
	
	else writeComando(input,0);
	
	close(fdArt);
}

/* - Envia uma mensagem ao sv por uma named pipe para executar o agregador.
   - Recebe as vendas agregadas por uma named pipe e manda-as para o sv. */
void chamarAgregador() {
	if (!abrirPipeSV()) {
		mkfifo(PIPEMAAG,0666);
		int pipe = open(PIPEMAAG, O_RDWR);
		writeToPipe(DIRPIPES,"a\n");

		char* buf = malloc(STRING);

		while (readline(pipe,buf)) {
			writeToPipe(DIRPIPES,buf);
			if (!strcmp(buf,ENDOFFILE)) break;
		}

		free(buf);
		close(pipe);
		unlink(PIPEMAAG);
	}
}

/* Recebe uma linha do ficheiro comandos_ma e executa a ação especificada.
Caso seja um comando inválido, imprime uma mensagem de erro para stderr. */
int main () {
    char* buf = malloc(STRING);
    char* input = malloc(STRING);
    int n;

    while ((n = readline(0,buf))) {
    	if (n == STRING) writeComando(buf,1);
    	else {
	    	strcpy(input,buf);
    	    char** comando = separarComando(buf,&n);
    	    
    	    if (!n);
    	    else if (n == 1 && !strcmp(comando[0],"a")) chamarAgregador();
    	    else if (n != 3 || strlen(comando[0]) != 1) writeComando(input,0);
    	    else {
	        	switch (comando[0][0]) {
    	        	case 'i': inserirArtigo(input,comando); break;
	    	        case 'n': mudarNome(input,comando);     break;
    	    	    case 'p': mudarPreco(input,comando);    break;
        	    	default : writeComando(input,0);        break;
        		}
        	}
    	    freeComando(comando,n);
        }
    }
    free(buf);
    free(input);
    return 0;
}