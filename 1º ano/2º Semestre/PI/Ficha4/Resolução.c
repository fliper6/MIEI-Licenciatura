#include <stdio.h>
#include <ctype.h>

//-----(1)
int minusculas (char s[]) {
    int c = 0;
    for (int i; s[i] != '\0'; i++) {
   		if (s[i] >= 'A' && s[i] <= 'Z')
   	 		s[i] = s[i] + ('a' - 'A');
     		c++;
    }
    return c;
}

//-----(2)
int contalinhas (char s[]) {
    int l = 1;
	for (int i = 0; s[i] != '\0'; i++) {
		if (s[i] =='\n') l++;
	}
	return l;
} 

//-----(3)
int contaPal (char s[]) {
	int p = 0;
	int c = 0;
	for (int i = 0; s[i] != '\0' /*ou apenas s[i]*/; i++) {
		if (isspace (s[i])) p = 0;
		else if (p==0) {c++; p = 1;}
	}
	return c;
}

//-----(4)
int compara (char *p, char *p2) {
	for (int i = 0; (p1[i] != 0) && (p2[i] != 0) && p1[i] == p2[i]; i++)
    	;
    if (p1[i] == p2[i]) return 1;
    else return 0;
}


int procura (char *p, char *ps[], int N) {
	int c; // variável que marca se encontramos a string ou não
	int i;
	for (i = 0; i < N && c == 0; i++) { // devido à "c==0", o ciclo para mal se encontre a string
	    c = compara (p, ps[i]);
	}
	return i; // se i == N, não se encontrou a string 
}

//-----(5)
int compara2 (char *p, char *p2) { // compara strings de acordo com a sua ordem alfabética ("abc" > "abb" porque 'a' == 'a', 'b' == 'b' e 'b' (vem primeiro no alfabeto) < 'c') 
	for (int i = 0; (p1[i] != 0) && (p2[i] != 0) && p1[i] == p2[i]; i++)
		;
    return p1[i] - (p2[i]);
}

int procura2 (char *p, char *ps[], int N) {
	int c; 
	int i;
	for (i = 0; i < N && c < 0; i++) { // "c < 0" porque a compara2 devolve números negativos enquanto a string for menor (o ciclo para se "c == 0", se encontramos a string ou de "c > 0", se tivermos à procura em strings demasiado grandes)
	    c = compara (p, ps[i]);
	    if (c == 0) return i; // encontrou a string
	    else return -1; // string não existe, devolve um índice aleatório (escolhemos '-1', quem nem existe)
	}
}

//------(6) 
int procuraBin (char *p, char *ps[], int N) {
	int i = 0; // onde é que começa a parte que quero considerar (no 1º passo é 0 porque queremos considerar o vetor todo)
	int j = N-1; 
	while (i != j) {
		int k = 1 + (j-i)/2
		if (compara2 () > 0)                   // ???
			i = k + 1;
		else if (compara2 () < 0)
				j = k - 1;
			 else return;
	}
}

int main () {
  //-----(1)
  char s[5] = "AbAb";
  printf("%d\n", (minusculas (s)));
  
  //-----(2)
  char x[20] = "Hello \n Olá";
  printf("%d\n", (contalinhas (x)));

  //-----(3)
  printf("%d\n", (contaPal (x)));


}




