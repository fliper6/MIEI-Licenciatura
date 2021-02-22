#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>

int main () {
	int n, size = 1024;
	int fd = open("fifo", O_WRONLY);
	char buf[size];

	while ((n = read(0,buf,size)) > 1)
		write(fd,buf,n);
	
	close(fd);
	return 0;
}