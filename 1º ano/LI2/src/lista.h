#ifndef ___LISTA_H___
#define ___LISTA_H___

/**
@file lista.h
Funções utilizadas no ficheiro lista.c documentadas 
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "estado.h"


/**@struct lista
* @brief Estrutura que armazena os estados do jogo
* @var lista :: estado 
* estado do jogo
* @var lista :: prox 
* apontador para o próximo estado (isto é, o estado da jogada anterior)
*/
typedef struct lista {
	ESTADO estado;
	struct lista *prox;
} *LInt;

/** 
\brief Apontador para uma lista 
*/
typedef struct lista *LInt;

/**
Função que compara estados
@param e1 primeiro estado a comparar
@param e2 segundo estado a comparar
@returns 1 se os estados forem iguais
@returns 0 se os estados forem diferentes
*/
int compEstados (ESTADO e1, ESTADO e2);

/**
Função que adiciona um estado à lista
@param l lista com os estados do jogo
@param e novo estado (atual) a adicionar à lista
@returns lista atualizada com o novo estado à cabeça
*/
LInt pushL (LInt l, ESTADO e);

/**
Função que adiciona um estado à lista. Retorna a lista atualizada na lista dada como argumento
@param *l endereço da lista com os estados do jogo
@param e novo estado (atual) a adicionar à lista
*/
void pushL2 (LInt *l, ESTADO e);

/**
Função que retira o estado mais recente à lista
@param l lista com os estados do jogo
@returns lista atualizada sem o estado em questão
*/
LInt popL (LInt l);

/**
Função que retira da lista todos os estados posteriores ao estado dado como argumento e também este mesmo
@param *el endereço da lista com os estados do jogo
@param e estado até ao qual se vai retroceder na lista, e também apagar de lá
*/
void popEmMassa (LInt *el, ESTADO e);

/**
Função que inverte a lista
@param l lista invertida com os estados do jogo
@returns lista invertida
*/
LInt revL (LInt l);

/**
Função que retrocede na lista até encontrar encontrar o estado dado como argumento
@param l lista com os estados do jogo
@param e estado até ao qual se vai retroceder na lista
@returns lista atualizada sem os estados posteriores ao estado dado 
*/
LInt ancoraLista (LInt l, ESTADO e);

/**
Função que calcula o comprimento da lista
@param l lista com os estados do jogo
@returns comprimento lista
*/
int listlen (LInt l);

/**
Função que lê a lista de um ficheiro txt
@param s[] nome do ficheiro onde está guardada a lista
@returns lista do ficheiro
*/
LInt txt2lista (char s[]);

/**
Função que escreve a lista dada no ficheiro txt correspondente
@param l lista com os estados do jogo
@param nr número do puzzle atual
@param *user nome do utilizador que está a jogar
*/
void lista2txt (LInt l, int nr, char *user);

#endif