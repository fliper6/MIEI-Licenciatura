#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>

int main () {
	int n, size = 1024;
	int fd = open("fifo", O_RDWR);
	char buf[size];

	while (n = read(fd,buf,size))
		write(1,buf,n);
	
	close(fd);
	return 0;
}