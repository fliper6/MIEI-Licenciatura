%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Conhecimento Imperfeito Incerto

% ----- Adjudicantes -----

% Adjudicantes com nome incerto
adjudicantesNomeIncerto(R) :-
    solucoes(adjudicante(IdAd,nomeIncerto,NIF,Morada), adjudicante(IdAd,nomeIncerto,NIF,Morada), R).

% Adjudicantes com nif incerto 
adjudicantesNIFIncerto(R) :-
    solucoes(adjudicante(IdAd,Nome,nifIncerto,Morada), adjudicante(IdAd,Nome,nifIncerto,Morada), R).

% Adjudicantes com morada incerta 
adjudicantesMoradaIncerta(R) :-
    solucoes(adjudicante(IdAd,Nome,NIF,moradaIncerta), adjudicante(IdAd,Nome,NIF,moradaIncerta), R).

% ----- Adjudicatarias -----

% Adjudicatarias com nome incerto 
adjudicatariasNomeIncerto(R) :-
    solucoes(adjudicataria(IdAda,nomeIncerto,NIF,Morada), adjudicataria(IdAda,nomeIncerto,NIF,Morada), R).

% Adjudicatarias com nif incerto 
adjudicatariasNIFIncerto(R) :-
    solucoes(adjudicataria(IdAda,Nome,nifIncerto,Morada), adjudicataria(IdAda,Nome,nifIncerto,Morada), R).

% Adjudicatarias com morada incerta 
adjudicatariasMoradaIncerta(R) :-
    solucoes(adjudicataria(IdAda,Nome,NIF,moradaIncerta), adjudicataria(IdAda,Nome,NIF,moradaIncerta), R).

% ----- Contratos -----

% Contratos com id de adjudicante incerto
contratosIdAdIncerto(R) :-
    solucoes(contrato(A,idAdIncerto,C,D,E,F,G,H,I,J), contrato(A,idAdIncerto,C,D,E,F,G,H,I,J), R).

% Contratos com id de adjudicataria incerto
contratosIdAdaIncerto(R) :-
    solucoes(contrato(A,B,idAdaIncerto,D,E,F,G,H,I,J), contrato(A,B,idAdaIncerto,D,E,F,G,H,I,J), R).

% Contratos de tipo incerto
contratosTipoIncerto(R) :-
    solucoes(contrato(A,B,C,tipoIncerto,E,F,G,H,I,J), contrato(A,B,C,tipoIncerto,E,F,G,H,I,J), R).

% Contratos com tipo de procedimento incerto
contratosProcedimentoIncerto(R) :-
    solucoes(contrato(A,B,C,D,procedimentoIncerto,F,G,H,I,J), contrato(A,B,C,D,procedimentoIncerto,F,G,H,I,J), R).

% Contratos com descricao incerta
contratosDescricaoIncerta(R) :-
    solucoes(contrato(A,B,C,D,E,descricaoIncerta,G,H,I,J), contrato(A,B,C,D,E,descricaoIncerta,G,H,I,J), R).

% Contratos de valor incerto
contratosValorIncerto(R) :-
    solucoes(contrato(A,B,C,D,E,F,valorIncerto,H,I,J), contrato(A,B,C,D,E,F,valorIncerto,H,I,J), R).

% Contratos de prazo incerto
contratosPrazoIncerto(R) :-
    solucoes(contrato(A,B,C,D,E,F,G,prazoIncerto,I,J), contrato(A,B,C,D,E,F,G,prazoIncerto,I,J), R).

% Contratos de local incerto
contratosLocalIncerto(R) :-
    solucoes(contrato(A,B,C,D,E,F,G,H,localIncerto,J), contrato(A,B,C,D,E,F,G,H,localIncerto,J), R).

% Contratos de data incerta
contratosDataIncerta(R) :-
    solucoes(contrato(A,B,C,D,E,F,G,H,I,dataIncerta), contrato(A,B,C,D,E,F,G,H,I,dataIncerta), R).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Conhecimento Imperfeito Impreciso
% Estas identificacoes nao funcionam com predicado que tenham parametros entre valores

% Todas as possibilidades para o adjudicante com certo id
adjudicantesImprecisosExplicitosId(IdAd,R) :-
    solucoes(adjudicante(IdAd,Nome,NIF,Morada), excecao(adjudicante(IdAd,Nome,NIF,Morada)), R),
    nao(comprimento(R,0)).
    
% Todas as possibilidades para a adjudicataria com certo id
adjudicatariasImprecisasExplicitasId(IdAda,R) :-
    solucoes(adjudicataria(IdAda,Nome,NIF,Morada), excecao(adjudicataria(IdAda,Nome,NIF,Morada)), R),
    nao(comprimento(R,0)).

% Todas as possibilidades para o contrato com certo id
contratosImprecisosExplicitosId(IdC,R) :-
    solucoes(contrato(IdC,B,C,D,E,F,G,H,I,J), excecao(contrato(IdC,B,C,D,E,F,G,H,I,J)), R),
    nao(comprimento(R,0)).

% Limites do intervalo de valores imprecisos do termo com certo id
intervaloImprecisoId(Predicado,Id,Intervalo) :-
    solucoes(intervalo(Predicado,Id,Parametro,(Inf,Sup)), intervalo(Predicado,Id,Parametro,(Inf,Sup)), [Intervalo|_]).

% As possibilidades para o adjudicante com um certo id, no formato que o utilizador usa para o introduzir
adjudicantesImprecisosImplicitosId(IdAd,R) :-
    intervaloImprecisoId(adjudicante,IdAd,intervalo(_,_,_,(Inf,Sup))),
    solucoes(adjudicante(IdAd,Nome,(Inf,Sup),Morada), excecao(adjudicante(IdAd,Nome,Inf,Morada)), R).

% As possibilidades para a adjudicataria com um certo id, no formato que o utilizador usa para o introduzir
adjudicatariasImprecisosImplicitosId(IdAda,R) :-
    intervaloImprecisoId(adjudicataria,IdAda,intervalo(_,_,_,(Inf,Sup))),
    solucoes(adjudicataria(IdAda,Nome,(Inf,Sup),Morada), excecao(adjudicataria(IdAda,Nome,Inf,Morada)), R).

% As possibilidades para o contrato com um certo id, no formato que o utilizador usa para o introduzir
contratosImprecisosImplicitosId(IdC,R) :-
    intervaloImprecisoId(contrato,IdC,intervalo(_,_,Parametro,(Inf,Sup))),
    ((Parametro = valor, solucoes(contrato(IdC,IdAd,IdAda,TC,TP,Desc,(Inf,Sup),P,L,D), excecao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,Inf,P,L,D)), R));
    (Parametro = prazo, solucoes(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,(Inf,Sup),L,D), excecao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,Inf,L,D)), R));
    (Parametro = ano, solucoes(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data((Inf,Sup),M,D)), excecao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(Inf,M,D))), R));
    (Parametro = mes, solucoes(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(A,(Inf,Sup),D)), excecao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(A,Inf,D))), R));
    (Parametro = dia, solucoes(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(A,M,(Inf,Sup))), excecao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(A,M,Inf))), R))).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Conhecimento Imperfeito Interdito

% ----- Adjudicantes -----

% Adjudicantes com nome interdito
adjudicantesNomeInterdito(R) :-
    solucoes(adjudicante(IdAd,nomeInterdito,NIF,Morada), adjudicante(IdAd,nomeInterdito,NIF,Morada), R).

% Adjudicantes com nif interdito
adjudicantesNIFInterdito(R) :-
    solucoes(adjudicante(IdAd,Nome,nifInterdito,Morada), adjudicante(IdAd,Nome,nifInterdito,Morada), R).

% Adjudicantes com morada interdita
adjudicantesMoradaInterdita(R) :-
    solucoes(adjudicante(IdAd,Nome,NIF,moradaInterdita), adjudicante(IdAd,Nome,NIF,moradaInterdita), R).

% ----- Adjudicatarias -----

% Adjudicatarias com nome interdito
adjudicatariasNomeInterdito(R) :-
    solucoes(adjudicataria(IdAda,nomeInterdito,NIF,Morada), adjudicataria(IdAda,nomeInterdito,NIF,Morada), R).

% Adjudicatarias com nif interdito
adjudicatariasNIFInterdito(R) :-
    solucoes(adjudicataria(IdAda,Nome,nifInterdito,Morada), adjudicataria(IdAda,Nome,nifInterdito,Morada), R).

% Adjudicatarias com morada interdita
adjudicatariasMoradaInterdita(R) :-
    solucoes(adjudicataria(IdAda,Nome,NIF,moradaInterdita), adjudicataria(IdAda,Nome,NIF,moradaInterdita), R).

% ----- Contratos -----

% Contratos com id de adjudicante interdito
contratosIdAdInterdito(R) :-
    solucoes(contrato(A,idAdInterdito,C,D,E,F,G,H,I,J), contrato(A,idAdInterdito,C,D,E,F,G,H,I,J), R).

% Contratos com id de adjudicataria interdito
contratosIdAdaInterdito(R) :-
    solucoes(contrato(A,B,idAdaInterdito,D,E,F,G,H,I,J), contrato(A,B,idAdaInterdito,D,E,F,G,H,I,J), R).

% Contratos de tipo interdito
contratosTipoInterdito(R) :-
    solucoes(contrato(A,B,C,tipoInterdito,E,F,G,H,I,J), contrato(A,B,C,tipoInterdito,E,F,G,H,I,J), R).

% Contratos com tipo de procedimento interdito
contratosProcedimentoInterdito(R) :-
    solucoes(contrato(A,B,C,D,procedimentoInterdito,F,G,H,I,J), contrato(A,B,C,D,procedimentoInterdito,F,G,H,I,J), R).

% Contratos com descricao interdita
contratosDescricaoInterdita(R) :-
    solucoes(contrato(A,B,C,D,E,descricaoInterdita,G,H,I,J), contrato(A,B,C,D,E,descricaoInterdita,G,H,I,J), R).

% Contratos de valor interdito
contratosValorInterdito(R) :-
    solucoes(contrato(A,B,C,D,E,F,valorInterdito,H,I,J), contrato(A,B,C,D,E,F,valorInterdito,H,I,J), R).

% Contratos de prazo interdito
contratosPrazoInterdito(R) :-
    solucoes(contrato(A,B,C,D,E,F,G,prazoInterdito,I,J), contrato(A,B,C,D,E,F,G,prazoInterdito,I,J), R).

% Contratos de local interdito
contratosLocalInterdito(R) :-
    solucoes(contrato(A,B,C,D,E,F,G,H,localInterdito,J), contrato(A,B,C,D,E,F,G,H,localInterdito,J), R).

% Contratos de data interdita
contratosDataInterdita(R) :-
    solucoes(contrato(A,B,C,D,E,F,G,H,I,dataInterdita), contrato(A,B,C,D,E,F,G,H,I,dataInterdita), R).