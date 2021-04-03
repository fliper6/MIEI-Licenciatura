%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- dynamic '-'/1.
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Questao,Resposta -> {V,F}

demo( Questao,verdadeiro ) :-
    Questao.
demo( Questao,falso ) :-
    -Questao.
demo( Questao,desconhecido ) :-
    nao( Questao ),
    nao( -Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%% 1

jogo(1,aa,500).

-jogo(I,1,C) :-
  nao(jogo(I,1,C)),
  nao(excecao(jogo(I,1,C))).



%% 2 - incerto

jogo(2,bb,xpto0123).

excecao(jogo(I,A,C)) :- jogo(I,A,xpto0123).




%% 3 - impreciso / inperfeito

excecao(jogo(3,cc,500)).

excecao(jogo(3,cc,2000)).




%% 4 - impreciso

excecao(jogo(4,dd,Ajudas)) :- Ajudas >= 250, Ajudas =< 750.




%% 5 - interdito (criar invariante)

jogo(5,ee,xpto765).

excecao(jogo(I,A,C)) :- jogo (I,A,xpto765).

nulo(xpto765).
+jogo(I,A,C) :: (solucoes(Ajudas,
                         (jogo(5,ee,Ajudas),
                         nao(nulo(Ajudas))),
                         S),
                         comprimento(S,N),
                         N==0).




%% 6 - impreciso

jogo(6,ff,250).

excecao(jogo(6,ff,Ajudas)) :- Ajudas >= 5000.




%% 7 - 

-jogo(7,gg,2500).
jogo(7,gg,xpto4567).
excecao(jogo(I,A,C)) :- jogo(I,A,xpto4567).


%% 8 - 

excecao(jogo(8,hh,Ajudas)) :- 
    cerca(1000,Csup,Cinf),
    Ajudas >= Cinf, Ajudas =< Csup.

cerca(X,Sup,Inf):- 
    Sup is X* 1.25,
    Inf is X*0.75.

    