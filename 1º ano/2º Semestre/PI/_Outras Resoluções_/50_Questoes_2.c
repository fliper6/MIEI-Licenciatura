typedef struct lligada {
	int valor;
	struct lligada *prox;
} *LInt;

//1. certo
int length (LInt l) {
	int count = 0;
	while (l != NULL) {
		++count;
		l = l -> prox;
	}
	return count;
}

//2.
void freeL (LInt l) {
	free (l);
}

//3.
void imprimeL (LInt l) {
	while (l != NULL) {
		printf("%d\n",l->valor);
		l = l -> prox;
	}
}

//4. certo
LInt reverseL (LInt l) {
	LInt p = NULL, ant;
	while (l != NULL) {
		ant = l;
		l = l -> prox;
		ant -> prox = p;
		p = ant;
	}
	return p;
}

//5. certo
void insertOrd (LInt *l, int x) {
	LInt r = *l, ant = NULL, new;
	while (r != NULL && r -> valor < x) {
		ant = r;
		r = r -> prox;
	}
	new = newLInt(x,r);
	if (ant == NULL) *l = new;
	else ant -> prox = new;
}

//6. certo
int removeOneOrd (LInt *l, int x) {
	LInt r = *l, ant = NULL;
	while (r != NULL && r -> valor != x) {
		ant = r;
		r = r -> prox;
	}
	if (r == NULL) return 1;
	else {
		if (ant == NULL) *l = r -> prox;
		else ant -> prox = r -> prox;
		return 0;
	}
}

//7. certo
void merge (LInt *r, LInt a, LInt b) {
	while (a != NULL && b != NULL) {
		if (a -> valor < b -> valor) {
			*r = a;
			a = a -> prox;
		}
		else {
			*r = b;
			b = b -> prox;
		}
		r = &((*r)->prox);
	}
	if (a == NULL) *r = b;
	else *r = a;
}

//8. certo
void splitQS (LInt l, int x, LInt *mx, LInt *Mx) {
	while (l) {
		if (l->valor < x) {
			*mx = malloc(sizeof(struct lligada));
			(*mx) -> valor = l -> valor;
			mx = &((*mx)->prox);
		}
		else {
			*Mx = malloc(sizeof(struct lligada)),
			(*Mx) -> valor = l -> valor;
			Mx = &((*Mx)->prox);
		}
		l = l -> prox;
	}
}

//9. certo
int tamanho (LInt l) {
	int i = 0;
	while (l) {
		l = l -> prox;
		++i;
	}
	return i;
}

LInt parteAmeio (LInt *l) {
	int tam = tamanho(*l)/2, i = 0;
	LInt y = NULL, *ys = &y, el = *l;
	while (i < tam) {
		*ys = malloc(sizeof(struct lligada));
		(*ys) -> valor = (el) -> valor;
		ys = &((*ys)->prox);
		*ys = NULL;
		el = el -> prox;
		++i;
	}
	*l = el;
	return y;
}

//10. certo
int removeAll (LInt *l, int x) {
	int count = 0;
	LInt r = *l, ant = NULL;
	while (r != NULL) {
		if (r -> valor == x) {
			if (ant == NULL) {
				*l = r -> prox;
				++count;
			}
			else {
				ant -> prox = r -> prox;
				++count;
			}
			r = r -> prox;
		}
		else {
			ant = r;
			r = r -> prox;
		}
	}
	return count;
}

//11. certo
int ocorre (int v[], int N, int x) {
	int i;
	for (i = 0; i < N; ++i)
		if (v[i] == x) return 1;
	return 0;
}

int removeDups (LInt *l) {
	int v[100], i = 0, num = 0;
	LInt ant = NULL;
	while (*l) {
		if (ocorre(v,i,(*l)->valor) == 0) {
			v[i] = (*l)->valor;
			++i;
			ant = *l;
			l = &((*l)->prox);
		}
		else {
			ant -> prox = (*l) -> prox;
			l = &(ant->prox);
			++num;
		}
	}
	return num;
}

//12. certo
int removeMaiorL (LInt *l) {
	int x; LInt r = *l, ant = NULL;
	if (r == NULL) return 0;

	x = r -> valor;
	r = r -> prox;
	while (r != NULL) {
		if (x < r -> valor) x = r -> valor;
		r = r -> prox;
	}
	r = *l;
	while (r != NULL && x != r -> valor) {
		ant = r;
		r = r -> prox;
	}

	if (ant == NULL) *l = r -> prox;
	else ant -> prox = r -> prox;
	return x;
}

//13. certo
void init (LInt *l) {
	LInt r = *l, ant = NULL;
	while (r -> prox != NULL) {
		ant = r;
		r = r -> prox;
	}
	if (ant == NULL) *l = ant;
	else ant -> prox = NULL;
	free(r);
}

//14. certo
void appendL (LInt *l, int x) {
	LInt r = *l, new = newLInt(x,NULL);
	if (r == NULL) *l = new;
	else {
		while (r -> prox != NULL) 
			r = r -> prox;
		r -> prox = new;
	}
}

//15. certo
void concatL (LInt *a, LInt b) {
	LInt r = *a;
	if (r == NULL) *a = b;
	else {
		while (r -> prox != NULL)
			r = r -> prox;
		r -> prox = b;
	}
}

//16. certo
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

//17. certo
LInt cloneRev (LInt l) {
	LInt r, *e = &r, dep = NULL;
	while (l != NULL) {
		dep = newLInt(l -> valor, dep);
		l = l -> prox;
	}
	*e = dep;
	return r;
}

//18. certo
int maximo (LInt l) {
	int x = l -> valor;
	l = l -> prox;
	while (l != NULL) {
		if (x < l -> valor) x = l -> valor;
		l = l -> prox;
	}
	return x;
}

//19. certo
int take (int n, LInt *l) {
	int tam = tamanho(*l), count = 1;
	if (tam <= n) return tam;
	LInt r = *l, p;
	while (count != n) {
		++count;
		r = r -> prox;
	}
	p = r -> prox;
	r -> prox = NULL;
	free(p);
	return n;
}

//20. certo
int drop (int n, LInt *l) {
	LInt r = *l, p;
	int tam = tamanho(r), count = 1;
	if (tam <= n) {
		free(r);
		*l = NULL;
		return tam;
	}
	while (count != n+1) {
		p = r;
		r = r -> prox;
		free(p);
		++count;
	}
	*l = r;
	return n;
}

//21. certo
LInt Nforward (LInt l, int N) {
	int i;
	for (i = 0; i < N; i++)
		l = l -> prox;
	return l;
}

//22. certo
int listToArray (LInt l, int v[], int N) {
	int i = 0;
	while (l != NULL && i != N) {
		v[i] = l -> valor;
		i++;
		l = l -> prox;
	}
	if (l == NULL) return i;
	return N;
}

//23. certo
LInt arrayToList (int v[], int N) {
	LInt l = NULL, *el = &l;
	int i = 0;
	while (i != N) {
		*el = malloc(sizeof(struct lligada));
		(*el) -> valor = v[i];
		el = &((*el)->prox);
		++i;
	}
	return l;
}

//24. certo
LInt somasAcL (LInt l) {
	int s = 0;
	LInt p = NULL, *ps = &p;
	while (l != NULL) {
		s += l -> valor;
		*ps = malloc(sizeof(struct lligada));
		(*ps) -> valor = s;
		ps = &((*ps)->prox);
		l = l -> valor;
	}
	*ps = NULL;
	return p;
}

//25. certo
int pertence (int a, int v[], int N) {
	int i;
	for (i = 0; i < N; i++)
		if (a == v[i]) return 1;
	return 0;
}

void remreps (LInt l) {
	int v[100], i = 0;
	LInt ant = NULL;
	while (l != NULL) {
		if (pertence(l->valor, v, i) == 0) {
			v[i] = l -> valor;
			ant = l;
			l = l -> prox;
		}
		else {
			ant -> prox = l -> prox;
			free(l);
			l = ant -> prox;
		}
		++i;
	}
}

//26. certo
LInt rotateL (LInt l) {
	if (l == NULL || l -> prox == NULL) return l;
	LInt el = l;
	while (l -> prox != NULL)
		l = l -> prox;
	l -> prox = el;
	l = el -> prox;
	el -> prox = NULL;
	return l;
}

//27. certo
LInt parte (LInt l) {
	LInt y, *ys = &y, ant = NULL;
	while (l != NULL) {
		if (l -> valor % 2 == 0) {
			*ys = malloc(sizeof(struct lligada));
			(*ys) -> valor = l -> valor;
			ys = &((*ys)->prox);
			if (ant == NULL) {
			    ant = l;
			    l = l -> prox;
			    free(ant);
			    ant = NULL;
			}
			else {
				ant -> prox = l -> prox;
				free(l);
				l = ant -> prox;
			}
		}
		else {
			ant = l;
			l = l -> prox;
		}
	}
	*ys = NULL;
	return y;
}

typedef struct nodo {
	int valor;
	struct nodo *esq, *dir;
} *ABin;

//28. certo mas conta o primeiro nodo é não é suposto
int max (int a, int b) {
	if (a < b) return b;
	return a;
}

int altura (ABin a) {
	int alt;
	if (a == NULL) alt = 0;
	else alt = 1 + max(altura(a->esq) + altura(a->dir));
	return alt;
}

//29. certo
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

//30. certo
void mirror (ABin *a) {
	if (*a) {
		ABin b = (*a) -> esq;
		(*a) -> esq = (*a) -> dir;
		(*a) -> dir = b;
		mirror(&((*a)->dir));
		mirror(&((*a)->esq));
	}
}

//31. certo
LInt* inorder (ABin a, LInt *l) {
	if (!a) (*l) = NULL;
	else {
		l = inorder(a->esq,l);
		(*l) = malloc(sizeof(struct nodo));
		(*l) -> valor = a -> valor;
		l = &((*l)->prox);
		l = inorder(a->dir,l);
	}
	return l;
}

//32. certo
void preorder (ABin a, LInt *l) {
	if (!a) *l = NULL;
	else {
		*l = malloc(sizeof(struct lligada));
		(*l) -> valor = a -> valor;
		l = &((*l)->prox);
		preorder(a->esq,l);
		while (*l)
			l = &((*l)->prox);
		preorder(a->dir,l);
	}
}

//33. certo
void posorder (ABin a, LInt *l) {
	if (!a) *l = NULL;
	else {
		posorder(a->esq,l);
		while (*l) 
			l = &((*l)->prox);
		posorder(a->dir,l);
		while (*l)
			l = & ((*l)->prox);
		*l = malloc(sizeof(struct lligada));
		(*l) -> valor = a -> valor;
		(*l) -> prox = NULL;
	}
}

//34. certo
int depth (ABin a, int x) {
	int i = 1, ld, rd;
	if (!a) i = -1;
	else {
		if (a -> valor != x) {
			ld = depth(a->esq,x);
			rd = depth(a->dir,x);
			if (rd < 0) i += ld;
			if (ld < 0) i += rd;
			if (rd > 0 && ld > 0 && ld > rd) i += rd;
			if (rd > 0 && ld > 0 && ld < rd) i += ld;
		}
	}
	return i;
}

//35. certo
int freeAB (ABin a) {
	int i = 0, il = 0, ir = 0;
	if (a) {
		if (a -> esq) il = freeAB(a->esq);
		if (a -> dir) ir = freeAB(a->dir);
		free(a);
		++i;
		i += ie + id;
	}
	return i;
}

//36. certo
int pruneAB (ABin *a, int l) {
	int i = 0;
	if (*a) {
		i += pruneAB(&((*a) -> esq),l-1);
		i += pruneAB(&((*a) -> dir),l-1);
		if (l < 1) {
			free(*a);
			*a = NULL;
			++i;
		}
	}
	return i;
}

//37. certo
int min (int a, int b) {
	if (a < b) return a;
	return b;
}

int iguaisAB (ABin a, ABin b) {
	int i = 1;
	if (a && b) {
		i = min(i,iguaisAB(a->esq,b->esq));
		i = min(i,iguaisAB(a->dir,b->dir));
		if (a -> valor != b -> valor) i = 0;
	}
	else if ((!a && b) || (a && !b)) return 0;
	return i;
}

//38. certo
LInt concat (LInt l, LInt p) {
	LInt *el = &l;
	while (*el)
		el = &((*el)->prox);
	*el = p;
	return l;
}

LInt nivelL (ABin a, int n) {
	LInt l = NULL, *el;
	el = &l;
	if (a) {
		if (n == 1) {
			if (a) {
			    *el = malloc(sizeof(struct lligada));
			    (*el) -> valor = a -> valor;
			    el = &((*el)->prox);
			    *el = NULL;
		    }
		}
		else {
			l = nivelL(a->esq,n-1);
			l = concat(l,nivelL(a->dir,n-1));
		}
	}
	return l;
}

//39. certo
int nivelV (ABin a, int n, int v[]) {
	int i = 0;
	if (a) {
		if (n == 1) {
			v[i] = a -> valor;
			++i;
		}
		else {
			i += nivelV (a->esq,n-1,v);
			i += nivelV (a->dir,n-1,v+i);
		}
	}
	return i;
}

//40. certo
int dumpAbin2 (ABin a, int v[], int N, int i) {
	if (a) {
		i = dumpAbin2(a->esq,v,N,i);
		if (i < N) {
			v[i] = a -> valor;
			++i;
		}
		i = dumpAbin2(a->dir,v+i,N,i);
	}
	return i;
}

int dumpAbin (ABin a, int v[], int N) {
	int i = 0;
	return dumpAbin2(a,v,N,i);
}

//41. certo
int somaA (ABin a) {
	int i = 0;
	if (a) {
		i += a -> valor;
		i += somaA(a->esq) + somaA(a-> dir);
	}
	return i;
}

ABin somasAcA (ABin a) {
	ABin b = NULL;
	if (a) {
		b = malloc(sizeof(struct nodo));
		b -> valor = somaA(a);
		b -> esq = NULL;
		b -> dir = NULL;
		if (a -> esq) b -> esq = somasAcA(a->esq);
		if (a -> dir) b -> dir = somasAcA(a->dir);
	}
	return b;
}

//42. certo
int contaFolhas (ABin a) {
	int i = 0;
	if (a) {
		i += contaFolhas(a->esq) + contaFolhas(a->dir);
	}
	else return i;
	if (!(a->esq) && !(a->dir)) i = 1;
	return i;
}

//43. certo
ABin cloneMirror (ABin a) {
	ABin b = NULL;
	if (a) {
		b = malloc(sizeof(struct nodo));
		b -> valor = a -> valor;
		b -> esq = NULL; b -> dir = NULL;
		b -> esq = cloneMirror(a -> dir);
		b -> dir = cloneMirror(a -> esq);
	}
	return b;
}

//44.
int addOrd (ABin *a, int x) {
	int i = 0;
	if (a) {
		if ((*a)->valor == x) i = 1;
		else if ((*a)->valor < x) {
			ABin b = malloc(sizeof(struct nodo));
			b -> valor = x;
			b -> 
		} i = addOrd(&((*a)->esq),x);
		else if ((*a)->valor > x) i = addOrd(&((*a)->dir),x);

	}
}

//45. certo
int lookupAB (ABin a, int x) {
	int i = 0;
	if (a) {
		if (a -> valor == x) return 1;
		else if (a -> valor < x) i += lookupAB(a->dir,x);
		else i += lookupAB(a->esq,x);
	}
	return i;
}

//46. certo
int depthOrd (ABin a, int x) {
	int i = 0, p;
	if (a) {
		if (a->valor == x) ++i;
		else if (a->valor < x) {
			++i;
			p = depthOrd(a->dir,x);
			if (p == -1) i = p;
			else i += p;
		}
		else {
			++i;
			p = depthOrd(a->esq,x);
			if (p == -1) i = p;
			else i += p;
		}
	}
	else i = -1;
	return i;
}

//47. certo
int maiorAB (ABin a) {
	int i;
	if (a) {
		if (!(a -> dir)) return a -> valor;
		else i = maiorAB(a -> dir);
	}
	return i;
}

//48. certo
void removeMaiorA (ABin *a) {
	ABin ant = NULL;
	if (*a) {
		if (!((*a)->dir)) {
			if (ant == NULL) {
				ant = (*a)->esq;
				free(*a);
				*a = NULL;
				*a = ant;
			}
			else {
				free(*a);
				*a = NULL;
			}
		}
		else {
			ant = *a;
			removeMaiorA(&((*a)->dir));
		}
	}
}

//49. certo
int quantosMaiores (ABin a, int x) {
	int i = 0;
	if (a) {
		if (x >= a -> valor) i = quantosMaiores(a->dir,x);
		else {
			++i;
			i += quantosMaiores(a -> esq,x) + quantosMaiores(a -> dir,x);
		}
	}
	return i;
}

//50. certo
void listToBTree (LInt l, ABin *a) {
	ABin ant;
	while (l) {
		ant = *a;
		*a = malloc(sizeof(struct nodo));
		(*a) -> valor = l -> valor;
		(*a) -> dir = NULL;
		(*a) -> esq = ant;
		l = l -> prox;
	}
}

//51.
int compara (int a, int b) {
	if (a < b) return a;
	return b;
}

int deProcura (ABin a) {
	int i = 0;
	if (a) {
		if ()
	}
}