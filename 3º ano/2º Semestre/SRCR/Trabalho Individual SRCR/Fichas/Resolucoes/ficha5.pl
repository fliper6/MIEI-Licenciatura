%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declarações iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definições iniciais

:- op( 900,xfy,'::' ).
:- dynamic filho/2.
:- dynamic pai/2.
:- dynamic idade/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado filho: Filho,Pai -> {V,F}

filho( joao,jose ).
filho( jose,manuel ).
filho( carlos,jose ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado idade: Pessoa,Idade -> {V,F}

idade( joao,21 ).
idade( jose,42 ).
idade( manuel,63 ).
idade( carlos,19 ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariante Estrutural: não permitir a inserção de conhecimento repetido

%1
%para (F,P), sendo F filho de P, o espaço de soluções é S e possui apenas um elemento
+filho(F,P) :: (solucoes((F,P), (filho(F,P)), S),
                  comprimento(S,N),
				  N == 1).

%2
+pai(P,F) :: (solucoes((P,F), pai(P,F), S),
                comprimento(S,N),
                N == 1).

%3
+neto(X,A) :: (solucoes((P,F), neto(X,A), S),
                comprimento(S,N),
                N == 1).

%4
+avo(A,X) :: (solucoes((P,F), avo(A,X), S),
                comprimento(S,N),
                N == 1).

%5
+descendente(X,Y,G) :: (solucoes((X,Y), descendente(X,Y,G), S),
                        comprimento(S,N),
                        N == 1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariante Referencial: não admitir mais do que 2 progenitores para um mesmo indivíduo

%6
%para Ps, sendo F filho de Ps, o espaço de soluções é S e tem comprimento <= 2
+filho(F,P) :: (solucoes((Ps), filho(F,Ps), S),
                comprimento(S,N),
                N =< 2).

%7
+pai(P,F) :: (solucoes(Ps, pai(Ps,F), S),
                comprimento(S,N),
                N =< 2).

%8
+neto(X,A) :: (solucoes(As, neto(X,As), S),
                comprimento(S,N),
                N =< 4).

%9
+avo(A,X) :: (solucoes(As, avo(As,X), S),
                comprimento(S,N),
                N =< 4).

%10
+descendente(X,Y,G) :: (solucoes((Gs), descendente(X,Y,Gs), S),
                        comprimento(S,N),
                        natural(N)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extens�o do predicado que permite a evolucao do conhecimento

evolucao( Termo ) :-
    solucoes( Invariante, +Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ). 

insercao( Termo ) :-
    assert( Termo ).
insercao( Termo ) :-
    retract( Termo ), !,fail.

    teste( [] ).
teste( [R|LR] ) :-
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
nao( Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).

comprimento( S,N ) :-
    length( S,N ).
    
natural(X) :- X=1.
natural(X) :- X > 1, Y is X-1, natural(Y).