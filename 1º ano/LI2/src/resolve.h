#ifndef ___RESOLVE_H___
#define ___RESOLVE_H___

/**
@file resolve.h
Funções utilizadas no ficheiro resolve.c documentadas 
*/

#include <stdio.h>
#include "estado.h"
#include "lista.h"
#include "ajudas.h"
#include "valida.h"

/** @struct jogada
* @brief Estrutura que armazena os dados de uma jogada
* @var jogada :: tipo 
* pode ser X ou O
* @var jogada :: linha 
* linha da jogada
* @var jogada :: coluna 
* coluna da jogada
*/
typedef struct jogada {
	char tipo; 
	int linha;
	int coluna; 
} Jogada;

/** 
\brief Mesmo que a struct jogada
*/
typedef struct jogada Jogada;

/** @struct passos
* @brief Estrutura que guarda os estados sem mais passos lógicos que encontra à medida que vai resolvendo o puzzle
* @var passos :: estado 
* estado sem mais passos lógicos
* @var passos :: jogada 
* jogada seguinte a fazer no estado em questão
* @var passos :: prox 
* apontador para o estado sem mais passos lógicos anterior
*/
typedef struct passos {
	ESTADO estado;
	Jogada jogada; 
	struct passos *prox;
} *Passos; 

/** 
\brief Apontador para lista de passos
*/
typedef struct passos *Passos;


/**
Função que verifica se o jogo acabou
@param e estado a verificar
@returns 0 se acabou
@returns 1 caso contrário
*/
int acabou (ESTADO e);

/**
Função que verifica se a casa cujas coordenadas são dadas como argumentos pode ser jogada ou não
@param lVazia inteiro que indica se a lista de passos atual está vazia ou não
@param i linha da peça atual
@param j coluna da peça atual
@param jog jogada onde estão guardadas as coordenadas da casa da jogada anterior
@returns 0 se puder ser jogada
@returns 1 caso contrário
*/
int pAnt (int lVazia, int i, int j, Jogada jog);

/**
Função que calcula a pŕoxima jogada a efetuar no estado em questão, tendo em conta a última jogada efetuada
@param e estado para o qual se vai calcular a próxima jogada
@param jog jogada onde se vai guardar a próxima jogada a efetuar
@param lVazia inteiro que indica se a lista de passos atual está vazia ou não
@returns próxima jogada
*/
Jogada proxJogada (ESTADO e, Jogada jog, int lVazia);

/**
Função que adicona um novo elemento à lista de passos
@param l lista de passos atual
@param e novo estado a colocar na lista de passos
@returns lista de passos atualizada
*/
Passos novoPasso (Passos l, ESTADO e);

/**
Função que efetua a jogada dada no estado dado
@param e estado em que vai ser efetuada a jogada
@param jog jogada a efetuar
@returns estado atualizado com a jogada já feita
*/
ESTADO fazJogada (ESTADO e, Jogada jog);

/**
Função que retira o elemento mais recente da lista de passos e atualiza a jogada do elemento seguinte
@param *l endereço da lista de passos atual
@returns estado do novo elemento à cabeça da lista com a jogada correspondente efetuada, antes de a atualizar
*/
ESTADO recuaPasso (Passos *l);

/**
Função que realiza todos os passos lógicos possíveis, até chegar a um estado inválido ou até não existirem mais passos lógicos
@param *e endereço do estado com a jogada do último elemento da lista de passos efetuada, que vai ser atualizado à medida que são efetuados passos lógicos
@param *p endereço da lista de estados atual, onde são postos todos os estados da lista de passos, além dos estados entre estes
@returns 1 se chegar um estado inválido
@returns 0 se não existirem mais passos lógicos
*/
int pLogicos (ESTADO *e, LInt *p);

/** 
Função que realiza a jogada do elemento mais recente da lista de passos e todos os passos lógicos possíveis a partir desse novo estado
@param l lista de passos atual
@param *p lista de estados atual
@returns lista de passos atualizada 
*/
Passos resolve (Passos l, LInt *p);

/**
Função que resolve o puzzle (caso seja possível)
@param p lista de estados atual, cujo estado mais recente não tem mais passos lógicos a efetuar
@returns lista de estados atualizada com os estados correspondentes a todas as jogadas que efetuou até acabar o puzzle
*/
LInt resolveFinal (LInt p);

#endif