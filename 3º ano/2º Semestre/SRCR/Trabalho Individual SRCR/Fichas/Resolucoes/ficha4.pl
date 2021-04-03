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
par(X) :- X=0.
par(X) :- X>1, Y is X-2, par(Y).
par(X) :- X<(-1), Y is X+2, par(Y).

% 2)
impar(X) :- X=1; X=(-1).
impar(X) :- X>1, Y is X-2, impar(Y).
impar(X) :- X<(-1), Y is X+2, impar(Y).

% 3)
natural(X) :- X=1.
natural(X) :- X > 1, Y is X-1, natural(Y).

% 4)
inteiro(X) :- X=0.
inteiro(X) :- X>=1, Y is X-1, inteiro(Y).
inteiro(X) :- X=<(-1), Y is X+1, inteiro(Y).

% 5)
divide(X,0,[]).
divide(X,N,[N|L]) :- Y is X/N, natural(Y), N1 is N-1, divide(X,N1,L).
divide(X,N,L) :- N1 is N-1, divide(X,N1,L).

divisores(X,L) :- divide(X,X,L).

% 6) Se tirar o comentário funciona direito para primos mas dá erro em não primos por algum motivo
primo(X) :- divisores(X,L), length(L,N).%, N=2.

% 7)
mdc(X,X,X).
mdc(X,Y,R) :- X>Y, Z is X-Y, mdc(Z,Y,R).
mdc(X,Y,R) :- Z is Y-X, mdc(X,Z,R).

% 8)
mmcAux(X,Y,M,M) :- X>Y, Z is M/Y, natural(Z).
mmcAux(X,Y,M,R) :- X>Y, Z is M+X, mmcAux(X,Y,Z,R).
mmcAux(X,Y,M,M) :- X<Y, Z is M/X, natural(Z).
mmcAux(X,Y,M,R) :- X<Y, Z is M+Y, mmcAux(X,Y,Z,R).

mmc(X,X,X).
mmc(X,Y,R) :- X>Y, mmcAux(X,Y,X,R).
mmc(X,Y,R) :- mmcAux(X,Y,Y,R).

% 9)
fibAux(F0,F1,N,M,F0) :- N=M, par(M).
fibAux(F0,F1,N,M,F1) :- N=M.
fibAux(F0,F1,N,M,T) :- par(N), NN is N+1, FN is F0+F1, fibAux(F0,FN,NN,M,T).
fibAux(F0,F1,N,M,T) :- NN is N+1, FN is F0+F1, fibAux(FN,F1,NN,M,T).

fibonacci(N,0) :- N=0.
fibonacci(N,1) :- N=1.
fibonacci(N,T) :- fibAux(0,1,1,N,T).