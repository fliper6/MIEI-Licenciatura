%{
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <math.h>
%}

%union{ char* nome; float numero; int um_ou_zero; }

%token <numero>num
%token <um_ou_zero>boolean
%token AND 
%token NOT
%token OR
%type <numero>Expressao
%type <numero>Termo
%type <numero>Fator

%%
Calc : Expressao '\n'       {printf("-> %f\n",$1);}
     | Calc Expressao '\n'  {printf("-> %f\n",$2);}
     ;

Expressao : Termo               {$$ = $1;}
          | Expressao OR Termo  {$$ = $1 || $3;}
          | Expressao '+' Termo {$$ = $1 + $3;}
          | Expressao '-' Termo {$$ = $1 - $3;}
          ;

Termo : Fator           {$$ = $1;}
      | Termo AND Fator {$$ = $1 && $3;}
      | Termo '*' Fator {$$ = $1 * $3;}
      | Termo '/' Fator {if($3!=0) {$$ = $1 / $3;}
                         else {
                                printf ("Impossivel dividir por 0! IGNORE O RESULTADO \n");
                                $$=$1;
                              }  
                        } 
      | Termo '^' Fator {$$ = pow($1,$3);}                  
      ;

Fator : num                 {$$ = $1;}
      | id                  {/*$$ =   tabela[$1]; completar isto*/ }  
      | boolean             {$$ = $1;}
      | '-' Fator           {$$ = -1*$2;}
      | NOT Fator           {$$ = !$2;}
      | '(' Expressao ')'   {$$ = $2;}
      ;
%%

#include "lex.yy.c"

int yyerror(char *s) { 
    printf("ERRO: %s\n",s); 
    return(0); 
}

int main(){
    yyparse();
    return 0;
}