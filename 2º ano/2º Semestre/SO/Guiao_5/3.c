#include <unistd.h>
#include <stdlib.h>
#include <string.h>

/* Chama o comando wc para o input do utilizador.

   Usar _exit() ao invocar um exec para abortar o filho
caso o exec falhe. */
int main () {
	int fd[2], n;
	char buf[100];
	pipe(fd);

	if (!fork()) {
		close(fd[1]);
		dup2(fd[0],0);
		close(fd[0]);
		execlp("wc","wc",NULL);
		_exit(1);
	}

	close(fd[0]);
	while ((n = read(0,buf,100)) > 1)	//se ler apenas "\n"
		write(fd[1],buf,n);
	close(fd[1]);

	return 0;
}