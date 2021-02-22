#include <unistd.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>

//1.
//int execlp(const char *file, const char *arg0, ..., NULL);
//execl(p) - troca o programa em execução pelo executável definido pelos argumentos da função
//o execl(p) executa um executável cujo nome é dado no primeiro argumento
//a seguir é dado o nome do executável - neste caso damos o executável original "ls" como podiamos dar qualquer outro - p.e. a.out
//e os restantes argumentos
//(char*)0 = NULL - o último argumento tem necessariamente de ser NULL
//comandos exec com p no fim usam o path atual de onde se está a correr o programa - o primeiro arg da função é o executável
//comandos exec sem p é preciso dar o path inteiro do executável como primeiro argumento
//se o programa executar corretamente, nada do que vem a seguir ao exec é feito
int main1() {
	execlp("ls","ls","-l",(char*)0);
	printf ("flag\n");
}

//2.
int main2() {
	if (!fork()) {
		execlp("ls","ls","-l",(char*)0);
		printf("ola\n");
		_exit(0);
	}
	wait(0);
}