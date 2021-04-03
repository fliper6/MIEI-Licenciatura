%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Evolucao de Conhecimento Imperfeito Interdito

% ----- Adjudicantes -----

% Inserir as restricoes relacionadas com o novo adjudicante interdito
insercaoAdjudicanteInterdito((IdAd,Nome,NIF,Morada),ParInterdito) :-
    insercao(nuloInterdito(ParInterdito)), % instancia de nulo
    ((ParInterdito = nomeInterdito, insercao((excecao(adjudicante(P1,P2,P3,P4)) :- adjudicante(P1,nomeInterdito,P3,P4))));
     (ParInterdito = nifInterdito, insercao((excecao(adjudicante(P1,P2,P3,P4)) :- adjudicante(P1,P2,nifInterdito,P4))));
     (ParInterdito = moradaInterdita, insercao((excecao(adjudicante(P1,P2,P3,P4)) :- adjudicante(P1,P2,P3,moradaInterdita))))), % excecao
    insercao((+adjudicante(P1,P2,P3,P4) :: (solucoes((P1,P2,P3,P4), % invariante
            (adjudicante(IdAd,Nome,NIF,Morada), nao(nuloInterdito(ParInterdito))), R),
            comprimento(R,0)))).

% Inserir adjudicante com nome interdito na base de conhecimento
evolucao(adjudicante(IdAd,nomeInterdito,NIF,Morada)) :-
    evolucaoIncertoInterdito(adjudicante(IdAd,nomeInterdito,NIF,Morada)),
    (demo(adjudicante(IdAd,teste,NIF,Morada),desconhecido); % a excecao ja esta na base
    insercaoAdjudicanteInterdito((IdAd,nomeInterdito,NIF,Morada),nomeInterdito)).

% Inserir adjudicante com NIF interdito na base de conhecimento
evolucao(adjudicante(IdAd,Nome,nifInterdito,Morada)) :-
    evolucaoIncertoInterdito(adjudicante(IdAd,Nome,nifInterdito,Morada)),
    (demo(adjudicante(IdAd,Nome,teste,Morada),desconhecido);
    insercaoAdjudicanteInterdito((IdAd,Nome,nifInterdito,Morada),nifInterdito)).

% Inserir adjudicante com morada interdita na base de conhecimento
evolucao(adjudicante(IdAd,Nome,NIF,moradaInterdita)) :-
    evolucaoIncertoInterdito(adjudicante(IdAd,Nome,NIF,moradaInterdita)),
    (demo(adjudicante(IdAd,Nome,NIF,teste),desconhecido);
    insercaoAdjudicanteInterdito((IdAd,Nome,NIF,moradaInterdita),moradaInterdita)).

% ----- Adjudicatarias -----

% Inserir as restricoes relacionadas com a nova adjudicataria interdita
insercaoAdjudicatariaInterdita((IdAd,Nome,NIF,Morada),ParInterdito) :-
    insercao(nuloInterdito(ParInterdito)), % instancia de nulo
    ((ParInterdito = nomeInterdito, insercao((excecao(adjudicataria(P1,P2,P3,P4)) :- adjudicataria(P1,nomeInterdito,P3,P4))));
     (ParInterdito = nifInterdito, insercao((excecao(adjudicataria(P1,P2,P3,P4)) :- adjudicataria(P1,P2,nifInterdito,P4))));
     (ParInterdito = moradaInterdita, insercao((excecao(adjudicataria(P1,P2,P3,P4)) :- adjudicataria(P1,P2,P3,moradaInterdita))))), % excecao
    insercao((+adjudicataria(P1,P2,P3,P4) :: (solucoes((P1,P2,P3,P4), % invariante
            (adjudicataria(IdAd,Nome,NIF,Morada), nao(nuloInterdito(ParInterdito))), R),
            comprimento(R,0)))).

% Inserir adjudicataria com nome interdito na base de conhecimento
evolucao(adjudicataria(IdAda,nomeInterdito,NIF,Morada)) :-
    evolucaoIncertoInterdito(adjudicataria(IdAda,nomeInterdito,NIF,Morada)),
    (demo(adjudicataria(IdAda,teste,NIF,Morada),desconhecido);
    insercaoAdjudicatariaInterdita((IdAd,nomeInterdito,NIF,Morada),nomeInterdito)).

% Inserir adjudicataria com NIF interdito na base de conhecimento
evolucao(adjudicataria(IdAda,Nome,nifInterdito,Morada)) :-
    evolucaoIncertoInterdito(adjudicataria(IdAda,Nome,nifInterdito,Morada)),
    (demo(adjudicataria(IdAda,Nome,teste,Morada),desconhecido);
    insercaoAdjudicatariaInterdita((IdAd,Nome,nifInterdito,Morada),nifInterdito)).

% Inserir adjudicataria com morada interdita na base de conhecimento
evolucao(adjudicataria(IdAda,Nome,NIF,moradaInterdita)) :-
    evolucaoIncertoInterdito(adjudicataria(IdAda,Nome,NIF,moradaInterdita)),
    (demo(adjudicataria(IdAda,Nome,NIF,teste),desconhecido);
    insercaoAdjudicatariaInterdita((IdAd,Nome,NIF,moradaInterdita),moradaInterdita)).

% ----- Contratos -----

% Inserir as restricoes relacionadas com o novo contrato interdito
insercaoContratoInterdito((IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,D),ParInterdito) :-
    insercao(nuloInterdito(ParInterdito)), % instancia de nulo
    ((ParInterdito = idAdInterdito, insercao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,idAdInterdito,P3,P4,P5,P6,P7,P8,P9,P10))));
     (ParInterdito = idAdaInterdito, insercao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,idAdaInterdito,P4,P5,P6,P7,P8,P9,P10))));
     (ParInterdito = tipoInterdito, insercao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,tipoInterdito,P5,P6,P7,P8,P9,P10))));
     (ParInterdito = procedimentoInterdito, insercao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,procedimentoInterdito,P6,P7,P8,P9,P10))));
     (ParInterdito = descricaoInterdita, insercao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,P5,descricaoInterdita,P7,P8,P9,P10))));
     (ParInterdito = valorInterdito, insercao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,P5,P6,valorInterdito,P8,P9,P10))));
     (ParInterdito = prazoInterdito, insercao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,P5,P6,P7,prazoInterdito,P9,P10))));
     (ParInterdito = localInterdito, insercao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,P5,P6,P7,P8,localInterdito,P10))));
     (ParInterdito = dataInterdita, insercao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,dataInterdita))))), % excecao
    insercao((+contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) :: (solucoes((P1,P2,P3,P4,P5,P6,P7,P8,P9,P10), % invariante
            (contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,D), nao(nuloInterdito(ParInterdito))), R),
            comprimento(R,0)))).

% Inserir contrato com id do adjudicante interdito na base de conhecimento
evolucao(contrato(IdC,idAdInterdito,IdAda,TC,TP,Desc,V,P,L,D)) :-
    evolucaoIncertoInterdito(contrato(IdC,idAdInterdito,IdAda,TC,TP,Desc,V,P,L,D)),
    (demo(contrato(IdC,teste,IdAda,TC,TP,Desc,V,P,L,D),desconhecido);
    insercaoContratoInterdito((IdC,idAdInterdito,IdAda,TC,TP,Desc,V,P,L,D),idAdInterdito)).

% Inserir contrato com id da adjudicataria interdito na base de conhecimento
evolucao(contrato(IdC,IdAd,idAdaInterdito,TC,TP,Desc,V,P,L,D)) :-
    evolucaoIncertoInterdito(contrato(IdC,IdAd,idAdaInterdito,TC,TP,Desc,V,P,L,D)),
    (demo(contrato(IdC,IdAd,teste,TC,TP,Desc,V,P,L,D),desconhecido);
    insercaoContratoInterdito((IdC,IdAd,idAdaInterdito,TC,TP,Desc,V,P,L,D),idAdaInterdito)).

% Inserir contrato de tipo interdito na base de conhecimento
evolucao(contrato(IdC,IdAd,IdAda,tipoInterdito,TP,Desc,V,P,L,D)) :-
    evolucaoIncertoInterdito(contrato(IdC,IdAd,IdAda,tipoInterdito,TP,Desc,V,P,L,D)),
    (demo(contrato(IdC,IdAd,IdAda,teste,TP,Desc,V,P,L,D),desconhecido);
    insercaoContratoInterdito((IdC,IdAd,IdAda,tipoInterdito,TP,Desc,V,P,L,D),tipoInterdito)).

% Inserir contrato com tipo de procedimento interdito na base de conhecimento
evolucao(contrato(IdC,IdAd,IdAda,TC,procedimentoInterdito,Desc,V,P,L,D)) :-
    evolucaoIncertoInterdito(contrato(IdC,IdAd,IdAda,TC,procedimentoInterdito,Desc,V,P,L,D)),
    (demo(contrato(IdC,IdAd,IdAda,TC,teste,Desc,V,P,L,D),desconhecido);
    insercaoContratoInterdito((IdC,IdAd,IdAda,TC,procedimentoInterdito,Desc,V,P,L,D),procedimentoInterdito)).

% Inserir contrato com descricao interdita na base de conhecimento
evolucao(contrato(IdC,IdAd,IdAda,TC,TP,descricaoInterdita,V,P,L,D)) :-
    evolucaoIncertoInterdito(contrato(IdC,IdAd,IdAda,TC,TP,descricaoInterdita,V,P,L,D)),
    (demo(contrato(IdC,IdAd,IdAda,TC,TP,teste,V,P,L,D),desconhecido);
    insercaoContratoInterdito((IdC,IdAd,IdAda,TC,TP,descricaoInterdita,V,P,L,D),descricaoInterdita)).

% Inserir contrato com valor interdito na base de conhecimento
evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,valorInterdito,P,L,D)) :-
    evolucaoIncertoInterdito(contrato(IdC,IdAd,IdAda,TC,TP,Desc,valorInterdito,P,L,D)),
    (demo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,teste,P,L,D),desconhecido);
    insercaoContratoInterdito((IdC,IdAd,IdAda,TC,TP,Desc,valorInterdito,P,L,D),valorInterdito)).

% Inserir contrato com prazo interdito na base de conhecimento
evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,prazoInterdito,L,D)) :-
    evolucaoIncertoInterdito(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,prazoInterdito,L,D)),
    (demo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,teste,L,D),desconhecido);
    insercaoContratoInterdito((IdC,IdAd,IdAda,TC,TP,Desc,V,prazoInterdito,L,D),prazoInterdito)).

% Inserir contrato com local interdito na base de conhecimento
evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,localInterdito,D)) :-
    evolucaoIncertoInterdito(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,localInterdito,D)),
    (demo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,teste,D),desconhecido);
    insercaoContratoInterdito((IdC,IdAdInterdito,IdAda,TC,TP,Desc,V,P,localInterdito,D),localInterdito)).

% Inserir contrato com data interdita na base de conhecimento
evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,dataInterdita)) :-
    evolucaoIncertoInterdito(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,dataInterdita)),
    (demo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,teste),desconhecido);
    insercaoContratoInterdito((IdC,IdAdInterdito,IdAda,TC,TP,Desc,V,P,L,dataInterdita),dataInterdita)).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Involucao de Conhecimento Imperfeito Interdito

% ----- Adjudicantes -----

% Remover o termo em questao e respetivo invariante do adjudicante
remocaoAdjudicanteInterdito((IdAd,Nome,NIF,Morada),ParInterdito) :-
    remocao(adjudicante(IdAd,Nome,NIF,Morada)), % termo
    remocao((+adjudicante(P1,P2,P3,P4) :: (solucoes((P1,P2,P3,P4), % invariante
            (adjudicante(IdAd,Nome,NIF,Morada), nao(nuloInterdito(ParInterdito))), R),
            comprimento(R,0)))).
    

% Remover adjudicante com nome interdito na base de conhecimento
involucao(adjudicante(IdAd,nomeInterdito,NIF,Morada)) :-
    remocaoAdjudicanteInterdito((IdAd,nomeInterdito,NIF,Morada),nomeInterdito),
    ((solucoes(adjudicante(_,nomeInterdito,_,_), adjudicante(_,nomeInterdito,_,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(adjudicante(P1,P2,P3,P4)) :- adjudicante(P1,nomeInterdito,P3,P4))),
    remocao(nuloInterdito(nomeInterdito))).

% Remover adjudicante com NIF interdito na base de conhecimento
involucao(adjudicante(IdAd,Nome,nifInterdito,Morada)) :-
    remocaoAdjudicanteInterdito((IdAd,Nome,nifInterdito,Morada),nifInterdito),
    ((solucoes(adjudicante(_,_,nifInterdito,_), adjudicante(_,_,nifInterdito,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(adjudicante(P1,P2,P3,P4)) :- adjudicante(P1,P2,nifIncerto,P4))),
    remocao(nuloInterdito(nifInterdito))).

% Remover adjudicante com morada interdita na base de conhecimento
involucao(adjudicante(IdAd,Nome,NIF,moradaInterdita)) :-
    remocaoAdjudicanteInterdito((IdAd,Nome,NIF,moradaInterdita),moradaInterdita),
    ((solucoes(adjudicante(_,_,_,moradaInterdita), adjudicante(_,_,_,moradaInterdita), R), comprimento(R,N), N \= 0);
    remocao((excecao(adjudicante(P1,P2,P3,P4)) :- adjudicante(P1,P2,P3,moradaInterdita))),
    remocao(nuloInterdito(moradaInterdita))).

% ----- Adjudicatarias -----

% Remover o termo em questao e respetivo invariante da adjudicataria
remocaoAdjudicatariaInterdita((IdAd,Nome,NIF,Morada),ParInterdito) :-
    remocao(adjudicataria(IdAd,Nome,NIF,Morada)), % termo
    remocao((+adjudicataria(P1,P2,P3,P4) :: (solucoes((P1,P2,P3,P4), % invariante
            (adjudicataria(IdAd,Nome,NIF,Morada), nao(nuloInterdito(ParInterdito))), R),
            comprimento(R,0)))).

% Remover adjudicataria com nome interdito na base de conhecimento
involucao(adjudicataria(IdAd,nomeInterdito,NIF,Morada)) :-
    remocaoAdjudicatariaInterdita((IdAd,nomeInterdito,NIF,Morada),nomeInterdito),
    ((solucoes(adjudicataria(_,nomeInterdito,_,_), adjudicataria(_,nomeInterdito,_,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(adjudicataria(P1,P2,P3,P4)) :- adjudicataria(P1,nomeInterdito,P3,P4))),
    remocao(nuloInterdito(nomeInterdito))).

% Remover adjudicataria com NIF interdito na base de conhecimento
involucao(adjudicataria(IdAd,Nome,nifInterdito,Morada)) :-
    remocaoAdjudicatariaInterdita((IdAd,Nome,nifInterdito,Morada),nifInterdito),
    ((solucoes(adjudicataria(_,_,nifInterdito,_), adjudicataria(_,_,nifInterdito,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(adjudicataria(P1,P2,P3,P4)) :- adjudicataria(P1,P2,nifIncerto,P4))),
    remocao(nuloInterdito(nifInterdito))).

% Remover adjudicataria com morada interdita na base de conhecimento
involucao(adjudicataria(IdAd,Nome,NIF,moradaInterdita)) :-
    remocaoAdjudicatariaInterdita((IdAd,Nome,NIF,moradaInterdita),moradaInterdita),
    ((solucoes(adjudicataria(_,_,_,moradaInterdita), adjudicataria(_,_,_,moradaInterdita), R), comprimento(R,N), N \= 0);
    remocao((excecao(adjudicataria(P1,P2,P3,P4)) :- adjudicataria(P1,P2,P3,moradaInterdita))),
    remocao(nuloInterdito(moradaInterdita))).

% ----- Contratos -----

% Remover o termo em questao e respetivo invariante do contrato
remocaoContratoInterdito((IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,D),ParInterdito) :-
    remocao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,D)),
    remocao((+contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) :: (solucoes((P1,P2,P3,P4,P5,P6,P7,P8,P9,P10),
            (contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,D), nao(nuloInterdito(ParInterdito))), R),
            comprimento(R,0)))).

% Remover contrato com id do adjudicante interdito na base de conhecimento
involucao(contrato(IdC,idAdInterdito,IdAda,TC,TP,Desc,V,P,L,D)) :-
    remocaoContratoInterdito((IdC,idAdInterdito,IdAda,TC,TP,Desc,V,P,L,D),idAdInterdito),
    ((solucoes(contrato(_,idAdInterdito,_,_,_,_,_,_,_,_), contrato(_,idAdInterdito,_,_,_,_,_,_,_,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,idAdInterdito,P3,P4,P5,P6,P7,P8,P9,P10))),
    remocao(nuloInterdito(idAdInterdito))).

% Remover contrato com id da adjudicataria interdito na base de conhecimento
involucao(contrato(IdC,IdAd,idAdaInterdito,TC,TP,Desc,V,P,L,D)) :-
    remocaoContratoInterdito((IdC,IdAd,idAdaInterdito,TC,TP,Desc,V,P,L,D),idAdaInterdito),
    ((solucoes(contrato(_,_,idAdaInterdito,_,_,_,_,_,_,_), contrato(_,_,idAdaInterdito,_,_,_,_,_,_,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,idAdaInterdito,P4,P5,P6,P7,P8,P9,P10))),
    remocao(nuloInterdito(idAdaInterdito))).

% Remover contrato de tipo interdito na base de conhecimento
involucao(contrato(IdC,IdAd,IdAda,tipoInterdito,TP,Desc,V,P,L,D)) :-
    remocaoContratoInterdito((IdC,IdAd,IdAda,tipoInterdito,TP,Desc,V,P,L,D),tipoInterdito),
    ((solucoes(contrato(_,_,_,tipoInterdito,_,_,_,_,_,_), contrato(_,_,_,tipoInterdito,_,_,_,_,_,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,tipoInterdito,P5,P6,P7,P8,P9,P10))),
    remocao(nuloInterdito(tipoInterdito))).

% Remover contrato com tipo de procedimento interdito na base de conhecimento
involucao(contrato(IdC,IdAd,IdAda,TC,procedimentoInterdito,Desc,V,P,L,D)) :-
    remocaoContratoInterdito((IdC,IdAd,IdAda,TC,procedimentoInterdito,Desc,V,P,L,D),procedimentoInterdito),
    ((solucoes(contrato(_,_,_,_,procedimentoInterdito,_,_,_,_,_), contrato(_,_,_,_,procedimentoInterdito,_,_,_,_,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,procedimentoInterdito,P6,P7,P8,P9,P10))),
    remocao(nuloInterdito(procedimentoInterdito))).

% Remover contrato com descricao interdita na base de conhecimento
involucao(contrato(IdC,IdAd,IdAda,TC,TP,descricaoInterdita,V,P,L,D)) :-
    remocaoContratoInterdito((IdC,IdAd,IdAda,TC,TP,descricaoInterdita,V,P,L,D),descricaoInterdita),
    ((solucoes(contrato(_,_,_,_,_,descricaoInterdita,_,_,_,_), contrato(_,_,_,_,_,descricaoInterdita,_,_,_,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,P5,descricaoInterdita,P7,P8,P9,P10))),
    remocao(nuloInterdito(descricaoInterdita))).

% Remover contrato com valor interdito na base de conhecimento
involucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,valorInterdito,P,L,D)) :-
    remocaoContratoInterdito((IdC,IdAd,IdAda,TC,TP,Desc,valorInterdito,P,L,D),valorInterdito),
    ((solucoes(contrato(_,_,_,_,_,_,valorInterdito,_,_,_), contrato(_,_,_,_,_,_,valorInterdito,_,_,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,P5,P6,valorInterdito,P8,P9,P10))),
    remocao(nuloInterdito(valorInterdito))).

% Remover contrato com prazo interdito na base de conhecimento
involucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,prazoInterdito,L,D)) :-
    remocaoContratoInterdito((IdC,IdAd,IdAda,TC,TP,Desc,V,prazoInterdito,L,D),prazoInterdito),
    ((solucoes(contrato(_,_,_,_,_,_,_,prazoInterdito,_,_), contrato(_,_,_,_,_,_,_,prazoInterdito,_,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,P5,P6,P7,prazoInterdito,P9,P10))),
    remocao(nuloInterdito(prazoInterdito))).

% Remover contrato com local interdito na base de conhecimento
involucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,localInterdito,D)) :-
    remocaoContratoInterdito((IdC,IdAd,IdAda,TC,TP,Desc,V,P,localInterdito,D),localInterdito),
    ((solucoes(contrato(_,_,_,_,_,_,_,_,localInterdito,_), contrato(_,_,_,_,_,_,_,_,localInterdito,_), R), comprimento(R,N), N \= 0);
    remocao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,P5,P6,P7,P8,localInterdito,P10))),
    remocao(nuloInterdito(localInterdito))).

% Remover contrato com data interdita na base de conhecimento
involucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,dataInterdita)) :-
    remocaoContratoInterdito((IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,dataInterdita),dataInterdita),
    ((solucoes(contrato(_,_,_,_,_,_,_,_,_,dataInterdita), contrato(_,_,_,_,_,_,_,_,_,dataInterdita), R), comprimento(R,N), N \= 0);
    remocao((excecao(contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)) :- contrato(P1,P2,P3,P4,P5,P6,P7,P8,P9,dataInterdita))),
    remocao(nuloInterdito(dataInterdita))).