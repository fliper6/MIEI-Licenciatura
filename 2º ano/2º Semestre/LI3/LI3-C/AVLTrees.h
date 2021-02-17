#ifndef AVLTREES_H
#define AVLTREES_H

#include "Navegador.h"

/*Definição de um tipo booleano*/
typedef enum {false=0, true=1} Boolean;

/*Definição da struct AVL*/
typedef struct avl {
	void* info;
	int bal;
	struct avl *esq, *dir;
} *AVL;

/*Definição da struct q3 usada na query 3*/
typedef struct strq3 {
	int vendasN;
	int vendasP;
	double faturadoN;
	double faturadoP;
} *q3;

/*Definição da struct Array_PU usada na query 10*/
typedef struct arr_pu {
	Lista_Strings prods;
	int* unis;
	int num;
} *Array_PU;

/*Definição da struct Prod_Uni usada na query 11*/
typedef struct prod_uni {
	char** clientes;
	char* prod;
	int uni;
	int clis;
} *Prod_Uni;

/*Definição da struct Array_Prod usada na query 11*/
typedef struct arr_prod {
	char** prod;
	int* uni;
	int* clis;
	int num;
} *Array_Prod;

/*Definição da struct Array_Fact usada na query 12*/
typedef struct arr_fact {
	char** prod;	/*prods*/
	double* fact;	/*fact por prod*/
	int num;		/*posiçao*/
} *Array_Fact;

/*Designação de certos inteiros para tornar mais percétivel
 o processo de balanceamento de árvores*/
#define Bal 0
#define Esq 1
#define Dir -1

/*Operações sobre AVLs*/
AVL inicializaAVL ();
void free_AVL (AVL a, char tipo);
AVL insereAVL (AVL a, void* str, int *aum, char tipo);
AVL insereAVLFil (AVL a, void* vfil, void* pcfil, int *aum);
AVL mudaFlagAVL (AVL a, void* str, char tipo, int fil);
Boolean lookupAVL (AVL a, void* str, char tipo);
void inorderAVL (AVL a, char tipo);

/*Queries*/
Lista_Strings prodsLetra (Lista_Strings l, AVL p);
q3* vendasFatur (q3* f, AVL a, char* p, int n);
Lista_Strings naoComprados (Lista_Strings l, AVL p, int fil);
Lista_Strings clisComuns (Lista_Strings l, AVL a);
int numNuncaComp (int a, AVL p, int l);
int** numMesFil (char* cod, int** tab, AVL f, int n);
int** atualizaTab (int** tab, AVL prods, int n);
double totalVendasAVL (AVL a);
Lista_Strings* clisCompramProd (Lista_Strings* l, AVL f, char* cod);

Array_PU init_PU ();
void free_PU (Array_PU a);
Lista_Strings ordenarLista (Lista_Strings l, Array_PU prodsUnis);
Array_PU percorreCli (AVL f, Array_PU prodsUnis, char* cod, int m);

Array_Fact init_Arrf();
void free_Arrf (Array_Fact a);
Array_Fact lookupCliente (char* cod, Array_Fact a, AVL f);

Array_Prod initArrP(int N);
void freeArrayProd (Array_Prod a);
Prod_Uni initProdUni();
AVL travessiaQ11Cli (AVL a, AVL f); 
AVL travessiaQ11Prod (AVL a,AVL prods,char* cliente);
AVL insereProdAVL (AVL a, void* str, int *aum);
Array_Prod prodsQ11 (Array_Prod a, AVL prods,int N);
AVL inserePAVL(AVL a,void* str);
Prod_Uni insereProdUni(Prod_Uni pu,Prod_Uni f,int tipo);
Array_Prod comparaMaisVenda(Array_Prod s,Prod_Uni a,int N);

#endif