%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão de um predicado que calcula a soma de dois valores

sum(X,Y,R) :- R is X + Y.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão de um predicado que calcula a soma de três valores

sum2(X,Y,Z,R) :- R is X + Y + Z.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão de um predicado que calcula a soma de um conjunto de valores

sum3([],0).

sum3([X|T],R) :- sum3(T,R1), R is R1 + X. %(O "R is ..." tem de vir depois da chamada recursiva)

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão de um predicado que aplique uma operação aritmética (adição,subtração, multiplicação ou divisão) a dois valores

op(X,Y,+,R) :- R is X + Y.

op(X,Y,-,R) :- R is X - Y.

op(X,Y,*,R) :- R is X * Y.

op(X,Y,:,R) :- R is X / Y.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensão de um predicado que aplique uma operação aritmética (adição ou multiplicação) a um conjunto de valores

op2([],+,0).

op2([H|T],+,R) :- op2(T,+,R2), R is H + R2.

op2([],-,0).

op2([H|T],-,R) :- op2(T,-,R2), R is H - R2.

op2([],*,1).

op2([H|T],*,R) :- op2(T,*,R2), R is H * R2.

op2([],:,1).

op2([H|T],:,R) :- op2(T,:,R2), R is H / R2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensão de um predicado que calcule o maior valor entre dois valores

maior(X,Y,R) :- X > Y, R is X.

maior(X,Y,R) :- X < Y, R is Y.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensão de um predicado que calcule o maior valor entre três valores


maior(X,Y,R) :- X > Y, R is X.

maior(X,Y,R) :- X < Y, R is Y.


