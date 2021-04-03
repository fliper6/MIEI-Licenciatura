%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Evolucao de Conhecimento Imperfeito Impreciso

% Inserir conhecimento imperfeito impreciso na base de conhecimento
evolucaoImprecisoExplicito(Termo) :-
    solucoes(Inv, (+(excecao(Termo),imprecisoExplicito)::Inv; +(Termo,naoNegativo)::Inv), Lista),
    insercao(excecao(Termo)), insercao(Termo), % insere o termo tambem para testar se os seus campos sao validos
    teste(Lista), % se nao for uma excecao valida, remove a excecao e o termo
    remocao(Termo). % se for valida, remove apenas o termo

% Verificar a validade dos intervalos de valores imprecisos do adjudicante que se pretender inserir
invariantesImprecisoImplicito(adjudicante(IdAd,Nome,(Inf,Sup),Morada)) :-
    nifValido(Inf), nifValido(Sup), Inf < Sup,
    solucoes(Inv, +(excecao(adjudicante(IdAd,Nome,(Inf,Sup),Morada)),imprecisoImplicito)::Inv, Lista),
    teste(Lista).

% Verificar a validade dos intervalos de valores imprecisos da adjudicataria que se pretender inserir
invariantesImprecisoImplicito(adjudicataria(IdAd,Nome,(Inf,Sup),Morada)) :-
    nifValido(Inf), nifValido(Sup), Inf < Sup,
    solucoes(Inv, +(excecao(adjudicataria(IdAd,Nome,(Inf,Sup),Morada)),imprecisoImplicito)::Inv, Lista),
    teste(Lista).

% Verificar a validade dos intervalos de valores imprecisos do contrato que se pretender inserir
invariantesImprecisoImplicito(contrato(IdC,IdAd,IdAda,TC,TP,Desc,(Inf,Sup),P,L,D)) :-
    numeroValido(Inf), numeroValido(Sup), Inf < Sup,
    solucoes(Inv, +(contrato(IdC,IdAd,IdAda,TC,TP,Desc,Inf,P,L,D),naoNegativo)::Inv, ListaNaoNegativoInf),
    teste(ListaNaoNegativoInf),
    solucoes(Inv, +(contrato(IdC,IdAd,IdAda,TC,TP,Desc,Sup,P,L,D),naoNegativo)::Inv, ListaNaoNegativoSup),
    teste(ListaNaoNegativoSup),
    solucoes(Inv, +(excecao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,(Inf,Sup),P,L,D)),imprecisoImplicito)::Inv, ListaImprecisoImplicito),
    teste(ListaImprecisoImplicito).

% Verificar a validade dos intervalos de valores imprecisos do contrato que se pretender inserir
invariantesImprecisoImplicito(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,(Inf,Sup),L,D)) :-
    numeroValido(Inf), numeroValido(Sup), Inf < Sup,
    solucoes(Inv, +(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,Inf,L,D),naoNegativo)::Inv, ListaNaoNegativoInf),
    teste(ListaNaoNegativoInf),
    solucoes(Inv, +(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,Sup,L,D),naoNegativo)::Inv, ListaNaoNegativoSup),
    teste(ListaNaoNegativoSup),
    solucoes(Inv, +(excecao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,(Inf,Sup),L,D)),imprecisoImplicito)::Inv, ListaImprecisoImplicito),
    teste(ListaImprecisoImplicito).

% Verificar a validade dos intervalos de valores imprecisos do contrato que se pretender inserir
invariantesImprecisoImplicito(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data((Inf,Sup),M,D))) :-
    numeroValido(Inf), numeroValido(Sup), Inf < Sup,
    solucoes(Inv, +(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(Inf,M,D)),naoNegativo)::Inv, ListaNaoNegativoInf),
    teste(ListaNaoNegativoInf),
    solucoes(Inv, +(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(Sup,M,D)),naoNegativo)::Inv, ListaNaoNegativoSup),
    teste(ListaNaoNegativoSup),
    solucoes(Inv, +(excecao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data((Inf,Sup),M,D))),imprecisoImplicito)::Inv, ListaImprecisoImplicito),
    teste(ListaImprecisoImplicito).

% Verificar a validade dos intervalos de valores imprecisos do contrato que se pretender inserir
invariantesImprecisoImplicito(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(A,(Inf,Sup),D))) :-
    numeroValido(Inf), numeroValido(Sup), Inf < Sup,
    solucoes(Inv, +(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(A,Inf,D)),naoNegativo)::Inv, ListaNaoNegativoInf),
    teste(ListaNaoNegativoInf),
    solucoes(Inv, +(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(A,Sup,D)),naoNegativo)::Inv, ListaNaoNegativoSup),
    teste(ListaNaoNegativoSup),
    solucoes(Inv, +(excecao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(A,(Inf,Sup),D))),imprecisoImplicito)::Inv, ListaImprecisoImplicito),
    teste(ListaImprecisoImplicito).

% Verificar a validade dos intervalos de valores imprecisos do contrato que se pretender inserir
invariantesImprecisoImplicito(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(A,M,(Inf,Sup)))) :-
    numeroValido(Inf), numeroValido(Sup), Inf < Sup,
    solucoes(Inv, +(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(A,M,Inf)),naoNegativo)::Inv, ListaNaoNegativoInf),
    teste(ListaNaoNegativoInf),
    solucoes(Inv, +(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(A,M,Sup)),naoNegativo)::Inv, ListaNaoNegativoSup),
    teste(ListaNaoNegativoSup),
    solucoes(Inv, +(excecao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(A,M,(Inf,Sup)))),imprecisoImplicito)::Inv, ListaImprecisoImplicito),
    teste(ListaImprecisoImplicito).

% ----- Adjudicantes -----

% Inserir adjudicante com NIF entre dois valores
evolucao(adjudicante(IdAd,Nome,(Inf,Sup),Morada)) :-
    invariantesImprecisoImplicito(adjudicante(IdAd,Nome,(Inf,Sup),Morada)),
    insercao((excecao(adjudicante(IdAd,Nome,NIFImpreciso,Morada)) :- NIFImpreciso >= Inf, NIFImpreciso =< Sup)),
    insercao(intervalo(adjudicante,IdAd,nif,(Inf,Sup))).

% ----- Adjudicatarias -----

% Inserir adjudicataria com NIF entre dois valores
evolucao(adjudicataria(IdAda,Nome,(Inf,Sup),Morada)) :-
    invariantesImprecisoImplicito(adjudicataria(IdAda,Nome,(Inf,Sup),Morada)),
    insercao((excecao(adjudicataria(IdAda,Nome,NIFImpreciso,Morada)) :- NIFImpreciso >= Inf, NIFImpreciso =< Sup)),
    insercao(intervalo(adjudicataria,IdAda,nif,(Inf,Sup))).

% ----- Contratos -----

insercaoContratoImprecisoImplicito((IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,D),ParImpreciso,NomePar,Inf,Sup) :-
    insercao((excecao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,D)) :- ParImpreciso >= Inf, ParImpreciso =< Sup)),
    insercao(intervalo(contrato,IdC,NomePar,(Inf,Sup))).

% Inserir contrato com valor entre dois valores
evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,(Inf,Sup),P,L,D)) :-
    invariantesImprecisoImplicito(contrato(IdC,IdAd,IdAda,TC,TP,Desc,(Inf,Sup),P,L,D)),
    insercaoContratoImprecisoImplicito((IdC,IdAd,IdAda,TC,TP,Desc,VImpreciso,P,L,D),VImpreciso,valor,Inf,Sup).

% Inserir contrato com prazo entre dois valores
evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,(Inf,Sup),L,D)) :-
    invariantesImprecisoImplicito(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,(Inf,Sup),L,D)),
    insercaoContratoImprecisoImplicito((IdC,IdAd,IdAda,TC,TP,Desc,V,PImpreciso,L,D),PImpreciso,prazo,Inf,Sup).

% Inserir contrato com ano da data entre dois valores
evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data((Inf,Sup),Mes,Dia))) :-
    invariantesImprecisoImplicito(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data((Inf,Sup),Mes,Dia))),
    insercaoContratoImprecisoImplicito((IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(AnoImpreciso,Mes,Dia)),AnoImpreciso,ano,Inf,Sup).

% Inserir contrato com mes da data entre dois valores
evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(Ano,(Inf,Sup),Dia))) :-
    invariantesImprecisoImplicito(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(Ano,(Inf,Sup),Dia))),
    insercaoContratoImprecisoImplicito((IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(Ano,MesImpreciso,Dia)),MesImpreciso,mes,Inf,Sup).

% Inserir contrato com dia da data entre dois valores
evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(Ano,Mes,(Inf,Sup)))) :-
    invariantesImprecisoImplicito(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(Ano,Mes,(Inf,Sup)))),
    insercaoContratoImprecisoImplicito((IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(Ano,Mes,DiaImpreciso)),DiaImpreciso,dia,Inf,Sup).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Involucao de Conhecimento Imperfeito Impreciso

% Pode haver varios predicados imprecisos com o mesmo id, logo remover uma
% entidade com um certo id implica a remocao de todos
involucaoImprecisoExplicito([]).
involucaoImprecisoExplicito([H|T]) :- remocao(excecao(H)), involucaoImprecisoExplicito(T).

% ----- Adjudicantes -----

% Remover adjudicante com NIF entre dois valores
involucao(intervalo(Predicado,IdAd,Parametro,(Inf,Sup))) :-
    remocao((excecao(adjudicante(IdAd,_,NIF,_)) :- NIF >= Inf, NIF =< Sup)),
    remocao(intervalo(Predicado,IdAd,Parametro,(Inf,Sup))).

% Remover adjudicataria com NIF entre dois valores
involucao(intervalo(Predicado,IdAda,Parametro,(Inf,Sup))) :-
    remocao((excecao(adjudicataria(IdAda,_,NIF,_)) :- NIF >= Inf, NIF =< Sup)),
    remocao(intervalo(Predicado,IdAda,Parametro,(Inf,Sup))).

% Remover contrato com valor entre dois valores
involucao(intervalo(Predicado,IdC,valor,(Inf,Sup))) :-
    remocao((excecao(contrato(IdC,_,_,_,_,_,V,_,_,_)) :- V >= Inf, V =< Sup)),
    remocao(intervalo(Predicado,IdC,valor,(Inf,Sup))).

% Remover contrato com prazo entre dois valores
involucao(intervalo(Predicado,IdC,prazo,(Inf,Sup))) :-
    remocao((excecao(contrato(IdC,_,_,_,_,_,_,P,_,_)) :- P >= Inf, P =< Sup)),
    remocao(intervalo(Predicado,IdC,prazo,(Inf,Sup))).

% Remover contrato com ano da data entre dois valores
involucao(intervalo(Predicado,IdC,ano,(Inf,Sup))) :-
    remocao((excecao(contrato(IdC,_,_,_,_,_,_,_,_,data(A,_,_))) :- A >= Inf, A =< Sup)),
    remocao(intervalo(Predicado,IdC,ano,(Inf,Sup))).

% Remover contrato com mes da data entre dois valores
involucao(intervalo(Predicado,IdC,mes,(Inf,Sup))) :-
    remocao((excecao(contrato(IdC,_,_,_,_,_,_,_,_,data(_,M,_))) :- M >= Inf, M =< Sup)),
    remocao(intervalo(Predicado,IdC,mes,(Inf,Sup))).

% Remover contrato com dia da data entre dois valores
involucao(intervalo(Predicado,IdC,dia,(Inf,Sup))) :-
    remocao((excecao(contrato(IdC,_,_,_,_,_,_,_,_,data(_,_,D))) :- D >= Inf, D =< Sup)),
    remocao(intervalo(Predicado,IdC,dia,(Inf,Sup))).