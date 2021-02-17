#include "valida.h"

/**
@file valida.c
Funções utilizadas para verificar a validade do puzzle
*/ 

int tabCheio (ESTADO e) { //verifica se todas as posições da grelha estão preenchidas com X, O ou BLOQUEADA
  int L, C;
  for (L = 0; L < e.num_lins; L++) {
    for (C = 0; C < e.num_cols; C++)
      if (e.grelha[L][C] == VAZIA || e.grelha[L][C] == ANCORA || e.grelha[L][C] == AJUDA) return 1;
  }
  return 0;
}

int verLC (int i, VALOR val[], int *pos) {
  int j, count = 1;
  VALOR valor = val[0];

  for (j = 1; j < i; j++) {
    if (valor == FIXO_X || valor == SOL_X) {
      if (val[j] == FIXO_X || val[j] == SOL_X) count++;
      else { valor = val[j]; count = 1; }
    }

    else if (valor == FIXO_O || valor == SOL_O) {
      if (val[j] == FIXO_O || val[j] == SOL_O) count++;
      else { valor = val[j]; count = 1; }
    }

    else valor = val[j];

    if (count == 3) {
      *pos = j;
      return 1;
    }; //há 3 X ou O seguidos
  }
  return 0;
}

int diagonais (ESTADO *e, int i, int j, char dir, int prox) {
  VALOR v1,v2,v3;
  v1 = e->grelha[i][j];
  v2 = e->grelha[i+prox][j+1];
  v3 = e->grelha[i+(2*prox)][j+2];
  if (((v1 == SOL_X || v1 == FIXO_X) && (v2 == SOL_X || v2 == FIXO_X) && (v3 == SOL_X || v3 == FIXO_X)) ||
      ((v1 == SOL_O || v1 == FIXO_O) && (v2 == SOL_O || v2 == FIXO_O) && (v3 == SOL_O || v3 == FIXO_O))) {
      e->inval = dir;
      e->pos1 = i;
      e->pos2 = j;
      return 1;
  }
  return 0;
}

int ciclosDiag (ESTADO *e, int tamJ, int tamI, char dir) {
  int i, j;
  if (dir == 'E') {
    for (j = 0; j < tamJ; ++j) {
      for (i = tamI; i > 1; --i)
        if (diagonais(e,i,j,dir,-1)) return 1;
    }
  }

  else {
    for (j = 0; j < tamJ; ++j) {
      for (i = 0; i < tamI; ++i)
        if (diagonais(e,i,j,dir,1)) return 1;
    }
  }

  return 0;
}

int horizVert (ESTADO *e, int tamI, int tamJ, char dir) {
  int i, j, pos;
  VALOR val[tamJ];

  for (i = 0; i < tamI; i++) {
    for (j = 0; j < tamJ; j++)
      if (dir == 'H') val[j] = e->grelha[i][j]; else val[j] = e->grelha[j][i];

    if (verLC(tamJ,val,&pos)) {
      e->inval = dir;
      e->pos1 = i; //linha/coluna inválida
      e->pos2 = pos; //terceira linha/coluna inválida
      return 1;
    }
  }
  return 0; //todas as linhas/colunas são válidas
}

int verifica (ESTADO *e) {
  if (horizVert(e,e->num_lins,e->num_cols,'H') || 
      horizVert(e,e->num_cols,e->num_lins,'V') || 
      ciclosDiag(e,e->num_cols-2,e->num_lins-1,'E') ||
      ciclosDiag(e,e->num_cols-2,e->num_lins-2,'W')) return 1; //estado inválido
  return 0; //estado válido
}