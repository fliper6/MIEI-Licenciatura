%option main
%{
    void mkdir(char*);
    void saveInIndex(char*,char*);
%}
%%
             char n1[20],n2[20],n3[20],com[100];
             int u=0;
[0-9]{2}0{6}   {sprintf(n1,"%.2s",yytext);u=1;mkdir(n1);}    
[0-9]{3}0{5}  {sprintf(n2,"%.2s/%c",yytext,yytext[2]);u=2;mkdir(n2);}
[0-9]{4}0{4}   {}
.|\n    {}

::.*/::    {saveInIndex((u==1?n1:n2),yytext+2);}
%%

void mkdir(char* d) {
    char com[100];
    sprintf(com,"mkdir %s",d);
    system(com);
}

void saveInIndex(char* d,char* pt){
    char com[100];
    sprintf(com,"%s/index.html",d);
    FILE* f = fopen(com,"a");
    fprintf(f,"<li>%s</li>",pt);
    fclose(f);
}