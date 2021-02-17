#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include "Queries.h"

/*Imprime o menu de opções do utilizador*/
void menu () {
	printf("\nQueries:\n\n");
	printf("(1)  Leitura dos ficheiros e apresentação do número de linhas lidas e validadas.\n");
	printf("(2)  Lista e número total de produtos cujo código se inicia por uma dada letra.\n");
	printf("(3)  Número de vendas e total facturado com um determinado produto, num dado mês.\n");
	printf("(4)  Número total e lista ordenada dos códigos de produtos que ninguém comprou.\n");
	printf("(5)  Lista ordenada de códigos de clientes que realizaram compras em todas as filiais.\n");
	printf("(6)  Número de clientes registados que não realizaram compras e de produtos que ninguém comprou.\n");
	printf("(7)  Número total de produtos comprados mês a mês por um dado cliente.\n");
	printf("(8)  Total faturado e número de vendas registadas num dado intervalo de meses.\n");
	printf("(9)  Códigos dos clientes que compraram um dado produto numa determinada filial.\n");
	printf("(10) Lista de códigos de produtos que um certo cliente mais comprou num dado mês.\n");
	printf("(11) Lista de N produtos mais vendidos em todo o ano, número total de clientes e de unidades vendidas.\n");
	printf("(12) Códigos dos 3 produtos em que um dado cliente gastou mais dinheiro durante o ano.\n");
	printf("(q)  Sair do programa.\n\n");
	printf("Insira o número da query que pretende consultar: ");
}

/*Pede ao utilizador para confirmar a intenção de voltar ao menu*/
void proximaQuery () {
	char* buf = malloc(10);

	printf("\nPrima (c) para continuar: ");
	while (buf[0] != 'c' || buf[1] != '\n')
		buf = fgets(buf,10,stdin);
	free(buf);
}

/*Invoca a função correspondente à query que o utilizador escolheu*/
SGV escolheQuerie (SGV sgv, char* buf) {
	int f = 0;
	if (buf[0] == '1' && buf[1] == '\n') { sgv = query1(sgv); f = 1; }
	if (buf[0] == '2' && buf[1] == '\n')   query2(sgv->catp);
	if (buf[0] == '3' && buf[1] == '\n') { query3(sgv); f = 1; }
	if (buf[0] == '4' && buf[1] == '\n')   query4(sgv->catp);
	if (buf[0] == '5' && buf[1] == '\n')   query5(sgv->catc);
	if (buf[0] == '6' && buf[1] == '\n') { query6(sgv); f = 1; }
	if (buf[0] == '7' && buf[1] == '\n') { query7(sgv); f = 1; }
	if (buf[0] == '8' && buf[1] == '\n') { query8(sgv->catvfact); f = 1; }
	if (buf[0] == '9' && buf[1] == '\n')   query9(sgv);
	if (buf[0] == '1' && buf[1] == '0' && buf[2] == '\n') query10(sgv);
	if (buf[0] == '1' && buf[1] == '1' && buf[2] == '\n') { query11(sgv); f = 1; }
	if (buf[0] == '1' && buf[1] == '2' && buf[2] == '\n') { query12(sgv); f = 1; }
	if (f) proximaQuery();
	return sgv;
}

/*Navega pelo menu das queries até o utilizador desejar sair do programa*/
void loopQueries (SGV sgv) {
	char* buf = malloc(10);

	while (!(buf[0] == 'q' && buf[1] == '\n')) {
		sgv = escolheQuerie(sgv,buf);
		menu();
		buf = fgets(buf,10,stdin);
	}
	free(buf);
}


/*Query1*/
SGV query1 (SGV sgv) {
	free_SGV(sgv);
	SGV new = lerFicheiros();

	printf("\n> Ficheiro: %s\n> Nº total de produtos: %d\n> Nº de produtos válidos: %d\n\n",
			 FILEP, getTotalProds(new->catp),getValProds(new->catp));
	printf("> Ficheiro: %s\n> Nº total de clientes: %d\n> Nº de clientes válidos: %d\n\n",
			 FILEC, getTotalClis(new->catc),getValClis(new->catc));
	printf("> Ficheiro: %s\n> Nº total de vendas: %d\n> Nº de vendas válidas: %d\n",
			 FILEV, getTotalVendas(new->catvfact),getValVendas(new->catvfact,1,12));

	return new;
}


/*Pergunta ao utilizador se quer os resultados globais ou por filial*/
char globalOuFilial () {
	char* buf = malloc(5);
	while(!((buf[0] == 'g' || buf[0] == 'f') && buf[1] == '\n')) {
		printf("\nPretende os valores globais (g) ou divididos por filial (f)? ");
		buf = fgets(buf,5,stdin);
	}
	return buf[0];
}

/*Query 2*/
void query2 (Cat_Prods p) {
	char* letra = malloc(30);
	do {
		printf("\nQual é a primeira letra do produto que deseja?: ");
		letra = fgets(letra,30,stdin);
	} while (!isupper(letra[0]) || letra[1] != '\n');

	Lista_Strings l = init_Lista();
 	l =(prodsLetra(l,getAVLProds(p,letra[0]-'A')));

 	char* frase = malloc(100);
	sprintf(frase,"> Códigos dos produtos começados pela letra %c:",letra[0]);
 	navegador(l,frase);
 	freeLista(l);
 	free(frase);
}


/*Query 3*/
/*Inicializa uma struct q3 que é usada para resolver a query 3*/
q3 init_q3 (q3 q) {
	q = malloc(sizeof(struct strq3));
	q->vendasN = 0;
	q->vendasP = 0;
	q->faturadoN = 0;
	q->faturadoP = 0;
	return q;
}

/*Verifica a validade do mês dado pelo utilizador*/
int verificaMes (char* mes) {
	int m;
	if (strlen(mes) == 1) {
		if (!isdigit(mes[0])) m = -1;
		else m = atoi(mes);
	}
	else if (strlen(mes) == 2) {
		if (!isdigit(mes[0]) || !isdigit(mes[1])) m = -1;
		else m = atoi(mes);
	}
	else m = -1;

	return m;
}

/*Calcula os resultados globais da query 3*/
void q3global (Cat_VFacts c, int mes, char* prod) {
	q3* results = malloc(sizeof(struct strq3));
	results[0] = init_q3(results[0]);

	results = vendasFatur(results,getAVLFact(c,mes-1),prod,1);

	printf("\n> Número de vendas de tipo N no mês %d do produto %s: %d", mes,prod,results[0]->vendasN);
	printf("\n> Número de vendas de tipo P no mês %d do produto %s: %d", mes,prod,results[0]->vendasP);
	printf("\n> Total faturado com vendas de tipo N do produto %s no mês %d: %.2f", prod,mes,results[0]->faturadoN);
	printf("\n> Total faturado com vendas de tipo P do produto %s no mês %d: %.2f\n", prod,mes,results[0]->faturadoP);

	free(results);
}

/*Calcula os resultados por filial da query 3*/
void q3filial (Cat_VFacts c, int mes, char* prod) {
	q3* f = malloc(3*sizeof(struct strq3));
	for (int i = 0; i < 3; i++)
		f[i] = init_q3(f[i]);

	f = vendasFatur(f,getAVLFact(c,mes-1),prod,3);

	for (int i = 0; i < 3; i++) {
		printf("\nFilial %d:",i+1);
		printf("\n> Número de vendas de tipo N no mês %d do produto %s: %d", mes,prod,f[i]->vendasN);
		printf("\n> Número de vendas de tipo P no mês %d do produto %s: %d", mes,prod,f[i]->vendasP);
		printf("\n> Total faturado com vendas de tipo N do produto %s no mês %d: %.2f", prod,mes,f[i]->faturadoN);
		printf("\n> Total faturado com vendas de tipo P do produto %s no mês %d: %.2f\n", prod,mes,f[i]->faturadoP);
	}

	for (int i = 0; i < 3; i++)
		free(f[i]);
	free(f);
}

/*Query 3*/
void query3 (SGV sgv) {
	int m;
	char gf = globalOuFilial();
	char* mes = malloc(10);
	char* prod = malloc(10);

	do {
		printf("\nQual é o mês que deseja consultar? ");
		strtok(fgets(mes,10,stdin),"\n\r");
		m = verificaMes(mes);

		printf("Qual é o código do produto que deseja consultar? ");
		strtok(fgets(prod,10,stdin),"\n\r");

	} while (!(m>0 && m<13 && validaProduto(prod) && existeProd(sgv->catp,criaProd(prod))));

	if (gf == 'g') q3global(sgv->catvfact,m,prod);
	if (gf == 'f') q3filial(sgv->catvfact,m,prod);
	
	free(mes);
	free(prod);
}


/*Query 4*/
/*Calcula os resultados globais da query 4*/
void q4global (Cat_Prods catp) {
	Lista_Strings l = init_Lista();
	for (int i = 0; i < NRLETRAS; i++) 
		l = naoComprados(l,getAVLProds(catp,i),0);

	char* frase = malloc(50);
	sprintf(frase,"> Códigos dos %d produtos que ninguém comprou:", getNumLista(l));
	navegador(l,frase);
	freeLista(l);
	free(frase);
}

/*Escreve as frases dos resultados por filial da query 4*/
char* fraseQ4filial (Lista_Strings l1, Lista_Strings l2, Lista_Strings l3, char fil) {
	char* frase = malloc(100);
	if (fil == '1')
		sprintf(frase,"> Códigos dos %d produtos que ninguém comprou na filial 1:", getNumLista(l1));
	if (fil == '2')
		sprintf(frase,"> Códigos dos %d produtos que ninguém comprou na filial 2:", getNumLista(l2));
	if (fil == '3')
		sprintf(frase,"> Códigos dos %d produtos que ninguém comprou na filial 3:", getNumLista(l3));
	return frase;
}

/*Pergunta ao utilizador que filial quer consultar*/
char inputF () {
	char* buf = malloc(10);
	while(!((buf[0] == '1' || buf[0] == '2' || buf[0] == '3' || buf[0] == 'q') && buf[1] == '\n')) {
		printf("\nQue filial pretende consultar? (q) para sair: ");
		buf = fgets(buf,10,stdin);
	}
	return buf[0];
}

/*Calcula os resultados por filial da query 4*/
void q4filial (Cat_Prods catp) {
	Lista_Strings l1 = init_Lista();
	Lista_Strings l2 = init_Lista();
	Lista_Strings l3 = init_Lista();

	for (int i = 0; i < NRLETRAS; i++)  {
		l1 = naoComprados(l1,getAVLProds(catp,i),1);
		l2 = naoComprados(l2,getAVLProds(catp,i),2);
		l3 = naoComprados(l3,getAVLProds(catp,i),3);
	}

	char fil = 'a';
	while (fil != 'q') {
		fil = inputF();
		if (fil == '1') navegador(l1,fraseQ4filial(l1,l2,l3,fil));
		if (fil == '2') navegador(l2,fraseQ4filial(l1,l2,l3,fil));
		if (fil == '3') navegador(l3,fraseQ4filial(l1,l2,l3,fil));
	}
}

/*Query 4*/
void query4 (Cat_Prods catp) {
	char letra = globalOuFilial();

	if (letra == 'g') q4global(catp);
	if (letra == 'f') q4filial(catp);
}


/*Query 5*/
void query5 (Cat_Clis catc) {
	Lista_Strings l = init_Lista();
	l = clisComuns(l,getAVLClis(catc));
	
	char* frase = malloc(100);
	sprintf(frase,"> Códigos dos %d clientes que realizaram compras em todas as filiais: ", getNumLista(l));
	navegador(l,frase);
	freeLista(l);
	free(frase);
}


/*Query 6*/
void query6 (SGV sgv) {
	int np = 0;
	for (int i = 0; i < 26; i++) 
		np = numNuncaComp(np,getAVLProds(sgv->catp,i),0);
	int nc = numNuncaComp(0,getAVLClis(sgv->catc),1);
	
	printf("\n> Número de produtos que ninguém comprou: %d\n", np);
	printf("> Número de clientes registados que não realizaram compras: %d\n", nc);
}


/*Query 7*/
/*Imprime a tabela dos resultados da query 7*/
void printTabela (int** tab) {
	printf("\n\nNúmero total de produtos comprados mês a mês pelo cliente dado:\n");
	printf("\n	Mês-Filial	 1	 2	 3\n	");
	for (int i = 0; i < NRMESES; i++) {
		printf("    %d   ",i+1);
		for (int j = 0; j < 3; j++) {
			printf("	%d", tab[i][j]);
		}
		printf("\n	");
	}
}

/*Query 7*/
void query7 (SGV sgv) {
	char* cod = malloc(10);
	do {
		printf("\nInsira o código de cliente que pretende consultar: ");
		strtok(fgets(cod,10,stdin),"\n\r");
	} while (!validaCliente(cod) || !existeCli(sgv->catc,criaCli(cod)));

	/*alocar a matriz*/
    int **tab = (int **) malloc (NRMESES * sizeof(int *)); 
    for (int i = 0; i < NRMESES; i++) 
         tab[i] = (int *) malloc (3 * sizeof(int));
    /*inicializar a matriz*/
	for (int i = 0; i < NRMESES; i++) {
		for (int j = 0; j < 3; j++)
				tab[i][j] = 0;
	}

	for (int j = 0; j < 3; j++)
		tab = numMesFil (cod,tab,getAVLFil(sgv->catvfil,j),j); 

	printTabela(tab);
}


/*Query 8*/
void query8 (Cat_VFacts f) {
	int x=-1, y=0;
	char* nome = malloc(10);
	do {
		printf("\nQual é o primeiro mês que deseja? ");
		strtok(fgets(nome,10,stdin),"\n\r");
		x = verificaMes(nome);

		printf("Qual é o segundo mês que deseja? ");
		strtok(fgets(nome,10,stdin),"\n\r");
		y = verificaMes(nome);
	
	} while(x<1 || x>12 || y<1 || y>12 || x>y);

	free(nome);
	double r = factTotalQ8(f,x,y);
	printf("\n> Número de vendas entres os meses %d e %d: %d\n",x,y,getValVendas(f,x,y));
	printf("> Total faturado nesses meses: %.2f\n",r);
}


/*Query 9*/
/*Pergunta ao utilizador que tipo de compras pretende consultar*/
char inputTipo () {
	char* buf = malloc(10);
	while(!((buf[0] == 'N' || buf[0] == 'P' || buf[0] == 'q') && buf[1] == '\n')) {
		printf("\nPretende consultar compras de tipo (N) ou (P)? (q) para sair: ");
		buf = fgets(buf,10,stdin);
	}
	return buf[0];
}

/*Query 9*/
void query9 (SGV sgv) {
	int x;
	char* cod = malloc(10);
	char* nome = malloc(10);

	do {
		printf("\nInsira o código de produto que pretende consultar: ");
		strtok(fgets(cod,10,stdin),"\n\r");

		printf("Insira a filial que pretende consultar: ");
		strtok(fgets(nome,10,stdin),"\n\r");
		if (!isdigit(nome[0])) x = -1;
		x = atoi(nome);

	} while (x<1 || x>3 || !validaProduto(cod) || !existeProd(sgv->catp,criaProd(cod)));

	Lista_Strings* l = init_arrLista(2);
	l = clisCompramProd(l, getAVLFil(sgv->catvfil,x-1), cod);

	char* frase = malloc(150);
	char tipo = 'a';

	while (tipo != 'q') {
		tipo = inputTipo();
		sprintf(frase,"> Códigos dos clientes que compraram o produto %s, na filial %d, numa compra de tipo %c:",cod,x,tipo);
		if (tipo == 'N') navegador(l[0],frase);
		if (tipo == 'P') navegador(l[1],frase);
	}

	freeLista(l[0]);
	freeLista(l[1]);
	free(l);
}

/*Query 10*/
void query10 (SGV sgv) {
	char* cod = malloc(10);
	char* nome = malloc(10);
	int mes;
	do {
		printf("\nInsira o código de cliente que pretende consultar: ");
		strtok(fgets(cod,10,stdin),"\n\r");

		printf("Insira o mês que pretende consultar: ");
		strtok(fgets(nome,10,stdin),"\n\r");
		mes = verificaMes(nome);
	
	} while (mes<1 || mes>12 || !validaCliente(cod) || !existeCli(sgv->catc,criaCli(cod)));

	Array_PU prodsUnis = init_PU (); 	
	for (int i = 0; i < 3; i++)
 		prodsUnis = percorreCli(getAVLFil(sgv->catvfil,i),prodsUnis,cod,mes);

 	Lista_Strings l = init_Lista();
 	l = ordenarLista(l,prodsUnis);

	char* frase = malloc(100);
	sprintf(frase,"> Lista de produtos que o cliente %s comprou no mês %d, por ordem descrescente de unidades:", cod, mes);
	navegador(l,frase);

	free_PU(prodsUnis);
	freeLista(l);
	free(cod);
	free(nome);
	free(frase);
}

/*Query 11*/
void query11(SGV sgv){
	char* cod = malloc(10);
	int N;
	do {
		printf("\nInsira o número de vendas que pretende: ");
		strtok(fgets(cod,10,stdin),"\n\r");
		N = atoi(cod);
	} while (N <= 0);

	for (int i = 0; i < 3; ++i) {
		Array_Prod s = initArrP(N);
		AVL a = inicializaAVL();
		s=prodsQ11(s,travessiaQ11Cli(a,getAVLFil(sgv->catvfil,i)),N);

		char* frase = malloc(100);
		sprintf(frase,"%d produtos mais vendidos na filial %d:\n",N,i+1);
		printf("\n%s",frase);
		for (int i = 0; i < N; ++i)
			printf("> Produto: %s  Unidades: %d  Clientes: %d\n",s->prod[i],s->uni[i],s->clis[i]);
		freeArrayProd(s);
		free(a);
	}
}


/*Query 12*/
void query12 (SGV sgv) {
	Array_Fact a = init_Arrf();
	char* cod = malloc(10);
	do {
		printf("\nInsira o código de cliente que pretende consultar: ");
		strtok(fgets(cod,10,stdin),"\n\r");
	} while (!validaCliente(cod) || !existeCli(sgv->catc,criaCli(cod)));


	for (int i = 0; i < 3; ++i)
		a = lookupCliente(cod,a,getAVLFil(sgv->catvfil,i));

	char* frase = malloc(100);
	sprintf(frase,"Códigos dos três produtos em que o cliente %s gastou mais dinheiro durante o ano:",cod);
	printf("\n%s\n",frase);
	
	for (int i = 0; i < 3; ++i)
		printf("> %s (total gasto: %.2f)\n",a->prod[i],a->fact[i]);
	
	free_Arrf(a);
	free(cod);
	free(frase);
}