#ifndef WRITES_H
#define WRITES_H

/* Protótipos das funções. */
void  crash (int flag);
void  writeComando (char* input, int flag);
void  writeMensagem (int flag);
void  writeToPipe (char* nome, char* buf);
void  writeFromPipe (int pipe);
void  writeInitStock (int fdSto, int cod);
char* writeStock (int fdS, int cod, double preco);
char* writeNewStock (int fdS, int cod, int qtd);
int   writeNome (int fdStr, char* comando, int flag);
void  writePreco (int fdArt, int cod, double preco);
void  writePos (int fdArt, int p, int linha);
int   writeContador (int fd, int init, int new, int flag);
void  writePosAg (int pos);
void  writeArtigo (int fdArt, int p, char* cod, double preco);
void  writeVenda (int cod, int qtd, double preco);
void  writeVendaAg (int fdAg, int cod, int qtd, double montante);
int*  writeStringsNovo (int fdStr, int num, int* posicoes);

#endif