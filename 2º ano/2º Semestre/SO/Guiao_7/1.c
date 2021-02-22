#include <signal.h>
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>

typedef void (*sighandler_t)(int);

int tempo;
int vezes;

void tempoPassado(int i) {
	(void) i;
	printf("Tempo passado: %d\n", tempo);
	vezes++;
}

void fechar(int i) {
	(void) i;
	printf("Vezes ctrl c: %d\n", vezes);
	exit(0);
}

void alarme(int i) {
	(void) i;
	alarm(1);
	tempo++;
}

int main() {
	printf("%d\n",getpid());
	signal(SIGINT, tempoPassado);
	signal(SIGQUIT, fechar);
	signal(SIGALRM, alarme);

	alarm(1);

	while(1)
		pause();
	return 0;
}