%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida
% Representacao de conhecimento imperfeito

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
%:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic jogo/3.
:- discontiguous jogo/3.
:- discontiguous excecao/1.
:- discontiguous (::)/2.

%Resolução de Hugo André Coelho Cardoso (a85006)

%1)
jogo( 1,aa,500 ).

%2)
jogo( 2,bb,x ).
excecao( jogo( Jogo,Arbitro,_ ) ) :- jogo( Jogo,Arbitro,x ).

%3)
excecao( jogo( 3,cc,500 ) ).
excecao( jogo( 3,cc,2500 ) ).

%4)
excecao( jogo( 4,dd,Ajudas ) ) :- Ajudas >= 250, Ajudas =< 750.

%5)
jogo( 5,ee,x ).
nulo(x).
excecao( jogo( Jogo,Arbitro,_ ) ) :- jogo( Jogo,Arbitro,x ).

%6)
excecao( jogo( 6,ff,250 ) ).
excecao( jogo( 6,ff,Ajudas ) ) :- Ajudas >= 5000.

%7)
-jogo( 7,gg,2500 ).
jogo( 7,gg,x ).
excecao( jogo( Jogo,Arbitro,_ ) ) :- jogo( Jogo,Arbitro,x ).

%8)
cerca( X,Sup,Inf ) :-
    Sup is X * 1.25,
    Inf is X * 0.75.

excecao( jogo( 8,hh,Ajudas ) ) :-
    cerca( 1000,Sup,Inf ),
    Ajudas >= Inf, Ajudas =< Sup.

%9)
muitoProximo( X,Sup,Inf ) :-
    Sup is X * 1.1,
    Inf is X * 0.9.

excecao( jogo( 9,ii,Ajudas ) ) :-
    muitoProximo( 3000,Sup,Inf ),
    Ajudas >= Inf, Ajudas =< Sup.

%10)
+jogo( J,A,_ ) :: (solucoes(A, jogo( J,A,_ ), S),
                    comprimento( S,N ),
                    N == 1).

%11)
+jogo( _,A,_ ) :: (solucoes(Js, jogo( Js,A,_ ), S),
                    comprimento( S,N ), 
                    N =< 3).

%12)
naoConsecutivos([]).
naoConsecutivos([_]).
naoConsecutivos([H1,H2|T]):- H1 =\= (H2-1), naoConsecutivos([H2|T]).

+jogo( J,A,_ ) :: (solucoes(Js, jogo( Js,A,_ ) , S),
                    naoConsecutivos(S)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado que permite a evolucao do conhecimento

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
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( _ ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).

comprimento( S,N ) :-
    length( S,N ).