%option main
%%
\"pt-BR\"\>\<seg\>[^\n<>]*     {printf("%s\n",yytext+13);}
\"pl\"\>\<seg\>[^\n<>]*        {printf("%s\n",yytext+10);}
.|\n                           {}
%%