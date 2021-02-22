#include <string.h>
#include <sys/wait.h>

//não destruir a string original
//tentar não alocar muita memória - strdup em vez de vários mallocs
int mysystem (char* s) {
	//se fizermos o parsing aqui, alocamos a memória do pai, logo no fim é preciso libertar - free(s) no fim do prog
	//s = strdup(s); //"arg1 arg2 arg3 ..." - string tem os argumentos espaçados

	pid_t p = fork();
	if (p == -1) return -1; //se o fork falhar retorna -1
	if (!p) {
		s = strdup(s); //com o parsing aqui alocamos a memória no filho e depois não é preciso libertar porque se corre o exec
		char* a[strlen(s) / 2 + 2]; //alocar memória em excesso - no pior caso possível, os argumentos são todos apenas uma letra
									//p.e. "a b c d e f" - neste caso vai haver strlen/2 + 1 argumentos
									//e precisamos de mais um espaço para o \0 final do array
		//.... separar os argumentos da string - com strtoks por exemplo ou manualmente

		execvp(a[0], a); //manda correr o programa a[0] (nome) com os argumentos a;
		_exit(127); //se o exec falhar retorna 127
	}
	//é perigoso fazer wait aqui porque um outro filho criado algures na main antes de chamar o mysystem pode dar exit
	//antes deste filho em específico acabar, podendo trocar os pids
	int status;
	waitpid(p, &status, 0);
	if (WIFEXITED(status)) {
		return WEXITSTATUS(status);
	}
	//??? - não está definido o que fazer caso o if anterior falhar
}