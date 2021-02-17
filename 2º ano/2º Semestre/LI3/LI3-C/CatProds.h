#ifndef CATPRODS_H
#define CATPRODS_H

#include "AVLTrees.h"

/*Structs*/
/*Declaração da struct Produto*/
typedef struct prod* Produto;
/*Declaração da struct Cat_Prods*/
typedef struct cat_prods* Cat_Prods;


/*Protótipos*/

/*Operações sobre produtos*/
Boolean validaProduto (char* produto);
Produto criaProd (char* codProd);
void free_Prod (Produto p);
int comparaProds (Produto p1, Produto p2);

/*Operações sobre Cat_Prods*/
Cat_Prods inicializa_CatProds ();
void free_Catp (Cat_Prods catp);
Cat_Prods insereProd (Cat_Prods catp, Produto p);
Boolean existeProd (Cat_Prods catp, Produto p);
Cat_Prods mudaFlagProd (Cat_Prods catp, Produto p, int fil);

/*Getters e setters*/
Produto setFlagProd (Produto p, int fil);
Cat_Prods incTotalProds (Cat_Prods catp);
AVL getAVLProds (Cat_Prods catp, int i);
int getTotalProds (Cat_Prods catp);
int getValProds (Cat_Prods catp);
char* getProd (Produto p);
int getFlagP (Produto p);

#endif