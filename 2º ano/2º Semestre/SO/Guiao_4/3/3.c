#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/wait.h>

int main () {
	int fd1 = open("/etc/passwd", O_RDONLY);
	int fd2 = open("saida.txt", O_CREAT | O_WRONLY | O_TRUNC, 0666);

	dup2(fd1,0);
	dup2(fd2,1);

	if (!fork()) {
		execlp("wc","wc",NULL);
		_exit(0);
	}

	wait(NULL);
	close(fd1);
	close(fd2);

	return 0;
}