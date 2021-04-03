%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida
% Representacao de conhecimento imperfeito

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

:- include funcAux.pl.

% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- discontiguous '::'/2.

:- dynamic servico/2.
:- dynamic ato/4.

%-------------------------------------------------------------------------
% a)

% Definição de predicados
   
% servico: Nome, Enfermeira -> {V,F,D}
% (ato: Nome, Enfermeira, Utente, Data -> {V,F}) - lógica tradicional
% ato: Nome, Enfermeira, Utente, Data -> {V,F,D} - lógica extendida

% Exemplos de predicado:

% servico(ortopedia,amelia).
% ato(penso,ana,joana,sabado).
% ato(sutura,[maria,mariana],josefa,[terca,sexta]). - REPRESENTAR OS VÁRIOS VALORES POSSÍVEIS (!= exceção)

% por omissão, se nao definir um predicado com dynamic, o prolog parte do principio que é estatico
% nao conseguimos adicionar, remover ou alterar dinamicamente nada relacionado com aquele predicado

% IMPRECISOS
excecaoData(ato(penso,ana,jacinta,segunda)).
excecaoData(ato(penso,ana,josefa,sexta)).

% INCERTOS
nuloIncerto(#007).
excecaoServico(servico(Servico,Enfermeira)):- servico(#007,teodora).

servico(ortopedia,amelia).
servico(obstetricia,ana).
servico(obstetricia,maria).
servico(obstetricia,mariana).
servico(geriatria,sofia).
servico(geriatria,susana).
servico(007,teodora).
servico(np9,zulmira).

ato(penso,ana,joana,sabado).
ato(gesso,amelia,jose,domingo).
ato(017,mariana,joaquina,domingo).
ato(domicilio,maria,121,251).
ato(domicilio,susana,[joao,jose],segunda).
ato(sutura,313,josue,segunda).
ato(sutura,[maria,mariana],josefa,[terca,sexta]).
ato(penso,ana,jacinta,X) :-
    X=segunda;X=terca;X=quarta;X=quinta;X=sexta.
    
excecao( ato( penso,ana,jacinta,X ) ) :- X=segunda; X=terca; X=quarta; X=quinta; X=sexta.

%excecao ( ato( penso,ana,jacinta,X ) ) :- dia(X).
%
%dia('segunda').
%dia('terca').
%dia('quarta').
%dia('quinta').
%dia('sexta').
% OU
%dia(X) :- X=segunda; X=terca; X=quarta; X=quinta; X=sexta.