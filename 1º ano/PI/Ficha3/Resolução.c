#include <stdio.h>

//-----(2)
void swapM (int *x, int *y) {
    int i = *x; // guardar no i o que originalmente está no x (criou-se um espaço i na memória que guarda 3)
    *x = *y; // o que estava no espaço x passa a ser igual ao que estava no espaço y
    *y = i; // (o tipo i é int (porque é O QUE ESTÁ no espaço x -- x não é de tipo int (*x é que é)))
} 

//-----(3)
void swap (int v[], int i, int j) { // int v[] é igual a int * v 
	int t;
	t = v[j]; // vai ao v original e vai buscar o que está j posições à frente = *(v+j)
    v[j] = v[i];
    v[i] = j;
}

//-----(4)
int soma (int v[], int N) {
	int s = 0;
    for (int i = 0; i < N; i++) {
    	s = s + *(v+i);
	}
	return s; 
}

//-----(5)
int maximum (int v[], int N, int *m) {
	int r = 0;
	*m = 0; 
	if (N <= 0) r = 1; // para verificar se o N (tamanho do vetor) é superior a 0 (se for, r mantém-se igual a 0 e, quando a função der return, não dá erro)
	for (int i = 0; i< N; i++) {
		if (*m < v[i]) *m = v [i];
	}
    return r;
}

void quadrados (int q[], int N) {
	
}

int main () {
 //-----(1)
 /*--(a) <- caderno 
 int x [15] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}; 
 int *y, *z, i; 
 y = x; z = x+3;
 for (i=0; (i<5); i++) {
    printf ("%d %d %d\n", x[i], *y, *z);
    y = y+1; z = z+2;
 }
*/

 //-----(2)
 int x = 3, y = 5;
 swapM (&x,&y); // os & servem para dar à swapM os espaços em que x e y estão (não os seus valores)
 printf("%d %d \n", x, y);

 //-----(4)
 int v[10] = {1,2,3,4,5,6,7,8,9,10};
 printf("%d \n",soma (v,10));

 //-----(5)
 int v[10];
 int m;
 if (0 == maximum (v,10,&m)) printf("%d \n", m); // ou seja, não dá erro (N > 0) // imprime valores aleatórios
 else printf("erro lol" );
}
















