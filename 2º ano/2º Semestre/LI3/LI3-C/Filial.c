#include <stdlib.h>
#include <string.h>
#include "AVLTrees.h"
#include "Filial.h"
#include "CatProds.h"
#include "CatClis.h"
#define _GNU_SOURCE
#include <string.h>

/*Structs*/
/*Definição da struct PCFil que possui os parâmetros de 
 uma venda relevantes ao módulo das filiais*/
struct pcfil {
	Produto  produto;  	
	double   preco;   
	int      unidades; 
	char     tipo;      
	int      mes;      
};

/*Definição da struct VFil que associa um conjunto de PCFils a um cliente*/
struct vfil {    
	Cliente cliente;
	AVL prodsc;      
};

/*Definição da struct Cat_VFils que representa um catálogo de VFils*/
struct cat_vfils {
	AVL* fils; 
};


/*Operações sobre PCFils*/
/*Compara os códigos de produtos de dois PCFils*/
int comparaPCFils (PCFil f1, PCFil f2) {
	return strcmp(getProd(f1->produto),getProd(f2->produto));
}

/*Cria um PCFil a partir de uma venda*/
PCFil criaPCFil (Venda v) {
	PCFil f = malloc(sizeof(struct pcfil));

	f->produto = criaProd(v.produto);
	f->preco = v.preco;
	f->unidades = v.unidades;
	f->tipo = v.tipo;
	f->mes = v.mes;
	return f;
}

/*Liberta a memória alocada por um PCFil*/
void free_PCFil (PCFil f) {
	free_Prod(f->produto);
	free(f);
}


/*Operações sobre VFils*/
/*Compara os códigos de clients de duas VFils*/
int comparaVFils (VFil f1, VFil f2) {
	return strcmp(getCli(f1->cliente),getCli(f2->cliente));
}

/*Cria uma VFil a partir de um código de cliente*/
VFil criaVFil (char* cliente) {
	VFil f = malloc(sizeof(struct vfil));

	f->cliente = criaCli(cliente);
	f->prodsc = malloc(sizeof(struct avl));
	f->prodsc = NULL;

	return f;
}

/*Liberta a memória alocada por uma VFil*/
void free_VFil (VFil v) {
	free_Cli(v->cliente);
	free_AVL(v->prodsc,'f');
	free(v);
}

/*Insere um PCFil numa VFil*/
VFil inserePCFil (VFil v, PCFil pc) {
	int aum = 0;
	v->prodsc = insereAVL(v->prodsc,pc,&aum,'f');
	return v;
}


/*Operações sobre Cat_VFils*/
/*Inicializa um Cat_VFils*/
Cat_VFils init_CatVFils () {
	Cat_VFils f = malloc(sizeof(struct cat_vfils));
	f->fils = malloc(3* sizeof(struct avl));
	
	for (int i = 0; i < 3; i++)
		f->fils[i] = NULL;
	return f;
}

/*Liberta a memória alocada por um Cat_VFils*/
void free_CatVFils (Cat_VFils f) {
	for (int i = 0; i < 3; i++)
		free_AVL(f->fils[i],'i');
	free(f->fils);
	free(f);
}

/*Insere um PCFil num Cat_VFils, através de uma VFil nova ou já existente*/
Cat_VFils insereVFil (Cat_VFils f, VFil v, PCFil pc, int nf) {
	int aum = 0;
	f->fils[nf] = insereAVLFil(f->fils[nf],v,pc,&aum);
	return f;
}


/*Getters e Setters*/
/*Devolve a AVL ordenada por códigos de clientes 
 de um Cat_VFils correspondente à filial dada*/
AVL getAVLFil (Cat_VFils catvf, int i) {
	return catvf->fils[i];
}

/*Devolve a AVL ordenada por códigos de produtos de uma VFil*/
AVL getAVLVFil (VFil vfil) {
	return vfil->prodsc;
}

/*Devolve o Cliente de uma VFil*/
Cliente getCliFil (VFil f) {
	return f->cliente;
}

/*Devolve o código de cliente de uma VFil*/
char* getCliFil2 (VFil f) {
	return getCli(f->cliente);
}

/*Devolve o mês de um PCFil*/
int getMesPCFil (PCFil p) {
	return p->mes;
}

/*Devolve as unidades de um PCFil*/
int getUniPCFil (PCFil p) {
	return p->unidades;
}

/*Devolve o código de produto de um PCFil*/
char* getProdPCFil (PCFil p) {
	return getProd(p->produto);
}

/*Devolve o tipo de venda de um PCFil*/
char getTipoPCFil (PCFil p) {
	return p->tipo;
}


/*Query 11*/
/*Insere um PCFil num Array_Fact*/
Array_Fact insereArrayFact (Array_Fact a, PCFil p, int i, int tipo) {
		if (tipo == 2) {
			a->prod[i] = strdup(getProd(p->produto));
			a->fact[i] = p->preco*p->unidades;
		}
		else if (tipo == 0) {
			a->prod[i]= strdup(getProd(p->produto));
			a->fact[i] = p->preco*p->unidades;
			a->num++;
		}
		if (tipo == 1) a->fact[i] += p->preco*p->unidades;;
	
	return a;
}

/*Calcula o índice do menor elemento de um array*/
int minFact (double* prod) {
	double min = prod[0];
   	int loc = 0;
    for (int c = 1; c < 3; c++) {
        if (prod[c] < min) {
           min = prod[c];
           loc = c;
        }
    }
	return loc;
}

/*Compara os códigos de produtos de um Array_Fact e de um PCFil
 a fim de determinar o tipo de inserção a realizar*/
Array_Fact comparaArrayFact (Array_Fact a, PCFil p) {
	for (int i = 0; i < a->num; i++) {
		if (!strcmp(getProd(p->produto),a->prod[i])) 
			return insereArrayFact(a,p,i,1);
	}
	if (a->num < 3) return insereArrayFact(a,p,a->num,0);
	
	double r = p->unidades*p->preco;
	if (r > a->fact[0] || r > a->fact[1] || r > a->fact[2])
		return insereArrayFact(a,p,minFact(a->fact),2);

	return a;
}

/*Passa os parâmetros da PCfil para uma estrutura Prod_Uni*/
Prod_Uni pcfilToProdUni(PCFil f,char* cliente){
	Prod_Uni pu = initProdUni();
	pu->clientes[0]=strdup(cliente);
	pu->prod = strdup(getProd(f->produto));
	pu->uni = f->unidades;
	pu->clis++;

	return pu;
}