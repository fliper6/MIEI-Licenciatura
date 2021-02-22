#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>

//1
int cria10Mb (char* nome) {							 
	int fd = open(nome, O_WRONLY | O_TRUNC | O_CREAT, 0666);
					 
	const int N = 1000;
	const int IT = 10000;
	char* buf = malloc(N);
	for (int i = 0; i < N; ++i) buf[i] = 'a';
	for (int i = 0; i < IT; ++i) {
		write(fd, buf, N);
	}
}
//2
int catfiltro (int N) {
	char c;
	//while true
	while (1) {
		//0 - standart input
		int n = read(0, &c, 1);
		if (n <= 0) break;
		//1 - standart output
		write(1, &c, 1);
	}
}

//3
int mycat (int N) {
	char* buf = malloc(N);
	while (1) {
		int n = read(0,buf,N);
		if (n <= 0) break;
		write(1,buf,N);
	}
}

//5
ssize_t myreadline (int fd, void* buf, size_t nb) {
	size_t i = 0;
	char* b = buf;
	while (1) {
		int n = read(fd,&b[i],1);
		if (n <= 0) break;
		const char c = b[i++];
		if (c == '\n') break;
	}
	return i;
}

//6
int main2 (int argc, char* argv[]) {
	int fd = 0;
	if (argc == 2) fd = open(argv[1], O_RDONLY);
	int BUFSIZE = 100000;
	char* buf = malloc(BUFSIZE);
	int linha = 1;
	while (1) {
		int pre = 8;
		ssize_t n = myreadline (fd, buf + pre, BUFSIZE - pre);
		if (n <= 0) break;
		if (n != 1) {
			sprintf (buf, "%6d ", linha);
			linha += 1;
			write(1, buf, pre + n);
		}
		else write(1, buf + pre, n);
	}
}

//1 adicional
int main (int argc, char* argv[]) {
	for (int i= 1; i < argc; i++) {
		int fd = open(argv[i], O_RDONLY);
		char c;
		while (read(fd,&c,1))
			write(1,&c,1);
		close(fd);
	}
}