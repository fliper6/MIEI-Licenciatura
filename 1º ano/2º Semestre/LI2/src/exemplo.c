/**
@file exemplo.c
Funções principais do programa
*/

#include "exemplo.h"

char *links (int nr, char *user, char acao, int novo, int L, int C) {
  char *link = malloc(sizeof(char)*MAXIMO);
  if (acao == 'P')
    sprintf(link, "%s%c|%d,%d,%d-%s",initLink,acao,L,C,nr,user);
  else
    sprintf(link, "%s%c|%d,%d,%d-%s",initLink,acao,novo,novo,nr,user);
  return link;
}

void geraImagem (char *link, int x, int y, int tam, char *imagem) {
  ABRIR_LINK(link);
  IMAGEM(x,y,tam,imagem); 
  FECHAR_LINK;
}

void imginval (ESTADO e, int L, int C, int nr, char *user) { 
  VALOR valor = e.grelha[L][C];
  char *link = links(nr,user,'P',0,L,C);

  if (valor == SOL_X || valor == FIXO_X)
    geraImagem(link,C,L,TAM,"XN.png");
  if (valor == SOL_O || valor == FIXO_O)
    geraImagem(link,C,L,TAM,"ON.png");
}

void imprime_casa (ESTADO e, int L, int C, int nr, char acao, char *user) {
  VALOR valor = e.grelha[L][C];
  if (!tabCheio(e) && acao != 'V') e.inval = 'A';
  if ((e.inval == 'H' && L == e.pos1 && (C == e.pos2 || C == e.pos2-1 || C == e.pos2-2)) || //horizontal
      (e.inval == 'V' && C == e.pos1 && (L == e.pos2 || L == e.pos2-1 || L == e.pos2-2)) || //vertical
      (e.inval == 'W' && ((L == e.pos1 && C == e.pos2) || (L == e.pos1+1 && C == e.pos2+1) || (L == e.pos1+2 && C == e.pos2+2))) || //NW
      (e.inval == 'E' && ((L == e.pos1 && C == e.pos2) || (L == e.pos1-1 && C == e.pos2+1) || (L == e.pos1-2 && C == e.pos2+2)))) //NE
    imginval(e,L,C,nr,user);    
  else {
    switch(valor) {
      case AJUDA:
      case VAZIA:
      case SOL_X:
      case SOL_O:
      geraImagem(links(nr,user,'P',0,L,C),C,L,TAM,ficheiro[valor]);
      break;
    default:
      IMAGEM(C,L,TAM,ficheiro[valor]);
}}}

LInt acaoJoga (LInt l, STACK *s, int L, int C) {
  ESTADO e = l -> estado;
  VALOR valor = e.grelha[L][C];
    switch(valor) {
      case VAZIA: e.grelha[L][C] = SOL_X; break;
      case SOL_X: e.grelha[L][C] = SOL_O; break;
      case SOL_O: e.grelha[L][C] = ANCORA; pushS(s,e); break; //se puserem uma âncora adiciona-se o estado à stack
      case AJUDA: e.grelha[L][C] = SOL_X; break;
      default: break; //no caso dos outros valores não acontece nada
     }
  l = pushL(l,e); //coloca estado na lista
  return l;
}

ESTADO casaAncora (ESTADO e1, ESTADO e2) { //estado popped da stack e estado que fica no topo da stack (função topodastack)
  int i, j;
  for (i = 0; i < e1.num_lins; i++) {
    for (j = 0; j < e1.num_cols; j++) {
      if (e1.grelha[i][j] == ANCORA && e2.grelha[i][j] != ANCORA) e1.grelha[i][j] = VAZIA;
  }}
  return e1;
}

LInt acaoUndo (LInt l, STACK *s) {
  if (l -> prox) { 
    LInt p = l;
    ESTADO e1 = l -> estado;
    p = p -> prox;
    ESTADO e2 = p -> estado;
    if (compEstados(e1,casaAncora(e1,e2))) e2 = popS(s);
  }
  l = popL(l); //retira estado da lista
  return l;
}

LInt acaoAncora (LInt l, STACK *s) {
  if (s->sp) { //se a stack estiver vazia não altera nada
      ESTADO e = popS(s); //dá pop à stack
      l = ancoraLista(l,e); //retrocede na lista até à âncora - devolve a lista com a cabeça igual ao estado retirado da stack
      e = casaAncora(e,topodastack(s,e.num_lins,e.num_cols)); //passa a âncora a vazia; se não houver âncora retorna o mesmo estado (esta parte só interessa para o undo)
      l -> estado = e; //altera a cabeça da lista para o estado atualizado sem a âncora
    }
  return l;
}

LInt link2lista (char *args, LInt l, STACK *s) { 
  int L, C, nr;
  char acao, user[MAXIMO], diretoria[MAXIMO];
  ESTADO e = l -> estado, e1;
  sscanf(args, "%c|%d,%d,%d-%s", &acao, &L, &C, &nr, user);

  if (acao == 'P') l = acaoJoga(l,s,L,C);

  else if (acao == 'U') l = acaoUndo(l,s); //dá pop à lista para voltar para o estado anterior; se o último passo foi uma âncora, dá pop à stack também
  
  else if (acao == 'C') l = acaoAncora(l,s);
  
  else if (acao == 'A' || acao == 'R') { 
    if (!tabCheio(e) && acabou(e));
    else if (!ajudas(l,&e1,acao)) l = pushL(l,e1);
    else if (verifica(&e));
    else if (acao == 'R' && acabou(e)) l = resolveFinal(l); //caso não haja mais passos lógicos, esta função resolve o puzzle todo
  }

  else if (acao == 'V') {
    if (!acabou(e)) { e.validade = 'W'; l = pushL(l,e); } //se o tabuleiro estiver cheio e for válido, o jogo acabou
    else if (verifica(&e)) { e.validade = 'N'; l = pushL(l,e); }
    else { e.validade = 'V'; l = pushL(l,e); }
  }

  else if (acao == 'N') { //ao reiniciar o puzzle, reinicia-se a lista e a stack
    sprintf(diretoria,"%s%d.txt", dirPuzzle, nr);
    l = txt2lista(diretoria);
    initS(s);
  }
  
  return l;
}

char *dados (char *args, int *nr, char *acao) { 
  char *user = malloc(sizeof(char)*MAXIMO);
  if (args[1] != '|') {
    *nr = 1;
    *acao = 'Z';
    user = args;
  }
  else {
    int a,b;
    sscanf(args,"%c|%d,%d,%d-%s",acao,&a,&b,nr,user);
    if (*acao == 'M') *nr = a; //se a ação for mudar de puzzle retorna o número do novo puzzle
  }
  return user;
}

LInt ler_lista(char *args, STACK *s, int nr, char *user) {
  char dir[MAXIMO]; LInt l;
  if (args[1] != '|') { //se se tiver acabado de escolher o user vai buscar o estado do puzzle 1
    sprintf(dir, "%s1-%s.txt", dirEstado, user);
    if (access(dir,F_OK) != -1) l = txt2lista(dir); //se o estado1.txt existir (o user já jogou e saiu a meio) recupera esse estado e continua o jogo
    else {
      sprintf (dir, "%s1.txt", dirPuzzle);
      l = txt2lista(dir); //se não existir (primeira vez que se joga) vai buscar o estado inicial do puzzle
    }
  }
  else {
    sprintf(dir, "%s%d-%s.txt", dirEstado, nr, user);
    if (access(dir,F_OK) == -1) sprintf(dir, "%s%d.txt", dirPuzzle, nr); //se o ficheiro não existir vai buscar o estado inicial do puzzle (mudança de puzzle)
    l = link2lista(args,txt2lista(dir),s); //caso contrário pega no estado atual e aplica a ação
  }
  return l;
}

void botoes (int nr, char *user, char *imagem) {
  geraImagem(links(nr,user,'A',0,0,0),5,4,80,"ajuda.png");
  geraImagem(links(nr,user,'M',1,0,0),4,0,90,"puzzlepiece1.png");
  geraImagem(links(nr,user,'M',2,0,0),4,1,90,"puzzlepiece2.png");
  geraImagem(links(nr,user,'M',3,0,0),5,0,90,"puzzlepiece3.png");
  geraImagem(links(nr,user,'M',4,0,0),5,1,90,"puzzlepiece4.png");
  geraImagem(links(nr,user,'V',0,0,0),2,4,80,imagem);
  geraImagem(links(nr,user,'U',0,0,0),1,4,80,"undo.png");
  geraImagem(links(nr,user,'C',0,0,0),0,4,80,"carregar.png");
  geraImagem(links(nr,user,'N',0,0,0),3,4,80,"novo.png");
  geraImagem(links(nr,user,'R',0,0,0),4,4,80,"bot.png");
  geraImagem("http://localhost/cgi-bin/GandaGalo",5,2,91,"mudar.png");
}

int main() {
  COMECAR_HTML;
  ABRIR_SVG(600, 600);
  
  if (!strlen(getenv("QUERY_STRING")))  
    IMAGEM(0,0,500,"user.png");

  else {
    int x, y, nr;
    char acao, imagem[13];
    char *user = dados(getenv("QUERY_STRING"),&nr,&acao);
    STACK s = txt2stack(nr,user);
    LInt l = ler_lista(getenv("QUERY_STRING"),&s,nr,user);
    ESTADO e = l -> estado;

    if (acao == 'V') sprintf(imagem, "validar%c.png", e.validade); //printa a respetiva imagem conforme a validade do estado
    else { 
      if (!acabou(e)) sprintf(imagem, "validarW.png"); //se o puzzle estiver acabado e o user tentar fazer uma ação que não altere a grelha, a imagem de vitória mantém-se
      else sprintf(imagem, "validar.png");
    }

    lista2txt(l,nr,user);
    stack2txt(s,nr,user);

    for (y=0; y<e.num_cols; y++) 
      for (x=0; x<e.num_lins; x++)
        imprime_casa(e,x,y,nr,acao,user); 

    botoes(nr,user,imagem);
  }

  FECHAR_SVG;
  FECHAR_HTML;
  return 0;
}