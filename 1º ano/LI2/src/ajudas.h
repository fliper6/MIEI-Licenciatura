#ifndef ___AJUDA_H___
#define ___AJUDA_H___

/**
@file ajudas.h
Funções utilizadas no ficheiro ajudas.c documentadas 
*/

#include <stdio.h>
#include "estado.h"
#include "lista.h"

/**
Função que verifica o valor da casa a ser mudada, para ver se tal operação é possível
@param acao ação a realizar (ajuda ou resolve)
@param v valor da casa em questão
@returns 1 quando se pode jogar na casa a ser mudada (é vazia no caso de ajudar ou vazia/ajuda no caso de resolver)
@returns 0 caso contrário
*/
int condicao (char acao, VALOR v);

/**
Função que compara valores para ver se põe um 'O' ou um 'X' na casa a ser mudada, ou se não faz nada
@param a valor da primeira peça
@param b valor da segunda peça
@param c valor da terceira peça
@param acao ação a realizar
@returns 1 quando for para meter um 'O' na casa a mudar
@returns 2 quando for para meter um 'X' na casa a mudar
@returns 0 caso não se verifique em nenhum dos casos anteriores
*/
int compV (VALOR a, VALOR b, VALOR c, char acao);

/**
Função que muda o valor da casa a ser mudada
@param *e endereço do estado atual, onde vai ser retornado o novo estado com a ajuda efetuada caso haja um passo lógico
@param cpV inteiro que indica qual o valor a colocar na casa
@param i linha da casa a alterar
@param j coluna da casa a alterar
*/
void mudaProx (ESTADO *e, int cpV, int i, int j);

/**
Função que ajuda a definir a posição da casa a ser mudada
@param valor número da casa vazia, de entre as 3 que estão a ser analisadas
@param dir direção em que se está a verificar o tabuleiro (horizontal, vertical, ...)
@param *ipos endereço de um inteiro em que vai ser retornada a distância na vertical da peça atual à primeira peça que está a ser estudada
@param *jpos endereço de um inteiro em que vai ser retornada a distância na horizontal da peça atual à primeira peça que está a ser estudada
*/
void posDir (int valor, char dir, int *ipos, int *jpos);

/**
Função que verifica se há um passo lógico a tomar ou não. Caso haja passo lógico, efetua-o e devolve o estado atualizado no argumento 'e'
@param *e endereço do estado atual, onde vai ser retornado o novo estado com a ajuda efetuada caso haja um passo lógico
@param i linha da primeira casa a ser comparada
@param j coluna da primeira casa a ser comparada
@param dir sentido em que se estão a comparar os valores das casas
@param acao ação a realizar
@returns 1 se houver passo lógico
@returns 0 se não houver passo lógico
*/
int acaoGeral (ESTADO *e, int i, int j, char dir, char acao);

/**
Função que escolhe os ciclos para percorrer o tabuleiro, dependendo da direção em que vai verificar 
@param e estado atual
@param l1 número de linhas do estado a percorrer no ciclo
@param l2 número de colunas do estado a percorrer no ciclo
@param dir direção segundo a qual verificar o tabuleiro
@param acao ação a realizar
@returns estado atualizado caso haja passo lógico a tomar
@returns mesmo estado caso contrário
*/
ESTADO ciclofor (ESTADO e, int l1, int l2, char dir, char acao);

/**
Função que, se a ação for correspondente a clicar na hint (ajuda), preenche a próxima casa lógica com um ponto de exclamação e, se a ação for correspondente a clicar no bot, preenche a próxima casa lógica com o ícone correto. Devolve o estado atualizado no argumento "estado"
@param l lista com os estados do jogo até ao momento
@param *estado endereço de um estado vazio em que vai ser retornado o estado com a ajuda efetuada, caso haja um passo lógico a tomar
@param acao ação a realizar
@returns 0 quando efetua com sucesso 
@returns 1 quando não há passo lógico a tomar  
*/
int ajudas (LInt l, ESTADO *estado, char acao);

#endif