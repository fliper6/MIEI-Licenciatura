%----------------------------------------------------------- - - - - - - - - - -  -  -  -  -   -
% Trabalho Individual de SRCR (19-20)

:- include('./Paragens_Prolog/fich01.pl').
:- include('./Paragens_Prolog/fich02.pl').
:- include('./Paragens_Prolog/fich06.pl').
:- include('./Paragens_Prolog/fich07.pl').
:- include('./Paragens_Prolog/fich10.pl').
:- include('./Paragens_Prolog/fich11.pl').
:- include('./Paragens_Prolog/fich12.pl').
:- include('./Paragens_Prolog/fich13.pl').
:- include('./Paragens_Prolog/fich15.pl').
:- include('./Paragens_Prolog/fich23.pl').
:- include('./Paragens_Prolog/fich101.pl').
:- include('./Paragens_Prolog/fich102.pl').
:- include('./Paragens_Prolog/fich106.pl').
:- include('./Paragens_Prolog/fich108.pl').
:- include('./Paragens_Prolog/fich111.pl').
:- include('./Paragens_Prolog/fich112.pl').
:- include('./Paragens_Prolog/fich114.pl').
:- include('./Paragens_Prolog/fich115.pl').
:- include('./Paragens_Prolog/fich116.pl').
:- include('./Paragens_Prolog/fich117.pl').
:- include('./Paragens_Prolog/fich119.pl').
:- include('./Paragens_Prolog/fich122.pl').
:- include('./Paragens_Prolog/fich125.pl').
:- include('./Paragens_Prolog/fich129.pl').
:- include('./Paragens_Prolog/fich158.pl').
:- include('./Paragens_Prolog/fich162.pl').
:- include('./Paragens_Prolog/fich171.pl').
:- include('./Paragens_Prolog/fich184.pl').
:- include('./Paragens_Prolog/fich201.pl').
:- include('./Paragens_Prolog/fich467.pl').
:- include('./Paragens_Prolog/fich468.pl').
:- include('./Paragens_Prolog/fich470.pl').
:- include('./Paragens_Prolog/fich471.pl').
:- include('./Paragens_Prolog/fich479.pl').
:- include('./Paragens_Prolog/fich714.pl').
:- include('./Paragens_Prolog/fich748.pl').
:- include('./Paragens_Prolog/fich750.pl').
:- include('./Paragens_Prolog/fich751.pl').
:- include('./Paragens_Prolog/fich776.pl').

:- include('./adjacencias_prolog.pl').

:- use_module(library(lists)). %reverse
:- use_module(library(pairs)). %pairs

% paragem ( ordem, gid,   latitude, longitude, Estado de Conservacao,      Tipo de Abrigo, Abrigo com Publicidade,	Operadora, Carreira, Codigo de Rua,        Nome da Rua,              Freguesia).
% paragem ( 17   , 607, -104700.62, -95803.69,                 'Bom', 'Fechado dos Lados',                  'Yes',   'Vimeca',        7,           327, 'Avenida do Forte', 'Carnaxide e Queijas' ).

%----------------------------------------------------------- - - - - - - - - - -  -  -  -  -   -
% 1) Calcular um trajeto entre dois pontos

%%%% NAO INFORMADO %%%%
adjacente(Paragem1, Paragem2) :-
	paragem(Ord, Paragem1, _, _, _, _, _, _, Car, _, _, _),
	OrdInc is Ord+1,
    paragem(OrdInc, Paragem2, _, _, _, _, _, _, Car, _, _, _).

trajetoNaoInformado(Origem, Destino, [Origem,Destino]) :-
	adjacente(Origem, Destino).

trajetoNaoInformado(Origem, Destino, [Origem|T]) :-
	adjacente(Origem, Temp),
	trajetoNaoInformado(Temp, Destino, T).

%%%% INFORMADO %%%%
% Determina todas as paragens adjacentes
adjacentes(Paragem, Adjacentes):-
	findall(ProxParagem,( paragem(Ord, Paragem, _, _, _, _, _, _, Car, _, _, _),
				  		  OrdInc is Ord+1,
				  		  paragem(OrdInc, ProxParagem, _, _, _, _, _, _, Car, _, _, _)
		        		),Adjacentes).

% "adjacentes" mais simplificado, para quando já sabemos que estamos na carreira do Destino
adjacentes2(Paragem, Car, ProxParagem):-
	paragem(Ord, Paragem, _, _, _, _, _, _, Car, _, _, _),
	OrdInc is Ord+1,
    paragem(OrdInc, ProxParagem,_,_,_,_,_,_,Car,_,_,_).

% Verifica se a Paragem (atual) e o Destino têm a mesma Carreira
verificarMesmaCarreira(Paragem, Destino, Car):-
	paragem(OrdP,Paragem,_,_,_,_,_,_,Car,_,_,_),
	paragem(OrdD,Destino,_,_,_,_,_,_,Car,_,_,_),
	OrdD > OrdP.

% Ciclo para verificar Visitadas
loopChk([], _, 0). % Todos os adjacentes foram visitados (devolve flag 0)

loopChk([H|_], Visitadas, H):- % Head não visitada ainda
	\+ memberchk(H, Visitadas).

loopChk([_|T], Visitadas, ProxParagem):- % Head já foi visitada
	loopChk(T, Visitadas, ProxParagem).
 
 % Ciclo para verificar Visitadas + se há algum adjacente com a carreira do atual
loopChkDestino([], _, _, 0). % Todos os adjacentes foram visitados + não há nenhum adjacente na carreira do destino (devolve flag 0)

loopChkDestino([H|_], Destino, Visitadas, H):- % Head é uma paragem não visitada
	\+ memberchk(H, Visitadas),
 	paragem(OrdH,H,_,_,_,_,_,_,Car,_,_,_),
	paragem(OrdD,Destino,_,_,_,_,_,_,Car,_,_,_),
	OrdD > OrdH.

loopChkDestino([_|T], Destino, Visitadas, ProxParagem):- % Head já foi visitada e/ou não estava na carreira do destino
	loopChkDestino(T, Destino, Visitadas, ProxParagem).

% Predicado auxiliar, que faz o ciclo para verificar todas as paragens adjacentes
auxTrajeto(Paragem, Destino, _, ProxParagem):-  % verificaMesmaCarreira devolve carreira em comum (do destino)
	verificarMesmaCarreira(Paragem, Destino, Car),
	adjacentes2(Paragem, Car, ProxParagem).

auxTrajeto(Paragem, Destino, Visitadas, ProxParagem):- % verificaMesmaCarreira devolve false 
	adjacentes(Paragem, Adjacentes),
	loopChkDestino(Adjacentes, Destino, Visitadas,Prox),
    ((Prox =\= 0,!, ProxParagem is Prox) ; (loopChk(Adjacentes,Visitadas,ProxParagem))).

% Algoritmo principal para estabelecer o trajeto 
trajeto(Destino, Destino, _, Final, RFinal):- reverse(Final,RFinal).

trajeto(Paragem, Destino, Visitadas, Caminho, Final):- 
	auxTrajeto(Paragem, Destino, Visitadas, ProxParagem),
	ProxParagem =\= 0 ,!, 
	trajeto(ProxParagem, Destino, [ProxParagem|Visitadas], [ProxParagem|Caminho], Final).

trajeto(Paragem, Destino, Visitadas, [Paragem,P2|RestoPercurso], Final):- % Backtracking (quando entramos em loops e todos os nodos vizinhos já foram visitados)
	trajeto(P2, Destino, Visitadas, [P2|RestoPercurso], Final). 

% Algoritmo final query1 
trajetoGeral(Origem, Destino, [Origem|Final]) :- trajeto(Origem, Destino, [Origem], [], Final).


%----------------------------------------------------------- - - - - - - - - - -  -  -  -  -   -
% 2) Selecionar apenas algumas das operadoras de transporte para um determinado percurso

% Ciclo para verificar Visitadas + requirimento da query específica
loopChk2(_,[],_,_, 0). % Todos os adjacentes foram visitados (devolve flag 0)

loopChk2(2, [H|_], Operadoras, Visitadas, H):-  % Head não visitada ainda + operadora pertence às selecionadas
	\+ memberchk(H, Visitadas),
	paragem(_,H,_,_,_,_,_,OpH,_,_,_,_),
	memberchk(OpH, Operadoras).

loopChk2(3, [H|_], Operadoras, Visitadas, H):- % Head não visitada ainda + operadora não pertence às excluídas
	\+ memberchk(H, Visitadas),
	paragem(_,H,_,_,_,_,_,OpH,_,_,_,_),
	\+ memberchk(OpH, Operadoras).

loopChk2(Query, [_|T], Operadoras, Visitadas, ProxParagem):- % Head já foi visitada
	loopChk2(Query, T, Operadoras, Visitadas,ProxParagem).

% Predicado auxiliar, que faz o ciclo para verificar todas as paragens adjacentes
auxquery(Query, Paragem, Operadoras, Visitadas, ProxParagem):-
	adjacentes(Paragem, Adjacentes),
	loopChk2(Query, Adjacentes, Operadoras, Visitadas, ProxParagem).

% Algoritmo principal para estabelecer o trajeto 
query(_, Destino, Destino, _, _, Final, RFinal):- reverse(Final,RFinal).

query(Query, Paragem, Destino, Operadoras, Visitadas, Caminho, Final):-   
	auxquery(Query, Paragem, Operadoras, Visitadas, ProxParagem),
	ProxParagem =\= 0 ,!, 
	query(Query, ProxParagem, Destino, Operadoras, [ProxParagem|Visitadas], [ProxParagem|Caminho], Final).

query(Query, Paragem, Destino, Operadoras, Visitadas, [Paragem,P2|RestoPercurso], Final):- %Backtracking
	query(Query, P2, Destino, Operadoras, Visitadas, [P2|RestoPercurso], Final). 

% Algoritmo final query2 
algumasOpGeral(Origem, Destino, Operadoras, [Origem|Final]) :- 
	paragem(_,Origem,_,_,_,_,_,OpH,_,_,_,_),
	\+ memberchk(OpH, Operadoras),
	query(2, Origem, Destino, Operadoras, [Origem], [], Final).


%----------------------------------------------------------- - - - - - - - - - -  -  -  -  -   -
% 3) Excluir um ou mais operadores de transporte para o percurso

% Algoritmo final query3
excluirOpGeral(Origem, Destino, Operadoras, [Origem|Final]) :- 
	paragem(_,Origem,_,_,_,_,_,OpH,_,_,_,_),
	memberchk(OpH, Operadoras),
	query(3, Origem, Destino, Operadoras, [Origem], [], Final).

%----------------------------------------------------------- - - - - - - - - - -  -  -  -  -   -
% 4) Identificar quais as paragens com o maior número de carreiras num determinado percurso
	
% Acha o número de carreiras para uma paragem (gid)	
xCarreiras(H,NrCarreirasHead) :-
	findall(Car,(paragem(_, H, _, _, _, _, _, _, Car, _, _, _)),CarreirasTodas),
	length(CarreirasTodas, NrCarreirasHead).

% Algoritmo principal, itera o percurso e guarda paragem e o número de carreiras correspondente num par
maisCarreiras([H], [(NrCarreirasHead-H)]) :- xCarreiras(H,NrCarreirasHead).

maisCarreiras([H|T], [(NrCarreirasHead-H)|TC]) :-
	xCarreiras(H,NrCarreirasHead),
	maisCarreiras(T,TC).

% Algoritmo final query4
maisCarreirasGeral(Origem, Destino, MaxCarreiras) :- 
	trajetoGeral(Origem, Destino, Caminho),
	maisCarreiras(Caminho, NrCarreiras),
    keysort(NrCarreiras, MaxCarreirasDec),
    reverse(MaxCarreirasDec, MaxCarreiras).
	

%----------------------------------------------------------- - - - - - - - - - -  -  -  -  -   -
% 5) Escolher o menor percurso (usando critério menor número de paragens)

trajetoNaoInformadoLim(_, _, Maximo, Maximo, _) :- !,fail.

trajetoNaoInformadoLim(Origem, Destino, _, _, [Origem,Destino]) :-
	adjacencia(Origem, Destino).

trajetoNaoInformadoLim(Origem, Destino, Iteracao, Maximo, [Origem|T]) :-
	IteracaoNova is Iteracao + 1,
	adjacencia(Origem, Temp),
	trajetoNaoInformadoLim(Temp, Destino, IteracaoNova, Maximo, T).

maisCurtoGeral(Origem, Destino, Caminho) :-
	trajetoGeral(Origem, Destino, CaminhoMax), % verifica se caminho existe
	length(CaminhoMax,L), 
	maisCurto(Origem, Destino, L, Caminho).

maisCurto(Origem, Destino, L, Caminho) :- 
	desce(Origem, Destino, L, NovoL),
	sobe(Origem, Destino, NovoL, Caminho).

desce(Origem, Destino, L, Caminho) :- 
	Lnovo is L-5,
	trajetoNaoInformadoLim(Origem, Destino, 1, Lnovo, _ ),
	desce(Origem, Destino, Lnovo, Caminho).

desce(_, _, L, L2):- L2 is L-5.

sobe(Origem, Destino, L, Caminho) :-
    trajetoNaoInformadoLim(Origem, Destino, 1, L, Caminho ).

sobe(Origem, Destino, L, Caminho) :-
	NovoL is L+1,
    sobe(Origem, Destino, NovoL, Caminho ).


%----------------------------------------------------------- - - - - - - - - - -  -  -  -  -   -
% 7) Escolher o percurso que passe apenas por abrigos com publicidade

% Ciclo para verificar Visitadas + verificar publicidade
loopChk3(_,[],_,_, 0). % Todos os adjacentes foram visitados (devolve flag 0)

loopChk3(7, [H|_], Visitadas, H):- % Head não visitada ainda + tem publicidade
	\+ memberchk(H, Visitadas),
	paragem(_,H,_,_,_,_,Pub,_,_,_,_,_),
	Pub == 'Yes'.

loopChk3(8, [H|_], Visitadas, H):- % Head não visitada ainda + paragem é abrigada
	\+ memberchk(H, Visitadas),
	paragem(_,H,_,_,_,Tipo,_,_,_,_,_,_),
    (Tipo == 'Aberto dos Lados'; Tipo == 'Fechado dos Lados').

loopChk3(Query, [_|T], Visitadas, ProxParagem):- % Head já foi visitada
	loopChk3(Query, T, Visitadas, ProxParagem).

% Predicado auxiliar, que faz o ciclo para verificar todas as paragens adjacentes
auxquery2(Query, Paragem, Visitadas, ProxParagem):- 
	adjacentes(Paragem, Adjacentes),
	loopChk3(Query, Adjacentes, Visitadas, ProxParagem).

% Algoritmo principal para estabelecer o trajeto 
query2(_, Destino, Destino, _, Final, RFinal):- reverse(Final,RFinal).

query2(Query, Paragem, Destino, Visitadas, Caminho, Final):-   
	auxquery2(Query, Paragem, Visitadas, ProxParagem),
	ProxParagem =\= 0 ,!, 
	query2(Query, ProxParagem, Destino, [ProxParagem|Visitadas], [ProxParagem|Caminho], Final).

query2(Query, Paragem, Destino, Visitadas, [Paragem,P2|RestoPercurso], Final):- %Backtracking
	query2(Query, P2, Destino, Visitadas, [P2|RestoPercurso], Final). 

% Algoritmo final query7
publicidadeGeral(Origem, Destino, [Origem|Final]) :- 
	paragem(_,Origem,_,_,_,_,Pub,_,_,_,_,_),
	Pub == 'Yes',
	query2(7, Origem, Destino, [Origem], [], Final).


%----------------------------------------------------------- - - - - - - - - - -  -  -  -  -   -
% 8) Escolher o percurso que passe apenas por paragens abrigadas

% Algoritmo final query8
abrigadasGeral(Origem, Destino, [Origem|Final]) :- 
	paragem(_,Origem,_,_,_,Tipo,_,_,_,_,_,_),
    (Tipo == 'Aberto dos Lados'; Tipo == 'Fechado dos Lados'),
	query2(8, Origem, Destino, [Origem], [], Final).


%----------------------------------------------------------- - - - - - - - - - -  -  -  -  -   -
% 9) Escolher um ou mais pontos intermédios por onde o percurso deverá passar

% Junta duas listas de modo a não repetir o ponto em comum
concatListas(Caminho1,[_|T2],Concated) :- append(Caminho1, T2, Concated).

% Algoritmo principal que faz os percursos intermédios e junta-os 
intermedios(Destino, [H,[]|[]], Atual, Final2) :- 
	trajetoGeral(H, Destino, CaminhoL),
	concatListas(Atual, CaminhoL, Final2).

intermedios(Destino, [H1,H2|R], Atual, Final2) :-
	trajetoGeral(H1, H2, CaminhoX),
	concatListas(Atual, CaminhoX, FinalTemp),
	intermedios(Destino, [H2,R], FinalTemp, Final2).

% Algoritmo final query9
intermediosGeral(Origem, Destino, [H|R], Final) :- 
	trajetoGeral(Origem, H, CaminhoP),
	intermedios(Destino, [H|R], CaminhoP, Final).

