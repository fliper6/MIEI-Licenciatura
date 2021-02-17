#ifndef VENDAS_H
#define VENDAS_H

#include "CatProds.h"
#include "CatClis.h"
#include "AVLTrees.h"

/*Definição da struct Venda usada na leitura do ficheiro de vendas*/
typedef struct venda {
	char*  produto;  /* AB1234*/
	double preco;    /* 0.0 - 999.99*/
	int    unidades; /* 1 - 200*/
	char   tipo;     /* P ou N*/
	char*  cliente;  /* A1234*/
	int    mes;      /* 1 - 12*/
	int    filial;   /* 1 - 3*/
} Venda;

Venda mkVenda (char* strVenda);
Boolean validaVenda (Venda v, Cat_Prods catp, Cat_Clis catc);

#endif