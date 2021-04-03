%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Sistemas de Representacao de Conhecimento e Raciocinio [MIEINF 2019/20]

% Exercicio 1 - avaliacao individual
% Hugo Andre Coelho Cardoso - a85006

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).

:- dynamic dataNascimento/2.
:- dynamic pai/2. % pai ou mae
:- dynamic excecao/1.

:- discontiguous (::)/2.
:- discontiguous dataNascimento/2.
:- discontiguous pai/2.
:- discontiguous excecao/1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Exercicios

% I
pai(abel,ana).
pai(alice,ana).

dataNascimento(ana,data(1,1,2010)).

% II
pai(antonio,anibal).
pai(alberta,anibal).

dataNascimento(anibal,data(2,1,2010)).

% III
pai(bras,berta).
pai(belem,berta).

pai(bras,berto).
pai(belem,berto).

dataNascimento(berta,data(2,2,2010)).
dataNascimento(berto,data(2,2,2010)).

% IV
dataNascimento(catia,data(3,3,2010)).

% V
pai(catia,crispim).

excecao( pai(celso,crispim) ).
excecao( pai(caio,crispim) ).

% VI
pai(daniel,danilo).

pai(maeDanilo,danilo).
excecao(pai(_,F)) :- pai(maeDanilo,F).

dataNascimento(danilo,data(4,4,2010)).

% VII
pai(elias,eurico).
pai(elsa,eurico).

excecao( dataNascimento(eurico,data(D,5,2010)) ) :- D=5; D=15; D=25.

% VIII
excecao( pai(fausto,fabia) ).
excecao( pai(fausto,octavia) ).

pai(mae,F) :- F=fabia; F=octavia.
excecao( pai(_,F) ) :- pai(mae,F).

% IX
pai(guido,golias).
pai(guida,golias).

nulo(dataGolias).
dataNascimento(golias,dataGolias).
excecao( dataNascimento(X,_) ) :- dataNascimento(X,dataGolias).

% X
-dataNascimento(helder,data(8,8,2010)).

dataNascimento(helder,dataHelder).
excecao( dataNascimento(X,_) ) :- dataNascimento(X,dataHelder).

% XI
excecao( dataNascimento(ivo,data(D,6,2010)) ) :- D >= 1, D =< 15.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes estruturais

% Nao permitir a insercao de pais repetidos para o mesmo filho
% assumindo que e sempre como no enunciado, em que nao ha pais com o mesmo nome
+pai(P,F) :: (solucoes((P,F), pai(P,F), R),
             comprimento(R,1)).

% Nao e preciso um invariante estrutural para evitar datas repetidas porque o invariante
% referencial da data de nascimento ja limita a 1 por pessoa

% A data de nascimento deve ser uma data valida
+dataNascimento(_,D) :: dataValida(D).

% Funcao auxiliar - verifica se uma data e valida
dataValida(data(A,M,D)) :-
    (pertence(M,[1,3,5,7,8,10,12]), D >= 1, D =< 31);
    (pertence(M,[4,6,9,11]), D >= 1, D =< 30);
    (M = 2, (mod(A,4) =:= 0, D >= 1, D =< 29);
            (D >= 1, D =< 28)).

% Nao permitir evolucao da data de nascimento interdita do exercicio IX
+dataNascimento(X,D) :: (solucoes((X,D), (dataNascimento(golias,dataGolias), nao(nulo(dataGolias))), R),
                        comprimento(R,0)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes referenciais

% Cada filho so pode ter 2 pais
+pai(P,F) :: (solucoes(Ps, pai(Ps,F), R),
             comprimento(R,N),
             N =< 2).

% Cada pessoa so pode ter 1 data de nascimento
+dataNascimento(X,D) :: (solucoes(Ds, dataNascimento(X,Ds), R),
                        comprimento(R,1)).

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