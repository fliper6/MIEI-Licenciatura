%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida
% Representacao de conhecimento imperfeito

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown, fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- discontiguous '::'/2.

:- discontiguous grafo/2.
:- discontiguous adjacente/5.
:- discontiguous pertence/2.
%:- discontiguous caminho/6.
%:- discontiguous caminho1/6.


:- dynamic grafo/2.
:- dynamic adjacente/5.
:- dynamic pertence/2.
%:- dynamic caminho/6.
%:- dynamic caminho1/6.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extens�o do predicado que permite a evolucao do conhecimento

evolucao( Termo ) :-
    solucoes( Invariante, +Termo::Invariante,Lista ),  %coloca numa lista todos os invariantes
    insercao( Termo ), %insere o termo na base de informação para ser testado a seguir
    teste( Lista ).  % testa o termo contra os invariantes, se passar fica

insercao( Termo ) :-
    assert( Termo ). % o assert insere o termo na base de conhecimento
insercao( Termo ) :-
    retract( Termo ), !,fail. % se não o consegui inserir direito, tem de o remover
	
teste( [] ).
teste( [R|LR] ) :-  % verifica se todos os testes ao invariante são positivos
    R,   
    teste( LR ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extens�o do predicado que permite a involucao do conhecimento

involucao( Termo ) :-
    solucoes( Invariante,-Termo::Invariante,Lista ),
    remocao( Termo ),
    teste( Lista ).

remocao( Termo ) :-
    retract( Termo ).
remocao( Termo ) :- 
    assert( Termo ),!,fail.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( _ ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).

comprimento( S,N ) :-
    length( S,N ).

membro(X, [X|_]).
membro(X, [_|Xs]):-
	membro(X, Xs).

membros([], _).
membros([X|Xs], Members):-
	membro(X, Members),
	membros(Xs, Members).

inverso(Xs, Ys):-
	inverso(Xs, [], Ys).

inverso([], Xs, Xs).
inverso([X|Xs],Ys, Zs):-
	inverso(Xs, [X|Ys], Zs).

% ------------------------------------- EXs -------------------------------------

% a
%inicial(jarros(0,0)).
%final(jarros(X, Y)):- X is 4 ; Y is 4. % final so precisa de estar um cheio.

/*b
Conjunto de estados: conjunto de pares ordenados inteiros (X,Y), X€[0,8], X€[0,5]
Estado inicial: (0,0)
Estados finais: (4,_) ou (_,4)
Operacoes: encher(), esvaziar(), transferir()
Teste objetivo: final(jarros(4,_) ou final(jarros(_,4))
Solucao: total de operacoes (caminho) ate atingir o estado final
Custo: 1

% c
 http://www.webgraphviz.com/ ... shotless

digraph G {
  "inicial(0,0)" -> "n1(8,0)"
  "inicial(0,0)" -> "n1(0,5)"
  "n1(8,0)" -> "n2(0,0)"
  "n1(8,0)" -> "n2(3,5)"
  "n1(8,0)" -> "n2_(8,5)"
  "n1(0,5)" -> "n2_(0,0)"
  "n1(0,5)" -> "n2(5,0)"
  "n1(0,5)" -> "n2(8,5)"
  "n2(0,0)" -> "n3(8,0)"
  "n2(0,0)" -> "n3(0,5)"
  "n2(3,5)" -> "n3(8,5)"
  "n2(3,5)" -> "n3___(0,5)"
  "n2(3,5)" -> "n3_(3,0)"
  "n2(3,5)" -> "n3_(8,0)"
  "n2_(0,0)" -> "n3___(8,0)"
  "n2_(0,0)" -> "n3_(0,5)"
  "n2(5,0)" -> "n3_(0,0)"
  "n2(5,0)" -> "n3__(8,0)"
  "n2(5,0)" -> "n3__(0,5)"
  "n2(5,0)" -> "n3_(5,5)"
  "n2(8,5)" -> "n3(0,8)"
  "n2(8,5)" -> "n3(5,0)"
  "n2_(8,5)" -> "n3____(0,5)"
  "n2_(8,5)" -> "n3____(8,0)"
}
*/

% estado inicial
inicial(jarros(0,0)).

% estado final
final(jarros(4,_)).
final(jarros(_,4)).

% transicoes possiveis: atual, operacao, estado "final"
transicao(jarros(V1,V2), encher(1), jarros(8,V2)) :- V1 < 8.
transicao(jarros(V1,V2), encher(2), jarros(V1,5)) :- V2 < 5.

transicao(jarros(V1,V2), vazio(1), jarros(0,V2)) :- V1 > 0.
transicao(jarros(V1,V2), vazio(2), jarros(V1,0)) :- V2 > 0.

transicao(jarros(V1,V2), transferir(1,2), jarros(NV1, NV2)):- 
    V1>0, 
    NV1 is max(V1 - 5 + V2, 0), 
    NV1 < V1, 
    NV2 is V2 + V1 - NV1.

transicao(jarros(V1,V2), transferir(2,1), jarros(NV1, NV2)):- 
    V2>0, 
    NV2 is max(V2 - 8 + V1, 0), 
    NV2 < V2, 
    NV1 is V1 + V2 - NV2.

% d
resolvedf(Solucao) :-
    inicial(Inicial),
    resolvedf(Inicial, [Inicial], Solucao).

resolvedf(Estado, _, []) :-
    final(Estado), !. % primeiro caminho que vá desde o inicio ao fim, cut e necessario

resolvedf(Estado, Historico, [Movimento|Solucao]) :-
    transicao(Estado, Movimento, Estado1),
    \+ memberchk(Estado1,Historico),
    resolvedf(Estado1, [Estado1|Historico], Solucao).

dfTodasSolucoes(L):- findall((S,C),(resolvedf(S),length(S,C)),L).
minimo([(P,X)],(P,X)).
minimo([(Px,X)|L],(Py,Y)):- minimo(L,(Py,Y)), X>Y. 
minimo([(Px,X)|L],(Px,X)):- minimo(L,(Py,Y)), X=<Y. 
melhorDF(S, Custo):- findall((S,C), (resolvedf(S), length(S,C)), L), minimo(L,(S,Custo)).

% e
resolvebf(Solucao):-
	inicial(InicialEstado),
	resolvebf([(InicialEstado, [])|Xs]-Xs, [], Solucao).

resolvebf([(Estado, Vs)|_]-_, _, Rs):-
	final(Estado),!, inverso(Vs, Rs).

resolvebf([(Estado, _)|Xs]-Ys, Historico, Solucao):-
	membro(Estado, Historico),!,
	resolvebf(Xs-Ys, Historico, Solucao).

resolvebf([(Estado, Vs)|Xs]-Ys, Historico, Solucao):-
	setof((Move, Estado1), transicao(Estado, Move, Estado1), Ls),
	atualizar(Ls, Vs, [Estado|Historico], Ys-Zs),
	resolvebf(Xs-Zs, [Estado|Historico], Solucao).

atualizar([], _, _, X-X).
atualizar([(_, Estado)|Ls], Vs, Historico, Xs-Ys):-
	membro(Estado, Historico),!,
	atualizar(Ls, Vs, Historico, Xs-Ys).

atualizar([(Move, Estado)|Ls], Vs, Historico, [(Estado, [Move|Vs])|Xs]-Ys):-
	atualizar(Ls, Vs, Historico, Xs-Ys).

bfTodasSolucoes(L):- findall((S,C),(resolvebf(S),length(S,C)),L).
melhorBF(S, Custo):- findall((S,C), (resolvebf(S), length(S,C)), L), minimo(L,(S,Custo)).