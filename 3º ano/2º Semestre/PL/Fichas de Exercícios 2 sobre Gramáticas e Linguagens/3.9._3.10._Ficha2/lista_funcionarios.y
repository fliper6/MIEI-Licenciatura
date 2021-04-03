%{
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <math.h>
/* --- texto de entrada
"Nome Funcionario 1"_a12345_"Docente";
"Nome Funcionario 2"_e345_"Contabilista";
"Nome Funcionario 3"_f321_"Tecnico Informatica";
a12345+13+14:45+urgente+"Correcao dos testes do curso x"|
e345+27+11:20+normal+"Contabilizar as contas"|
f321+5+15:15+baixa+"Fazer coisas informaticas"|
*/
/* --- texto de saida produzido
INSERT INTO table.Funcionarios values ('Nome Funcionario 1','a12345','Docente');
INSERT INTO table.Funcionarios values ('Nome Funcionario 2','e345','Contabilista');
INSERT INTO table.Funcionarios values ('Nome Funcionario 3','f321','Tecnico Informatica');
INSERT INTO table.Tarefas values ('a12345',13,'14:45',1,'Correcao dos testes do curso x');
INSERT INTO table.Tarefas values ('e345',27,'11:20',2,'Contabilizar as contas');
INSERT INTO table.Tarefas values ('f321',5,'15:15',3,'Fazer coisas informaticas');
*/

%}

%union{ char* nome; char* codigo; int dia; }

%token <nome> texto
%token <codigo> codigo_func
%token <dia> dia_semana
%token <nome> mes_ano
%token urgente
%token normal
%token baixa
%type <dia> Prioridade
%type <nome> NomeFuncionario
%type <nome> FuncaoFuncionario
%type <nome> DescTar

%%

Secretaria : ListaF ListaTarefas
           ; 

ListaF : ListaF Funcionario
       | Funcionario
       ;

Funcionario : NomeFuncionario '_' codigo_func '_' FuncaoFuncionario ';' {printf("INSERT INTO table.Funcionarios values ('%s','%s','%s');\n",$1,$3,$5); }
            ;

NomeFuncionario : texto {$$=strdup($1);}
                ;

FuncaoFuncionario : texto {$$=strdup($1);}
                  ;

ListaTarefas : ListaTarefas Tarefa 
             | Tarefa
             ;

Tarefa : codigo_func '+' dia_semana '-' mes_ano '+' Prioridade '+' DescTar '|' {printf("INSERT INTO table.Tarefas values ('%s',%d,'%s',%d,'%s');\n",$1,$3,$5,$7,$9);}
       ;

DescTar : texto {$$=strdup($1);}
        ;

Prioridade : urgente {$$=1;}
           | baixa   {$$=3;}
           | normal  {$$=2;}
           ; 

%%

#include "lex.yy.c"

int yyerror(char *s) { 
    printf("ERRO: %s\n",s); 
    return(0); 
}

int main(){
    yyparse();
    return 0;
}
