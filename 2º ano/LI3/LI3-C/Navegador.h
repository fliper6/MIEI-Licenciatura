#ifndef NAVEGADOR_H
#define NAVEGADOR_H

/*Definição da struct Lista_Strings*/
typedef struct lst_str* Lista_Strings;

/*Operações sobre Lista_Strings*/
Lista_Strings init_Lista ();
Lista_Strings* init_arrLista ();
void freeLista (Lista_Strings l);
int getNumLista (Lista_Strings l);
char** getStringsLista (Lista_Strings l);
Lista_Strings insereLista (Lista_Strings l, char* cod);
void navegador (Lista_Strings l, char* frase);

#endif