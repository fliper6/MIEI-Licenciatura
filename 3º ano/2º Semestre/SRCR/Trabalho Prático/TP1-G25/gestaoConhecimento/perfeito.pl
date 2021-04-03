%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Conhecimento perfeito

% Inserir conhecimento perfeito positivo na base de conhecimento
evolucaoPos(Termo) :-
    solucoes(Invariante, (+(Termo,positivo)::Invariante; +(Termo,naoNegativo)::Invariante), Lista),
    insercao(Termo),
    teste(Lista).

% Inserir conhecimento perfeito negativo na base de conhecimento
evolucaoNeg(Termo) :-
    solucoes(Invariante, +(-Termo,negativo)::Invariante, Lista),
    insercao(-Termo),
    teste(Lista).

% Remover conhecimento perfeito positivo da base de conhecimento
involucaoPos(Termo) :-
    solucoes(Invariante, -(Termo,positivo)::Invariante, Lista),
    remocao(Termo),
    teste(Lista).

% Remover conhecimento perfeito negativo da base de conhecimento
involucaoNeg(Termo) :-
    solucoes(Invariante, -(Termo,negativo)::Invariante, Lista),
    remocao(Termo),
    teste(Lista).

% Pode haver varios predicados negativos com o mesmo id, logo remover uma
% entidade com um certo id implica a remocao de todos
involucaoListaNeg([]).
involucaoListaNeg([H|T]) :- involucaoNeg(H), involucaoListaNeg(T).

% Pressuposto do Mundo Fechado
-X :- nao(X), nao(excecao(X)).