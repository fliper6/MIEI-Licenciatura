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
:- discontiguous adjacente/5.
:- discontiguous pertence/2.
%:- discontiguous caminho/6.
%:- discontiguous caminho1/6.


:- dynamic grafo/2.
:- dynamic adjacente/5.
:- dynamic pertence/2.
%:- dynamic caminho/6.
%:- dynamic caminho1/6.

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

g1(
    grafo([huelva,cadiz,sevilla,granad,cordoba,jaen,madrid],  
    [aresta(huelva,sevilla,a49,94),aresta(cadiz,sevilla,ap4,125),
    aresta(sevilla,granad,a92,125),aresta(sevilla,cordoba,a4,138),
    aresta(granad,jaen,a44,97),aresta(jaen,madrid,a4,335),
    aresta(cordoba,madrid,a4,400)])
).

pertence(X,[X|_]).
pertence(X,[Y|T]):- pertence(X,T).

adjacente(X,Y,E,P,grafo(_,Arestas)):- pertence(aresta(X,Y,E,P),Arestas); pertence(aresta(Y,X,E,P),Arestas).

% 1 
caminho(G,A,B,P,Km,Es):- caminho1(G,A,[B],P,Km,Es).
caminho1(_,A,[A|P1],[A|P1],Km,Es).
caminho1(G,A,[Y|P1],P,Km,Es):- 
    adjacente(X,Y,Estrada1,Km1,G),
    \+ memberchk(X,[Y|P1]),
    append([Estrada1],Es,Es2),
    caminho1(G,A,[X,Y|P1],P,Km2,Es2), 
    Km is Km1 + Km2.

% 2
ciclo(G,A,P,Km,Es) :- 
    adjacente(B,A,Estrada1,Km1,G), 
    caminho(G,A,B,P1,Km,Es), append(P1,[A],P).