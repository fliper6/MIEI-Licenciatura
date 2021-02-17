/**
@file ajudas.c
Funções que tratam da parte de dar ajudas ao jogador
*/

#include "ajudas.h"

int condicao (char acao, VALOR v) {
  if (acao == 'A') {
    if (v == VAZIA) return 1;
  }
  else {
    if (v == VAZIA || v == AJUDA) return 1;
  }
  return 0;
}

int compV (VALOR a, VALOR b, VALOR c, char acao) {
  if (((a == FIXO_X || a == SOL_X) && condicao(acao,c)) || ((c == FIXO_X || c == SOL_X) && condicao(acao,a))) {
    if (b == FIXO_X || b == SOL_X) return 1; }

  else if  (((a == FIXO_O || a == SOL_O) && condicao(acao,c)) || ((c == FIXO_O || c == SOL_O) && condicao(acao,a))) {
    if (b == FIXO_O || b == SOL_O) return 2; }

  else if ((a == FIXO_X || a == SOL_X) && condicao(acao,b)) {
    if (c == FIXO_X || c == SOL_X) return 1; }

  else if  ((a == FIXO_O || a == SOL_O) && condicao(acao,b)) {
    if (c == FIXO_O || c == SOL_O) return 2; }

  return 0;
}

void mudaProx (ESTADO *e, int cpV, int i, int j) {
  if (cpV == 1) e->grelha[i][j] = SOL_O;
  else e->grelha[i][j] = SOL_X;
}

void posDir (int valor, char dir, int *ipos, int *jpos) {
  if (valor == 3) {
    switch (dir) {
      case 'h': *ipos = 0; *jpos = 2; break;
      case 'v': *ipos = 2; *jpos = 0; break;
      case 'w': *ipos = 2; *jpos = 2; break;
      case 'e': *ipos = -2; *jpos = 2; break;
      default: break;
    }
  }
  else {
    switch (dir) {
      case 'h': *ipos = 0; *jpos = 1; break;
      case 'v': *ipos = 1; *jpos = 0; break;
      case 'w': *ipos = 1; *jpos = 1; break;
      case 'e': *ipos = -1; *jpos = 1; break;
      default: break;
    }
  }
}

int acaoGeral (ESTADO *e, int i, int j, char dir, char acao) {
  VALOR v1,v2,v3;
  int ipos, jpos;

  v1 = e->grelha[i][j];
  switch (dir) {
    case 'h': v2 = e->grelha[i][j+1]; v3 = e->grelha[i][j+2]; break;
    case 'v': v2 = e->grelha[i+1][j]; v3 = e->grelha[i+2][j]; break;
    case 'w': v2 = e->grelha[i+1][j+1]; v3 = e->grelha[i+2][j+2]; break;
    case 'e': v2 = e->grelha[i-1][j+1]; v3 = e->grelha[i-2][j+2]; break;
    default: v3 = v2 = v1; //nunca acontece, é só para cobrir "todos" os casos e conseguir compilar o exemplo.c sem erros
  }
  int cpV = compV(v1,v2,v3,acao);
  if (cpV)
  {
    if (acao == 'A') {
      if (v1 == VAZIA)      e->grelha[i][j] = AJUDA;
      else if (v3 == VAZIA) { posDir(3,dir,&ipos,&jpos); e->grelha[i+ipos][j+jpos] = AJUDA; }
      else                  { posDir(2,dir,&ipos,&jpos); e->grelha[i+ipos][j+jpos] = AJUDA; }
    }

    else {
      if (v1 == VAZIA || v1 == AJUDA) mudaProx(e,cpV,i,j);
      else if (v3 == VAZIA || v3 == AJUDA) { posDir(3,dir,&ipos,&jpos); mudaProx(e,cpV,i+ipos,j+jpos); }
      else { posDir(2,dir,&ipos,&jpos); mudaProx(e,cpV,i+ipos,j+jpos); }
    }
    return 1;
  }
  return 0;
}

ESTADO ciclofor (ESTADO e, int l1, int l2, char dir, char acao) {
  int i, j;
  if (dir == 'h') {
    for (i = 0; i < l1; ++i) {
      for (j = 0; j < l2; ++j)
        if (acaoGeral(&e,i,j,dir,acao) == 1) return e;
  }}
  else if (dir == 'e') {
    for (j = 0; j < l1; ++j) {
      for (i = l2; i > 1; --i)
        if (acaoGeral(&e,i,j,dir,acao) == 1) return e;
  }}
  else {
    for (j = 0; j < l1; ++j) {
      for (i = 0; i < l2; ++i)
        if (acaoGeral(&e,i,j,dir,acao) == 1) return e;
  }}
  return e;
}

int ajudas (LInt l, ESTADO *estado, char acao) {
  ESTADO e = l -> estado, est;
  ESTADO le[4];

    le[0] = ciclofor(e,e.num_lins,e.num_cols-2,'h',acao);
    le[1] = ciclofor(e,e.num_cols,e.num_lins-2,'v',acao);
    le[2] = ciclofor(e,e.num_cols-2,e.num_lins-2,'w',acao);
    le[3] = ciclofor(e,e.num_cols-2,e.num_cols-1,'e',acao);
  int i;
  for (i = 0; i < 4; ++i) {
    est = le[i];
    if (compEstados(e,est)) {
      *estado = est;
      return 0;
    }
  }
  return 1; 
}