%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento com informacao genealogica.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
%:- set_prolog_flag( unknown,fail ).

% 1)
soma(X,Y,R) :- R is X+Y.

% 2)
soma3(X,Y,Z,R) :- R is X+Y+Z.

% 3)
somaArray([],0).
somaArray([H|T],R) :- somaArray(T,R1), R is R1+H.

% 4)
op2(X,Y,+,R) :- R is X+Y.
op2(X,Y,-,R) :- R is X-Y.
op2(X,Y,*,R) :- R is X*Y.
op2(X,Y,/,R) :- R is X/Y.

% 5)
opArray([],+,0).
opArray([H|T],+,R) :- opArray(T,+,R1), R is R1+H.
opArray([],*,1).
opArray([H|T],*,R) :- opArray(T,*,R1), R is R1*H.

% 6)
maior(X,Y,R) :- X<Y, R is Y.
maior(X,Y,X).

% 7)
maior3(X,Y,Z,R) :- maior(X,Y,R1), maior(Z,R1,R).

% 8)
maiorArray([H],H).
maiorArray([H1,H2|T],R) :- H1 < H2, maiorArray([H2|T],R).
maiorArray([H1,H2|T],R) :- maiorArray([H1|T],R).

% 9,10,11 análogas a 6,7,8

% 12)
comprimento([],0).
comprimento([H|T],R) :- comprimento(T,R1), R is R1+1.

media(L,R) :- somaArray(L,S), comprimento(L,T), R is S/T.

% 13)
insertAsc([],X,[X]).
insertAsc([H|T],X,[X,H|T]) :- X =< H, !.
insertAsc([H|T],X,[H|T1]) :- insertAsc(T,X,T1).

% sortAsc([H|T],R) :- insertAsc(R1,H,R), sortAsc(T,R).

% 14) Análoga à 13

% 15)
vazios([],0).
vazios([[]|T],N) :- vazios(T,N1), N is N1+1.
vazios([_|T],N) :- vazios(T,N).