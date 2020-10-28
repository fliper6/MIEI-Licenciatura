#ifndef ___STACK_H___
#define ___STACK_H___

/**
@file stack.h
Funções utilizadas no ficheiro stack.c documentadas 
*/ 

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "estado.h"

/**
\brief Diretoria das stacks
*/
#define dirStack "/usr/local/games/GandaGalo/Estados/Stack"

/** @struct stack
* @brief Estrutura que armazena os estados do jogo em que o user coloca âncoras
* @var stack :: size 
* tamanho do array que armazena os estados
* @var stack :: sp 
* número de estados armazenados
* @var stack :: estados 
* array onde estão guardados os estados
*/
typedef struct stack {
	int size;
	int sp;                   
	ESTADO *estados;
} STACK;

/** 
\brief Mesmo que a struct stack
*/
typedef struct stack STACK;


/**
Função que adiciona um novo estado à stack, retornando a stack atualizada no primeiro argumento
@param *s endereço da stack com os estados em que o utilizador adiciona âncoras
@param e novo estado em que o utilizador colocou uma âncora a ser adicionado à stack
*/
void pushS (STACK *s, ESTADO e);

/**
Função que remove o estado mais recente da stack
@param *s endereço da stack com os estados em que o utilizador colocou âncoras
@returns estado removido
*/
ESTADO popS (STACK *s);

/**
Função que vai buscar o estado mais recente da stack, sem a alterar
@param *s endereço da stack com os estados em que o utilizador colocou âncoras
@param lins número de linhas do puzzle, para se retornar um puzzle vazio caso a stack esteja vazia
@param cols número de colunas do puzzle, para se retornar um puzzle vazio caso a stack esteja vazia
@returns estado no topo da stack
*/
ESTADO topodastack (STACK *s, int lins, int cols);

/**
Função que inicializa uma stack
@param *s endereço da stack a inicializar
*/
void initS (STACK *s);

/**
Função que lê uma stack de um ficheiro txt
@param nr número do puzzle atual
@param *user nome do utilizador que está a jogar
@returns stack do ficheiro
*/
STACK txt2stack (int nr, char *user);

/**
Função que escreve a stack dada no ficheiro txt correspondente
@param s stack com os estados em que o utilizador colocou âncoras
@param nr número do puzzle atual
@param *user nome do utilizador que está a jogar
*/
void stack2txt (STACK s, int nr, char *user);

#endif