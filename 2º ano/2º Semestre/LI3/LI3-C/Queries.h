#ifndef QUERIES_H
#define QUERIES_H

#include "AVLTrees.h"
#include "CatProds.h"
#include "CatClis.h"
#include "Facturacao.h"
#include "Filial.h"
#include "Navegador.h"
#include "main.h"

/*Funções para apresentar as queries ao utilizador*/
SGV escolheQuerie (SGV sgv, char* buffer);
void menu ();
void loopQueries (SGV sgv);

/*Queries*/
SGV  query1 (SGV sgv);
void query2 (Cat_Prods p);
void query3 (SGV sgv);
void query4 (Cat_Prods p);
void query5 (Cat_Clis c);
void query6 (SGV sgv);
void query7 (SGV sgv);
void query8 (Cat_VFacts f);
void query9 (SGV sgv);
void query10(SGV sgv);
void query11(SGV sgv);
void query12(SGV sgv);

#endif