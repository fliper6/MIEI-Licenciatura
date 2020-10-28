#include <stdio.h>


//------(1) lê (usando a função scanf) uma sequência de números inteiros terminada com o número 0 e imprime no ecran o maior elemento da sequência
void maiorSeq () {
	int i = 0;
	printf ("Insira um número: ");
	scanf ("%d", &i); // o'scanf' guarda o número inserido (no endereço de i)
	int m = i;

	while (i != 0) { // enquanto continuarem inserir números diferentes de 0, o ciclo não para
		printf("Insira outro número: ");
		scanf ("%d", &i);
		if (i > m) m = i; // atualiza o maior número
    }

	printf("%s %d\n", "O maior'número é:", m);	
}


//------(2) lê (usando a função scanf) uma sequência de números inteiros terminada com o número 0 e imprime no ecran a média da sequência
void mediaSeq () {
	int i = 0;
	printf ("Insira um número: ");
	scanf ("%d", &i); 
	int m = i;
    int n = 1;

	while (i != 0) { 
		n = 2; 
		printf("Insira outro número: ");
		scanf ("%d", &i);
		m = (m + i);
		n++;
    }

    m = m/n;
	printf("%s %d\n", "A média é:", m);	
}


//------(3) lê (usando a função scanf) uma sequência de números inteiros terminada com o número 0 e imprime no ecran o segundo maior elemento.
void segMaiorSeq () {
	int i;
	printf ("Insira um número: ");
	scanf ("%d", &i); 
	int m = i;
    int n = i;

	while (i != 0) {
		printf("Insira outro número: ");
		scanf ("%d", &i);
		if (i != 0) {
		
			if (n == m) {n = i;}
            if (i > m) {n = m; m = i;}
            if (i < m && i > n) {n = i;}
		}
    }
	printf("%s %d\n", "O segundo maior número é:", n);	
}


//------(4) calcula o número de bits iguais a 1 usados na representação binária de um dado número n
int bitsUm (unsigned int n) { // unsigned = números inteiros sem sinal
    int contador = 0; // inicializar contador a 0 caso o n inicial seja logo 0

    while (n != 0) {
    	if (n%2 == 1) contador ++;
    	n = n/2;
    }
    return contador; 
}


//------(5) calcula o número de bits a 0 no final da representação binária de um número (i.e., o expoente da maior potência de 2 que é divisor desse número)
int trailingZ (unsigned int n) {
	int contador;
	if (n==0) contador = 1; 
   
    else {
    	contador = 0; 
    	while (((n%2)!= 1) && n != 0) {
    		contador ++;
    		n = n/2;
     	}
    }
    return contador;
}


//------(6) calcula o número de dı́gitos necessários para escrever o inteiro n em base decimal (ou seja, é contar os dígitos)
int qDig (unsigned int n) {
	int c, d; 
	c = 10; // número para comparar
    d = 1; // número de dígitos

	while (n >= c) {
		d++;
		c = c*10;
	}
	return d;
}


//------(7) concatena a string s2 a s1 (retornando o endereço da primeira)
char *strcat (char s1[], char s2[]) { // não esquecer -> o array é o apontador para a 1ª posição deste 
	int j, i;
	for (i=0; s1[i] != '\0'; i++); // vai ver qual o "comprimento" de s1 e coloca-o na variável l1
	 for (j=0; s2[j] != '\0'; j++) {
    	s1[i] = s2[j];
    	i++;
    }
    s1[i] = '\0';
    
    return s1;
}


//------(8) copia a string source para dest retornando o valor desta última
char * strcpy (char *dest, char source[]) {
	int i;
	for (i=0; source[i] != '\0'; i++) { // '\0' determina o fim do do array (já que aqui não nos dão o N, não conseguimos saber o comprimento do que "não é lixo")
		dest[i] = source[i]; // *(dest + i) = dest[i]
	}
    //dest[i] = '\0'; //pretty sure que isto é opcional
    return dest;
}


//------(9) compara (lexicograficamente) duas strings (0 se as strings forem iguais, <0 se s1 < s2, >0 se s1 > s2)
int strcmp (char s1[], char s2[]) { // compara strings de acordo com a sua ordem alfabética ("abc" > "abb" porque 'a' == 'a', 'b' == 'b' e 'b' (vem primeiro no alfabeto) < 'c')  
	int i;
	for (i = 0; (s1[i] != 0) && (s2[i] != 0) && s1[i] == s2[i]; i++) ;
    return ( (s1[i]) - (s2[i]) );
}


//------(10) que determina a posição onde a string s2 ocorre em s1 (NULL caso s2 não ocorra em s1)
char * strstr (char s1[], char s2[]) {
	int i,l = 0; 
	for (i = 0; (s1[i] != '\0') && (s2[l] != '\0'); i++) {
    	if(s1[i]==s2[l]) l++; 
    	else l=0;
	}
    if (s2[l] == '\0') return s1+i-l; // ou seja, se no final do ciclo o l for igual ao "comprimento do conteúdo" de s2 (s2 tiver contindo sem s1), quer dizer que s[l] vai corresponder a '\0'
    else return NULL;       //s1 -> posição inicial s1 + i (i final do ciclo) - l (comprimento de s2) = 1ª posição de s2 em s1
}


//------(11) inverte uma string
void strrev (char s[]) {
  	int i;
	for (i = 0;s[i] != '\0';i++) ; // conta o "tamanho" de s

	int t = i-1;
	char aux[t+1];
	i = t;
	for (i = t ; i >= (t+1)/2 ; i--) { // inverte 
		aux[i] = s[t-i];
		aux[t-i] = s[i];
	}

    for (i = 0 ; i <= t ; i++) { // copia a aux para o array original
		s[i] = aux[i];
	}
    return;
}


//------(12) retira todas as vogais de uma string
void strnoV (char s[]) {
    int i,n = 0;
	for (i = 0 ; s[i] != '\0' ; i++) {
		if (s[i] != 'a' && s[i] != 'e' && s[i] != 'i' && s[i] != 'o' && s[i] != 'u' && s[i] != 'A' && s[i] != 'E' && s[i] != 'I' && s[i] != 'O' && s[i] != 'U')	
        	{ s[n] = s[i]; n++; }       
	}
    s[n] = '\0';
}


//------(13) dado um texto t com várias palavras (as palavras estão separadas em t por um ou mais espaços) e um inteiro n, trunca todas as palavras de forma a terem no máximo n caracteres.
void truncW (char t[], int n) {
	int i,e = 0; // e -> posicões no novo texto
	int a = 1; // a -> vai contado o número de letras de cada palavra
	for (i = 0 ; t[i] != '\0' ; i++) { 
		if (t[i] != ' ') { // se nos depararmos com uma letra...
         if (a <= n) {t[e] = t[i]; a++; e++;} // ... se a palavra ('a') for menor do que o 'n' (ou seja, ainda faz parte do novo texto), ainda escrevemos essa letra; o comprimento da palavra "aumenta"; e no novo texto avançamos um posição.
		}
		else {
		 a = 1; // quando nos deparamos com espaços, o 'a' dá restart ...
		 t[e] = ' '; // ... no novo texto também vamos ter um espaço ...
		 e++; // ... e no novo texto avançamos um posição.

		}
	}
	t[e] = '\0'; // encerramos o novo texto
}


//------(14) determina qual o caracter mais frequente numa string (a função deverá retornar 0 no caso de s ser a string vazia)
int freqChar (char x, char s[]) { // dá-nos as vezes que uma char aparece numa string
	int i,a; 
	a = 0;
	for (i = 0; s[i] != '\0'; i++) 
    	if (x == s[i]) a++;
	return a; 
}


char charMaisfreq (char s[]) {
	int i;
	char c;
	c = s[0];
	for (i = 0; s[i] != '\0'; i++) {
    	if (freqChar(c,s) < freqChar(s[i],s)) c = s[i];
    }
    return c;
}


//------(15) dada uma string s calcula o comprimento da maior sub-string com caracteres iguais ("aabccccaac" --> 3 ("ccc"))
int max (int aux[]) {
	int i,m;
	i = 0;
	m = aux[i];
	for (i = 0; aux[i] != '\0'; i++) {
		if (m < aux[i+1]) m = aux[i+1];
	}
	return m;
}


int iguaisConsecutivos (char s[]) {
	int i,n,c;
	n = 1; // contador de letras seguidas
	c = 0; // posição no aux
    
    if (s[0] == '\0') return 0; // excluimos assim strings vazias
    
    else {
    
	for (i = 0; s[i] != '\0';i++) ; // conta o "tamanho" de s...
	int t = i;
	int aux[i]; // ... para sabermos o tamanho a alocar para a aux.

	for (i = 0; i < t ; i++) {
    	if (s[i] == s[i+1]) n++; // se forem iguais dois char seguidos, o contador de letras seguidas aumenta uma unidade
    	else {aux[c] = n; n = 1; c++;} // caso contrário, termina essa sub-string c/ caracteres iguais, guarda-se o seu comprimento na aux,
    	                                       // o contador retoma o seu valor inicial (1), e avança-se uma posição no aux
    }
    
    aux[c] = '\0';
    int x = max (aux);
    return (x);
    }
}

 
//------(16) dada uma string s calcula o comprimento da maior sub-string com caracteres diferentes ("aabccccaac" --> 3 ("abc"))
int max1 (int aux[]) {
	int i,m;
	i = 0;
	m = aux[i];
	for (i = 0; aux[i] != '\0'; i++) {
		if (m < aux[i+1]) m = aux[i+1];
	}
	return m;
}

int difConsecutivos (char s[]) { // racicínio igual ao da 'iguaisConsecutivos'
	int i,n,c;
	n = 1; 
	c = 0; 
    
    if (s[0] == '\0') return 0; 
    
    else {
    
	for (i = 0; s[i] != '\0';i++) ; 
	int t = i;
	int aux[i]; 

	for (i = 0; i <= (t-1) ; i++) {
    if (s[i] != s[i+1] && s[i] != '\n') n++; 
    else {aux[c] = n; n = 1; c++;}   	                                       
    }
    
    aux[c] = '\0';
    int x = max1 (aux);
    return (x);
    }
}


//------(17) calcula o comprimento do maior prefixo comum entre as duas strings
int maiorPrefixo (char s1 [], char s2 []) {
	int i, n = 0; 
	for (i = 0; s1[i] != '\0' && s2[i] != '\0' ;i++) {
		if (s1[i] == s2[i]) n++;
		else return n; // para o ciclo parar quando encontrar char's diferentes
  	}
  	return n;
}


//------(18) calcula o comprimento do maior sufixo comum entre as duas strings
int maiorSufixo (char s1 [], char s2 []) {
	int i,l,n = 0;
	for (i = 0; s1[i] != '\0';i++) ; // comprimento de s1 
	for (l = 0; s2[l] != '\0';l++) ; // comprimento de s2

    while(i > 0 && l > 0) {
    	if (s1[i-1] == s2[l-1]) {n++; i--; l--;}
    	else return n; 
  	}
  	return n;
}


//------(19) calcula o tamanho do maior sufixo de s1 que é um prefixo de s2
int sufPref (char s1[], char s2[]) {
	int i,l,n;
	l = 0;
	n = 0;
	i = 0;
	while (s1[i] != '\0' && s1[i] != '\0') {
        if(s2[l] == s1[i]) {i++; l++; n++;} 
		else {i++; l = 0 ; n = 0;} 
		}
  	return n;
}


//------(20) conta as palavras de uma string (palavra é uma sequência de caracteres (diferentes de espaço) terminada por um ou mais espaços)
int contaPal (char s[]) {
	int i, n = 0; // n --> contador de palavras
	
	if (s[0] == '\0') return 0; // excluimos assim strings vazias

	else {
	for (i = 0 ; s[i] != '\0'; i++) {
		if (s[i] != ' ' && s[i] != '\n' && s[i+1] == ' ') n++; // char diferente de ' ' e '\n' seguido de 1 ' ' = 1 palavra
	}
	if (s[i - 1] == ' ' || s[i - 1] == '\n') return n; 
	else return n+1; // caso a string acabe num char diferente de ' ' e '\n', no ciclo não conta como 1 palavra, logo temos de adicionar +1 palavra
	}
}


//------(21)
int contaVogais (char s[]) {
	int i, n = 0; 
	for (i = 0 ; s[i] != '\0'; i++) {
		if (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u' || s[i] == 'A' || s[i] == 'E' || s[i] == 'I' || s[i] == 'O' || s[i] == 'U')	n++;
	}
	return n;	
}


//------(22) testa se todos os caracteres da primeira string também aparecem na segunda
int contida (char a[], char b[]) {
	int i,l,t,n;
	i = l = t = n = 0;

	for (t = 0; a[t] != '\0';t++) ; // tamanho de a
	
    while (a[l] != '\0' && b[i] != '\0') {
    	if (a[l] == b[i]) {l++; i = 0; n++;}
    	else {i++;}
    }
    if (n == t) return 1; // 1 = Verdadeiro
    else return 0; // 0 = Falso 
}


//------(23) testa se uma palavra é palı́ndrome, i.e., lê-se de igual forma nos dois sentidos
int palindorome (char s[]) { // mesmo raciocínio que a strrev (só muda o último ciclo)
  	int i;
	for (i = 0;s[i] != '\0';i++) ; // conta o "tamanho" de s

	int t = i-1;
	char aux[t+1];
	i = t;
	for (i = t ; i >= (t+1)/2 ; i--) { // inverte 
		aux[i] = s[t-i];
		aux[t-i] = s[i];
	}

    for (i = 0 ; i <= t ; i++) { // compara a aux com s 
		if (s[i] != aux[i]) return 0;
	}
    return 1;
}


//------(24) elimina de uma string todos os caracteres que se repetem sucessivamente deixando lá apenas uma cópia (a função deverá retornar o comprimento da string resultante)
int remRep (char x[]) {
	int t,i,n = 0;
	
	for (i = 0; x[i] != '\0';i++) {
		if (x[i] != x[i+1]) {x[n] = x[i]; n++;} // se forem diferentes, escreve-se esse caracteres na 'nova x'
	}
    x[n] = '\0';
	for (t = 0; x[t] != '\0';t++) ; // conta o "tamanho" de s já sem os caracteres repetidos (sucessivamente)
	return t;
}


//------(25) elimina repetições sucessivas de espaços por um único espaço (a função deve retornar o comprimento da string resultante)
int limpaEspacos (char t[]) {
	int l,i,n = 0;
	
	for (i = 0;t[i] != '\0';i++) {
		if (t[i] != ' ') {t[n] = t[i]; n++;} // se for uma letra, escreve-a na 'nova t'
		else {
			if (t[i] != t[i+1]) {t[n] = t[i]; n++;} // se for um espaço, só o escreve na 'nova t' se não tiver mais um espaço na posição a seguir
		}
	}
    t[n] = '\0';
	for (l = 0; t[l] != '\0';l++) ; // conta o "tamanho" de s já sem os espaços extra
	return l;
}


//------(26) insere um elemento (x) num vector ordenado (as N primeiras posições do vector estão ordenadas e que por isso, após a inserção o vector terá as primeiras N+1 posições ordenadas)
int pos (int v[], int N, int x) {
	int i,p = 0; 
	for (i = 0; i < N ;i++) {
		if (x <= v[i]) return p; 
        else p++;
	}	
	return p;
}

void insere (int v[], int N, int x) {
	int i,t,p;
	int aux[N+1];
	p = pos (v,N,x);
    
    aux[p] = x; // coloca x...
    
	for (i = 0; i < p ;i++) { // ... os números antes de x ficam no mesmo sítio...
    	aux[i] = v[i]; }

    for (i = (p+1); i < (N+1) ;i++) { // ... e os números maiores de x avançam uma posição.
    	aux[i] = v[i-1]; }
    	
    for (i = 0 ; i < (N+1); i++) { // copia a aux para o array original
		v[i] = aux[i]; }
}


//------(27) dados vectores ordenados a (com na elementos) e b (com nb elementos), preenche o vector r (com na+nb elementos) com os elementos de a e b ordenados
void merge (int r [], int a[], int b[], int na, int nb) {
	int i = 0, j = 0, m = 0;

	while (i != na && j != nb) {
		if (a[i] < b[j]) {
			r[m] = a[i];
			m++; i++;
		}
		else {
			r[m] = b[j];
			m++; j++;
		} 
	}
	if (i == na) {
		while (j != nb) {
			r[m] = b[j];
			m++; j++;
		}
	}
	else {
		while (i != na) {
			r[m] = a[i];
			m++; i++;
		}
	} 
}


//------(28) testa se os elementos do vector a, entre as posições i e j (inclusivé) estão ordenados por ordem crescente (a função deve retornar 1 ou 0 consoante o vector esteja ou não ordenado)
int crescente (int a[], int i, int j) {
	int t,y;
    
	for (t = j; t > i ;t--) {
		for (y = i; y < t ;y++)
			{ if (a[y] > a[t]) return 0; }
	}
	return 1;
}


//------(29) retira os números negativos de um vector com N inteiros (a função deve retornar o número de elementos que não foram retirados)
int retiraNeg (int v[], int N) {
	int i, n = 0;
	for (i = 0; i < N; i++) {
		if (i > 0) {v[n] = v[i]; n++;}
	}
	v[n] = '\0';
	return n;
} // o Codeboar tem erro nesta pergunta


//------(30) recebe um vector v com N elementos ordenado por ordem crescente e retorna o menos frequente dos elementos do vector.
              //Se houver mais do que um elemento nessas condições deve retornar o que começa por aparecer no ı́ndice mais baixo

int min2 (int aux[], int N) {
	int i,m,pm;
	i = 0;
	m = aux[0];
	pm = i;
	for (i = 0; i < (N-1); i++) {
		if (m > aux[i+1]) {m = aux[i+1]; pm = i+1;} // pm --> posição da frequência mínima
	}
	return pm;
}


int menosFreq (int v[], int N) {
	int i,n,c;
	n = 1;
	c = 0;
	int aux[N];

	for (i = 0 ; i < (N-1) ; i++) { // faz uma lista com as frequências
		if (v[i] == v[i+1]) {n++;}
		else {aux[c] = n; n = 1; c++;}
	}

	aux[c] = n;
	
	int pm = min2 (aux,(c+1)); 
	i = 0;
	for (i = 0 ; (i < N) && (pm > 0) ; i++) { // encontra o caracter correspondente à pm 
		if (v[i] != v[i+1]) {pm--;}
	}
	return v[i];
}


//------(31)recebe um vector v com N elementos ordenado por ordem crescente e retorna o mais frequente dos elementos do vector.
            //Se houver mais do que um elemento nessas condições deve retornar o que começa por aparecer no ı́ndice mais baixo
int max2 (int aux[], int N) {
	int i,m,pm;
	i = 0;
	m = aux[0];
	pm = i;
	for (i = 0; i < (N-1); i++) {
		if (m < aux[i+1]) {m = aux[i+1]; pm = i+1;} // pm --> posição da frequência mínima
	}
	return pm;
}


int maisFreq (int v[], int N) {
	int i,n,c;
	n = 1;
	c = 0;
	int aux[N];

	for (i = 0 ; i < (N-1) ; i++) {   // faz uma lista com as frequências
		if (v[i] == v[i+1]) {n++;}
		else {aux[c] = n; n = 1; c++;}
	}

	aux[c] = n;
	
	int pm = max2 (aux,(c+1)); 
	i = 0;
	for (i = 0 ; (i < N) && (pm > 0) ; i++) { // encontra o caracter correspondente à pm 
		if (v[i] != v[i+1]) {pm--;}
	}
	return v[i];
}

//------(32) calcula o comprimento da maior sequência crescente de elementos consecutivos num vector v com N elementos
int maxCresc (int v[], int N) {
	int i,a,c,m; // m - máximo
	a = 1; // acumulador 
	c = 0; // posições do array aux
	int aux[N]; 

	for (i = 0; i < (N-1); i++) {
		if (v[i] <= v[i+1]) {a++;}
		else {aux[c] = a ; a = 1 ; c++;}
	}
	aux[c] = a;
	m = aux[0];

	for (i = 0; i < c; i++) {
		if (m < aux[i+1]) {m = aux[i+1];} 
	}
	
	return m;
}


//------(33) recebe um vector v com n inteiros e elimina as repetições (a função deverá retornar o número de elementos do vector resultante)
int verificaRep (int v, int aux[], int c) {
	int l;
	for (l = 0; l < c; l++) {
		if (v == aux[l]) return 0;
	}
	return 1;
}

int elimRep (int v[], int n) {
	int i,c;
	c = 1; // comprimento do array aux
	int aux[n]; 

	aux[0] = v[0]; 
	for (i = 1; i < n; i++) {
		if (verificaRep (v[i],aux,c) == 1) {aux[c] = v[i]; c++;}
	}

	for (i = 0 ; i < c; i++) { // copia a aux para o array original
    	v[i] = aux[i]; }
    	
	return c;
}


//------(34) recebe um vector v com n inteiros ordenado por ordem crescente e elimina as repetições (a função deverá retornar o número de elementos do vector resultante)
int elimRepOrd (int v[], int n) { // posso pôr igual à função elimRep (esta é uma versão mais eficiente dado que v é ordenado)
	int i,c;
	c = 0; // posições do array aux
	int aux[n]; 
 
	for (i = 0; i < (n-1); i++) { 
		if (v[i] != v[i+1]) {aux[c] = v[i]; c++;}
	}
    aux[c] = v[i];

	for (i = 0 ; i < (c+1); i++) { // copia a aux para o array original
    	v[i] = aux[i]; }

    return (c+1);
}


//------(35) calcula quantos elementos os vectores a (com na elementos) e b (com nb elementos) têm em comum (a e b ordenados por ordem crescente)
int comunsOrd (int a[], int na, int b[], int nb) {
	int i,l,c;
	i = l = c = 0;

	while (i < na && l < nb) {
		if (a[i] == b[l]) {i++; l++; c++;}
		if (a[i] < b[l]) {i++;}
		if (a[i] > b[l]) {l++;}
	}

	return c;
}


//------(36) calcula quantos elementos os vectores a (com na elementos) e b (com nb elementos) têm em comum (a e b não ordenados por ordem crescente)
int comuns (int a[], int na, int b[], int nb) {
	int i,l,c;
	i = l = c = 0;

	for (i = 0 ; i < na; i++) {
		for (l = 0 ; l < nb; l++) {
			if (a[i] == b[l]) {c++; break;} // break para não contarmos repetidos
		}
	}
	
	return c;
}


//------(37) dado um vector v com n inteiros, retorna o ı́ndice do menor elemento do vector
int minInd (int v[], int n) {
	int i,im,m;
	im = 0;
	m = v[0];

	for (i = 0 ; i < (n-1); i++) {
		if (m > v[i+1]) {m = v[i+1]; im = i+1;}
	}

	return im;
}


//------(38) preenche o vector Ac com as somas acumuladas do vector v
void somasAc (int v[], int Ac [], int N) {
	int i,s;
	s = 0;

	for (i = 0 ; i < N; i++) {
		s = s + v[i];
		Ac[i] = s;
	}
}


//------(39) testa se uma matriz quadrada é triangular superior, i.e., que todos os elementos abaixo da diagonal são zeros
int triSup (int N, float m [N][N]) {
	int i,l;
    
    // quando N == 0 e N == 1, é triangular superior

	for (l = 0 ; l < N ; l++) {
		for (i = (l+1) ; i < N ; i++) {
			if (m[i][l] != 0) return 0;
		}
	}

	return 1;
}


//------(40) transforma uma matriz na sua transposta
void transposta (int N, float m [N][N]) {
	int i,l;
    float aux [N][N];

	for (l = 0 ; l < N ; l++) {
		for (i = 0 ; i < N ; i++) {
			aux[l][i] = m[i][l];
		}
	}

	for (l = 0 ; l < N ; l++) { // copia a matriz aux para a m
		for (i = 0 ; i < N ; i++) {
			m[i][l] = aux[i][l];
		}
	}
}


//------(41) adiciona a segunda matriz à primeira
void addTo (int N, int M, int a [N][M], int b[N][M]) {
	int i,l;

	for (l = 0 ; l < M ; l++) {
		for (i = 0 ; i < N ; i++) {
			a[i][l] = a[i][l] + b[i][l];
		}
	}
}


//------(42) coloca no array r o resultado da união dos conjuntos v1 e v2
int unionSet (int N, int v1[N], int v2[N], int r[N]) {
	int i;
	for (i = 0 ; i < N ; i++) {
		if (v1[i] == 0 && v2[i] == 0) r[i] = 0;
		else r[i] = 1;
	}
	return 0;
}


//------(43) coloca no array r o resultado da intersecção dos conjuntos v1 e v2
int intersectSet (int N, int v1[N], int v2[N], int r[N]) {
	int i;
	for (i = 0 ; i < N ; i++) {
		if (v1[i] == 1 && v2[i] == 1) r[i] = 1;
		else r[i] = 0;
	}
	return 0;
}


//------(44) coloca no array r o resultado da intersecção dos multi-conjuntos v1 e v2
int intersectMSet (int N, int v1[N], int v2[N], int r[N]) {
	int i;
	for (i = 0 ; i < N ; i++) {
		if (v1[i] == 0 && v2[i] == 0) r[i] = 0;
		if (v1[i] <= v2[i]) r[i] = v1[i];
		if (v1[i] > v2[i]) r[i] = v2[i];
	}
	return 0;
}


//------(45) coloca no array r o resultado da união dos multi-conjuntos v1 e v2
int unionMSet (int N, int v1[N], int v2[N], int r[N]) {
	int i;
	for (i = 0 ; i < N ; i++) {
		r[i] = v1[i] + v2[i];
	}
	return 0;
}


//------(46) calcula a número de elementos do multi-conjunto v
int cardinalMSet (int N, int v[N]) {
	int i = 0;
	int n = 0;
	while (i < N) {
		n = n + v[i]; 
		i++;
	}
	return n;
}


//------(47) dada uma posição inicial e um array com N movimentos, calcula a posição final do robot depois de efectuar essa sequência de movimentos
typedef enum movimento {Norte, Oeste, Sul, Este} Movimento;

typedef struct posicao {
int x, y;
} Posicao;

Posicao posFinal (Posicao inicial, Movimento mov[], int N) {
	int i;
	for (i = 0; i < N; i++) {
		if (mov[i] = Norte) inicial.y++;
		else if (mov[i] = Sul) inicial.y--;
		else if (mov[i] = Este) inicial.x++;
		else inicial.x--;
	}
	return inicial;
}


//------(48) dadas as posições inicial e final do robot, preenche o array com os movimentos suficientes para que o robot passe de uma posição para a outra
int posIgual (Posicao inicial, Posicao final) {
	if ((inicial.x == final.x) && (inicial.y == final.y)) return 1;
	return 0;
}

int caminho (Posicao inicial, Posicao final, Movimento mov[], int N) {
	int i = 0;
	while (posIgual(inicial,final) == 0) {
		if (i == N) return -1;

		else if (inicial.x > final.x) {
			mov[i] = Oeste;
			inicial.x--;
		}
		else if (inicial.x < final.x) {
			mov[i] = Este;
			inicial.x++;
		}
		else if (inicial.y > final.y) {
			mov[i] = Sul;
			inicial.y--;
		}
		else if (inicial.y < final.y) {
			mov[i] = Norte;
			inicial.y++;
		}
		i++;
	}
	return i;
}


//------(49) 
int distancia (Posicao p) {
	int d = p.x * p.x + p.y * p.y;
	return d;
}
int maisCentral (Posicao pos[], int N) {
	int d = distancia(pos[0]);
	int i, n = 0;
	for (i = 1; i < N; i++) {
		if (distancia(pos[i]) < d) {
			d = distancia(pos[i]);
			n = i;
		}
	}
	return n;
}


//------(50)
int dist (Posicao p1, Posicao p2) {
	int dx = p1.x - p2.x;
	int dy = p1.y - p2.y;
	int d = dx*dx + dy*dy;
	return d;
}

int vizinhos (Posicao p, Posicao pos[], int N) {
	int i, n = 0;
	for (i = 0; i < N; i++)
		if (dist(p,pos[i]) == 1) n++;
	return n;
}

int main () {

  /*1*maiorSeq ();

  /*2*mediaSeq ();

  /*3*segMaiorSeq ();

  /*4*int i;
       printf ("Insira um número decimal: ");
       scanf ("%d", &i);
       printf("%s %d\n", "Número de bits iguais a 1:", bitsUm(i));

  /*5*printf ("Insira um número decimal: ");
       scanf ("%d", &i);
       printf("%s %d\n", "Número de bits iguais a 0 no fim desse número:", trailingZ(i));

  /*6*printf ("Insira um número decimal: ");
       scanf ("%d", &i);
       printf("%s %d\n", "Número de dígitos:", qDig(i));

  /*7*char s1[10] = "Filipa";
	   char s2[10] = "Santos"
	   printf("%d\n" , (*strcat (s1,s2)));

  /*8*char dest[10] = "Filipa";
	   char source[10] = "Santos";
	   printf("%d\n" , (*strcpy (dest,source))); // aqui dá o dest (número), a apontador

  /*8*char dest[50];
	   char * source  = "Santos";
	   strcpy (dest,source);
	   printf("%c\n", *dest); // só escrevi assim para verificar que a cópia estava a ser feita corretamente (de facto o conteúdo da célula da memória para onde 'dest' aponta é o primeiro 'S' de "Santos")
  
  /*9*char s1 [10] = "Filipa";
	   char s2 [10] = "Santos";
	   printf("%d\n", strcmp(s1,s2));

  /*10*char s1 [20] = "FiSantoslipa";
	    char s2 [10] = "Santos";
	    printf("%d\n", *strstr(s1,s2));

  /*11,12,13 - verificados no 'codeboard' */

  /*14*char s [10] = "Joana";
	   printf("%c\n", charMaisfreq(s));*/

  /*15*char s[10] = "bbaaabb";
	    int n = iguaisConsecutivos (s);
	    printf("%d\n", n ) ;

  /*16-27- verificados no 'codeboard' */

  /*26* int v[20] = {1,2,3,5};
         printf("%d\n", pos (v,5,1) ); // para verificar a função auxiliar 'pos' */

  /*27-35 - verificados no 'codeboard' */

}








 
