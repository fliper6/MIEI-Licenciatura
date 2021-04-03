%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento com informacao genealogica.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

% 1)
pertence(X,[X|T]).
pertence(X,[H|T]) :- pertence(X,T).

% 2)
comprimento([],0).
comprimento([H|T],N) :- comprimento(T,N1), N is N1+1.

% 3)
diferentes([],0).
diferentes([H|T],N) :- pertence(H,T), diferentes(T,N).
diferentes([H|T],N) :- diferentes(T,N1), N is N1+1.

% 4)
apaga1(X,[],[]).
apaga1(X,[X|T],T).
apaga1(X,[H|T],[H|T1]) :- apaga1(X,T,T1).

% 5)
apagaT(X,[],[]).
apagaT(X,[X|T],L) :- apagaT(X,T,L).
apagaT(X,[H|T],[H|T1]) :- apagaT(X,T,T1).

% 6)
adicionar(X,[],[X]).
adicionar(X,[X|T],[X|T]).
adicionar(X,[H|T],[H|T1]) :- adicionar(X,T,T1).

% 7)
% [1,2] [3,4] -> [1,2,3,4]
concatenar([],[],[]).
concatenar([],[H|T],[H|L]) :- concatenar([],T,L).
concatenar([H|T1],L2,[H|L]) :- concatenar(T1,L2,L).

% [1,2] [3,4] -> [1,3,2,4]
%concatenar([],[],[]).
%concatenar([H|T],[],[H|L]) :- concatenar(T,[],L).
%concatenar([],[H|T],[H|L]) :- concatenar([],T,L).
%concatenar([H1|T1],[H2|T2],[H1,H2|L]) :- concatenar(T1,T2,L).

% 8)
inverter([],[]).
inverter([H|T],L) :- inverter(T,L1), adicionar(H,L1,L).

% 9)
percorre([],L,true).
percorre(L,[],false).
percorre([H|T1],[H|T2],R) :- percorre(T1,T2,R).
percorre([H1|T1],[H2|T2],false).

sublista([],L,true).
sublista([H|T1],[H|T2],R) :- percorre(T1,T2,R).
sublista(S,[H|T],R) :- sublista(S,T,R).