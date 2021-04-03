move(s, a, 2).

move(a, b, 2).
move(b, c, 2).
move(c, d, 3).
move(d, t, 3).
move(s, e, 2).
move(e, f, 5).
move(f, g, 2).
move(g, t, 2).
move(b, f, 2).
move(Nodo, ProxNodo):-
	move(Nodo,ProxNodo,_).


estima(a, 5).
estima(b, 4).
estima(c, 4).
estima(d, 3).
estima(e, 7).
estima(f, 4).
estima(g, 2).
estima(s, 10).
estima(t, 0).
	
start(s).
goal(t).

%a
resolve_pp(Nodo, [Nodo|Caminho]):-  % o nodo de começo é o Nodo
	profundidadeprimeiro(Nodo,Caminho).

profundidadeprimeiro(Nodo, []):-
	goal(Nodo).

profundidadeprimeiro(Nodo, [ProxNodo|Caminho]):-
	move(Nodo, ProxNodo),
	profundidadeprimeiro(ProxNodo, Caminho).

dfTodasSolucoes(L):- findall((S,C),(resolve_pp(s,S),length(S,C)),L).

%b
% Versão com custo
resolve_pp_custo(Nodo, [Nodo|Caminho],Custo):-
	profundidadeprimeiro_custo(Nodo,Caminho,Custo).

profundidadeprimeiro_custo(Nodo, [],0):-
	goal(Nodo).

profundidadeprimeiro_custo(Nodo, [ProxNodo|Caminho],Custo):-
	move(Nodo, ProxNodo,CustoMovimento),
    profundidadeprimeiro_custo(ProxNodo, Caminho, Custo2),
    Custo is CustoMovimento + Custo2.



dfTodasSolucoesCusto(L):- findall((S,C),(resolve_pp_custo(s,S,C)),L).

% / - concatenação e separação da lista


%---------------------------------pesquisa a estrela 

resolve_aestrela(Nodo, Caminho/Custo) :-
	estima(Nodo, Estima),
	aestrela([[Nodo]/0/Estima], InvCaminho/Custo/_),
	inverso(InvCaminho, Caminho).

aestrela(Caminhos, SolucaoCaminho) :-
	obtem_melhor(Caminhos, MelhorCaminho),
	seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
	expande_aestrela(MelhorCaminho, ExpCaminhos),
	append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
	aestrela(NovoCaminhos, SolucaoCaminho).	


expande_aestrela(Caminho, ExpCaminhos) :-
	findall(NovoCaminho, move_aestrela(Caminho,NovoCaminho), ExpCaminhos).

move_aestrela([Nodo|Caminho]/Custo/_, [ProxNodo,Nodo|Caminho]/NovoCusto/Est) :-
	move(Nodo, ProxNodo, PassoCusto),\+ member(ProxNodo, Caminho),
	NovoCusto is Custo + PassoCusto,
	estima(ProxNodo, Est).	
	

obtem_melhor([Caminho], Caminho) :- !.

obtem_melhor([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho) :-
	Custo1 + Est1 =< Custo2 + Est2, !, % custo 1 é a soma dos caminhos até aí
	obtem_melhor([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho).
	
obtem_melhor([_|Caminhos], MelhorCaminho) :- 
	obtem_melhor(Caminhos, MelhorCaminho).


aestrela(Caminhos, Caminho) :-
	obtem_melhor(Caminhos, Caminho),
	Caminho = [Nodo|_]/_/_,goal(Nodo).


%---------------------------------predicados auxiliares

inverso(Xs, Ys):-
	inverso(Xs, [], Ys).

inverso([], Xs, Xs).
inverso([X|Xs],Ys, Zs):-
	inverso(Xs, [X|Ys], Zs).

seleciona(E, [E|Xs], Xs).
seleciona(E, [X|Xs], [X|Ys]) :- seleciona(E, Xs, Ys).

minimo([(P,X)],(P,X)).
minimo([(Px,X)|L],(Py,Y)):- minimo(L,(Py,Y)), X>Y. 
minimo([(Px,X)|L],(Px,X)):- minimo(L,(Py,Y)), X=<Y. 


aestrelaTodasSolucoesCusto(L):- findall((S),(resolve_aestrela(s,S)),L).


% greedy search

%---------------------------------pesquisa Gulosa
% NOTA: posso tirar a parte 

resolve_gulosa(Nodo, Caminho/Custo) :-
	estima(Nodo, Estima),
	agulosa([[Nodo]/0/Estima], InvCaminho/Custo/_),
	inverso(InvCaminho, Caminho).

agulosa(Caminhos, Caminho) :-
	obtem_melhor_g(Caminhos, Caminho),
	Caminho = [Nodo|_]/_/_,goal(Nodo).

agulosa(Caminhos, SolucaoCaminho) :-
	obtem_melhor_g(Caminhos, MelhorCaminho),
	seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
	expande_gulosa(MelhorCaminho, ExpCaminhos),
	append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
        agulosa(NovoCaminhos, SolucaoCaminho).		


obtem_melhor_g([Caminho], Caminho) :- !.

obtem_melhor_g([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho) :-
	Est1 =< Est2, !,
	obtem_melhor_g([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho).
	
obtem_melhor_g([_|Caminhos], MelhorCaminho) :- 
	obtem_melhor_g(Caminhos, MelhorCaminho).

expande_gulosa(Caminho, ExpCaminhos) :-
	findall(NovoCaminho, adjacente(Caminho,NovoCaminho), ExpCaminhos).


adjacente([Nodo|Caminho]/Custo/_, [ProxNodo,Nodo|Caminho]/NovoCusto/Est) :-
	move(Nodo, ProxNodo, PassoCusto),\+ member(ProxNodo, Caminho),
	NovoCusto is Custo + PassoCusto,
	estima(ProxNodo, Est).