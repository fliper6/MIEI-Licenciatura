%{
#include "y.tab.h"
#include <math.h>
void yyerror(char*);


int nEspacos=0;
int nEspacosAtual=-1;
int block=0;
int diferenca=0;
int back=0;
int spaces=0;
int termina=0;


%}

%option noyywrap yylineno
%x tag texto atributos class id

%%
  {if (back==0&&termina==1)   {back--; return closetagg;} }
  {if (back>0)                {back--; return closetagg;} }
  {if (spaces>0)              {spaces--; return espacos;} }
  {if (termina==1)            {return 0;} }
  

doctype.*                 {yylval.s = strdup(yytext+8); return DOCTYPE;}

[ ]*                     {nEspacosAtual=strlen(yytext);
                          diferenca=nEspacosAtual-nEspacos;
                          if (block==1 && nEspacosAtual>nEspacos)  {BEGIN texto;}
                          if (block==1 && nEspacosAtual<=nEspacos) {block=0;}
                          if (block==0) nEspacos=nEspacosAtual;
                          yylval.s = strdup(yytext);
                          if(diferenca<=0){
                            while(diferenca<=-2) {diferenca+=2;back++;}
                            spaces++;
                            return closetagg;
                          }
                          return espacos;
                         }


#                          {BEGIN id; return yytext[0];}


<id>[^\.\n]+               {BEGIN class;
                            yylval.s = strdup(yytext);                         
                            return idd;}

         
<class>\n                  {BEGIN INITIAL;}
<class>\.\n                {BEGIN texto; block=1;}
<class>[^\.\n]+            {yylval.s = strdup(yytext); return classs;}
<class>\.                  {return yytext[0];}



[a-zA-Z0-9]+/[ (=\n\.]     {if (nEspacosAtual==0) {yyerror("Erro : Uma tag necessita de indentação");}
							              yylval.s = strdup(yytext); 
							              nEspacosAtual=0;
                            BEGIN tag; 
                            return tagg;}



<tag>\(                    {BEGIN atributos; return yytext[0];}
<tag>\)                    {return yytext[0];}
<tag>=.*                   {BEGIN INITIAL;}
<tag>\n                    {BEGIN INITIAL;}
<tag>[ ].*                 {yylval.s = strdup(yytext+1);return conteudo;}
<tag>\.\n                  {BEGIN texto; block=1;}



<atributos>.*/[)]          {yylval.s = strdup(yytext);
                            BEGIN tag;
                            return atribute;}


<texto>[^ ].*/\n           {yylval.s = strdup(yytext);
                            nEspacosAtual=0;
                            BEGIN INITIAL;
                            return string;}

<texto>[ ]*                {nEspacosAtual=strlen(yytext);
							              if (nEspacosAtual<=nEspacos) {yyerror("Erro : Dentro de um bloco de texto é necessário indentação");}
                            yylval.s = strdup(yytext);
                            return espacos;
                           }



<<EOF>>                    {diferenca=-nEspacos;
                            while(diferenca<-2) {diferenca+=2;back++;}
                            termina=1;
                            return closetagg;
                           }



[\n\t\r ]                ;


.                         {yyerror("Caracter Invalido");}

%%


