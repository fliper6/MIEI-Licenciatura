%{
#include "y.tab.h"
%}
%option noyywrap
%%
[()]				{return(yytext[0]);}
[a-zA-Z]+			{yylval.str = strdup(yytext); return(pal);}
[0-9]+(\.[0-9]+)?	{yylval.valor = atof(yytext); return(num);}
.|\n 				{;}
%%