#include "stack.h"

/**
@file stack.c
Funções utilizadas relativas a stacks
*/ 

void pushS (STACK *s, ESTADO e) {
    ESTADO *t;
	int i;
	if (s -> sp < s -> size) {
		s -> estados [s -> sp] = e;
		s -> sp++;
	}
	else { // stack dinâmica -> quando sp == size (stack cheia), coloca-se os estados num array (t) de dobro de tamanho
		t = malloc(2*s -> size*sizeof(ESTADO));
		for (i = 0; i < s -> size; i++)
			t[i] = s -> estados[i];
		t[i] = e;
		s -> size = 2*s -> size; 
		s -> sp++;
		free (s -> estados);
		s -> estados = t;
	}
}

ESTADO popS (STACK *s) { //esta função nunca vai ser chamada quando não tem nenhum estado, por isso não dá seg. fault caso sp = 0
	ESTADO e;
	s -> sp--;
	e = s -> estados[s -> sp];
	return e;
}

ESTADO topodastack (STACK *s, int lins, int cols) {
	ESTADO e; int i, j;
	if (s -> sp) { // se a stack estiver vazia, não faz nada
		s -> sp--;
		e = s -> estados[s -> sp]; 
		s -> sp++;
	}
  else {
    for (i = 0; i < lins; i++) {
      for (j = 0; j < cols; j++)
        e.grelha[i][j] = VAZIA;
    }
  }
	return e;  
}

void initS (STACK *s) {
  s->size = 5;
  s->sp = 0;
  s->estados = malloc(sizeof(ESTADO)*s->size);
}

STACK txt2stack (int nr, char *user) {
  STACK s;
  char diretoria[100];
  sprintf(diretoria, "%s%d-%s.txt", dirStack, nr, user);
  if (access(diretoria,F_OK) == -1) {initS(&s); return s;} //se o ficheiro txt da stack não existir (primeiro uso do jogo), inicializa a stack
  
  FILE *fp = fopen (diretoria, "r");
  int tam, pointer, L, C, i, n;
  char linha[22];
  ESTADO e;

  if (fgets(linha, 22, fp)) sscanf(linha, "%d %d", &tam, &pointer);
  s.size = tam;
  s.sp = 0;
  s.estados = malloc(sizeof(ESTADO)*tam);

  for (tam = 0; tam < pointer; tam++) {
    if (fgets(linha, 22, fp)) sscanf(linha, "%d %d", &L, &C);
    e.num_lins = L;
    e.num_cols = C;
    e.validade = e.inval = 'A';
    e.pos1 = e.pos2 = 0;
    
    for (i = 0; i < e.num_lins; i++) {
      if (fgets(linha, 22, fp)) {
      	for (n = 0; linha[n] != '\n'; n++) {
          switch (linha[n]) {
          	case '.': e.grelha[i][n] = VAZIA; break;
          	case 'X': e.grelha[i][n] = FIXO_X; break;
          	case 'O': e.grelha[i][n] = FIXO_O; break;
          	case '#': e.grelha[i][n] = BLOQUEADA; break;
          	case 'x': e.grelha[i][n] = SOL_X; break;
          	case 'o': e.grelha[i][n] = SOL_O; break;
          	case 'a': e.grelha[i][n] = AJUDA; break;
          	case 'b': e.grelha[i][n] = ANCORA; break;
    }}}}
    pushS(&s,e);
  }
  fclose(fp);
  return s;
}

void stack2txt (STACK s, int nr, char *user) { //guarda o tamanho, apontador e estados da stack (pela ordem que aparecem no array) num ficheiro txt
  int i, j, a;
  ESTADO e;
  char diretoria[100];
  sprintf(diretoria, "%s%d-%s.txt", dirStack, nr, user);
  FILE *fp = fopen (diretoria, "w");
  
  fprintf(fp, "%d %d\n", s.size, s.sp);

  for (a = 0; a < s.sp; a++) {
    e = s.estados[a];

    fprintf (fp, "%d %d\n", e.num_lins, e.num_cols);
  
    for (i = 0; i < e.num_lins; i++) {
      for (j = 0; j < e.num_cols; j++) {
        switch (e.grelha[i][j]) {
          case VAZIA: fprintf(fp, "."); break;
          case BLOQUEADA: fprintf(fp, "#"); break;
          case SOL_X: fprintf(fp, "x"); break;
          case SOL_O: fprintf(fp, "o"); break;
          case FIXO_X: fprintf(fp, "X"); break;
          case FIXO_O: fprintf(fp, "O"); break;
          case AJUDA: fprintf(fp, "a"); break;
          case ANCORA: fprintf(fp, "b"); break;
          }
      }
      fprintf(fp, "\n");
    }
  }
  fclose(fp);
}