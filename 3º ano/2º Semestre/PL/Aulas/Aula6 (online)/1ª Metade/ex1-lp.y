%{
 int yylex();
 void yyerror(char*);
 #include <stdio.h>
%}



%%

texto : lp {printf("ok\n");}

// Versão 4

lp : bpe lp    // bpe*
   |   
   ;       

bpe: '(' lp ')' 
   ;


%%


int main(){
    yyparse();
    return 0;
}

void yyerror(char* s){
   extern int yylineno;
   extern char* yytext;
   fprintf(stderr, "Linha %d: %s (%s)\n", yylineno,s,yytext);
}
 // Expreg          Gramáticas
 // a*              A: A a | ; ou A: a A | ;
 // a+              A: A a | a;
 // (a | b)*c  (1)  A: Bc ; B: aB | bB | ;
 //                         ==> B : (a|b)B | ; ==> B: (a|b)*
 //            (2)  A: a A | b A | c
 //            (3)  A: B A | c ; B: a | b



 // Versão 1
 //lp : '(' ')'            // ()

 //lp  : '(' lp ')' | ;    // vazio ; () ; (()) ; ((()))
                           // não inclui () () ((())) ; (()()())   // bpe (...)

 // Versão 2
 //lp : '(' ')'            // (), (()), ((())) = Versão 1 sem o caso do vazio
 //   | '(' lp ')'

 // Versão 3
 //lp : ( lp ) lp | ;      // vazio, (), ()()


