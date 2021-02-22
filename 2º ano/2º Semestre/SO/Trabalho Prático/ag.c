#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <stdio.h>
#include "writes.h"
#include "cod_partilhado.h"

/* Escreve num ficheiro os nomes de todos os ficheiros com vendas agregadas por código. */
int lsPasta (char* nomes) {
  sprintf(nomes,"%s/nomes", DIRFILES);
  int fdNomes = open(nomes, O_CREAT | O_RDWR, 0666);

  if (!fork()) {
    dup2(fdNomes,1);
    execlp("ls","ls",DIRVENDAS,NULL);
    _exit(0);
  }

  wait(NULL);
  lseek(fdNomes,0,SEEK_SET);
  return fdNomes;
}

/* - Agrega as vendas presentes num ficheiro.
   - Envia o resultado para o stdout.*/
void agregarCodigo (char* dirfile, int cod) {
  int fd = open(dirfile, O_RDONLY);
  if (fd < 0) crash(0);

  int qtd = 0;
  double montante = 0;

  char* buf = malloc(STRING);
  while (readline(fd,buf)) {
    qtd      += atoi(buf + OFFSETSTOCK);
    montante += atof(buf + OFFSETMONT);
  }

  sprintf(buf,"%.*d %.*d %s", CODIGO, cod, QTDTOTAL, qtd, doubleToString(montante,1,MONTANTEINT));
  if (write(1,buf,strlen(buf)) < 0) crash(0);

  close(fd);
  unlink(dirfile);
}

/* - Percorre todos os ficheiros com vendas por código.
   - Envia as vendas para o stdout.
   - Vai apagando os ficheiros à medida que lê deles. */
void agregarVendas (int fdNomes) {
  char* file    = malloc(STRING);
  char* dirfile = malloc(STRING);
  
  while (readline(fdNomes,file)) {
    file[strlen(file)-1] = '\0';

    sprintf(dirfile, "%s/%s", DIRVENDAS, file);
    agregarCodigo(dirfile,atoi(file));
  }
  if (write(1,ENDOFFILE,strlen(ENDOFFILE)) < 0) crash(0);
  
  free(file);
  free(dirfile);
}

/* - Copia a informação agregada de todos os ficheiros criados para o ficheiro novo.
   - Apaga todos os ficheiros temporários criadas e a pasta criada para esse fim também. */
void juntarFicheiros () {
  char* file = malloc(STRING);
  int fdNomes = lsPasta(file);

  agregarVendas(fdNomes);
  close(fdNomes);

  unlink(file);
  rmdir(DIRVENDAS);
  free(file);
}

/* - Agrega a venda seguinte no vendas.
   - Verifica se já foi agregada alguma venda com o mesmo código,
ou seja, se já existe um ficheiro com esse código no nome:
      - Sim -> soma-lhe a quantidade e receita da venda atual.
      - Não -> cria um novo ficheiro e insere lá a venda. */
void adicionarVenda (char* venda) {
  char* buf = malloc(STRING);
  int cod = atoi(venda);
  sprintf(buf, "%s/%d", DIRVENDAS, cod);

  int fd = open(buf, O_CREAT | O_RDWR, 0666);
  if (fd < 0) crash(0);
  
  lseek(fd,0,SEEK_END);
  if (write(fd,venda,strlen(venda)) < 0) crash(0);
  
  close(fd);
  free(buf);
}

/* - Agrega as vendas executadas desde a última agregação (cria um ficheiro por 
código e agrega em cada todas as vendas do artigo com o código respetivo).
   - Guarda no vendas a posição a partir da qual a próxima agregação deve começar.
   - Envia as vendas agregadas para a manutenção de artigos pelo stdout (redirecionado para uma pipe). */
int main () {
  char* buf = malloc(STRING);
  readline(0,buf);
  int pos = atoi(buf);

  int pipe = open(PIPEMAAG, O_WRONLY);
  dup2(pipe,1);
  close(pipe);

  if (strcmp(buf,ENDOFFILE)) {  // Caso se tente agregar sem haver vendas;
    struct stat st = {0};
    if (stat(DIRVENDAS, &st) == -1) mkdir(DIRVENDAS, 0700);

    while (readline(0,buf)) {
      if (!strcmp(buf,ENDOFFILE)) break;
      pos += LINHAVENDAS;
      adicionarVenda(buf);
    }
    
    juntarFicheiros();
    writePosAg(pos);
  }
  else if (write(1,ENDOFFILE,strlen(ENDOFFILE)) < 0) crash(0);

  free(buf);
  return 0;
}