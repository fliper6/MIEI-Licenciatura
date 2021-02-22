#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>

/*gcc -o redir 4.c
  ./redir -i input.txt -o saida.txt wc 4.c*/

int main (int argc, char* argv[]) {
	for (int i = 1; argv[1]; i++) {
	
		if (argv[i][0] == '-') {
			if (argv[i][1] == 'i') {
				int fd = open(argv[++i],O_RDONLY);
				dup2(fd,0);
				close(fd);
			}
	
			else if (argv[i][1] == 'o') {
				int fd = open(argv[++i],O_CREAT | O_WRONLY | O_TRUNC, 0666);
				dup2(fd,1);
				close(fd);
			}

			else {
				printf("Opção inválida: %s\n", argv[i]);
				return -1;
			}
		}

		else {
			execvp(argv[i], argv+i+1);
		}
	}
	return 0;
}