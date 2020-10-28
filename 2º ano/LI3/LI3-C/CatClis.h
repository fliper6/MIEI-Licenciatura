#ifndef CATCLIS_H
#define CATCLIS_H

#include "AVLTrees.h"

/*Structs*/
/*Declaração da struct Cliente*/
typedef struct cli* Cliente;
/*Declaração da struct Cat_Clis*/
typedef struct cat_clis* Cat_Clis;


/*Protótipos*/

/*Operações sobre clientes*/
Boolean validaCliente (char* cliente);
Cliente criaCli (char* codProd);
void free_Cli (Cliente c);
int comparaClis (Cliente c1, Cliente c2);

/*Operações sobre Cat_Clis*/
Cat_Clis inicializa_CatClis ();
void free_Catc (Cat_Clis catc);
Cat_Clis insereCli (Cat_Clis catc, Cliente c);
Boolean existeCli (Cat_Clis catc, Cliente c);
Cat_Clis mudaFlagCli (Cat_Clis catc, Cliente c, int fil);

/*Getters e setters*/
Cliente setFlagCli (Cliente c, int fil);
Cat_Clis incTotalClis (Cat_Clis catc);
AVL getAVLClis (Cat_Clis catc);
int getTotalClis (Cat_Clis catc);
int getValClis (Cat_Clis catc);
char* getCli (Cliente c);
int getFlagC (Cliente c);

#endif