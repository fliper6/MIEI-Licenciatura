%{
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>

int comp = 0;
int contaN = 0;
int contaP = 0;
float soma = 0;
%}

%union {float valor; char* str; int valI;}
%token <str>pal
%token <valor>num
%type <valI>SexpList

%%
Lisp : SExp    {printf("comprimento global = %d\n", comp);}
	 ;
SExp : pal					{contaP++; printf("[%s]\n", $1);}
     | num					{contaN++; soma += $1;}
     | '(' SexpList ')'		{printf("comprimento = %d\n", $2);}
     ;
SexpList : SExp SexpList	{comp++; $$ = 1 + $2;}
         |					{$$ = 0;}
		 ;
%%
#include "lex.yy.c"

int yyerror(char *s) { printf("ERRO: %s\n", s); return(0); }

int main(){
    yyparse();
    printf("total num = %d\n", contaN);
    printf("total pal = %d\n", contaP);
    printf("somatorio = %f\n", soma);
	return 0;
}
