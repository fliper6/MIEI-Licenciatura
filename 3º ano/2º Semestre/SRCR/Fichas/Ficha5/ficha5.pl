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

% Exercício i.
+filho( F,P ) :: (solucoes( (F,P),(filho( F,P )),S ),
                  comprimento( S,N ), 
				  N == 1).

% Exercício ii.
+pai( P,F ) :: (solucoes((P,F),(pai(P,F)),S),
				comprimento(S,N),
				N == 1).

% Exercício iii.
+neto(N,A)  :: (solucoes((N,A),(neto(N,A)),S),
		        comprimento(S,N),
		        N == 1).

% Exercício iv.
+avo( A,N ) :: (solucoes((A,N),(avo(A,N)),S),
			    comprimento(S,N),
	        	N == 1).

% Exercício v.
+descendente( D,A ) :: (solucoes((D,A),(descendente(D,A)),S),
					    comprimento(S,N),
			            N == 1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariante Referencial: não admitir mais do que 2 progenitores para um mesmo individuo

% Exercício vi.
+filho( F,P ) :: (solucoes( (Ps),(filho( F,Ps )),S ),
                  comprimento( S,N ), 
                  N =< 2).

% Exercício vii.
+pai( P,F ) :: (solucoes((Ps),(filho(F,Ps)),S),
				comprimento(S,N),
				N =< 2).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariante Referencial: nao admitir mais do que 4 avós para um mesmo individuo

% Exercício viii.
+neto( N,A ) ::(solucoes((As),(neto(N,As)),S),
				comprimento(S,N),
				N =< 4).

% Exercício ix.
+avo( A,N ) :: (solucoes((As),(neto(N,As)),S),
				comprimento(S,N),
				N =< 4).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% A identificação do grau de descendência deverá pertencer ao conjunto dos números naturais N

% Exercício x.
+descendente( D,A ) :: (solucoes((D,A),(grau(D,A,G)),S),
						G >= 0).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariante Referencial: não é possivel remover filhos para os quais exista registo de idade

-filho( F,P ) :: (solucoes( (F),( idade( F,I ) ),S ),
                  comprimento( S,N ), 
                  N == 0).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a evolucao do conhecimento

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
% Extensão do predicado que permite a involucao do conhecimento

involucao( Termo ) :-
    solucoes( Invariante,-Termo::Invariante,Lista ),
    remocao( Termo ),
    teste( Lista ).

remocao( Termo ) :-
    retract( Termo ).
remocao( Termo ) :-
    assert( Termo ),!,fail.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).

comprimento( S,N ) :-
    length( S,N ).
