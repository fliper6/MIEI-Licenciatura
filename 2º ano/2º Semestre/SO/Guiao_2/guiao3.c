#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>
/*
	fork cria um processo filho para executar código paralelamente ao pai e retorna o pid (process id) do filho
	o pai executa a generalidade do programa, ocasionalmente criando um filho para executar certos pedaços de código
	
	pid_t pid = fork();
	if (!pid) {
		//filho
		_exit(0);
	}
	//pai

int main() {
	printf("ola"); //como não tem um \n, não se faz flush (ocorre quando se encontra um '\n' ou no fim do programa)
	fork(); //da informação em memória. O write só ocorre quando é realizado o flush
	fork(); //os forks vão ficar com uma cópia da informação bufferizada para o print
	fork(); //no fim do programa, todos os processos fazem flush, logo printa-se 8 'ola'

	_exit(0); //o _exit termina o programa imediatamente - como não se chega a fazer flush, não se printa nada
}
*/

//usar o comando ps no terminal para comprovar se o pai é a bash - comparar os pids
void ex1() {
	printf("Id do pai: %d\n", getppid());
	printf("Id do processo: %d\n", getpid());
}

void espera() {
	for (long i = 0; i < 2L << 29; ++i);
}
/*
void main () {
	pid_t pid = fork();
	if (!pid) { //filho
		espera();
		printf("Id do pai do filho: %d\n", getppid());
		printf("Id do processo filho: %d\n", getpid());
		_exit(0); //essencial para matar o processo, senão continua a correr sem fim
	}
	//wait(); //sem o wait, os prints não ocorrem pela ordem em que estão escritos
				  //o pai e o filho correm em paralelo
	printf("Id do filho do pai: %d\n", pid);
	printf("Id do pai do pai: %d\n", getppid());
	printf("Id do processo pai: %d\n", getpid());
}*/

/*
int main() { //o pai morre antes do filho, então o filho é "adotado" pelo init, por isso o ppid é 1
	if (!fork()) { //não é preciso guardar o pid 
		espera();
		printf("sou o filho, pid: %d, ppid: %d\n", getpid(), getppid());
	} else {
		printf("sou o pai, pid: %d, ppid: %d\n", getpid(), getppid());
	}
}

int main() { //observar um processo zombie - o filho terminou mas o pai ainda não recolheu o seu pid com wait
			 //pomos o pai a fazer tempo depois do filho acabar e fazemos ps l noutro terminal
			 //o filho vai ter estado Z+ (zombie) porque o pai ainda não fez nada
	if (!fork()) {
		printf("sou o filho, pid: %d, ppid: %d\n", getpid(), getppid());
	} else {
		espera();
		printf("sou o pai, pid: %d, ppid: %d\n", getpid(), getppid());
	}
}*/

//3
/*int main() {
	for (int i = 0; i < 10; i++) {
		if (!fork()) { //sem wait, passariamos a ter 2, 4, 8, ... processos - o fork duplica todos os existentes
			//printf("pid: %d, ppid: %d\n", getpid(), getppid());
			_exit(i+1); //número do filho
		}
		int status; //guardar variável que indica modo como o processo terminou
		wait(&status);
		if (WIFEXITED(status)) {
			printf("filho fez exit: %d\n", WEXITSTATUS(status));
		}
	}
}*/

//4
/*int main() {
	for (int i = 0; i < 10; i++) { //cria processos e ficam todos a correr concorrentemente
		if (!fork()) { 
			printf("pid: %d, ppid: %d\n", getpid(), getppid());
			_exit(i);

		}
	}
	for (int i = 0; i < 10; i++) { //para o pai saber que status corresponde a que filho, cria-se um array dos pids dos filhos no primeiro for
		//compara-se o pid retornado pelo wait com o array e sabe-se que foi o filho posição i do array
		int status; //guardar variável que indica modo como o processo terminou
		wait(&status); //wait retorna o pid do filho que acabou
		if (WIFEXITED(status)) {
			printf("filho fez exit: %d\n", WEXITSTATUS(status));
		}
	}
}*/

//5
int main2 () { //versão a imprimir todos por ordem
	for (int i = 1; i < 11; i++) {
		printf("%d %d %d\n", i, getpid(), getppid());
		if (i == 10) _exit(0); //saída do último processo do ciclo, para não criar um filho a mais
							   //ou break se queremos que ainda façam algo fora do ciclo
		pid_t p = fork();
		//if (p) _exit(0); //dar exit ao pai, o filho continua
						 //ao continuar, cria outro filho e deixa de existir também
		if (p) {
			//wait(0); //evitar orfãos - a certo ponto o pai vai estar à espera de todos os filhos
					 //os waits vão ser todos concluídos do último processo para o primeiro (ordem contrário)
			_exit(0);
		}
	}
}

int main3 () { //versão a imprimir todos pela ordem contrária - mas ter código duplicado é chato
	for (int i = 1; i < 11; i++) {
		if (i == 10) {
			printf("%d %d %d\n", i, getpid(), getppid());
			_exit(0); 
		}
		pid_t p = fork();
		if (p) {
			wait(0); //evitar orfãos - a certo ponto o pai vai estar à espera de todos os filhos
					 //os waits vão ser todos concluídos do último processo para o primeiro (ordem contrário)
			printf("%d %d %d\n", i, getpid(), getppid());
			_exit(0);
		}
	}
}

int main () { //versão a imprimir todos pela ordem contrária - sem código duplicado
	int i;
	for (i = 1; i < 11; i++) {
		if (i == 10) break; //com break os processo continuam fora do ciclo
		pid_t p = fork();
		if (p) {
			wait(0);
			break;
		}
	}
	printf("%d %d %d\n", i, getpid(), getppid());
	_exit(0);
}

//6
int encontraMatriz (int l, int c, int m[l][c], int num) {
	for (int i = 0; i < l; i++) {
		if (!fork()) {
			for (int j = 0; j < c; j++)
				if (m[i][j] == num) _exit(1);
			_exit(0);
		}
	}
	for (int i = 0; i < l; i++) {
		int status;
		wait(&status);
		if (!WIFEXITED(status)) return -1; //assert(WIFEXITED(status)) - não é suposto acontecer, se acontecer crasha tudo logo
		if (WIFEXITED(status)) {
			if (WEXITSTATUS(status)) return 1;
		}
	}
	return 0;
}

int mainn () {
	int m[6][500];
	int p = 5;
	for (int i = 0; i <	6; i++) {
		for (int j = 0; j < 500; j++) {
			m[i][j] = p;
			p++;
		}
	}
	printf("Resultado da encontraMatriz: %d\n", encontraMatriz(6,500,m,663));
	return 0;
}

//7
void encontraMatriz2 (int l, int c, int m[l][c], int num) {
	for (int i = 0; i < l; i++) {
		if (!fork()) {
			for (int j = 0; j < c; j++)
				if (m[i][j] == num) _exit(1);
			_exit(0);
		}
	}
	for (int i = 0; i < l; i++) {
		int status;
		wait(&status);
		if (WIFEXITED(status)) {
			if (WEXITSTATUS(status) == 1) printf("O processo %d encontrou\n", i);
		}
	}
}

int maine() {
	int m[6][500];
	int p = 5;
	for (int i = 0; i <	6; i++) {
		if (i%2 != 0) p = 50;
		else p = 5;
		for (int j = 0; j < 500; j++) {
			m[i][j] = p;
			p++;
		}
	}
	encontraMatriz2(6,500,m,30);
	return 0;
}