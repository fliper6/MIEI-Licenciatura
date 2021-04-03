%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Conhecimento perfeito positivo

% ----- Adjudicantes -----

% Todos os adjudicantes
adjudicantes(R) :-
    solucoes(adjudicante(IdAd,Nome,NIF,Morada), 
            (adjudicante(IdAd,Nome,NIF,Morada), adjudiPerfeito(Nome,NIF,Morada)), R).

% Adjudicantes que fecharam contrato com uma dada adjudicataria
adjudicantesContratoComAdjudicataria(IdAda,Adjudicantes) :-
    solucoes(contrato(_,IdAd,IdAda,D,E,F,G,H,I,J), 
            (contrato(_,IdAd,IdAda,D,E,F,G,H,I,J), contratoPerfeito(IdAd,IdAda,D,E,F,G,H,I,J)), Contratos),
    adjudicantesDosContratos(Contratos,Adjudicantes).

% Adjudicantes com contratos ativos
adjudicantesContratosAtivos(Adjudicantes) :- 
    solucoes(contrato(_,IdAd,C,D,E,F,G,Prazo,I,Data), (contrato(_,IdAd,C,D,E,F,G,Prazo,I,Data), 
        contratoPerfeito(IdAd,C,D,E,F,G,Prazo,I,Data), nao(prazoExpirado(Data,Prazo))), Ativos),
    adjudicantesDosContratos(Ativos,Adjudicantes).
                            
% Custos totais de todos os contratos terminados de um adjudicante
adjudicanteCustosTotais(IdAd,Custo) :-
    solucoes(Valor, (contrato(_,IdAd,C,D,E,F,Valor,Prazo,I,Data), 
            contratoPerfeito(IdAd,C,D,E,F,Valor,Prazo,I,Data), prazoExpirado(Data,Prazo)), ValoresExpirados),
    valorAcumulado(ValoresExpirados,Custo).

% ----- Adjudicatarias -----

% Todas as adjudicatarias
adjudicatarias(R) :-
    solucoes(adjudicataria(IdAda,Nome,NIF,Morada), 
            (adjudicataria(IdAda,Nome,NIF,Morada), adjudiPerfeito(Nome,NIF,Morada)), R).

% Adjudicatarias com quem um certo adjudicante fechou contrato
adjudicatariasContratoComAdjudicante(IdAd,Adjudicatarias) :-
    solucoes(contrato(_,IdAd,IdAda,D,E,F,G,H,I,J),
            (contrato(_,IdAd,IdAda,D,E,F,G,H,I,J), contratoPerfeito(IdAd,IdAda,D,E,F,G,H,I,J)), Contratos),
    adjudicatariasDosContratos(Contratos,Adjudicatarias).

% Adjudicatarias com contratos ativos
adjudicatariasContratosAtivos(Adjudicatarias) :- 
    solucoes(contrato(_,B,IdAda,D,E,F,G,Prazo,I,Data), (contrato(_,B,IdAda,D,E,F,G,Prazo,I,Data), 
        contratoPerfeito(B,IdAda,D,E,F,G,Prazo,I,Data), nao(prazoExpirado(Data,Prazo))), Ativos),
    adjudicatariasDosContratos(Ativos,Adjudicatarias).

% Receitas totais de todos os contratos terminados de uma adjudicataria
adjudicatariaReceitasTotais(IdAda,Receita) :- 
    solucoes(Valor, (contrato(_,B,IdAda,D,E,F,Valor,Prazo,I,Data), 
        contratoPerfeito(B,IdAda,D,E,F,Valor,Prazo,I,Data), prazoExpirado(Data,Prazo)), ValoresExpirados),
    valorAcumulado(ValoresExpirados,Receita).

% ----- Contratos -----

% Contratos ativos de um certo adjudicante
contratosAtivosAdjudicante(IdAd,Ativos) :-
    solucoes(contrato(A,IdAd,C,D,E,F,G,Prazo,I,Data), (contrato(A,IdAd,C,D,E,F,G,Prazo,I,Data),
        contratoPerfeito(IdAd,C,D,E,F,G,Prazo,I,Data), nao(prazoExpirado(Data,Prazo))), Ativos).

% Contratos ativos de uma certa adjudicataria
contratosAtivosAdjudicataria(IdAda,Ativos) :-
    solucoes(contrato(A,B,IdAda,D,E,F,G,Prazo,I,Data), (contrato(A,B,IdAda,D,E,F,G,Prazo,I,Data),
        contratoPerfeito(B,IdAda,D,E,F,G,Prazo,I,Data), nao(prazoExpirado(Data,Prazo))), Ativos).

% Contratos entre um certo adjudicante e uma adjudicataria
contratosEntreAdjudicanteAdjudicataria(IdAd,IdAda,Contratos) :-
    solucoes(contrato(A,IdAd,IdAda,D,E,F,G,H,I,J),
            (contrato(A,IdAd,IdAda,D,E,F,G,H,I,J),contratoPerfeito(IdAd,IdAda,D,E,F,G,H,I,J)), Contratos).

% Contratos de um certo tipo
contratosTipoContrato(Tipo,Contratos) :-
    solucoes(contrato(A,B,C,Tipo,E,F,G,H,I,J),
            (contrato(A,B,C,Tipo,E,F,G,H,I,J), contratoPerfeito(B,C,Tipo,E,F,G,H,I,J)), Contratos).

% Contratos com um certo tipo de procedimento
contratosTipoProcedimento(Procedimento,Contratos) :-
    solucoes(contrato(A,B,C,D,Procedimento,F,G,H,I,J),
            (contrato(A,B,C,D,Procedimento,F,G,H,I,J), contratoPerfeito(B,C,D,Procedimento,F,G,H,I,J)), Contratos).

% Contratos celebrados em dado ano
contratosAno(Ano,Contratos) :-
    solucoes(contrato(A,B,C,D,E,F,G,H,I,data(Ano,J,K)),
            (contrato(A,B,C,D,E,F,G,H,I,data(Ano,J,K)), contratoPerfeito(B,C,D,E,F,G,H,I,data(Ano,J,K))), Contratos).

% Contratos fechados num certo local
contratosLocal(Local,Contratos) :-
    solucoes(contrato(A,B,C,D,E,F,G,H,Local,J),
            (contrato(A,B,C,D,E,F,G,H,Local,J), contratoPerfeito(B,C,D,E,F,G,H,Local,J)), Contratos).

% Contratos com valor superior a um certo limite
contratosAcimaValor(Limite,Contratos) :-
    solucoes(contrato(A,B,C,D,E,F,Valor,H,I,J), (contrato(A,B,C,D,E,F,Valor,H,I,J),
        contratoPerfeito(B,C,D,E,F,Valor,H,I,J), Valor >= Limite), Contratos).

% Contratos com valor entre dois limites
contratosEntreValores(Inf,Sup,Contratos) :-
    solucoes(contrato(A,B,C,D,E,F,Valor,H,I,J), (contrato(A,B,C,D,E,F,Valor,H,I,J),
        contratoPerfeito(B,C,D,E,F,Valor,H,I,J), Valor >= Inf, Valor =< Sup), Contratos).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Conhecimento perfeito negativo

% Em conhecimento negativo, e possivel haver mais do que um predicado com o mesmo id, mas nao predicados repetidos

% ----- Adjudicantes -----

% Adjudicantes negativos por id
% Devido ao PMF, um dos matches so tem o id instanciado, nao existe de facto na base de conhecimento
adjudicanteNegId(IdAd,R) :-
    solucoes(-adjudicante(IdAd,Nome,NIF,Morada), (-adjudicante(IdAd,Nome,NIF,Morada), number(NIF)), R),
    nao(comprimento(R,0)).

% Adjudicantes negativos
adjudicantesNeg(Adjudicantes) :-
    solucoes(-adjudicante(IdAd,Nome,NIF,Morada), -adjudicante(IdAd,Nome,NIF,Morada), Adjudicantes).

% NIFS de adjudicantes negativos com os parametros dados
nifsAdjudicantesNeg((IdAd,Nome,Morada),NIFS) :-
    solucoes(NIF, (-adjudicante(IdAd,Nome,NIF,Morada), number(NIF)), NIFS).

% ----- Adjudicatarias -----

% Adjudicatarias negativas por id
adjudicatariaNegId(IdAda,R) :-
    solucoes(-adjudicataria(IdAda,Nome,NIF,Morada), (-adjudicataria(IdAda,Nome,NIF,Morada), number(NIF)), R),
    nao(comprimento(R,0)).

% Adjudicatarias negativas
adjudicatariasNeg(Adjudicatarias) :-
    solucoes(-adjudicataria(IdAda,Nome,NIF,Morada), -adjudicataria(IdAda,Nome,NIF,Morada), Adjudicatarias).

% NIFS de adjudicatarias negativos com os parametros dados
nifsAdjudicatariasNeg((IdAda,Nome,Morada),NIFS) :-
    solucoes(NIF, (-adjudicataria(IdAda,Nome,NIF,Morada), number(NIF)), NIFS).

% ----- Contratos -----

% Contratos negativos por id
contratoNegId(IdC,R) :-
    solucoes(-contrato(IdC,B,C,D,E,F,G,H,I,J), (-contrato(IdC,B,C,D,E,F,G,H,I,J), number(G)), R),
    nao(comprimento(R,0)).

% Contratos negativos
contratosNeg(Contratos) :-
    solucoes(-contrato(IdC,B,C,D,E,F,G,H,I,J), -contrato(IdC,B,C,D,E,F,G,H,I,J), Contratos).

% Valores de contratos negativos com os parametros dados
valoresContratosNeg((IdC,IdAd,IdAda,TC,TP,Desc,P,L,D),Valores) :-
    solucoes(Valor, (-contrato(IdC,IdAd,IdAda,TC,TP,Desc,Valor,P,L,D), number(Valor)), Valores).

% Prazos de contratos negativos com os parametros dados
prazosContratosNeg((IdC,IdAd,IdAda,TC,TP,Desc,V,L,D),Prazos) :-
    solucoes(Prazo, (-contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,Prazo,L,D), number(Prazo)), Prazos).

% Anos de contratos negativos com os parametros dados
anosContratosNeg((IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,M,D),Anos) :-
    solucoes(Ano, (-contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(Ano,M,D)), number(Ano)), Anos).

% Meses de contratos negativos com os parametros dados
mesesContratosNeg((IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,A,D),Meses) :-
    solucoes(Mes, (-contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(A,Mes,D)), number(Mes)), Meses).

% Dias de contratos negativos com os parametros dados
diasContratosNeg((IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,A,M),Dias) :-
    solucoes(Dia, (-contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(A,M,Dia)), number(Dia)), Dias).