%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Exercicio Individual nº1
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- discontiguous '::'/2.
:- discontiguous excecao/1.
:- discontiguous '-'/1.

:- dynamic data/3.
:- discontiguous data/3.

:- dynamic pai/2.
:- discontiguous pai/2.

:- dynamic dataNasc/2.
:- discontiguous dataNasc/2.

:- op( 1100,xfy,'??' ).

%--------------------------------- - - - - - - - - - -  -  
%Definições de -pai e -dataNasc
-pai(P,F):- nao(pai(P,F)), nao(excecao(pai(P,F))).
-dataNasc(N,D):- nao(dataNasc(N,D)), nao(excecao(dataNasc(N,D))).

%--------------------------------- - - - - - - - - - -  -  Exercicio i.
pai(abel,ana).
pai(alice,ana).
dataNasc(ana,data(1,1,2010)).

%--------------------------------- - - - - - - - - - -  -  Exercicio ii.
pai(antonio,anibal).
pai(alberta,anibal).
dataNasc(anibal,data(1,1,2010)).

%--------------------------------- - - - - - - - - - -  -  Exercicio iii.
pai(bras, berto).
pai(belem, berto).

pai(bras, berta).
pai(belem, berta).

dataNasc(berto,data(2,2,2010)).
dataNasc(berta,data(2,2,2010)).

%--------------------------------- - - - - - - - - - -  -  Exercicio iv.
dataNasc(catia,data(3,3,2010)).

%--------------------------------- - - - - - - - - - -  -  Exercicio v. (Tipo 2)
pai(catia,crispim).
excecao(pai(celso,crispim)).
excecao(pai(caio,crispim)).

%--------------------------------- - - - - - - - - - -  -  Exercicio vi. (Tipo 1)
pai(daniel,danilo).
pai(desconhecido,danilo).
excecao(pai(_,Filho)):- pai(desconhecido,Filho).
dataNasc(danilo,data(4,4,2010)).

%--------------------------------- - - - - - - - - - -  -  Exercicio vii. (Tipo 2)
pai(elias,eurico).
pai(elsa,eurico).
excecao(dataNasc(eurico,data(5,5,2010))).
excecao(dataNasc(eurico,data(15,5,2010))).
excecao(dataNasc(eurico,data(25,5,2010))).

%--------------------------------- - - - - - - - - - -  -  Exercicio viii. (Tipo 1 e 2)
excecao(pai(fausto,fabia)).
excecao(pai(fausto,octavia)).
pai(desconhecido,fabia).
pai(desconhecido,octavia).
excecao(pai(_,Filho)):- pai(desconhecido,Filho).

%--------------------------------- - - - - - - - - - -  -  Exercicio ix. (Tipo 3)
pai(guido,golias).
pai(guida,golias).
dataNasc(golias,dataNula).
excecao(dataNasc(Filho,_)):-dataNasc(Filho,dataNula).

%--------------------------------- - - - - - - - - - -  -  Exercicio x. (Tipo 1)
-dataNasc(helder,data(8,8,2010)).
dataNasc(helder,desconhecido).
excecao(dataNasc(Filho,_)):- dataNasc(Filho,desconhecido). 

%--------------------------------- - - - - - - - - - -  -  Exercicio xi. (Tipo 2)
excecao(dataNasc(ivo,data(Dia,6,2010))):- Dia>=1, Dia=<15.

    
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
nao(_).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes
+pai(_,F):: (solucoes( (Ps), pai( Ps,F),R),
            comprimento(R,N),
            N =< 2).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado que permite a evolucao do conhecimento

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
% Extensao do predicado que permite a involucao do conhecimento

involucao( Termo ) :-
    solucoes( Invariante,-Termo::Invariante,Lista ),
    remocao( Termo ),
    teste( Lista ).

remocao( Termo ) :-
    retract( Termo ).
remocao( Termo ) :- 
    assert( Termo ),!,fail.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).

comprimento( S,N ) :-
    length( S,N ).