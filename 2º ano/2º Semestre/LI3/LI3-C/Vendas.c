#include "Vendas.h"
#include <stdlib.h>
#define _GNU_SOURCE
#include <string.h>

/*Cria uma venda a partir de um código de venda*/
Venda mkVenda (char* strVenda) { 
	char** campos = (char**) malloc(7 * sizeof(char*));
	Venda* venda  = (Venda*) malloc(sizeof(struct venda));
	int i = 0;

	char* token = strtok(strVenda," ");
	while (token) {
		campos[i++] = strdup(token);
		token = strtok(NULL," ");
	}

	venda->produto  = strdup(campos[0]);
	venda->preco    = atof(campos[1]);
	venda->unidades = atoi(campos[2]);
	venda->tipo     = campos[3][0];
	venda->cliente  = strdup(campos[4]);
	venda->mes      = atoi(campos[5]);
	venda->filial   = atoi(campos[6]);

	free(campos);
	return *venda;
}

/*Valida uma venda*/
Boolean validaVenda (Venda v, Cat_Prods catp, Cat_Clis catc) { 
	if (!existeProd(catp,criaProd(v.produto)))   return false;
	if (!existeCli(catc,criaCli(v.cliente)))     return false;
	
	if (!(v.preco >= 0 && v.preco <= 999.99))    return false;
	if (!(v.unidades >= 1 && v.unidades <= 200)) return false;
	if (!(v.tipo == 'P' || v.tipo == 'N'))       return false;
	if (!(v.mes >= 1 && v.mes <= 12))            return false;
	if (!(v.filial >= 1 && v.filial <= 3))    	 return false;

	return true;
}