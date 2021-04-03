%{
#include "y.tab.h" 

%}
%option noyywrap
%%
[_;\-+|]              { return(yytext[0]); }
(?i:urgente)          { return urgente; } 
(?i:normal)           { return normal; } 
(?i:baixa)            { return baixa; } 
\"[^"]+\"             { yytext[yyleng-1]='\0'; yylval.nome=strdup(yytext+1); return texto; }
[a-z][0-9]{3,5}       { yylval.codigo=strdup(yytext); return codigo_func; }
[1-9]|[123][0-9]      { yylval.dia=atoi(yytext); return dia_semana; } 
[0-9]{1,2}:[0-9]{1,2} { yylval.nome=strdup(yytext); return mes_ano; }
.|\n                  { ; }
%%
