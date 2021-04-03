%option noyywrap

%x META TREE FICH

%{ 
    #define M 20 
    #define N 50

    /*------GLOBAL VARIABLES------*/
    int   indiceAtual = 0;
    int   indiceMeta = 0;
    char* nome;
    char* meta[M], * dados[M];
    char* nomes[M], * dirs[M];
    char  diretoriaAtual[N], nomeFicheiroAtual[M];
    char  temp[M], temp2[M], root[M], n1[M], n2[M], n3[M];

    /*---------FUNCTIONS---------*/
    char* getMetaDado (char*);
    void saveMetaDado (char*, int);
    void  createFolder (char*, char*, int, int);
    void  createFile   (char*, int, int, int);
    void  openFile     (int,int);
    void  writeFile    (char*);
    void  mkdir        (char*);
    char* cutBarraN    (char* s);
%}


%%
 
<*>===\ meta\n\n              BEGIN META;
<*>===\ tree\n\n              BEGIN TREE;
<*>=                          BEGIN FICH;


  /*----------------------META----------------------*/ 

<META>.*:              { saveMetaDado(yytext,0);}

<META>\ .*\n           { saveMetaDado(yytext+1,1);}

<META>#.*\n|\n         {}


 /*-----------------CREATE FOLDERS-----------------*/ 

<TREE>--.\{%name%\}\/       { createFolder(n2, n1 ,0,0);} 

<TREE>--+.*\/               { createFolder(n2, n1 ,3,1);} 

<TREE>-.\{%name%\}\/        { createFolder(n1,root,0,0);}

<TREE>-+.*\/                { createFolder(n1,root,2,1);}

<TREE>\{%name%\}\/          { sprintf(root,"%s/",nome);  mkdir(root);}  

<TREE>.*\/                  { sprintf(root,"%s",yytext); mkdir(root);}  

<TREE>.|\n                  {}   

 /*-----------------CREATE FILES-----------------*/

<TREE>--.\{%name%\}.*       { createFile(n1  , 11, 0, 2);}

<TREE>--+.*                 { createFile(n1  , 3 , 1, 2);}

<TREE>-.\{%name%\}.*        { createFile(root, 10, 0, 2);}

<TREE>-+.*                  { createFile(root, 2 , 1, 2);}

<TREE>\{%name%\}.*          { createFile(""  , 8 , 0, 3);}    

<TREE>[^=\n].*              { createFile(""  , 0 , 1, 3);}                

 /*-----------------EDIT FILES-----------------*/

<FICH>==\ \{%name%\}.*\n    { openFile(11,0);}

<FICH>==\ +.*\n             { openFile( 3,1);}

<FICH>===\ \{%name%\}.*\n   { openFile(12,0);}
 
<FICH>===+.*\n              { openFile( 4,1);}

<FICH>\{%name%\}            { writeFile(nome);}

<FICH>\{\%[^\%\}]+\%\}      { writeFile(getMetaDado(yytext));}

<FICH>.*[=].*               { writeFile(yytext);}

<FICH>.|\n                  { writeFile(yytext);}

.|\n                        {}


%%


char* getMetaDado( char* name) {
    char* n;
    n = strdup(name+2);
    n[strlen(n)-2] = ':';
    n[strlen(n)-1] = '\0';
 
    for(int i=0; i<M; i++) {
      if (meta[i]==0) return name;
      if (strcmp(meta[i],n)==0) return dados[i];
    }
}


void saveMetaDado (char* name, int tipo) { 
    if (tipo == 0) meta[indiceMeta] = strdup(name);
    else dados[indiceMeta++] = strdup(cutBarraN(name));

  }


void createFolder(char* nS, char* nI, int inc, int tipo) {
    if (tipo == 0) 
      sprintf(nS,"%s/",nome);
    else 
      sprintf(nS,"%s",yytext + inc);
    strcpy(temp,nI);
    mkdir(strcat(temp,nS));
    strcpy(nS,temp); 
}


void createFile (char* nivel, int inc, int tipo, int tipo2) {
    char com[100];

    if (tipo == 0) 
      sprintf(temp,"%s%s",nome,yytext + inc);
    else
      sprintf(temp,"%s",yytext + inc);
    nomes[indiceAtual] = strdup(temp);

    if (tipo2 == 2) {
      sprintf(temp2,"%s/%s",nivel,temp);
      dirs[indiceAtual] = strdup(temp2);
      sprintf(com,"%s/%s",nivel,temp);}
    else {
      dirs[indiceAtual] = strdup(temp);
      sprintf(com,"%s",temp);}

    indiceAtual++;
    FILE* f = fopen(com,"a");
    fclose(f);
}


void openFile (int inc, int tipo) { 
    int j = 0;
    if (tipo == 0) {
      sprintf(temp,"%s%s", nome, yytext + inc);
      strcpy(nomeFicheiroAtual,cutBarraN(temp));}
    else
      strcpy(nomeFicheiroAtual,cutBarraN(yytext + inc));

    for(int i = 0; i < M; i++) {
      if (nomes[i]!=0) {
        if (strcmp(nomeFicheiroAtual,nomes[i]) == 0) {
            strcpy(diretoriaAtual,dirs[i]);
            j=1;
            break;
        }
      }
    }
    if (j==0) {
      strcpy(diretoriaAtual,"erro");
      printf("Erro: Ficheiro %s não contido na 'tree'!\n",nomeFicheiroAtual);
    }
}


void writeFile(char* linha) {
  if (strcmp(diretoriaAtual,"erro")!=0) {
    FILE* f = fopen(diretoriaAtual,"a");
    fprintf(f,"%s",linha);
    fclose(f);
  }
}


void mkdir(char* d) {
    char com[100];
    sprintf(com,"mkdir %s",d);
    system(com);
}


char* cutBarraN(char* s){
    char* n;
    n = strdup(s);
    n[strlen(n)-1] = '\0';
    return n;
}


int main(int c, char* argv[]) {
    nome  = strdup(argv[1]);
    yylex();
    return 0;
}
