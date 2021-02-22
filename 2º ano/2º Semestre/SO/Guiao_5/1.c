#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>

/* Transferir informação do pai para o filho.

   Se houver um atraso (sleep()) ao escrever na pipe, a 
leitura bloqueia até haver algo escrito

   Neste caso, o programa bloqueava infinitamente se se pusesse
um wait antes do write do pai */
int main () {
	int fd[2];
	int size = 10;
	char buf[size];

	pipe(fd);

	if (!fork()) {
		int n;
		while ((n = read(fd[0],buf,size)) > 0)
			write(1,buf,n);
		exit(0);
	}

	sleep(2);
	read(0,buf,15);
	write(fd[1], buf,15);

	return 0;
}

/* Transferir informação do filho para o pai. 

   O tamanho do buffer varia e não se deve depender deste,
daí usar um ciclo ao ler do pipe e possivelmente ao 
escrever também? */
int main2 () {
	int fd[2];
	int size = 10;
	char buf[size];

	pipe(fd);

	if (!fork()) {		
		sleep(2);
		write(fd[1],"abara abiri abjiri patchiri\n",28);
		exit(0);
	}
	wait(NULL);
	int n;
	while ((n =	read(fd[0],buf,size)) > 0)
		write(1,buf,size);

	return 0;
}