#ifndef ___ESTADO_H___
#define ___ESTADO_H___

/**
@file estado.h
Definição do estado e do valor
*/
#include <stdio.h>

/** 
\brief Tamanho máximo da grelha 
*/
#define MAX_GRID		20

/** 
\brief Valores que cada casa pode ter
*/
typedef enum {BLOQUEADA, FIXO_X, FIXO_O, VAZIA, SOL_X, SOL_O, AJUDA, ANCORA} VALOR;

/** @struct estado
* @brief Estrutura que armazena o estado do jogo
* @var estado :: num_lins 
* Número de linhas da grelha
* @var estado :: num_cols 
* Número de colunas da grelha
* @var estado :: grelha[MAX_GRID][MAX_GRID] 
* Grelha (tabuleiro) de dimensão máxima MAX_GRID^2
* @var estado :: validade 
* Indica se o estado é válido ou não
* @var estado :: inval 
* Indica em que sentido é o que o puzzle é inválido - vertical, horizontal, etc
* @var estado :: pos1 
* Linha da primeira posição inválida (ou coluna no caso da vertical)
* @var estado :: pos2 
* Coluna da primeira/última posição inválida (ou linha no caso da vertical)
*/
typedef struct estado {
	char num_lins;
	char num_cols;
	char grelha[MAX_GRID][MAX_GRID];
	char validade; 
	char inval; 
	char pos1; 
	char pos2; 
} ESTADO; 

/** 
\brief Mesmo que a struct estado
*/
typedef struct estado ESTADO;

#endif