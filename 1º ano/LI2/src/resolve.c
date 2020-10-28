#include "resolve.h"

/**
@file resolve.c
Funções utilizadas para a parte do bot do jogo
*/ 

int acabou (ESTADO e) { 
	if (!tabCheio(e) && !verifica(&e)) return 0;
	return 1;
}

int pAnt (int lVazia, int i, int j, Jogada jog) {
	int r;
	if (!lVazia) r = 0;
	else {
		if ((i == jog.linha && j > jog.coluna) || i > jog.linha) r = 0;
		else r = 1;
	}
	return r;
}

Jogada proxJogada (ESTADO e, Jogada jog, int lVazia) {
	int i, j;
	if (jog.tipo == 'X') { //jogar na mesma casa mas desta vez com O
		jog.tipo = 'O';
		return jog;
	}
	
	else { //inicializar a lista / jogada X em vazio
		for (i = 0; i < e.num_lins; ++i) {
			for (j = 0; j < e.num_cols; ++j) {
				if (e.grelha[i][j] == VAZIA && !pAnt(lVazia,i,j,jog)) {
					jog.tipo = 'X';
					jog.linha = i;
					jog.coluna = j;
					return jog;
	}}}}

	jog.tipo = 'Z'; //se já tiver experimentado todas as hipóteses no estado atual e nenhuma for viável
	return jog;
}

Passos novoPasso (Passos l, ESTADO e) {
	Passos new = malloc(sizeof(struct passos));
	Jogada jog;
	if (!acabou(e)) {
		jog.tipo = 'F';
		new -> jogada = jog;
	}
	else {
		jog.tipo = 'A';
		new -> jogada = proxJogada(e,jog,0);
	}
	new -> estado = e;
	new -> prox = l;
	return new;
}

ESTADO fazJogada (ESTADO e, Jogada jog) {
	int i = jog.linha, j = jog.coluna;
	if (jog.tipo == 'X') e.grelha[i][j] = SOL_X;
	else e.grelha[i][j] = SOL_O;
	return e;
}

ESTADO recuaPasso (Passos *l) {
  Passos p = *l; ESTADO e;
  *l = (*l) -> prox;
  free(p);
  if (!(*l)) return e;
  Jogada jog = proxJogada((*l)->estado,(*l)->jogada,1);
  while (jog.tipo == 'Z') {
    p = *l;
    *l = (*l)->prox;
    free(p);
    if (!(*l)) return e;
    jog = proxJogada((*l)->estado,(*l)->jogada,1);
  }
  e = fazJogada((*l)->estado,(*l)->jogada);
  (*l) -> jogada = jog;
  return e;
}

int pLogicos (ESTADO *e, LInt *p) {
	ESTADO e1;

	while (!verifica(e) && !ajudas(*p,&e1,'R')) {
		pushL2(p,e1);
		*e = e1;
	}

	if (verifica(e)) return 1; //chegou a um estado inválido através de ajudas lógicas
	return 0; //fez todos os passos lógicos possíveis e fica de novo sem passos, com um estado válido - pode estar acabado o puzzle
}

Passos resolve (Passos l, LInt *p) {
	int i; Jogada jog;
	ESTADO e;
	e = fazJogada(l->estado,l->jogada);
	pushL2(p,e);
	i = pLogicos(&e,p);

	if (i) {
		jog = proxJogada(l->estado,l->jogada,1);
		if (jog.tipo == 'Z') {
			e = recuaPasso(&l);
			popEmMassa(p,e);
		}
		else { 
			e = fazJogada(l->estado,l->jogada);
			popEmMassa(p,e); //retrocede na lista até ao estado dado à pLogicos nesta iteração
			l -> jogada = jog;
		}
	}
	else l = novoPasso(l,e);

	return l;
}

LInt resolveFinal (LInt p) {//a função recebe um estado válido sem mais passos lógicos
	ESTADO e = p -> estado;
	Passos l = NULL;

	l = novoPasso(l,e);

	while (l && acabou(l->estado))
		l = resolve(l,&p);
	
	return p;
}