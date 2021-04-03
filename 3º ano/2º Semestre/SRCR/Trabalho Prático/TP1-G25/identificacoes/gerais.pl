%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes gerais a conhecimento nao negativo

% Adjudicante por id
adjudicanteId(IdAd,Adjudicante) :-
    solucoes(adjudicante(IdAd,Nome,NIF,Morada), adjudicante(IdAd,Nome,NIF,Morada), [Adjudicante|_]).

% Adjudicataria por id
adjudicatariaId(IdAda,Adjudicataria) :-
    solucoes(adjudicataria(IdAda,Nome,NIF,Morada), adjudicataria(IdAda,Nome,NIF,Morada), [Adjudicataria|_]).

% Contrato por id
contratoId(IdC,Contrato) :-
    solucoes(contrato(IdC,B,C,D,E,F,G,H,I,J), contrato(IdC,B,C,D,E,F,G,H,I,J), [Contrato|_]).