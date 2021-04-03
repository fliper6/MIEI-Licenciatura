%option noyywrap
%x R E
%%
                    char reporter[200], entrevistado[200];
<*>R:               BEGIN R;
<*>E:               BEGIN E;
<E>[Ee]u            {printf("%s (%s)", yytext, entrevistado);}
<E>[Tt]u            {printf("%s (%s)", yytext, reporter);}
<R>[Ee]u            {printf("%s (%s)", yytext, reporter);}
<R>[Tt]u            {printf("%s (%s)", yytext, entrevistado);}
R=.*                {strcpy(reporter, yytext+2);}
E=.*                {strcpy(entrevistado, yytext+2);}

%%

int main(){
  yylex();
  return 0;
}