#ifndef ___VERIFICA_H___
#define ___VERIFICA_H___

/**
@file valida.h
Funções utilizadas no ficheiro valida.h documentadas 
*/ 

#include <stdio.h>
#include "estado.h"

/**
Função que verifica se o tabuleiro está cheio, isto é, se nenhuma das suas casa está vazia ou tem uma ajuda/âncora
@param e estado a verificar
@returns 1 se o tabuleiro não estiver cheio
@returns 0 se o tabuleiro estiver preenchido
*/
int tabCheio (ESTADO e);

/**
Função que verifica a validade das linhas/colunas do puzzle, comparando todas as 3 casas consecutivas no sentido em questão que encontrar
@param i número de linhas/colunas do puzzle, dependendo da direção em que se está a verificar
@param val[] array com todos os valores da linha/coluna atual
@param *pos endereço de um inteiro em que se vai retornar a linha/coluna da terceira casa inválida, caso o puzzle esteja inválido
@returns 1 se alguma linha/coluna do puzzle for inválida, com a posição da primeira peça inválida no terceiro argumento
@returns 0 se todas as linhas/colunas do puzzle estiverem válidas
*/
int verLC (int i, VALOR val[], int *pos);

/**
Função que verifica a validade das diagonais do puzzle, comparando todas as 3 casas consecutivas na diagonal que encontrar
@param *e endereço do estado a verificar, no qual se vão retornar os dados das peças inválidas, caso seja necessário
@param i linha da primeira peça a verificar
@param j coluna da primeira peça a verificar
@param dir direção da diagonal segundo a qual verificar o puzzle
@param prox distância relativa na vertical da próxima peça a verificar
@returns 1 se alguma diagonal do puzzle for inválida, com os dados das peças em questão no estado dado como argumento
@returns 0 se todas as diagonais do puzzle estiverem válidas
*/
int diagonais (ESTADO *e, int i, int j, char dir, int prox);

/**
Função responsável pelos ciclos segundos os quais se vai percorrer o tabuleiro para verificar as diagonais
@param *e endereço do estado a verificar, no qual se vão retornar os dados das peças inválidas, caso seja necessário
@param tamJ número de colunas a percorrer no ciclo
@param tamI número de linhas a percorrer no cico
@param dir direção da diagonal segundo a qual verificar o puzzle
@returns 1 se alguma diagonal do puzzle for inválida
@returns 0 se todas as diagonais do puzzle estiverem válidas
*/
int ciclosDiag (ESTADO *e, int tamJ, int tamI, char dir);

/**
Função responsável pelos ciclos segundos os quais se vai percorrer o tabuleiro para verificar as linhas e as colunas
@param *e endereço do estado a verificar, no qual se vão retornar os dados das peças inválidas, caso seja necessário
@param tamI número de linhas do puzzle, caso se esteja a verificar na horizontal, ou colunas caso seja na vertical
@param tamJ número de colunas do puzzle, caso se esteja a verificar na horizontal, ou linhas caso seja na vertical
@param dir direção segundo a qual verificar o puzzle, horizontal ou vertical
@returns 1 se alguma linha/coluna do puzzle for inválida, com os dados das peças em questão no estado dado como argumento
@returns 0 se todas as linhas e colunas do puzzle estiverem válidas
*/
int horizVert (ESTADO *e, int tamI, int tamJ, char dir);

/**
Função que verifica a validade do jogo
@param *e endereço do estado a verificar, no qual se vão retornar os dados das peças inválidas, caso seja necessário
@returns 1 se o estado atual do puzzle for inválido
@returns 0 se o estado atual do puzzle for válido
*/
int verifica (ESTADO *e);

#endif