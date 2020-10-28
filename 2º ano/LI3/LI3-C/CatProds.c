#include <stdlib.h>
#define _GNU_SOURCE
#include <string.h>
#include <ctype.h>
#include "CatProds.h"

/*Definição de um macro com o número de letras do alfabeto*/
#define NRLETRAS 26 


/*Structs*/
/*Definição da struct Produto*/
struct prod {
	char* codProd;
	int flag;
};

/*Definição da struct Cat_Prods que representa um catálogo de produtos*/
struct cat_prods {
	int validos;
	int total;
	AVL* prods;
};


/*Operações sobre produtos*/
/*Valida um código de produto*/
Boolean validaProduto (char* produto) {	/* devolve 1 quando o produto é válido*/
	for (int i = 0; i < 2; i++) 
		if (!isupper(produto[i])) return false; 
	for (int i = 2; i < 6; i++) 
		if (!isdigit(produto[i])) return false;
	if (produto[2] == '0') return false;	/* os números só podem ser de 1000 a 9999 logo o primeiro algarismo não pode ser 0*/
	return true;
}


/*Cria um Produto a partir de um código de produto*/
Produto criaProd (char* codProd) {
	Produto p = malloc(sizeof(struct prod));
	p->codProd = strdup(codProd);
	p->flag = 0;
	return p;
}

/*Liberta a memória alocada por um Produto*/
void free_Prod (Produto p) {
	free(p->codProd);
	free(p);
}

/*Compara os códigos de produto de dois Produtos*/
int comparaProds (Produto p1, Produto p2) {
	return strcmp(p1->codProd,p2->codProd);
}


/*Operações sobre Cat_Prods*/
/*Inicializa um Cat_Prods*/
Cat_Prods inicializa_CatProds () {
	Cat_Prods catp = malloc(sizeof(struct cat_prods));
	catp->prods = malloc(NRLETRAS * sizeof(struct avl));
	
	for (int i = 0; i < NRLETRAS; i++)
		catp->prods[i] = NULL;
	catp->validos = 0;
	catp->total = 0;
	return catp;
}

/*Liberta a memória alocada por um Cat_Prods*/
void free_Catp (Cat_Prods catp) {
	for (int i = 0; i < NRLETRAS; i++)
		free_AVL(catp->prods[i],'p');
	free(catp->prods);
	free(catp);
}

/*Insere um Produto num Cat_Prods*/
Cat_Prods insereProd (Cat_Prods catp, Produto p) {
	int aum = 0, i = p->codProd[0]-'A';
	catp->prods[i] = insereAVL(catp->prods[i],p,&aum,'p');
	catp->validos++;
	return catp;
}

/*Verifica se um Produto existe num Cat_Prods*/
Boolean existeProd (Cat_Prods catp, Produto p) {
	return lookupAVL(catp->prods[p->codProd[0]-'A'],p,'p');
}

/*Procura um Produto num Cat_Prods e muda a sua flag*/
Cat_Prods mudaFlagProd (Cat_Prods catp, Produto p, int fil) {
	catp->prods[p->codProd[0] - 'A'] = mudaFlagAVL(catp->prods[p->codProd[0]-'A'],p,'p',fil);
	return catp;
}


/*Getters e setters*/
/*Muda a flag de um Produto conforme as filiais em que tenha sido comprado*/
/*1 - F1, 2 - F2, 3 - F3, 4 - F1+F2, 5 - F1+F3, 6 - F2+F3, 7 - F1+F2+F3*/
Produto setFlagProd (Produto p, int fil) {
	if (p->flag == 0) p->flag = fil;
	else if (fil == 1) {
		if (p->flag == 2) p->flag = 4;
		if (p->flag == 3) p->flag = 5;
		if (p->flag == 6) p->flag = 7;
	}
	else if (fil == 2) {
		if (p->flag == 1) p->flag = 4;
		if (p->flag == 3) p->flag = 6;
		if (p->flag == 5) p->flag = 7;
	}
	else if (fil == 3) {
		if (p->flag == 1) p->flag = 5;
		if (p->flag == 2) p->flag = 6;
		if (p->flag == 4) p->flag = 7;
	}
	return p;
}

/*Incrementa o número total de produtos de um Cat_Prods*/
Cat_Prods incTotalProds (Cat_Prods catp) {
	catp->total++;
	return catp;
}

/*Devolve a AVL ordenada por códigos de produtos 
 dos produtos começados por determinada letra*/
AVL getAVLProds (Cat_Prods catp, int i) {
	return catp->prods[i];
}

/*Devolve o número total de produtos de um Cat_Prods*/
int getTotalProds (Cat_Prods catp) {
	return catp->total;
}

/*Devolve o número de produtos válidos de um Cat_Prods*/
int getValProds (Cat_Prods catp) {
	return catp->validos;
}

/*Devolve o código de produto de um Produto*/
char* getProd (Produto p) {
	return p->codProd;
}

/*Devolve a flag de um Produto*/
int getFlagP (Produto p) {
	return p->flag;
}