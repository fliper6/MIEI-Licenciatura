%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento com informacao genealogica.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais
 
:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
 
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- discontiguous ave/1.
:- discontiguous mamifero/1.
:- dynamic '-'/1.
:- dynamic excecao/1.
:- dynamic mamifero/1.
:- dynamic morcego/1.
:- dynamic ave/1.
:- dynamic periquito/1.
:- dynamic gato/1.
 
:- op( 1100,xfy,'??' ).
 
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Declaracoes

excecao(voa(X)) :- avestruz(X).
excecao(-voa(X)) :- morcego(X).

%1)
voa(X) :- ave(X),nao(excecao(voa(X))).

%2)
-voa(X) :- mamifero(X),nao(excecao(-voa(X))).

%3)
-voa(tweety).

%4)
ave(pitigui).

%5)
ave(X) :- canario(X).

%6)
ave(X) :- periquito(X).

%7)
canario(piupiu).

%8)
mamifero(silvestre).

%9)
mamifero(X) :- cao(X).

%10)
mamifero(X) :- gato(X).

%11)
cao(boby).

%12)
ave(X) :- avestruz(X).

%13)
ave(X) :- pinguim(X).

%14)
avestruz(trux).

%15)
pinguim(pingu).

%16)
mamifero(X) :- morcego(X).

%17)
morcego(batemene). 
 
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado si: Questao,Resposta -> {V,F}
%                            Resposta = { verdadeiro,falso,desconhecido }
 
si( Questao,verdadeiro ) :-
    Questao.
si( Questao,falso ) :-
    -Questao.
si( Questao,desconhecido ) :-
    nao( Questao ),
    nao( -Questao ).
 
Questao ?? verdadeiro :-
    Questao.
Questao ?? falso :-
    -Questao.
Questao ?? desconhecido :-
    nao( Questao ),
    nao( -Questao ).
 
 
 
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}
 
nao( Questao ) :-
    Questao, !, fail.
nao( _ ).