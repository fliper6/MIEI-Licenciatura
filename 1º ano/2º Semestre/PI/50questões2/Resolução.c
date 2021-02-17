typedef struct lligada {
	int valor;
	struct lligada *prox;
} *LInt;


//_1_ (calcula o comprimento de uma lista ligada - não recursiva)
int length (LInt l) {
	int c = 0;  
	while (l != NULL) {
		l = l -> prox; 
		c++; 
	}
	return c;
}

//_2_ (liberta o espaço ocupado por uma lista - não recursiva)
void freeL (LInt l) { 
	while (l != NULL) {
		free(l);
		l = l -> prox; 
	}
}

//_3_ (imprime no ecran os elementos de uma lista (um por linha) - não recursiva)
void imprimeL (LInt l) { 
	while (l != NULL) {
		printf("%d\n", (l-> valor));
		l = l -> prox; 
	}	
}

//_4_ (inverte uma lista (sem criar uma nova lista) - não recursiva)
LInt reverseL (LInt l) {
	LInt seg = l, ant = NULL; // o ant, inicialmente, vai ser o último elemento, daí ant = NULL  
	while (seg != NULL) {
		l = seg; 
		seg = seg -> prox; // tem que estar antes de "l -> prox = ant;" 
		l -> prox = ant; 
		ant = l; 

	}	
	return l; 
}

//_5_ (insere ordenadamente um elemento numa lista ordenada - não recursiva)
void insertOrd (LInt *l, int x) { 
	LInt i = malloc(sizeof(struct lligada));
	while (*l && (x >= ((*l) -> valor))) // (*l != NULL vai dar igual a pôr *l apenas) percorre a lista até um valor da lista ser menor que x 
    	l = &((*l) -> prox);
    i -> valor = x; // o valor desse nodo passa a ser o elemento passa a ser o x
	i -> prox = *l; // e o prox passa a apontar para o nodo atual
	*l = i; 
} 

//_6_ (remove um elemento de uma lista ordenada. Retorna 1 caso o elemento a remover não exista, 0 no outro caso - não recursiva)
int removeOneOrd (LInt *l, int x) {
	LInt i;
	while (*l) {
		if (x == (*l) -> valor) {
  		  i = (*l) -> prox;
		  free(*l);
		  (*l) = i; // *l é o "prox" do nodo antes do x que passa a apontar para i, que é o novo nodo depois de x
		  return 0;
		}
		else l = &((*l) -> prox); 
	}
	return 1; 
}

//_7_ (junta duas listas ordenadas (a e b) numa única lista ordenada (r))
void merge (LInt *r, LInt a, LInt b) {
	while (a && b) {
		if (a -> valor < b -> valor) {(*r) = a; a = a -> prox;}
		else {(*r) = b; b = b -> prox;}
	r = &((*r) -> prox); 
	}
	
	if (a) (*r) = a; // caso b seja nula
	if (b) (*r)  = b; // caso a seja nula
	if (!a && !b) (*r) = NULL; // caso a e b sejam nulas
}

//_8_ (dada uma lista ligada l e um inteiro x, parte a lista em duas (retornando os endereços dos primeiros elementos da lista em *mx e *Mx): uma com os elementos de l menores do que x e a outra com os restantes. Note que esta função não deverá criar cópias dos elementos da lista)
void splitQS (LInt l, int x, LInt *mx, LInt *Mx) {
	while (l) {
		if (l -> valor < x) {(*mx) = l; mx = &((*mx) -> prox);}
		else {(*Mx) = l; Mx = &((*Mx) -> prox);} // (*Mx) = l <-- não criamos cópias dos valores, pomos as listas a apontar para esses valores
		l = l -> prox;
	}
	*mx = 0; // para "terminar" as listas (também podemos igualar a NULL)
	*Mx = 0;
}

//MAL 
//_9_ (parte uma lista não vazia *l a meio)
LInt parteAmeio (LInt *l) {
	int i, i= 0;
	LInt p, t, d = (*l);
	while (p) { // calcula comprimento da lista dada
		i++;
		p = p -> prox;
	}
	j = i/2;
	while (j != 0) {
		j--;
		l = &((*l) -> prox); 

	}
	return t;
}  

//_10_ (remove todas as ocorrências de um dado inteiro de uma lista, retornando o número de células removidas)
int removeAll (LInt *l, int x) {
	int i = 0; // número de ocorrências
	LInt p = *l; 
	LInt ant = NULL; 
	while (p) {
		if (p -> valor == x) {
			i++;
			if (ant == NULL) (*l) = p -> prox; // (início da lista) elimina-se o 1º elemento a pôr a lista a começar no 2º
			else  {ant -> prox = p -> prox;} // (no meio da fila) põe-se o ant a apontar para o seguir do que se quer retirar
		}
		else ant = p; 
	p = p -> prox; 
	}
	return i;
}

//MAL
//_11_ (remove os valores repetidos de uma lista (deixando apenas a primeira ocorrência))
int removeDups (LInt *l) {
	int j = 0, o = 0, i = 0; 
	LInt p,t, ant;
	p = t = ant = (*l);
	while (*l) {
		while (j != 0) { // vai repetir este ciclo o número de vezes equivalente ao número de elementos atrás do que estamos a estudar (j = i)
			if (p -> valor == (*l) -> valor) {
			    o++;
			    i--; // número elementos atrás o (*l) diminui
				ant -> prox = (*l) -> prox; // retira-se esse elemento
			}
			p = p -> prox;  
			j--;
	    }
        p = t; //repor o p 
        i++;
	    j = i; //repor o j 
	    ant = (*l); // O ANT ESTÁ MAL
	    l = &((*l)->prox);
	}
	return o; 
}

//_12_ (que remove (a primeira ocorrência) o maior elemento de uma lista não vazia, retornando o valor desse elemento)
int removeMaiorL (LInt *l) {
	int m;
	LInt p, ant = NULL;
	p = (*l);
	m = (*l) -> valor;  

	while (p) { // procura o valor do maior elemento (1ª ocorrência)
		if (m < p -> valor) m = p-> valor; 
		p = p -> prox;
	}

	while (p) { // retira o maior elemento (1ª ocorrência)
		if (p -> valor == m) {
			if (ant == NULL) (*l) = p -> prox; 
			else ant -> prox = p -> prox;
			return m;
		}
		else ant = p; 
	p = p -> prox; 
  }
}

//_13_ (remove o último elemento de uma lista não vazia (libertando o correspondente espaço) - não recursiva)
void init (LInt *l) {
	LInt a = *l, res = NULL; // !! para evitar erros no código mexer apenas com cópias de (*l) !!

	while (a -> prox) {
		res = a;
		a = a -> prox;
	}

	free(a);
	if (res == NULL) (*l) = NULL; 
	else res -> prox = NULL;
}

//_14_ (acrescenta um elemento no fim da lista - não recursiva)
void appendL (LInt *l, int x) {
	while (*l) {
		l = &((*l)->prox);
	}
    (*l) = malloc(sizeof(struct lligada));
	(*l) -> valor = x;
	(*l) -> prox = NULL; 
}

//_15_ (acrescenta a lista b à lista *a)
void concatL (LInt *a, LInt b) {
	while (*a) {
		a = &((*a)->prox);
	}
	(*a) = malloc(sizeof(struct lligada));
	(*a) = b;
}

//_16_ (cria uma nova lista ligada com os elementos pela ordem em que aparecem na lista argumento)
LInt cloneL (LInt l) {
	LInt r, *e;
	e = &r;
	while (l != NULL) {
		*e = malloc(sizeof(struct lligada));
		(*e)->valor = l -> valor;
		e = &((*e) -> prox);
		l = l -> prox;
	}
	*e = NULL;
	return r;
}
/* Esta definição não funciona: (ao fazermos este tipo de funções convém usarmos endereços)

LInt cloneL (LInt l) {
	LInt t, r;
	r = t; >>>> aqui igualamos r a t, que no início não é está definido
	while (l) {
		t = malloc(sizeof(struct lligada));
		t -> valor = l -> valor;
		t = t -> prox;
		l = l -> prox;
	}
	t = NULL; 
	return r; >>>> ao devolver r dá segmentation fault porque r não está a apontar para nada 
}
*/

//_17_ (cria uma nova lista ligada com os elementos por ordem inversa - não recursiva)	
LInt cloneRev (LInt l) {
	return (reverseL(cloneL (l)));
}

//_18_ (calcula qual o maior valor armazenado numa lista não vazia)
int maximo (LInt l) {
	int m;
	m = l -> valor;  

	while (l) { // procura o valor do maior elemento (1ª ocorrência)
		if (m < l -> valor) m = l -> valor; 
		l = l -> prox;
	}

	return m;
}

//_19_ (dado um inteiro n e uma lista ligada de inteiros l, apaga de l todos os nodos para além do n-ésimo (libertando o respectivo espaço). Se a lista tiver n ou menos nodos, a função não altera a lista. A função deve retornar o comprimento final da lista - iterativa)
int take (int n, LInt *l) {
	int i = 0;
	while (*l) {
	    if (i == (n-1)) {(*l) -> prox = NULL;} // termina a lista
 		if (i >= n) {free (*l);} // apaga os nodos a seguir
 		else i++;
	l = &((*l) -> prox);
	}
	return (i);
}

//_20_ (dado um inteiro n e uma lista ligada de inteiros l, apaga de l os n primeiros elementos da lista (libertando o respectivo espaço). Se a lista tiver n ou menos nodos, a função liberta a totalidade da lista. A função deve retornar o número de elementos removidos - iterativa)
int drop (int n, LInt *l) {
	int a, i = 0;
	LInt p = (*l);
	
    while (p) {p = p -> prox; i++;} // calcula comprimento da lista
    
    if (n >= i) {free(p); (*l) = NULL; return i;} // caso o número de elementos a retirar seja superior ao comprimento, dá-se free a eles todos e (*l) passa a apontar para NULL
    
    a = n;
	while (a != 0) {
 	    free (*l);
 	    a--;
    	(*l) = (*l) -> prox; //	//l = &((*l) -> prox); não dá neste caso
	}

	return (n); // caso o número de elementos a retirar seja inferior ao comprimento, o número de elementos removidos vai ser n
}
//_21_ (dada uma lista circular dá como resultado o endereço do elemento da lista que está N posições à frente)
LInt Nforward (LInt l, int N) {
	while (N != 0) {
		N--;
		l = l -> prox;
	}
	return l;
}

//_22_ (dada uma lista l, preenche o array v com os elementos da lista. A função deverá preencher no máximo N elementos e retornar o número de elementos preenchidos)
int listToArray (LInt l, int v[], int N) {
	int i = 0;
	while (l && N != 0) {
		v[i] = l -> valor;
		l = l -> prox;
		i++;
		N--;
	}
	return i;
}

//_23_ (constrói uma lista com os elementos de um array, pela mesma ordem em que aparecem no array)
LInt arrayToList (int v[], int N) {
	int i = 0;
	LInt *l, e;
	l = &e; // o 'e' permanece no início da lista
	
	while (N != 0) {
	    (*l) = malloc(sizeof(struct lligada));
		(*l) -> valor = v[i];
		l = &((*l) -> prox);
		i++;
		N--;
	}
	(*l) = NULL; 

	return (e);
}

//_24_ (dada uma lista de inteiros, constrói uma nova lista de inteiros contendo as somas acumuladas da lista original (que deverá permanecer inalterada))
LInt somasAcL (LInt l) {
	int s = 0;
	LInt *p, e;
	p = &e; 

	while (l) {
		s += l -> valor;
	    (*p) = malloc(sizeof(struct lligada));
		(*p) -> valor = s;
		p = &((*p) -> prox);
		l = l -> prox;
	}
	(*p) = NULL;

	return e;
}

//MAL
//_25_ (dada uma lista ordenada de inteiros, elimina dessa lista todos os valores repetidos assegurando que o espaço de memória correspondente aos nós removidos é correctamente libertado)
void remreps (LInt l) {

}

//_26_ (coloca o primeiro elemento de uma lista no fim. Se a lista for vazia ou tiver apenas um elemento, a função não tem qualquer efeito prático (i.e., devolve a mesma lista que recebe como argumento))
LInt rotateL (LInt l) {
	LInt a = l;

    if (!l || !(l -> prox)) return l; // para listas vazias ou de 1 elemento ficam iguais
    
	while (l -> prox) 
		l = l -> prox;

	l -> prox = a; // o último passa a apontar para o primeiro
	l = a -> prox; // o início da lista passa a ser o segundo nodo
	a -> prox = NULL; // o primeiro passa a apontar para NULL (termina-se a lista)
	return l;

}

//_27_ (parte uma lista l em duas: na lista l ficam apenas os elementos das posições ı́mpares; na lista resultante ficam os restantes elementos.) 
LInt parte (LInt l) {
	int i = 1;
  	LInt *x, *y, p; 
  	x = &l;
  	y = &p;

    if (!l || !(l -> prox)) return NULL; 

  	while (*x) {
  		if (i%2 == 0) { // elementos pares na lista y
  			(*y) = malloc(sizeof(struct lligada));
  			(*y) = (*x);
  			y = &((*y) -> prox);
  			(*x) = (*x) -> prox;
  		}
  	
  		if (i%2 != 0) { // elementos ímpares na lista l
  			x = &((*x) -> prox);
  		}
  		i++;
  	}

  	(*y) = NULL;
  	l = NULL;

  	return p;
}

/*-------------------------------------------------------------------------ÁRVORES BINÁRIAS--------------------------------------------------------------------------*/

typedef struct nodo {
	int valor;
	struct nodo *esq, *dir;
} *ABin;

//_28_ (calcula a altura de uma árvore binária)
int maximaAlt (int x, int y) {
	if (x > y) return x;
	else return y;
}

int altura (ABin a) {
	int t;
	if (a == NULL) return 0;
	else t = 1 + maximaAlt(altura (a -> esq), altura (a -> dir));
	return t;
}

//_29_ (cria uma cópia de uma árvore)
ABin cloneAB (ABin a) {
	ABin b;
	if (!a) return NULL;
	else {
		b = malloc(sizeof(struct nodo));
		b -> valor = a -> valor;
		b -> esq = cloneAB(a -> esq);
		b -> dir = cloneAB(a -> dir);
	}
	return b;
}

//_30_ (inverte uma árvore (sem criar uma nova árvore))
void mirror (ABin *a) {
	ABin b;
	if (*a) { // serve como condição de paragem
		b = (*a) -> esq;
		(*a) -> esq = (*a) -> dir;
		(*a) -> dir = b; 

		mirror(&((*a)->dir));
		mirror(&((*a)->esq));
	}
}

//_31_ (cria uma lista ligada de inteiros a partir de uma travessia inorder de uma árvore binária) esq -> raiz -> dir
LInt* inorder (ABin a, LInt *l) {
	if (!a) (*l) = NULL; // condição de paragem 
	else {
		l = inorder(a->esq,l);
		(*l) = malloc(sizeof(struct nodo));
		(*l) -> valor = a -> valor;
		l = &((*l)->prox);
		l = inorder(a->dir,l);
	}
	return l;
}

//_32_ (cria uma lista ligada de inteiros a partir de uma travessia preorder de uma árvore binária) raiz -> esq -> dir 
void preorder (ABin a, LInt *l) {
   if (!a) (*l) = NULL; // condição de paragem 
   else {
		(*l) = malloc(sizeof(struct nodo));
		(*l) -> valor = a -> valor;
		l = &((*l)->prox);
		preorder(a->esq,l);
		while (*l) {l = &((*l)->prox);} // depois de por na lista os da 'esq', temos que avançar até ao fim para começarmos a por os da 'dir'
		preorder(a->dir,l);
	}
}

//_33_ (cria uma lista ligada de inteiros a partir de uma travessia posorder de uma árvore binária) esq -> dir -> raiz
void posorder (ABin a, LInt *l) {
   if (!a) (*l) = NULL; // condição de paragem 
   else {
		posorder(a->esq,l);
		while (*l) {l = &((*l)->prox);} 
		posorder(a->dir,l);
		while (*l) {l = &((*l)->prox);} 
		(*l) = malloc(sizeof(struct nodo));
		(*l) -> valor = a -> valor;
		(*l) -> prox = NULL; // depois de pormos a raiz, terminamos a lista
	}
} 

//_34_ (calcula o nı́vel (menor) a que um elemento está numa árvore binária (-1 caso não exista))
int depth (ABin a, int x) {
	int n = 1, e, d; 
	// se a o elemento estiver logo na raíz, não vai entrar em nenhum if e a n vai permanecer 1
	if (!a) return -1;

	if (x != a -> valor) {
		e = depth (a -> esq, x);
		d = depth (a -> dir, x);
		if (e == -1) n += d; // caso x não esteja na esq
		if (d == -1) n += e; // caso x não esteja na dir
		if (e != -1 && d != -1 && e < d) n += e; // o menor nível em que x vai estar vai estar vai ser 1 - n - (da raíz) + o menor 'depth' dos dois lados
		if (e != -1 && d != -1 && d < e) n += d;
	}
	return n;
}

//_35_(liberta o espaço ocupado por uma árvore binária, retornando o número de nodos libertados)
int freeAB (ABin a) {
	int n = 1;

	if (!a) return 0;
	else {
		free(a);
		n += freeAB(a -> esq) + freeAB(a -> dir);
	}

	return n;
}

//_36_ (remove (libertando o espaço respectivo) todos os elementos da árvore *a que estão a uma profundidade superior a l, retornando o número de elementos removidos)
int pruneAB (ABin *a, int l) {
	int n = 0;

	if (*a) {
	    n += pruneAB(&((*a)->esq), l-1) + pruneAB(&((*a)->dir), l-1);
		
		if (l <= 0) { // a partir do momento em que chega à profundidade indicada, começa a dar free a todos os nodos seguintes
			free (*a);
			(*a) = NULL;
   			n++;
		}
    }
    
	return n; 
}

//_37_ (testa se duas árvores são iguais (têm os mesmos elementos e a mesma forma)) 0 - diferentes / 1 - iguais
int min (int a, int b) {
	if (a < b) return a;
	else return b;
}

int iguaisAB (ABin a, ABin b) {
	int n = 1;
	if (!a && !b) return 1;
	if (a && b) { 
		if (a -> valor == b -> valor) 
			n = min(iguaisAB(a->esq,b->esq), iguaisAB(a->dir,b->dir));
		else n = 0;
	}
	else if ((a && !b) || (!a && b)) return 0; // se não têm o mesmo comprimento nunca serão iguais
	return n;
}

//MAL
//_38_ (dada uma árvore binária, constrói uma lista com os valores dos elementos que estão armazenados na árvore ao nı́vel n (assuma que a raiz da árvore está ao nı́vel 1))
LInt nivelL (ABin a, int n) {

}


//MAL
//_39_ (preenche o vector v com os elementos de a que se encontram no nı́vel n. Considere que a raı́z da árvore se encontra no nı́vel 1. A função deverá retornar o número de posições preenchidas do array)
int nivelV (ABin a, int n, int v[]) {

}

//_40_ (dada uma árvore a, preenche o array v com os elementos da árvore segundo uma travessia inorder. A função deverá preencher no máximo N elementos e retornar o número de elementos preenchidos)
int dumpAbinAux (ABin a, int v[], int N, int i) { // a função auxiliar serve para podermos ir acumulando o 'i'
	if (a) {
		i = dumpAbinAux(a->esq,v,N,i);
		if (i < N) { // é até i < N apenas porque temos que considerar que v começa em v[0] e não v[1]
			v[i] = a -> valor;
			i++;
	    }
		i = dumpAbinAux(a->dir,v,N,i);
	}
	return i;
}

int dumpAbin (ABin a, int v[], int N) {
	int i = 0;
	return (dumpAbinAux (a,v,N,i));
}

//MAL
//_41_ (dada uma árvore de inteiros, calcula a árvore das somas acumuladas dessa árvore. A árvore calculada deve ter a mesma forma da árvore recebida como argumento e em cada nodo deve conter a soma dos elementos da sub-árvore que aı́ se inicia) 
ABin somasAcA (ABin a) {
	ABin *b = NULL;
    
	if (a) {
		(*b) -> esq = somasAcA (a -> esq);
		(*b) -> dir = somasAcA (a -> dir);
		(*b) = malloc(sizeof(struct nodo));
		if (((*b) -> esq) && ((*b) -> dir))
			(*b) -> valor += ((*b) -> esq)-> valor + ((*b) -> dir) -> valor;
		else if (((*b) -> esq) && !((*b) -> dir))
				(*b) -> valor += ((*b) -> esq)-> valor;
		else if (!((*b) -> esq) && ((*b) -> dir))
				(*b) -> valor += ((*b) -> dir)-> valor;
		else (*b) -> valor = (*b) -> valor;
	}
	return *b;
}

//_42_ (dada uma árvore binária de inteiros, conta quantos dos seus nodos são folhas, i.e., que não têm nenhum descendente.)
int contaFolhas (ABin a) {
	int n = 0; 
	if (a) {
		n = contaFolhas (a -> esq) + contaFolhas (a -> dir);
		if (!(a -> esq) && !(a -> dir)) n++;
	}
	return n;
}

//_43_(cria uma árvore nova, com o resultado de inverter a árvore (efeito de espelho))
ABin cloneMirror (ABin a) {
	ABin b;
	if (!a) return NULL;
	else { 
		b = malloc(sizeof(struct nodo));
		b -> valor = a -> valor;
		b -> esq = cloneMirror(a -> dir);
	    b -> dir = cloneMirror(a -> esq);
	}
	return b;
}

//_44_ (adiciona um elemento a uma árvore binária de procura. A função deverá retornar 1 se o elemento a inserir já existir na árvore ou 0 no outro caso - não recursiva)
int addOrd (ABin *a, int x) {
	ABin *b = a;

 	while (*b) {
 		if ((*b) -> valor > x) {
 			b = &((*b) -> esq);
 		}
 		if ((*b) -> valor == x) {
 			return 1;
 		}
 		if ((*b) -> valor > x) {
 			b = &((*b) -> esq);
 		}
 	}

 	if (!(*b)) {
 		(*b) = malloc(sizeof(struct nodo)); 
 		(*b) -> valor = x; 
 		(*b) -> esq = (*b) -> dir = NULL;
 		return 0;
 	}
 }

//MAL
//_45_ (testa se um elemento pertence a uma árvore binária de procura - não recursiva)
int lookupAB (ABin a, int x) {
	ABin b;
	a = &b;

 	while (b) {

 		if (b -> valor == x) {
 			return 0;
 		}

 		//...
 	}
}

//MAL
//_46_ (calcula o nı́vel a que um elemento está numa árvore binária de procura (-1 caso não exista))
int depthOrdAux (ABin a, int x, int n) {
	if (!a) return -1;
	else {
		//...
	}
}

//_47_ (calcula o maior elemento de uma árvore binária de procura não vazia)
int maiorAB (ABin a) {
	int m;
	if (a) {
		if (!(a -> dir)) return (a -> valor); // numa árvore binária de procura o maior elemento está sempre na extremidade mais à direita
		else m = maiorAB(a -> dir);
	}
	return m;
}

//_48_ (remove o maior elemento de uma árvore binária de procura)
void removeMaiorA (ABin *) {

}

//_49_ (dada uma árvore binária de procura de inteiros e um inteiro, conta quantos elementos da árvore são maiores que o inteiro dado)
int quantosMaiores (ABin a, int x) {
	int i = 0;
	if (!a) return 0;
	else {
		if (a -> valor > x) i++;
	i += quantosMaiores (a -> esq, x) + quantosMaiores (a -> dir, x);
	} 
	return i;
}


//_50_ (constrói uma árvore binária de procura a partir de uma lista ligada ordenada)
void listToBTree (LInt l, ABin *a) {

}

//_51_
int deProcura (ABin a) {
	//...
}
