#ifndef FACTURACAO_H
#define FACTURACAO_H

#include "Vendas.h"

/*Structs*/
/*Declaração da struct VFact*/
typedef struct vfact* VFact;
/*Declaração da struct Cat_VFacts*/
typedef struct cat_vfacts* Cat_VFacts;

/*Operações sobre VFacts (vendas da faturação)*/
int comparaVFacts (VFact v1, VFact v2);
VFact criaVFact (Venda v);
void free_VFact (VFact v);

/*Operações sobre Cat_VFacts*/
Cat_VFacts init_CatVFacts ();
void free_CatVFacts (Cat_VFacts f);
Cat_VFacts insereVFact (Cat_VFacts f, VFact v, int m);

/*Getters e setters*/
Cat_VFacts incTotalVendas (Cat_VFacts c);
int getTotalVendas (Cat_VFacts c);
int getValVendas (Cat_VFacts c, int x, int y);
double getFact(VFact f);
AVL getAVLFact (Cat_VFacts f, int m);

/*Queries*/
q3* vendasFaturPorTipo (q3* q, VFact v, char* p, int n);
double factTotalQ8 (Cat_VFacts f, int x ,int y);

#endif
