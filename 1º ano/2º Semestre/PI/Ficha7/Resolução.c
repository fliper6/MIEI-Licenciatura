//_1_
typedef struct slist *LInt;
typedef struct slist {
	int valor;
	LInt prox; // apontador para o próximo elemento da lista 
} Nodo;

//_a_
LInt Lista () {
	Nodo *n = malloc(sizeof(Nodo));
	n -> valor = 10; 
	n -> prox = NULL; 

	Nodo *m = malloc(sizeof(Nodo));
	n -> valor = 5;
	n -> prox = m;
	m -> prox = NULL;

	return n; // n aponta para o primeiro elemento da lista 
}

//_b_

//_i_
LInt cons (LInt l, int x) {
	Nodo *n = malloc(sizeof(Nodo));
	n -> valor = x;
	n -> prox = l;

	return n;
}

//_ii_
LInt tail (LInt l) {
	LInt n; 
	n -> valor = (l -> prox) -> valor;
	n -> prox = (l -> prox) -> prox;
	free (l);
	return n; 
}

/*
LInt tail (LInt l) {
	LInt n = l -> prox;
	free (l);
	return n; 
}
*/

//_iii_
LInt init (LInt l) { // assumindo que l é não vazia
	if (l -> prox == NULL) return NULL; //  = if (!l -> prox) --- listas de 1 elemento 

	LInt l1 = l; // para não mudarmos o l (para retornarmos l)
	LInt p = NULL;
	while (l1 -> prox != NULL) {
		p = l1;
		l1 = l1 -> prox; // "incrementamos" l1
	}
	free (l1);
	p -> prox = NULL; // para terminarmos a nova lista 
	return l;
}

//_iv_
LInt snoc (LInt l, int x) {
	LInt k = l;
	while (k -> prox != NULL) 
		k = k -> prox;
	Nodo *n = malloc(sizeof(Nodo));
	n -> valor = k;
	n -> prox = NULL;
	k -> prox = n;
	return l;
}

//_v_
LInt concat (LInt a, LInt b) {

}


//_2_

//_a_
typedef struct  aluno {
	int numero;
	int nota;
	char nome [60];
} Aluno;

typedef struc naluno {
	Aluno valor;
	NAluno *prox;
} NAluno;

typedef struct naluno *Turma;

//_b_
int acrescentaAluno (Turma *t, Aluno a) { // assumimos que está ordenada

}

/*
main () {
	Turma t;
	acrescentaAluno (&t, )
}
*/