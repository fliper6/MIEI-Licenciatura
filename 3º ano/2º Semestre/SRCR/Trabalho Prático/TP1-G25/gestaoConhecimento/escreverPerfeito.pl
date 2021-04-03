writeAdjudicantePos(Stream) :- adjudicante(IdAd,Nome,NIF,Morada),
        adjudiPerfeito(Nome,NIF,Morada),
        write(Stream, 'adjudicante('), write(Stream, IdAd), write(Stream, ',\''),
        write(Stream, Nome), write(Stream, '\','),
        write(Stream, NIF), write(Stream, ',\''),
        write(Stream, Morada), write(Stream, '\').\n'),
    fail; true.

writeAdjudicanteNeg(Stream) :- -adjudicante(IdAd,Nome,NIF,Morada),
        write(Stream, '-adjudicante('), write(Stream, IdAd), write(Stream, ',\''),
        write(Stream, Nome), write(Stream, '\','),
        write(Stream, NIF), write(Stream, ',\''),
        write(Stream, Morada), write(Stream, '\').\n'),
    fail; true.

writeAdjudicatariaPos(Stream) :- adjudicataria(IdAda,Nome,NIF,Morada),
        adjudiPerfeito(Nome,NIF,Morada),
        write(Stream, 'adjudicataria('), write(Stream, IdAda), write(Stream, ',\''),
        write(Stream, Nome), write(Stream, '\','),
        write(Stream, NIF), write(Stream, ',\''),
        write(Stream, Morada), write(Stream, '\').\n'),
    fail; true.

writeAdjudicatariaNeg(Stream) :- -adjudicataria(IdAda,Nome,NIF,Morada),
        write(Stream, '-adjudicataria('), write(Stream, IdAda), write(Stream, ',\''),
        write(Stream, Nome), write(Stream, '\','),
        write(Stream, NIF), write(Stream, ',\''),
        write(Stream, Morada), write(Stream, '\').\n'),
    fail; true.

writeContratoPos(Stream) :- contrato(IdC,IdAd,IdAda,TipoContrato,TipoProcedimento,Descricao,Valor,Prazo,Local,Data),
        contratoPerfeito(IdAd,IdAda,TipoContrato,TipoProcedimento,Descricao,Valor,Prazo,Local,Data),
        write(Stream, 'contrato('), write(Stream, IdC), write(Stream, ','),
        write(Stream, IdAd), write(Stream, ','),
        write(Stream, IdAda), write(Stream, ',\''),
        write(Stream, TipoContrato), write(Stream, '\',\''),
        write(Stream, TipoProcedimento), write(Stream, '\',\''),
        write(Stream, Descricao), write(Stream, '\','),
        write(Stream, Valor), write(Stream, ','),
        write(Stream, Prazo), write(Stream, ',\''),
        write(Stream, Local), write(Stream, '\','),
        write(Stream, Data), write(Stream, ').\n'),
    fail; true.

writeContratoNeg(Stream) :- -contrato(IdC,IdAd,IdAda,TipoContrato,TipoProcedimento,Descricao,Valor,Prazo,Local,Data),
        write(Stream, '-contrato('), write(Stream, IdC), write(Stream, ','),
        write(Stream, IdAd), write(Stream, ','),
        write(Stream, IdAda), write(Stream, ',\''),
        write(Stream, TipoContrato), write(Stream, '\',\''),
        write(Stream, TipoProcedimento), write(Stream, '\',\''),
        write(Stream, Descricao), write(Stream, '\','),
        write(Stream, Valor), write(Stream, ','),
        write(Stream, Prazo), write(Stream, ',\''),
        write(Stream, Local), write(Stream, '\','),
        write(Stream, Data), write(Stream, ').\n'),
        fail; true.

escreverPerfeito :-
    open('conhecimento/perfeito.pl', write, Stream),

    write(Stream, '%--------------------------------- - - - - - - - - - -  -  -  -  -   -\n'),
    write(Stream, '% Conhecimento perfeito positivo\n'),
    write(Stream, '\n% Adjudicante: #IdAd, Nome, NIF, Morada\n'),
    writeAdjudicantePos(Stream),
    write(Stream, '\n% Adjudicataria: #IdAda, Nome, NIF, Morada\n'),
    writeAdjudicatariaPos(Stream),
    write(Stream, '\n% Contrato: #IdC, #IdAd, #IdAda, Tipo, Procedimento, Descricao, Valor, Prazo, Local, Data\n'),
    writeContratoPos(Stream),

    write(Stream, '\n\n%--------------------------------- - - - - - - - - - -  -  -  -  -   -\n'),
    write(Stream, '% Conhecimento perfeito negativo\n'),
    write(Stream, '\n% Adjudicante: #IdAd, Nome, NIF, Morada\n'),
    writeAdjudicanteNeg(Stream),
    write(Stream, '\n% Adjudicataria: #IdAda, Nome, NIF, Morada\n'),
    writeAdjudicatariaNeg(Stream),
    write(Stream, '\n% Contrato: #IdC, #IdAd, #IdAda, Tipo, Procedimento, Descricao, Valor, Prazo, Local, Data\n'),
    writeContratoNeg(Stream),
    
    close(Stream).