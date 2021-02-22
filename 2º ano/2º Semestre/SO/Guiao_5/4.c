#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>

/* O primeiro filho escreve o resultado do comando ls /etc
para a pipe. 
   O segundo corre o comando wc -l a partir da pipe.*/
int main () {
	int fd[2];
	pipe(fd);

	if (!fork()) {
		dup2(fd[1],1);
		close(fd[0]);
		execlp("ls","ls","/etc",NULL);
		_exit(1);
	}
	
	if (!fork()) {
		dup2(fd[0],0);
		close(fd[1]);
		execlp("wc","wc","-l",NULL);
		_exit(1);
	}

	close(fd[0]);
	close(fd[1]);

	return 0;
}