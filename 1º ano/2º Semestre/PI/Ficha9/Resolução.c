#include <stdio.h>

typedef struct abin {
	int ocorre; 
	char pal;
	struct abin *esq, *dir;	
} *Dicionario;


//_1_

void initDic (Dicionario *d) {
	*d= NULL; 
}


Dicionario novaPalavra (char* pal) { //cria novo nodo
	Dicionario n = malloc(sizeof(struct abin));
	n -> pal = pal;
	n -> ocorre = 0;
	n -> esq = NULL;
	n -> dir = NULL;
	return n;
}

int acrescenta (Dicionario *d, char + pal) {
	int r;
	if (!*a) { //dicionário vazio
		*a = novaPalavra(pal);  r = 1;
	}
	else { 
		int c = strcmp (*a->pal,pal); // compara palavra a inserir com a 1ª palavra do dicionário
		if (c > 0) // se a palavra a inserir for superior à 1ª palavra do dicionário
			r = acrescenta (&(*a->dir),pal); // acrescentamo-la à direita
		else if (c < 0)
				r = acrescenta (&(*a->esq),pal);
			 else // quando as palavras são iguais, apenas incrementamos o número de ocorrências (ocorre), não acrescentamos nada
		 		r = *a -> ocorre ++;
    }
    return r; 
}

char *maisFreq (Dicionario d, int *c) { // nesta função, como não alteramos nada no dicionário, apenas lidamos a seu conteúdo (cópia) - d - e não o endereço
	char *r;
	if (!d) { // dicionário vazio 
		*c = 0;
		r = NULL; 		
	} 
	else {
		int oe; // ocorrências da palavra esquerda
		char *pe = maisFreq (d->esq, &oe);
		int od; // ocorrências da palavra direita
		char *pd = maisFreq (d->dir, &od);
		*c = d -> ocorre; // número de ocorrências da palavra atual
		r = d -> pal; // palavra atual
		if (*c < oe) { // se o número de ocorrências da palavra atual for inferior ao da palavra mais frequente da árvore esquerda ...
			*c = oe; // ... o número de ocorrências da palavra atual passa a ser o número de ocorrências da palavra mais frequente da árvore esquerda ...
			r = pe; // ... a nossa palavra atual passa a ser a mais frequente da árvore esquerda 
		}  
		if (*c < od) {
			*c = od;
			r = pd;  
		}
	}
	return r; // devolvemos assim a palavra atual, ou seja, a mais frequente
}

//_2_

typedef struct abin2 {
	int valor;
	struct abin *esq,*dir;
} *ABin;

typedef struct lista {
	int valor;
	struct lista *prox;
} *LInt;

ABin fromListN (Lint *l, int N) {
	if (N == 0)
		return NULL; 
	Abin e = fromListN(e,N/2);
	Abin r = novaABIn(el->valor);
	*l = *l -> prox;
	ABin d = fromListN (l,N-(N/2)-1);
	r -> esq = e;
	r -> dir = d; 
}

ABin fromList (LInt l) {
	// chamar fromListN, com N = comprimento de l
}

//_3_

typedef struct dlista { //lista duplamente ligada
	int valor;
	struct dlista *prox, *ant;
} *DLInt;
	
