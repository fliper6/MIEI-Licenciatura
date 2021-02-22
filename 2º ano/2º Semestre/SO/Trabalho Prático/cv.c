#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <stdio.h>
#include "writes.h"
#include "cod_partilhado.h"

/* Cria uma pipe com o pid do processo filho no nome para o sv lhe devolver o resultado. */
char* pipeFilho (pid_t pid) {
  char* nomePipe = malloc(STRING);
  sprintf(nomePipe, "%s%d", DIRPIPES, pid);

  mkfifo(nomePipe,0666);
  return nomePipe;
}

/* Espera pelo fim da execução do processo filho. */
void esperarFilho () {
  wait(NULL);
}

/* - Cria um processo filho (de maneira a permitir execução concorrente de clientes).
   - Cria uma pipe com o pid desse processo no nome.
   - Envia a instrução recebida pelo input para o sv.
   - Recebe o resultado do sv pela pipe criada e imprime-o no stdout.
   - Apaga a pipe criada e termina o processo filho. */
void executarComando (char* input) {
  pid_t pid = fork();
  if (!pid) {
    char* nomePipe = pipeFilho(getpid());
    int pipe = open(nomePipe, O_RDWR);

    char* buf = malloc(STRINGMAIOR);
    sprintf(buf, "%s %s", nomePipe, input);

    writeToPipe(DIRPIPES,buf);
    writeFromPipe(pipe);
                
    close(pipe);
    unlink(nomePipe);
    free(nomePipe);
    free(buf);

    _exit(0);
  }
}

/* - Faz uma entrada de stock de 10 mil unidades ao primeiro artigo. 
   - Executa 10 mil vendas concorrentes desse artigo.
   - É necessário existir pelo menos um artigo. */
int cvsConcorrentes () {
  executarComando("1 10000\n");

  for (int i = 0; i < 10000; i++) executarComando("1 -1\n");
  for (int i = 0; i < 10000; i++) esperarFilho();
  return 0;
}

/* - Verifica se o sv está online (já criou a pipe principal de comunicação).
   - Cria uma pipe nova através da qual receberá os resultados (isto para permitir
execução concorrentes de clientes).
   - Lê input do stdin e reencaminha-o para o sv através de named pipes.
   - Recebe o resultado e escreve-o no stdout. Caso seja uma mensagem de erro, no stderr.
   - Apaga a pipe criada para este cv. */
int main () {
  if (abrirPipeSV()) return 1;
  else {
      int n;
      char* input = malloc(STRING);

      while ((n = readline(0,input))) {
        if (n == 1);
        else if (n == STRING) writeComando(input,1);
        else {
          executarComando(input);
          esperarFilho();
        }
      }

      free(input);
  }
  return 0;
}