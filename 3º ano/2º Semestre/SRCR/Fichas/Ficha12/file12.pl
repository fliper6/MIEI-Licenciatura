


estima(a, 5).
estima(b, 4).
estima(c, 4).
estima(d, 3).
estima(e, 7).
estima(f, 4).
estima(g, 2).
estima(s, 10).
estima(t, 0).

move(s, a, 2).
move(a, b, 2).
move(b, c, 2).
move(c, d, 3).
move(d, t, 3).
move(s, e, 2).
move(e, f, 5).
move(f, g, 2).
move(g, t, 2).


move(b,f,2).





goal(t).


%--------------------------------------------------------------------------
%a) Pesquisa em profundidade.

resolve_pp(Nodo,[Nodo|Caminho]):-
        profundidadeprimeiro(Nodo,Caminho).

profundidadeprimeiro(Nodo,[]):- goal(Nodo).


profundidadeprimeiro(Nodo,[ProxNodo|Caminho]) :-
        adjacente(Nodo,ProxNodo),
        profundidadeprimeiro(ProxNodo,Caminho).


%b) Custo associado ao caminho encontrado.

resolve_pp(Nodo,[Nodo|Caminho],Custo):-
    profundidadeprimeiro(Nodo,Caminho,Custo).

profundidadeprimeiro(Nodo,[],0):- goal(Nodo).

profundidadeprimeiro(Nodo,[ProxNodo|Caminho],Custo):- 
            adjacente(Nodo,ProxNodo,C1),
            profundidadeprimeiro(ProxNodo,Caminho,C2),
            Custo is C1 + C2.


%c) Melhor em custo 

melhor(Nodo,S,Custo):- findall((SS,CC),resolve_pp(Nodo,SS,CC),L),
                        minimo(L,(S,Custo)).

               



% d) A*  


resolve_aestrela(Nodo, Caminho/Custo) :-
	estima(Nodo, Estima),
	aestrela([[Nodo]/0/Estima], InvCaminho/Custo/_),
	inverso(InvCaminho, Caminho).

aestrela(Caminhos, Caminho) :-
	obtem_melhor(Caminhos, Caminho),
	Caminho = [Nodo|_]/_/_,goal(Nodo).

aestrela(Caminhos, SolucaoCaminho) :-
	obtem_melhor(Caminhos, MelhorCaminho),
	seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
	expande_aestrela(MelhorCaminho, ExpCaminhos),
	append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
        aestrela(NovoCaminhos, SolucaoCaminho).		


obtem_melhor([Caminho], Caminho) :- !.

obtem_melhor([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho) :-
	Custo1 + Est1 =< Custo2 + Est2, !,
	obtem_melhor([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho).
	
obtem_melhor([_|Caminhos], MelhorCaminho) :- 
	obtem_melhor(Caminhos, MelhorCaminho).

expande_aestrela(Caminho, ExpCaminhos) :-
	findall(NovoCaminho, adjacente(Caminho,NovoCaminho), ExpCaminhos).

adjacente([Nodo|Caminho]/Custo/_, [ProxNodo,Nodo|Caminho]/NovoCusto/Est) :-
	move(Nodo, ProxNodo, PassoCusto),\+ member(ProxNodo, Caminho),
	NovoCusto is Custo + PassoCusto,
	estima(ProxNodo, Est).



%e) Guloso

resolve_gulosa(Nodo,Caminho/Custo):- estima(Nodo,Estima),
									 agulosa([[Nodo]/0/Estima],InvCaminho/Custo/_),
									 inverso(InvCaminho,Caminho).

agulosa(Caminhos,Caminho):- obtem_melhor_g(Caminhos,Caminho),
							Caminho = [Nodo|_]/_/_,goal(Nodo).

agulosa(Caminhos,SolucaoCaminho):-obtem_melhor_g(Caminhos,MelhorCaminho),
								  seleciona(MelhorCaminho,Caminhos,OutrosCaminhos),
								  expande_gulosa(MelhorCaminho,ExpCaminhos),
								  append(OutrosCaminhos,ExpCaminhos,NovoCaminhos),
								  agulosa(NovoCaminhos,SolucaoCaminho).

obtem_melhor_g([Caminho],Caminho):- !.

obtem_melhor_g([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos],MelhorCaminho):- Est1 =< Est2,
																			  !,
																			  obtem_melhor_g([Caminho1/Custo1/Est1|Caminhos],MelhorCaminho).

																			
obtem_melhor_g([_|Caminhos],MelhorCaminho):- obtem_melhor_g(Caminhos,MelhorCaminho).

expande_gulosa(Caminho,ExpCaminhos):- findall(NovoCaminho,adjacente(Caminho,NovoCaminho),ExpCaminhos).


%f)






%--------------------------------------------------------------------------
adjacente(Nodo,ProxNodo):- 
	move(Nodo, ProxNodo,_).


adjacente(Nodo,ProxNodo,Custo):- 
	move(Nodo, ProxNodo,Custo).


inverso(Xs, Ys):-
	inverso(Xs, [], Ys).

inverso([], Xs, Xs).
inverso([X|Xs],Ys, Zs):-
	inverso(Xs, [X|Ys], Zs).

seleciona(E, [E|Xs], Xs).
seleciona(E, [X|Xs], [X|Ys]) :- seleciona(E, Xs, Ys).



