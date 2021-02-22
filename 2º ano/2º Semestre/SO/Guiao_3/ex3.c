#include <unistd.h>
#include <stdio.h>

//3.
int main (int argc, char* argv[]) {
	for (int i = 0; argv[i]; i++)
		printf("%s\n",argv[i]);
}