#include "lista.h"

/**
@file lista.c
Funções sobre listas 
*/

int compEstados (ESTADO e1, ESTADO e2) {
  int i, j;
  for (i = 0; i < e1.num_lins; i++) {
    for (j = 0; j < e1.num_cols; j++)
      if (e1.grelha[i][j] != e2.grelha[i][j]) return 1;
  }
  return 0;
}

LInt pushL (LInt l, ESTADO e) {
	LInt new;
	new = malloc (sizeof (struct lista));
	new -> estado = e; // estado atual 
	new -> prox = l; 
	return new; 
}

void pushL2 (LInt *l, ESTADO e) {
	LInt ls = *l, new;
	new = malloc(sizeof(struct lista));
	new -> estado = e;
	new -> prox = ls;
	*l = new;
}

LInt popL (LInt l) { 
	if (l -> prox) { // caso a lista tenha só 1 elemento, devolve o estado inicial. a lista nunca é vazia
    	LInt p = l;                                      
    	l = p -> prox; // vai buscar o último estado a ser colocado na lista
    	free(p);
  	}
  	return l; 
}

void popEmMassa (LInt *el, ESTADO e) {
	LInt l = *el, ant;
	while (compEstados(l->estado,e)) {
		ant = l;
		l = l -> prox;
		free(ant);
	}
  ant = l;
  l = l -> prox;
  free(ant);

	*el = l;
}

LInt revL (LInt l) { //reverte a lista
  LInt r, t;
  r = NULL;
  while (l) {
    t = l;
    l = l -> prox;
    t -> prox = r;
    r = t;
  }
  return r;
}

LInt ancoraLista (LInt l, ESTADO e) {
  LInt ant;
  while (compEstados(l->estado,e)) { //caso contrário, encontra-se o estado em que se pôs a âncora na lista e liberta-se a memória alocada para os estados posteriores a isso
    ant = l;
    l = l -> prox;
    free(ant);
  }
  return l;
}

int listlen (LInt l) { //comprimento da lista
  int count = 0; //a lista nunca é nula, o comprimento é >= 1
  while (l) {
    ++count;
    l = l -> prox;
  }
  return count;
}

LInt txt2lista (char s[]) { //devolve a lista do txt
  FILE *fp = fopen (s, "r");
  char linha[22]; //tamanho máximo da matriz é 20x20
  int i, n, lins, cols;
  ESTADO e;
  LInt l = NULL;

  //a fgets vai buscar uma linha de um ficheiro txt - para quando lê n-1 caracteres, um \n (recolhe também) ou chega ao feof (file end of file)
  while (fgets(linha, 22, fp)) { 
  	sscanf(linha, "%d %d", &lins, &cols);
    e.num_lins = lins;
    e.num_cols = cols;
    e.validade = e.inval = 'A';
    e.pos1 = e.pos2 = 0;

    for (i = 0; i < e.num_lins; i++) {
      if (fgets(linha, 22, fp)) { //se a matriz tiver 20 colunas, recolhe as 20 e o \n e põe o \0 no fim
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
    l = pushL(l,e);
  }
  l = revL(l);
  fclose(fp);
  return l;
}

//Imprime os estados no txt pela ordem que aparecem na lista
void lista2txt (LInt l, int nr, char *user) {
  int i, j;
  int len = listlen(l);
  char diretoria[100];
  sprintf(diretoria, "/usr/local/games/GandaGalo/Estados/Estado%d-%s.txt",nr,user);
  FILE *fp = fopen(diretoria, "w");

  while (len) {
    ESTADO e = l -> estado;
    if (e.validade == 'A') {
    fprintf (fp, "%d %d\n", e.num_lins, e.num_cols); //os outros parâmetros de cada estado vão ser sempre "A A 0 0", por isso não vale a pena escrevê-los
  
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
    len--;
    l = l -> prox;
    }
    else {len--; l = l -> prox;}
  }
  fclose(fp);
}