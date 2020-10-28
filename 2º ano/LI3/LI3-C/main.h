#ifndef CATALOGOS_H
#define CATALOGOS_H

#include "CatProds.h"
#include "CatClis.h"
#include "Facturacao.h"
#include "Filial.h"

/*Definição de macros úteis para este módulo*/
#define STRP 8 
#define STRC 7 
#define STRV 32
#define NRLETRAS 26 /*nº letras alfabeto*/
#define NRMESES 12

#define FILEP "Ficheiros/Produtos.txt"
#define FILEC "Ficheiros/Clientes.txt"
#define FILEV "Ficheiros/Vendas_1M.txt"

/*Definição da struct SGV que representa o Sistema de Gestão de Vendas*/
typedef struct sgv {
	Cat_Prods catp;
	Cat_Clis catc;
	Cat_VFacts catvfact;
	Cat_VFils catvfil;
} *SGV;

/*Operações sobre SGV*/
SGV init_SGV ();
void free_SGV (SGV sgv);
SGV lerFicheiros ();

#endif