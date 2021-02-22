#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>

int main () {
	if (mkfifo("fifo",0666) == -1)
		perror("fifo");
	return 0;
}