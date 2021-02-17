#include <stdio.h>
#define HSIZE 1000

typedef struct entrada{
	char *palavra;
	int ocorre;
	struct entrada *prox;
} *Palavras;


//_(2)

//_(a)
typedef Palavras Dicionario;

void initDic (Dicionario *d) { // inicializa o dicionário a vazio
	d = NULL;
}


int acrescenta (Dicionario *d, char *pal) { // que acrescenta uma ocorrência da palavra pal ao dicionário *d (a função deverá retornar o número de vezes que a palavra pal passou a ter após a inserção)
	Dicionario ant, act = d;
	while (strcmp(pal,act->palavra) < 0 && act != NULL) {
		ant = act;
		act = act -> prox;
	}
	if (act == NULL) { // chega ao fim da lista
		Palavra n = malloc(sizeof(struct entrada)); 
		n -> palavra = pal:
		n -> ocorre = 1;
		n -> prox = NULL;
		if (ant) // fim da lista 
			ant -> prox = n;
		else // adicionar à cabeça da lista | lista nula
			*d = n;
		return 1;
	} else if (strcmp(act -> palavra, pal)) { // adicionar ao meio da lista
		n = malloc(sizeof(Dicionario));
		n -> ocorre = 1;
		n -> prox = act;
		act -> prox = n; 
	} else { // a palavra já existe na lista
		act -> ocorre ++;
		free (pal);
		return act -> ocorre;
	}

}


char * maisFreq (Dicionario d, int *c) {
	Dicionario ruf, aux;
	char * res; 
	if (d == NULL) {
		res = NULL;
		*c = 0; 
	} else {
		ruf = d;
		aux = d -> prox;
		while (aux != NULL) {
			if (aux -> ocorre > ruf -> ocorre) {
				ruf = aux -> prox;
			}
		}
		*c = ruf -> ocorre;
		res = ruf -> palavra;
	}
	return res; 
}

//_(b)
typedef Palavras Dicionario2[HSIZE];

int hash (char *pal, int s){
	int r;
	for (r=0; *pal != ’\0’; pal++)
		r += *pal;
	return (r%s);
}

void initDic2 (Dicionario2 *d) {
	int i;
	for (i=0; i<HSIZE ;i++) 
		(*d)[i] = NULL;
}


void acrescenta2 (Dicionario2 *d, char *w) {
	int h = hash (w, HSIZE);
	Dicionario2 aux = (*d)[h];
	while (aux != NULL && strcmp(aux->palavra,w)){
		aux = aux -> prox;
	}
	if (aux == NULL) {
		aux = novaEntrada(w,*d[h]);
		*d[h] = aux;
	}
	aux -> ocorre++; 
}

char * maisFreq2 (Dicionario2 d, int *cont) {
	int i, c, vmf = -1;
	char *p, *pmf = NULL;
	for (i=0; i<HSIZE; i++) {
		p = maisFreq2 - aux (d[i], &c);
		if (c > vmf) {
			vmf = c;
			pmf = p;
		}
	}
	*cont = vmf;
	return pmf;
}

/*
int main (int argc, char *argv[]){
	FILE *input;
	int r=0, count=0;
	char word[100];
	if (argc==1) input=stdin;
	else input=fopen(argv[1],"r");
	if (input==NULL) r=1;
	else {
		while ((fscanf(input,"%s",word)==1))
			count ++;
		fclose (input);
	    printf ("%d palavras\n", count);
	}
	return r;
    
   //(1)

    FILE *input;
	int r=0, count=0;
	char word[100];
	if (argc==1) input=stdin;
	else input=fopen(argv[1],"r");
	if (input==NULL) r=1;

	Dicionario d;
	initDic (&d);
	else {
		while ((fscanf(input,"%s",word)==1)) {
		 	// acrescenta(&d,word); --> não resulta porque assim estavamos sempre a escrever as palavras a partir do mesmo apontador (dado pela word)
			char *n = malloc(sizeof(char)*strlen(word));
			strcpy(n,word);
			acrescenta(&d,n);
	}

	char m[100];
	int O;
	m = maisFreq(&d,&o);

	return r;
}
*/


