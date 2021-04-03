%option main
%%
\"pt-BR\"\>\<seg\>[0-9]{8}-[0-9]     {printf("%s :: ",yytext+13);}
\"pl\"\>\<seg\>[0-9]{8}-[0-9]        {}

\"pt-BR\"\>\<seg\>[^\n\r<>]*         {printf("%s :: ",yytext+13);}
\"pl\"\>\<seg\>[^\n\r<>]*            {printf("%s\n",yytext+10);}

.|\n                                 {}
%%