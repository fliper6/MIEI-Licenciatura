%{
#include "y.tab.h"
%}
%option noyywrap
%%
[(+\-*/)\n\^]         { return(yytext[0]); }
(?i:true)           { yylval.um_ou_zero=1; return(boolean); }
(?i:false)          { yylval.um_ou_zero=0; return(boolean); }
(?i:and)            { return(AND); }
(?i:or)             { return(OR); }
(?i:not)            { return(NOT); }
[0-9]+(\.[0-9]+)?   { yylval.numero=atof(yytext); return(num); }
.                   { ; }
%%