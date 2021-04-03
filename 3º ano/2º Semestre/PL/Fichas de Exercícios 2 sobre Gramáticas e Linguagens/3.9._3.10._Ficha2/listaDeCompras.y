%{
#include <stdio.h>
#include <strings.h>
#include <stdlib.h>
/* 
"Peixe":(123 - Pescada - 4 - < Unidade - 1 >) 
| "Cosmetica":(12345 - Sabao - 2 - < Unidade - 5 >) 
, (1221 - Espuma - 3 - < Volume - 1 >)
*/
%}

%union{ int num; float prec; char* str; }

%token  <num>Codigo Valor
%token  <prec>Preco
%token  Peso Volume Unidade Talho Cosmetica Peixaria 
%token  <str>Designacao 

%%
Compras : Seccoes
        ;

Seccoes : 
        | Seccs 
        ;

Seccs : Secc
      | Seccs '|' Secc
      ;

Secc : '"' Sec '"' ':' Prods
     ;

Sec : Talho
    | Cosmetica
    | Peixaria
    ;

Prods : Prod
      | Prods ',' Prod
      ;

Prod : '(' Codigo '-' Designacao '-' Preco '-' Quantidade ')'
     ;

Quantidade : '<' Tipo '-' Valor '>'
           ;

Tipo : Unidade 
     | Peso
     | Volume
     ; 
%%

#include "lex.yy.c"

int yyerror(char *s)
{
  fprintf(stderr, "ERRO: %s \n", s);
}

int main()
{
    printf("Bem-vindo à nossa lista de compras!\n");
    yyparse();
    printf("Obrigado pela escolha!\n");
    return(0);
}
