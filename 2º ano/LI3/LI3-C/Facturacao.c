#include <stdlib.h>
#include <string.h>
#include "AVLTrees.h"
#include "Facturacao.h"
#include "CatProds.h"

/*Structs*/
/*Definição da struct VFact que possui os parâmetros de 
 uma venda relevantes ao módulo da faturação*/
struct vfact {
	Produto produto;  /* AB1234*/
	double  preco;    /* 0.0 - 999.99*/
	int     unidades; /* 1 - 200*/
	char    tipo;     /* P ou N*/
	int     filial;   /* 1 - 3*/
};

/*Definição da struct Cat_VFacts que representa um catálogo de VFacts*/
struct cat_vfacts {	/*array de 12 avls(meses) de produtos ordenados*/
	int totalVendas;
	int* vendasValidas;
	AVL* mes;
};


/*Operações sobre VFacts*/
/*Compara os códigos de produto de dois VFacts*/
int comparaVFacts (VFact v1, VFact v2) {
	return strcmp(getProd(v1->produto),getProd(v2->produto));
}

/*Cria uma VFact a partir de uma venda*/
VFact criaVFact (Venda v) {
	VFact f = malloc(sizeof(struct vfact));

	f->produto = criaProd(v.produto);
	f->preco = v.preco;
	f->unidades = v.unidades;
	f->tipo = v.tipo;
	f->filial = v.filial;

	return f;
}

/*Liberta a memória alocada por uma VFact*/
void free_VFact (VFact v) {
	free_Prod(v->produto);
	free(v);
}


/*Operações sobre Cat_VFacts*/
/*Inicializa um Cat_VFacts*/
Cat_VFacts init_CatVFacts () {
	Cat_VFacts f = malloc(sizeof(struct cat_vfacts));
	f->mes = malloc(12 * sizeof(struct avl));
	f->vendasValidas = malloc(12 * sizeof(int));

	for (int i = 0; i < 12; i++) {
		f->mes[i] = NULL;
		f->vendasValidas[i] = 0;
	}
	f->totalVendas = 0;
	return f;
}

/*Liberta a memória alocada por um Cat_VFacts*/
void free_CatVFacts (Cat_VFacts f) {
	for (int i = 0; i < 12; i++) {
		free_AVL(f->mes[i],'a');
	}
	free(f->mes);
	free(f->vendasValidas);
	free(f);
}

/*Insere um VFact num Cat_VFacts*/
Cat_VFacts insereVFact (Cat_VFacts f, VFact v, int m) {
	int aum = 0;
	f->mes[m] = insereAVL(f->mes[m],v,&aum,'a');
	f->vendasValidas[m]++;
	return f;
}


/*Getters e setters*/
/*Incrementa o número total de vendas de um Cat_VFacts*/
Cat_VFacts incTotalVendas (Cat_VFacts c) {
	c->totalVendas++;
	return c;
}

/*Devolve o número total de vendas de um Cat_VFacts*/
int getTotalVendas (Cat_VFacts c) {
	return c->totalVendas;
}

/*Calcula o número de vendas válidas entre dois meses*/
int getValVendas (Cat_VFacts c, int x, int y) {
	int val = 0;
	for (int i = x-1; i < y; i++)
		val += c->vendasValidas[i];
	return val;
}

/*Devolve o total faturado com a venda a partir da qual se criou o VFact*/
double getFact (VFact f) {
	return (f->unidades*f->preco);
}

/*Devolve a AVL dos VFacts correspondente a um mês*/
AVL getAVLFact (Cat_VFacts f, int m) {
	return f->mes[m];
}


/*Q3*/
/*Coloca numa struct q3 o número de vendas e o total
 faturado com um produto, por tipo de venda*/
q3* vendasFaturPorTipo (q3* q, VFact v, char* p, int n) {
	int fil;
	if (n == 1) fil = 0;
	if (n == 3) fil = v->filial-1;
	if (!strcmp(getProd(v->produto),p)) {
		if (v->tipo == 'N') {
			q[fil]->vendasN++;
			q[fil]->faturadoN += v->unidades*v->preco;
		}
		if (v->tipo == 'P') {
			q[fil]->vendasP++;
			q[fil]->faturadoP += v->unidades*v->preco;
		}
	}
	return q;
}

/*Q8*/
/*Calcula o total faturado entre dois meses*/
double factTotalQ8 (Cat_VFacts f, int x ,int y) {
	double r=0;
	for (int i = x-1; i < y; ++i)
		r+=totalVendasAVL(f->mes[i]);
	return r;
}