#ifndef COD_PARTILHADO_H
#define COD_PARTILHADO_H

/* Definição de um tipo booleano. */
typedef enum {false=0, true=1} Boolean;

/* Definição de variáveis globais importantes. */
#define DIRPIPES  "Pipes/pipe"
#define PIPEMAAG  "Pipes/pipemaag"
#define PIPESVAG  "Pipes/pipesvag"
#define DIRFILES  "Ficheiros"
#define DIRAGREG  "Dados_Agregados"
#define DIRVENDAS "Dados_Vendas"
#define ARTIGOS   "Ficheiros/artigos"
#define STRINGS   "Ficheiros/strings"
#define INFO      "Ficheiros/info"
#define STOCKS    "Ficheiros/stocks"
#define VENDAS    "Ficheiros/vendas"
#define NOVO      "Ficheiros/novo"

#define AGREGADOR  "Dados das vendas agregados.\n"
#define COMANDO    "Comando inválido.\n"
#define ENDOFFILE  "EOF\n"

#define PARAMETRO    100
#define STRINGMAIOR	 1100
#define STRING       1024

#define CODIGO       7
#define POSICAO      9
#define PARTEFRAC    2
#define PRECOINT     4
#define PRECO        PRECOINT+1+PARTEFRAC
#define RECEITASINT  9
#define MONTANTEINT  15
#define STOCK        5
#define QTDTOTAL	 10
#define CACHE		 250

#define MAXPOSICAO   1000000000
#define MAXCODIGO    10000000
#define MAXSTOCK     100000
#define MAXPRECO     10000

#define OFFSETSTOCK  CODIGO+1
#define OFFSETPRECO  CODIGO+1
#define OFFSETPOS    OFFSETPRECO+PRECO+1
#define OFFSETMONT   OFFSETSTOCK+STOCK+1
#define OFFSETCONT   POSICAO+1

#define LINHAARTIGOS 26
#define LINHASTOCKS  14
#define LINHAVENDAS  27


/* Protótipos das funções. */
Boolean isInt (char* x);
Boolean isDouble (char* x);
char* intToString (int x, int flag, int len);
char* doubleToString (double str, int flag, int len);

int readStock (int fdS, int cod);
double readPreco (int cod);
int readPos (int fdArt, int linha, int flag);
int readline (int fd, char* buf);

char** separarComando (char* comando, int *ncampos);
void freeComando (char** comando, int n);
void criarPasta ();
int abrirPipeSV ();

#endif