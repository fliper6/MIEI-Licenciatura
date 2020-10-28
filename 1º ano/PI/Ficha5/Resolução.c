#include <stdio.h>
//-----(1) // dado uma lista ordenada e um elemento, coloca esse elemento na posição correta dessa lista
void insere (int v[], int N, int x) { // temos de arrastar para o lado direito os números quen forem maiores do que o número que queremos inserir (para arranjarmos espaço para colocar esse número)
	int i; 
	for (i = N-1; i >= 0 && v[i] > x; i--) { // (temos de supor que N = numero de elementos de v + 1 espaço para alocar o novo elemento, no mínimo)
		v[i++] = v[i];
	}
	v[i+1] = x; // porque v[i] já é menor que x, queros pôr x a seguir e esse 
}

//-----(2) // organiza os elementos de uma lista pegando e neles e colocando-os um a um, de modo ordenado, numa nova lista (inicialmente vazia)  

/*
void iSort (int v[], int N) {
	int i;
    for (i=1; (i<N); i++) {
    	insere (v, i, v[i]);
    }
}
*/

void iSort (int v[], int N) { // agora sem usar a função auxiliar 'insere'
// queremos, em cada passo, inserir um elemento, considerando que para trás já esstá tudo ordenado
	int k;
	for (k = 1; k < N; k++) { // k = 1 porque o primeiro elemento, como está sozinho numa lista, já está ordenado
    	int i;
    	for (i = k-1; i >= 0 && v[i] > v[k]; i--) { // 'insere'
			v[i++] = v[i];
	    }
	    v[i+1] = x
	} 
}

//-----(3) 
int maxInd (int v[], int N) {
	int i, int c = 0;
	for (i = 1; i < N; i++) 
		if (v[c] < v[i]) c == i;
	return c;
}
 
//-----(4)
void sSort (int v[], int N) {
	int i; 
	for (i = N-1; i >= 0; i--) {
		int r = maxInd (v, i+1)
		swap (v, r, i);
	}
}

//-----(5)

//-----(6)
void bubble (int v[], int N) { // aula teórica
	int i;
	for (i = 1; (i < n); i++)
		if (v[i-1] > v[i]) swap (v,i-1, i);
}

//-----(7)
void bubbleSort (int v[], int N) {
	while (N > 0) {
		bubble (v, N);
	    N--;
	}
}

//-----(8)

//-----(9)
void merge (int r [], int a[], int na, int b[], int nb) {
	int ai = 0; bi = 0; ri = 0;
	while (ai < m && bi < nb) {
		if (a[ai] < b[bi])
			r[ri++] = a[ai++];
		else r[ri++] = b[bi++]; 
	}
	while (bi < nb)
		r[ri++] = b[bi++];
	while (ai < na)
		r[ri++] = a[ai++];
}

void mergesort (int v[], int n, int aux[]) {
	int i, m;
	if (n>1) {
		m = n/2;
		mergesort (v, m, aux);
		mergesort (v+m, n-m, aux);
		merge (aux, v, m, v+m, n-m);
		for (i=0; (i<n); i++)
			v[i] = aux[i];
	}
}