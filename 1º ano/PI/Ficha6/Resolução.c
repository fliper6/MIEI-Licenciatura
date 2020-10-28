
//__1__
#define MAX 100 // usado para definir constantes
typedef struct stack {
	int sp;                   
	int valores [MAX]; // 0 - 99  
} STACK;

//__a__
void initStack (STACK *s) { // STACK = struct stack
	s -> sp = 0; // é igual a (*s).sp = 0
}

//__b__
int isEmptyS (STACK *s) { 
	if (s -> sp = 0) return 1; // True
	else return 0; // False
}

//__c__
int push (STACK *s, int x) {
	if (s -> sp == (MAX - 1)) return 1; // stack está cheia 
	else {s -> valores[sp] = x; s -> sp++; return 0;} // coloca x no topo da stack ; incrementa sp  
}

//__d__
int pop (STACK *s, int *x) {
	if (s -> sp == 0) return 1; // stack está vazia
	else {s -> sp--; *x = (s -> valores[s -> sp]); return 0;} // decrementa sp ; retira o último elemento e coloca-o em x
}

//__e__
int top (STACK *s, int *x) {
	if (s -> sp == 0) return 1; // stack está vazia
	else {*x = (s -> valores[s -> --sp]); return 0;} // copia o topo da stack para x (--sp para decrementar antes de copiar para x)
}

//__2__
#define MAX 100
typedef struct queue {
	int inicio, tamanho;
	int valores [MAX];
} QUEUE;

//__a__
void initQueue (QUEUE *q) {
	q -> inicio = 0;
	q -> tamanho = 0; 
}

//__b__
int isEmptyQ (QUEUE *q) {
	if (q -> tamanho == 0) return 1;
	return 0; 
}

//__c__
int enqueue (QUEUE *q, int x) {
	if (q -> tamanho == (MAX - 1)) return 1; // queue está cheia 
	int i = q -> inicio + q -> tamanho;
	if (i >= MAX) i = i - MAX; // em vez deste passo, podiamos simplesmente acrescentar "% MAX" à linha de código anterior (5%6 = 5)
	q -> valores[i] = x;                                                                                                // (6%6 = 0) -> chega ao fim da lista e volta para o início
	q -> tamanho ++;                                                                                                    // (7%6 = 1)
	return 0; 
}

//__d__
int dequeue (QUEUE *q, int *x) {
	if (q -> tamanho == 0) return 1; // queue está vazia
	*x = s -> valores[s->inicio]; // copia o valor do início para x
	q -> inicio = (q -> inicio + 1) % MAX; // atualiza o início 
	q -> tamanho --; // atualiza o tamanho
	return 0; 
}

//__e__
int front (QUEUE *q, int *x) {
	if (q -> tamanho == 0) return 1; // queue está vazia
	*x = q -> inicio;
	return 0;
}

//__3__

//__a__
typedef struct stack2 { // (estrutura dinâmica) 
	int size; // guarda o tamanho do array valores
	int sp;
	int *valores;
} STACK2;

void initStack2 (STACK2 *s, int x) {
	s -> sp = 0;
	s -> valores = malloc (sizeof(int)*10);
	s -> size = 10; 
}

int push2 (STACK2 *s, int x) { 
	if (s -> sp == s -> size) { // se estiver cheio aumentamos a memória
		int * aux = malloc (sizeof(int) * 2 * sp -> size); // realocar o array para um de tamanho superior (normalmente duplica-se o tamanho do array)
		for (i = 0; i < (s -> size); i++) 
			aux [i] = s -> valores[i];
		s -> size = size * 2; 
		free (s -> valores);
		s -> valores = aux;
	}
	s -> valores[s->sp] = x;
	s -> sp++;
}

//__b__
typedef struct queue2 {
	int size; // guarda o tamanho do array valores
	int inicio, tamanho;
	int *valores;
} QUEUE2;






