#include <stdio.h>
//----------(1)
/*
//--(1)

int main () {
	int i, j, *a, *b;
	i = 3; j = 5;
	a = &i; b = &j;
	i++;
	j = i + *b;  <- 4 + 5 = 9
	b = a; 
	j = j + *b;  <- 9 + 4 = 13
	printf ("%d \n", j); <- devolve 13
	return 0;
}


//--(adicional)

void t (int *a) {
	*a = 1;
}

int main () {
	int x = 0; 
	t(x);
    printf ("%d", x);
}
*/



//----------(2)
//--(1)
/*
float mult (int n, float m) {
  float r ;
  if (n >0) r = m + mult (n - 1, m) ;
  else r = 0;
  return r ;
}
*/

float mult (int n, float m) {
  float r = 0;
  while (n>0) {
  	r = r + m; 
  	n--;
  }
  return r;
}

//--(2)
/*
int mult (int n, float m) {
  float r = 0;
  if (n >0) {
   if (n % 2 != 0)
    r = r + m;
  r = r + mult (n / 2, m + m) ;
  }
 return r ;
}
*/

// --- exercício 2

//--(3)
/*
int mdc ( int a , int b ) {
  int d ;
  if (a > b ) d = b;   <- d vai ser o menor dos dois números
  else d = a; 
  while (( a % d != 0) || ( b % d != 0))  <- enquando o resto da divisão de a por d e de b por d não dor em ambos 0, repete-se o ciclo com d-1 (d--)
  d--;                                                (ou seja, enquanto a e b não forem divisíveis por d)
  return d ;
}
*/

// (1,1000)   -> ocorre apenas 1 iteração (porque 1 é logo mdc de 1 e 1000)
// (999,1000) -> ocorre 1000 vezes até de o 'd' (que começa por ser 999) chegue a 1

//--(4)
/*
int mdc (int a, int b) { 
  int r;
  if (a == b) r = a;
  else if (a > b) r = mdc (a - b, b);
       else r = mdc (a, b - a);
  return r ;
*/

int mdc (int a, int b) {
    while (a != b) {
    	if (a > b) a = a - b // vai subtraindo o número mais pequeno ao maior até que sejam iguais (e aí será o seu mdc)
        else b = b - a; 
    } 
    return a;  // tanto faz pôr 'return a' ou 'return b' (porque o ciclo pára quando a = b)
}

//--(7)

// --- exercício 7 


float main () { 
	int a;
    float b,c;
    a = 2;
    b = 1;
    c = mult (a,b);
    printf("%f \n", c);

    int d = 1;
    int e = 2;
    int f = mdc (d,e);
    printf("%d \n", f);

    return 0;  
}


