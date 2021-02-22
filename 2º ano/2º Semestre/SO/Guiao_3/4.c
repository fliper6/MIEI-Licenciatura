#include <unistd.h>

// 0   1    2    3
//ex4 arg1 arg2 arg3 ...

//int execvp(const char *file, char *const argv[]);
//recebe os argumentos do executável como array (argv)

//para correr isto é preciso gerar o executável do exercício 3 - cc ex3.c -o ex3
//compila-se o ex4.c e executa-se o executável ex4 com os argumentos que quisermos
//estes são redirecionados para o executável ex3, que os imprime
int main (int argc, char* argv[]) {
	execv("./ex3",argv+1); //executa o execício 3 dando-lhe os argumentos que são dados ao ex4
							//argv+1 para excluir o nome do programa atual e passar só os argumentos
}