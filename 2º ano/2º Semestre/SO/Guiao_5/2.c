#include <stdlib.h>
#include <unistd.h>


/* Processos que vão ler de um pipe devem fechar o 
extremo de escrita e vice-versa. 
   Quando terminarem de ler/escrever, devem fechar
o extremo que usaram, para evitar deadlocks. 

   O pai e um dos filhos estão a tentar escrever 
simultaneamente no pipe, mas a escrita bloqueia 
quando o pipe está cheio, até o que está lá ser 
lido - não há overwrite. */
int main3 () {
	int fd[2];
	char buf[100];

	pipe(fd);

	if (!fork()) {
		int n;
		close(fd[1]);
		while ( (n = read(fd[0],buf,10)))
			write(1,buf,n);
		close(fd[0]);
		exit(0);
	}

	if (!fork()) {
		close(fd[0]);
		write(fd[1], "aaaaaaaaaaaaaaaaaaaaaaaaaaa\n",28);
		write(fd[1], "xxxxxxxxxx\n", 11);
		close(fd[1]);
	}

	close(fd[0]);
	write(fd[1], "abara abiri abjiri patchiri\n",28);
	write(fd[1], "1234567890\n", 11);
	close(fd[1]);

	return 0;
}

/* Transferir informação do filho para o pai.

   Neste caso, a leitura do pai tem o mesmo efeito que um
wait, pois só se vai realizar quando o filho acabar de 
escrever, que praticamente equivale a quando morre. */
int main2 () {
	int fd[2];
	int size = 10;
	char buf[size];

	pipe(fd);

	if (!fork()) {		
		close(fd[0]);
		sleep(2);
		write(fd[1],"abara abiri abjiri patchiri\n",28);
		close(fd[1]);
		exit(0);
	}
	
	close(fd[1]);
	int n;
	while ((n =	read(fd[0],buf,size)) > 0)
		write(1,buf,size);
	close(fd[0]);
	return 0;
}

int main(){
	int pd[2]; int n;
	pipe(pd);
	char buf[1024];

	if (!fork()){
		close(pd[1]);
		while((n = read(pd[0],buf,10)))
			write(1,buf,n);
		close(pd[0]);
		_exit(0);
	}

	char buf2[1024]; int m; close(pd[0]);
	while((m = read(0,buf2,10)) > 1)
		write(pd[1],buf2,m);
	close(pd[1]);
}