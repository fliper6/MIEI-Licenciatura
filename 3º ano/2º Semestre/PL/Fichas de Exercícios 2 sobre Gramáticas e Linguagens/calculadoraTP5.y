%{
#include <stdio.h>
#include <strings.h>
#include <stdlib.h>
/* Declaracoes C diversas */
int erro = 0;
float letras[27];
%}

%union{ float num; char c;}

%token <num>NUM <c>LETRA
%type <num>Fator Termo Expr
%type <num>Atrib

%%
Calculadora : Exprs
            ;

Exprs : Atrib '\n'         {if(!erro) printf("=> %.3f\n", $1); erro = 0;}
      | Exprs Atrib '\n'   {if(!erro) printf("=> %.3f\n", $2); erro = 0;}
      ;

Expr : Termo              {$$ = $1;}
     | Expr '+' Termo     {$$ = $1 + $3;}
     | Expr '-' Termo     {$$ = $1 - $3;}
     ;

Atrib : LETRA '=' Expr    {$$ = $3; letras[$1 - 65] = $3;}
      | Expr              {$$ = $1;}
      ;

Termo : Fator             {$$ = $1;}
      | Termo '*' Fator   {$$ = $1 * $3;}
      | Termo '/' Fator   {if($3 == 0) {yyerror("Divisão por 0\n"); erro = 1;} else {$$ = $1 / $3;} }
      ;

Fator : NUM               {$$ = $1;}
      | '-' NUM           {$$ = -1 * $2;}
      | '(' Expr ')'      {$$ = $2;}
      | LETRA             {$$ = letras[$1 - 65];}
      ;

%%

#include "lex.yy.c"

int yyerror(char *s)
{
  fprintf(stderr, "ERRO: %s \n", s);
}

int main()
{
  printf("Calculadora PM disponivel\n");
    yyparse();
  printf("Obrigado pela escolha :)\n");
  return(0);
}
