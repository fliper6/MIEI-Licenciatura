#ifndef ___EXEMPLO_H___
#define ___EXEMPLO_H___

/**
@file exemplo.h
Funções utilizadas no ficheiro exemplo.c documentadas 
*/ 

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "cgi.h"
#include "estado.h"
#include "lista.h"
#include "valida.h"
#include "ajudas.h"
#include "stack.h"
#include "resolve.h"

/** 
\brief Tamanho alocado às strings que guardam o nome dos users e das diretorias
*/
#define MAXIMO  100

/**
\brief Tamanho das imagens das casas da grelha
*/
#define TAM     30

/**
\brief Link inicial do jogo
*/
#define initLink  "http://localhost/cgi-bin/GandaGalo?"

/**
\brief Diretoria dos estados
*/
#define dirEstado "/usr/local/games/GandaGalo/Estados/Estado"

/**
\brief Diretoria dos puzzles
*/
#define dirPuzzle "/usr/local/games/GandaGalo/Puzzles/Puzzle"

/**
\brief String com as várias imagens possíveis das casas da grelha
*/
char *ficheiro[] = {"bloq.png", "X.png", "O.png", "vazio.png", "X.png", "O.png", "Ajuda.png", "ancora.png"};

/**
Função que cria o link correspondente às ações efetuadas pelo jogador
@param nr número do puzzle atual
@param *user nome do utilizador que está a jogar
@param acao ação a efetuar
@param novo número do novo puzzle, caso o utilizador queira mudar
@param L linha da peça jogada, caso o utilizador tenha jogado na grelha
@param C coluna da peça jogada, caso o utilizador tenha jogado na grelha
@returns link_gerado
*/
char *links (int nr, char *user, char acao, int novo, int L, int C);

/** 
Função que cria a imagem correspondente aos parâmetros que recebe, associando-lhe um link
@param *link link associado à imagem gerada
@param x posição relativa da imagem em termos de "colunas"
@param y posição relativa da imagem em termos de "linhas"
@param tam tamanho relativo da imagem
@param *imagem nome do ficheiro associado à imagem
*/
void geraImagem (char *link, int x, int y, int tam, char *imagem);

/**
Função que verifica as imagens de fundo vermelho a pôr conforme os valores das casas correspondentes
@param e estado inválido
@param L linha da peça inválida
@param C linha da coluna inválida
@param nr número do puzzle atual
@param *user nome do utilizador que está a jogar
*/

void imginval (ESTADO e, int L, int C, int nr, char *user);

/**
Função que gera a imagem correspondente ao valor da casa dada
@param e estado atual que vai ser imprimido
@param L linha da peça a imprimir
@param C coluna da peça a imprimir
@param nr número do puzzle atual
@param acao ação a realizar
@param *user nome do utilizador que está a jogar
*/
void imprime_casa (ESTADO e, int L, int C, int nr, char acao, char *user);

/**
Função que muda o valor da casa que o jogador clicou
@param l lista com os estados do jogo
@param *s endereço da stack com os estados em que o utilizador colocou âncoras
@param L linha da peça em que o jogador carregou
@param C coluna da peça em que o jogador carregou
@returns lista_atualizada com o estado novo gerado com o click
*/
LInt acaoJoga (LInt l, STACK *s, int L, int C);

/**
Função que descobre qual foi a última âncora adicionada pela jogador
@param e1 estado atual
@param e2 estado no topo da stack
@returns estado com a casa que tinha a última âncora adicinada agora vazia 
*/
ESTADO casaAncora (ESTADO e1, ESTADO e2);

/**
Função que retrocede um passo no jogo
@param l lista com os estados do jogo
@param *s endereço da stack com os estados em que o utilizador colocou âncoras
@returns lista_atualizada sem o estado correspondente à última jogada
*/
LInt acaoUndo (LInt l, STACK *s);

/**
Função que retrocede até à última âncora colocada
@param l lista com os estados do jogo
@param *s endereço da stack com os estados em que o utilizador colocou âncoras
@returns lista_atualizada sem os estados correspondentes às ações posteriores à última âncora colocada
*/
LInt acaoAncora (LInt l, STACK *s);

/**
Função que identifica a ação a realizar a partir do link e chama a função correspondente
@param *args query_string, parte do link a seguir ao '?'
@param l lista com os estados do jogo
@param *s endereço da stack com os estados em que o utilizador colocou âncoras
@returns lista_atualizada com ação efetuada
*/
LInt link2lista (char *args, LInt l, STACK *s);

/**
Função que identifica a ação, o número do puzzle e o nome do user a partir do link
@param *args query_string, parte do link a seguir ao '?'
@param *nr endereço de um inteiro onde se vai guardar o número do puzzle
@param *acao endereço de um caractér onde se vai guardar a ação a realizar
@returns nome_do_user e o número do puzzle e ação nos argumentos dados
*/
char *dados (char *args, int *nr, char *acao);

/**
Função que verifica se o user em questão já existe e, em caso afirmativo, se já tinha jogado no puzzle em questão e, caso não tivesse, começa novo jogo
@param *args query_string, parte do link a seguir ao '?'
@param *s endereço da stack com os estados em que o utilizador colocou âncoras
@param nr número do puzzle atual
@param *user nome do utilizador que está a jogar
@returns lista retorna a lista do puzzle em questão (ou já com estados - com jogadas feitas - ou só com o estado inicial - novo jogo)
*/
LInt ler_lista(char *args, STACK *s, int nr, char *user);

/**
Função que gera a interface do jogo
@param nr número do puzzle atual
@param *user nome do utilizador que está a jogar
@param *imagem nome do ficheiro associado à imagem do botão validar, cujo fundo varia de cor conforme a validade do puzzle
*/
void botoes (int nr, char *user, char *imagem);

/**
Função principal do programa
@returns 0 se tudo correr bem 
*/
int main();

#endif