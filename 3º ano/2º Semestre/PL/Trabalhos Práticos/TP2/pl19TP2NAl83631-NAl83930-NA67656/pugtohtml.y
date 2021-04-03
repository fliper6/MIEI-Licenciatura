%{
#define _GNU_SOURCE       


  int yylex();
  void yyerror(char*);
  void writeFile(char*);
  char* limpaTag(char*);

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>


%}

%union{
    char c;
    int n;
    char* s;
}

%token  DOCTYPE string tagg conteudo atribute idd classs closetagg espacos
%type <s>  string DOCTYPE ListaLinhas tagg Special Linha conteudo atribute idd classs closetagg Tag espacos Espacos


%%

Prog       : ListaLinhas                      {writeFile($1);}
           ;


ListaLinhas: ListaLinhas Linha                {asprintf(&$$,"%s\n%s",$1,$2);}
           | Linha                            {$$ = strdup($1);} 
           ;


Linha      : Espacos Tag ListaLinhas closetagg               {asprintf(&$$,"%s<%s>\n%s\n%s</%s>",$1,$2,$3,$1,limpaTag($2));}
           | Espacos Tag closetagg                           {asprintf(&$$,"%s<%s></%s>",$1,$2,limpaTag($2));}  
           | Espacos Tag conteudo ListaLinhas closetagg      {asprintf(&$$,"%s<%s>%s\n%s\n%s</%s>",$1,$2,$3,$4,$1,limpaTag($2));}
           | Espacos Tag conteudo closetagg                  {asprintf(&$$,"%s<%s>%s</%s>",$1,$2,$3,limpaTag($2));}  
           | DOCTYPE                                         {asprintf(&$$,"<!DOCTYPE %s>",$1);}
           | Espacos string                                  {asprintf(&$$,"%s %s",$1,$2);}
           ;
     

Espacos    : espacos                          {$$=strdup($1);}
           |                                  {$$=strdup("");}          
           ;

     
Tag        : tagg                             {$$=strdup($1);}
           | tagg '(' atribute ')'            {asprintf(&$$,"%s %s",$1,$3);}
           | '#' idd                          {asprintf(&$$,"div id=\"%s\"",$2);}
           | '#' idd '.' Special              {asprintf(&$$,"div class=\"%s\" id=\"%s\"",$4,$2);}
           ;


Special    : Special '.' classs               {asprintf(&$$,"%s %s",$1,$3);}
           | classs                           {$$ = strdup($1);}
           ; 



%%

int main(){
    yyparse();
    return 0;
}

void yyerror(char *s){
    extern int yylineno;
    extern char* yytext;
    fprintf(stderr, "linha %d: %s (%s)\n", yylineno, s, yytext);
}

void writeFile(char* linha) {
    FILE* f = fopen("HTML.html","w");
    fprintf(f,"%s",linha);
    fclose(f);
}

char* limpaTag(char* s) {
  char* f=strdup(s);
  int i=0;
  for(i;f[i]!=' ' && f[i]!='\0';i++);
  f[i]='\0';
  return f;
}

