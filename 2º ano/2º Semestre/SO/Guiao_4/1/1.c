#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

int main () {
	int fd1 = open("/etc/passwd", O_RDONLY);
	int fd2 = open("saida.txt", O_CREAT | O_WRONLY | O_TRUNC, 0666);
	int fd3 = open("erros.txt", O_CREAT | O_WRONLY | O_TRUNC, 0666);

	dup2(fd1,0);
	dup2(fd2,1);
	dup2(fd3,2);

	if (fd1 == -1 || fd2 == -1 || fd3 == -1)
		return -1;

	int size = 1024;
	char* buffer = malloc(size);
    
    while (read(0, buffer, size) > 0) {
        write(1, buffer, size);
        write(2, buffer, size);
    }

	close(fd1);
	close(fd2);
	close(fd3);

    free(buffer);
	return 0;
}