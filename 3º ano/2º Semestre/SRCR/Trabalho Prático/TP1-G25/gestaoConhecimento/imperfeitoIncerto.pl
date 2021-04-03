%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Evolucao de Conhecimento Imperfeito Incerto

evolucaoIncertoInterdito(Termo) :-
    solucoes(Invariante, (+(Termo,incertoInterdito)::Invariante; +(Termo,naoNegativo)::Invariante), Lista),
    insercao(Termo),
    teste(Lista).

% ----- Adjudicantes -----

% Inserir adjudicante com nome incerto na base de conhecimento
evolucao(adjudicante(IdAd,nomeIncerto,NIF,Morada)) :-
    evolucaoIncertoInterdito(adjudicante(IdAd,nomeIncerto,NIF,Morada)),
    (demo(adjudicante(IdAd,teste,NIF,Morada),desconhecido); % a excecao ja esta na base
    insercao((excecao(adjudicante(P1,P2,P3,P4)) :- adjudicante(P1,nomeIncerto,P3,P4)))). % se nao estiver, inserir

% Inserir adjudicante com NIF incerto na base de conhecimento
evolucao(adjudicante(IdAd,Nome,nifIncerto,Morada)) :-
    evolucaoIncertoInterdito(adjudicante(IdAd,Nome,nifIncerto,Morada)),
    (demo(adjudicante(IdAd,Nome,teste,Morada),desconhecido);
    insercao((excecao(adjudicante(P1,P2,P3,P4)) :- adjudicante(P1,P2,nifIncerto,P4)))).

% Inserir adjudicante com morada incerta na base de conhecimento
evolucao(adjudicante(IdAd,Nome,NIF,moradaIncerta)) :-
    evolucaoIncertoInterdito(adjudicante(IdAd,Nome,NIF,moradaIncerta)),
    (demo(adjudicante(IdAd,Nome,NIF,teste),desconhecido);
    insercao((excecao(adjudicante(P1,P2,P3,P4)) :- adjudicante(P1,P2,P3,moradaIncerta)))).

% ----- Adjudicatarias -----

% Inserir adjudicataria com nome incerto na base de conhecimento
evolucao(adjudicataria(IdAda,nomeIncerto,NIF,Morada)) :-
    evolucaoIncertoInterdito(adjudicataria(IdAda,nomeIncerto,NIF,Morada)),
    (demo(adjudicataria(IdAda,teste,NIF,Morada),desconhecido);
    insercao((excecao(adjudicataria(P1,P2,P3,P4)) :- adjudicataria(P1,nomeIncerto,P3,P4)))).

% Inserir adjudicataria com NIF incerto na base de conhecimento
evolucao(adjudicataria(IdAda,Nome,nifIncerto,Morada)) :-
    evolucaoIncertoInterdito(adjudicataria(IdAda,Nome,nifIncerto,Morada)),
    (demo(adjudicataria(IdAda,Nome,teste,Morada),desconhecido);
    insercao((excecao(adjudicataria(P1,P2,P3,P4)) :- adjudicataria(P1,P2,nifIncerto,P4)))).

% Inserir adjudicataria com morada incerta na base de conhecimento
evolucao(adjudicataria(IdAda,Nome,NIF,moradaIncerta)) :-
    evolucaoIncertoInterdito(adjudicataria(IdAda,Nome,NIF,moradaIncerta)),
    (demo(adjudicataria(IdAda,Nome,NIF,teste),desconhecido);
    insercao((excecao(adjudicataria(P1,P2,P3,P4)) :- adjudicataria(P1,P2,P3,moradaIncerta)))).

% ----- Contratos -----

% Inserir contrato com id do adjudicante incerto na base de conhecimento
evolucao(contrato(IdC,idAdIncerto,IdAda,TC,TP,Desc,V,P,L,D)) :-
    evolucaoIncertoInterdito(contrato(IdC,idAdIncerto,IdAda,TC,TP,Desc,V,P,L,D)),
    (demo(contrato(IdC,teste,IdAda,TC,TP,Desc,V,P,L,D),desconhecido);
    insercao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,idAdIncerto,P3,P4,P5,P6,P7,P8,P9,P10)))).

% Inserir contrato com id da adjudicataria incerto na base de conhecimento
evolucao(contrato(IdC,IdAd,idAdaIncerto,TC,TP,Desc,V,P,L,D)) :-
    evolucaoIncertoInterdito(contrato(IdC,IdAd,idAdaIncerto,TC,TP,Desc,V,P,L,D)),
    (demo(contrato(IdC,IdAd,teste,TC,TP,Desc,V,P,L,D),desconhecido);
    insercao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,idAdaIncerto,P4,P5,P6,P7,P8,P9,P10)))).

% Inserir contrato de tipo incerto na base de conhecimento
evolucao(contrato(IdC,IdAd,IdAda,tipoIncerto,TP,Desc,V,P,L,D)) :-
    evolucaoIncertoInterdito(contrato(IdC,IdAd,IdAda,tipoIncerto,TP,Desc,V,P,L,D)),
    (demo(contrato(IdC,IdAd,IdAda,teste,TP,Desc,V,P,L,D),desconhecido);
    insercao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,tipoIncerto,P5,P6,P7,P8,P9,P10)))).

% Inserir contrato com tipo de procedimento incerto na base de conhecimento
evolucao(contrato(IdC,IdAd,IdAda,TC,procedimentoIncerto,Desc,V,P,L,D)) :-
    evolucaoIncertoInterdito(contrato(IdC,IdAd,IdAda,TC,procedimentoIncerto,Desc,V,P,L,D)),
    (demo(contrato(IdC,IdAd,IdAda,TC,teste,Desc,V,P,L,D),desconhecido);
    insercao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,procedimentoIncerto,P6,P7,P8,P9,P10)))).

% Inserir contrato com descricao incerta na base de conhecimento
evolucao(contrato(IdC,IdAd,IdAda,TC,TP,descricaoIncerta,V,P,L,D)) :-
    evolucaoIncertoInterdito(contrato(IdC,IdAd,IdAda,TC,TP,descricaoIncerta,V,P,L,D)),
    (demo(contrato(IdC,IdAd,IdAda,TC,TP,teste,V,P,L,D),desconhecido);
    insercao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,P5,descricaoIncerta,P7,P8,P9,P10)))).

% Inserir contrato com valor incerto na base de conhecimento
evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,valorIncerto,P,L,D)) :-
    evolucaoIncertoInterdito(contrato(IdC,IdAd,IdAda,TC,TP,Desc,valorIncerto,P,L,D)),
    (demo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,teste,P,L,D),desconhecido);
    insercao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,P5,P6,valorIncerto,P8,P9,P10)))).

% Inserir contrato com prazo incerto na base de conhecimento
evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,prazoIncerto,L,D)) :-
    evolucaoIncertoInterdito(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,prazoIncerto,L,D)),
    (demo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,teste,L,D),desconhecido);
    insercao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,P5,P6,P7,prazoIncerto,P9,P10)))).

% Inserir contrato com local incerto na base de conhecimento
evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,localIncerto,D)) :-
    evolucaoIncertoInterdito(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,localIncerto,D)),
    (demo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,teste,D),desconhecido);
    insercao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,P5,P6,P7,P8,localIncerto,P10)))).

% Inserir contrato com data incerta na base de conhecimento
evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,dataIncerta)) :-
    evolucaoIncertoInterdito(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,dataIncerta)),
    (demo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,teste),desconhecido);
    insercao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,dataIncerta)))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Involucao de Conhecimento Imperfeito Incerto

% ----- Adjudicantes -----

% Remover adjudicante com nome incerto na base de conhecimento
involucao(adjudicante(IdAd,nomeIncerto,NIF,Morada)) :-
    remocao(adjudicante(IdAd,nomeIncerto,NIF,Morada)), % nao ha invariantes de remocao de conhecimento imperfeito
    ((solucoes(adjudicante(_,nomeIncerto,_,_), adjudicante(_,nomeIncerto,_,_), R), comprimento(R,N), N \= 0); % se ainda houver mais adjudicantes com nome incerto, nao remove excecao
    remocao((excecao(adjudicante(P1,P2,P3,P4)) :- adjudicante(P1,nomeIncerto,P3,P4)))). % caso contrario, remove a excecao porque nao sera mais usada

% Remover adjudicante com NIF incerto na base de conhecimento
involucao(adjudicante(IdAd,Nome,nifIncerto,Morada)) :-
    remocao(adjudicante(IdAd,Nome,nifIncerto,Morada)),
    ((solucoes(adjudicante(_,_,nifIncerto,_), adjudicante(_,_,nifIncerto,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(adjudicante(P1,P2,P3,P4)) :- adjudicante(P1,P2,nifIncerto,P4)))).

% Remover adjudicante com morada incerta na base de conhecimento
involucao(adjudicante(IdAd,Nome,NIF,moradaIncerta)) :-
    remocao(adjudicante(IdAd,Nome,NIF,moradaIncerta)),
    ((solucoes(adjudicante(_,_,_,moradaIncerta), adjudicante(_,_,_,moradaIncerta), R), comprimento(R,N), N \= 0);
    remocao((excecao(adjudicante(P1,P2,P3,P4)) :- adjudicante(P1,P2,P3,moradaIncerta)))).

% ----- Adjudicatarias -----

% Remover adjudicataria com nome incerto na base de conhecimento
involucao(adjudicataria(IdAda,nomeIncerto,NIF,Morada)) :-
    remocao(adjudicataria(IdAda,nomeIncerto,NIF,Morada)),
    ((solucoes(adjudicataria(_,nomeIncerto,_,_), adjudicataria(_,nomeIncerto,_,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(adjudicataria(P1,P2,P3,P4)) :- adjudicataria(P1,nomeIncerto,P3,P4)))).

% Remover adjudicataria com NIF incerto na base de conhecimento
involucao(adjudicataria(IdAda,Nome,nifIncerto,Morada)) :-
    remocao(adjudicataria(IdAda,Nome,nifIncerto,Morada)),
    ((solucoes(adjudicataria(_,_,nifIncerto,_), adjudicataria(_,_,nifIncerto,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(adjudicataria(P1,P2,P3,P4)) :- adjudicataria(P1,P2,nifIncerto,P4)))).

% Remover adjudicataria com morada incerta na base de conhecimento
involucao(adjudicataria(IdAda,Nome,NIF,moradaIncerta)) :-
    remocao(adjudicataria(IdAda,Nome,NIF,moradaIncerta)),
    ((solucoes(adjudicataria(_,_,_,moradaIncerta), adjudicataria(_,_,_,moradaIncerta), R), comprimento(R,N), N \= 0);
    remocao((excecao(adjudicataria(P1,P2,P3,P4)) :- adjudicataria(P1,P2,P3,moradaIncerta)))).

% ----- Contratos -----

% Remover contrato com id do adjudicante incerto na base de conhecimento
involucao(contrato(IdC,idAdIncerto,IdAda,TC,TP,Desc,V,P,L,D)) :-
    remocao(contrato(IdC,idAdIncerto,IdAda,TC,TP,Desc,V,P,L,D)),
    ((solucoes(contrato(_,idAdIncerto,_,_,_,_,_,_,_,_), contrato(_,idAdIncerto,_,_,_,_,_,_,_,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,idAdIncerto,P3,P4,P5,P6,P7,P8,P9,P10)))).

% Remover contrato com id da adjudicataria incerto na base de conhecimento
involucao(contrato(IdC,IdAd,idAdaIncerto,TC,TP,Desc,V,P,L,D)) :-
    remocao(contrato(IdC,IdAd,idAdaIncerto,TC,TP,Desc,V,P,L,D)),
    ((solucoes(contrato(_,_,idAdaIncerto,_,_,_,_,_,_,_), contrato(_,_,idAdaIncerto,_,_,_,_,_,_,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,idAdaIncerto,P4,P5,P6,P7,P8,P9,P10)))).

% Remover contrato de tipo incerto na base de conhecimento
involucao(contrato(IdC,IdAd,IdAda,tipoIncerto,TP,Desc,V,P,L,D)) :-
    remocao(contrato(IdC,IdAd,IdAda,tipoIncerto,TP,Desc,V,P,L,D)),
    ((solucoes(contrato(_,_,_,tipoIncerto,_,_,_,_,_,_), contrato(_,_,_,tipoIncerto,_,_,_,_,_,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,tipoIncerto,P5,P6,P7,P8,P9,P10)))).

% Remover contrato com tipo de procedimento incerto na base de conhecimento
involucao(contrato(IdC,IdAd,IdAda,TC,procedimentoIncerto,Desc,V,P,L,D)) :-
    remocao(contrato(IdC,IdAd,IdAda,TC,procedimentoIncerto,Desc,V,P,L,D)),
    ((solucoes(contrato(_,_,_,_,procedimentoIncerto,_,_,_,_,_), contrato(_,_,_,_,procedimentoIncerto,_,_,_,_,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,procedimentoIncerto,P6,P7,P8,P9,P10)))).

% Remover contrato com descricao incerta na base de conhecimento
involucao(contrato(IdC,IdAd,IdAda,TC,TP,descricaoIncerta,V,P,L,D)) :-
    remocao(contrato(IdC,IdAd,IdAda,TC,TP,descricaoIncerta,V,P,L,D)),
    ((solucoes(contrato(_,_,_,_,_,descricaoIncerta,_,_,_,_), contrato(_,_,_,_,_,descricaoIncerta,_,_,_,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,P5,descricaoIncerta,P7,P8,P9,P10)))).

% Remover contrato com valor incerto na base de conhecimento
involucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,valorIncerto,P,L,D)) :-
    remocao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,valorIncerto,P,L,D)),
    ((solucoes(contrato(_,_,_,_,_,valorIncerto,_,_,_), contrato(_,_,_,_,_,valorIncerto,_,_,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,P5,P6,valorIncerto,P8,P9,P10)))).

% Remover contrato com prazo incerto na base de conhecimento
involucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,prazoIncerto,L,D)) :-
    remocao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,prazoIncerto,L,D)),
    ((solucoes(contrato(_,_,_,_,_,_,prazoIncerto,_,_), contrato(_,_,_,_,_,_,prazoIncerto,_,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,P5,P6,P7,prazoIncerto,P9,P10)))).

% Remover contrato com local incerto na base de conhecimento
involucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,localIncerto,D)) :-
    remocao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,localIncerto,D)),
    ((solucoes(contrato(_,_,_,_,_,_,_,localIncerto,_), contrato(_,_,_,_,_,_,_,localIncerto,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,P5,P6,P7,P8,localIncerto,P10)))).

% Remover contrato com data incerta na base de conhecimento
involucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,dataIncerta)) :-
    remocao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,dataIncerta)),
    ((solucoes(contrato(_,_,_,_,_,_,_,_,dataIncerta), contrato(_,_,_,_,_,_,_,_,dataIncerta), R), comprimento(R,N), N \= 0);
    remocao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,dataIncerta)))).