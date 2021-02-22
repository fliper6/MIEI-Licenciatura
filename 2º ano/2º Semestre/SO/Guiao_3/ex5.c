#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>


//o programa corre executáveis sem argumentos concorrentemente
//se passassemos o executável deste próprio programa como argumento, pode-se pensar que entraria em loop
//contudo não, apenas se cria uma nova execução deste programa sem argumentos, logo não acontece nada
int main (int argc, char* argv[]) {
	for (int i = 1; i < argc; ++i) {
		if (!fork()) {
			execlp(argv[i], argv[i], (char*)0);
			_exit(0);
		}
	}
	for (int i = 1; i < argc; ++i)
		wait(0);
}