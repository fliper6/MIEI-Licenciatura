%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento com informacao genealogica.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais
:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado filho: Filho,Pai -> {V,F}
filho(joao,jose).
filho(jose,manuel).
filho(carlos,jose).
filho(manuel,antonio).

%joao -> jose -> manuel -> antonio
%carlos -> jose -> manuel -> antonio

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pai: Pai,Filho -> {V,F}
pai(P,F) :- filho(F,P).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado avo: Avo,Neto -> {V,F}
avo(A,N) :- filho(N,X), filho(X,A).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado bisavo: Bisavo,Bisneto -> {V,F}
bisavo(B,N) :- filho(N,P), filho(P,A), filho(A,B).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado neto: Neto,Avo -> {V,F}
neto(N,A) :- avo(A,N).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente -> {V,F}
descendente(X,Y) :- filho(X,Y); filho(X,P), descendente(P,Y).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente,Grau -> {V,F}
grauDescendencia(X,Y,1) :- filho(X,Y).
grauDescendencia(X,Y,G) :- grauDescendencia(P,Y,G2), filho(X,P), G is G2+1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado capaz de determinar se o indivíduo A é avô de N pela utilização do predicado que determina o grau de descendência entre dois indivíduos
avoPeloGrau(A,N) :- grauDescendencia(N,A,G), G == 2.

%estoura se não for true porque a grauDescendencia é recursiva e fica a correr infinitamente