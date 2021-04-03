%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% i. Construir a extensão do predicado «pertence» que verifica se um elemento existe dentro de uma lista de elementos;

pertence([H|T],H).
pertence([H|T],X) :- pertence(T,X).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ii. Construir a extensão do predicado «comprimento» que calcula o número de elementos existentes numa lista;

comprimento([],0).
comprimento([H|T],X) :- comprimento(L,X), N is X+1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% iii. Construir a extensão do predicado «diferentes» que calcula a quantidade de elementos diferentes existentes numa lista;

diferente([],0).
diferente([H|T],X) :- pertence(T,H),!, diferente(T,X).
diferente([H|T],X) :- diferente(T,K), X is K+1.