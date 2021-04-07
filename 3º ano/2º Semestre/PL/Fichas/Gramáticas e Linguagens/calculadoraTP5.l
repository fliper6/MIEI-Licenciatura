%{
#include "y.tab.h"
#include <ctype.h>
%}


%%
[0-9]+(\.[0-9]+)?       {yylval.num = atof(yytext); return NUM;}
[A-Za-z]                {yylval.c = toupper(yytext[0]); return LETRA;}
[+\-*/\n()=]            {return yytext[0]; }
.                       { ; }
%%


int yywrap(){
  return(1);
}
