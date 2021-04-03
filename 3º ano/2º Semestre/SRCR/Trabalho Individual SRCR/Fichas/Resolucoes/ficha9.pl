%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida
% Representacao de conhecimento imperfeito

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown, fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- discontiguous '::'/2.

:- discontiguous grafo/2.
:- discontiguous aresta/2.
:- discontiguous pertence/2.


:- dynamic grafo/2.
:- dynamic aresta/2.
:- dynamic pertence/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extens�o do predicado que permite a evolucao do conhecimento

evolucao( Termo ) :-
    solucoes( Invariante, +Termo::Invariante,Lista ),  %coloca numa lista todos os invariantes
    insercao( Termo ), %insere o termo na base de informação para ser testado a seguir
    teste( Lista ).  % testa o termo contra os invariantes, se passar fica

insercao( Termo ) :-
    assert( Termo ). % o assert insere o termo na base de conhecimento
insercao( Termo ) :-
    retract( Termo ), !,fail. % se não o consegui inserir direito, tem de o remover
	
teste( [] ).
teste( [R|LR] ) :-  % verifica se todos os testes ao invariante são positivos
    R,   
    teste( LR ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extens�o do predicado que permite a involucao do conhecimento

involucao( Termo ) :-
    solucoes( Invariante,-Termo::Invariante,Lista ),
    remocao( Termo ),
    teste( Lista ).

remocao( Termo ) :-
    retract( Termo ).
remocao( Termo ) :- 
    assert( Termo ),!,fail.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( _ ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).

comprimento( S,N ) :-
    length( S,N ).

% ------------------------------------- EXs -------------------------------------

grafo(
    [a,b,c,d,e,f,g],  
    [aresta(a,b), aresta(b,a), aresta(d,c), aresta(c,d), aresta(f,c), aresta(c,f), aresta(d,f), aresta(f,d), aresta(g,f), aresta(f,g), aresta(e,desconhecido)]
    ).

% 1
pertence(X,[X|_]).
pertence(X,[Y|T]):- pertence(X,T).

adjacente(X,Y,grafo(_,Arestas)):- pertence(aresta(X,Y),Arestas); pertence(aresta(Y,X),Arestas).

% 2
caminho(G,A,B,P):- caminho1(G,A,[B],P).
caminho1(_,A,[A|P1],[A|P1]).
caminho1(G,A,[Y|P1],P):- adjacente(X,Y,G), \+ memberchk(X,[Y|P1]), caminho1(G,A,[X,Y|P1],P).

% 3
ciclo(G,A,P) :- 
    adjacente(B,A,G), caminho(G,A,B,P1), append(P1,[A],P).