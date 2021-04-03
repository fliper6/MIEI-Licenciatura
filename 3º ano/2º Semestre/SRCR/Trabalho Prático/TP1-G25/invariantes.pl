%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Predicados auxiliares

% Ve se o numero existente de adjudicantes com o id dado e N
solucoesAdjudicanteId(IdAd,N) :-
    solucoes(IdAd, adjudicante(IdAd,_,_,_), R),
    comprimento(R,N).

% Ve se o numero existente de adjudicantes e excecoes dos mesmos com o id dado e N
solucoesAdjudicanteExcecaoId(IdAd,N) :-
    solucoes(IdAd, (adjudicante(IdAd,_,_,_); excecao(adjudicante(IdAd,_,_,_))), R),
    comprimento(R,N).

% Ve se o numero existente de adjudicatarias com o id dado e N
solucoesAdjudicatariaId(IdAda,N) :-
    solucoes(IdAda, adjudicataria(IdAda,_,_,_), R),
    comprimento(R,N).

% Ve se o numero existente de adjudicatarias e excecoes das mesmas com o id dado e N
solucoesAdjudicatariaExcecaoId(IdAda,N) :-
    solucoes(IdAda, (adjudicataria(IdAda,_,_,_); excecao(adjudicataria(IdAda,_,_,_))), R),
    comprimento(R,N).

% Ve se o numero existente de contratos com o id dado e N
solucoesContratoId(IdC,N) :-
    solucoes(IdC, contrato(IdC,_,_,_,_,_,_,_,_,_), R),
    comprimento(R,N).

% Ve se o numero existente de contratos e excecoes dos mesmos com o id dado e N
solucoesContratoExcecaoId(IdC,N) :-
    solucoes(IdC, (contrato(IdC,_,_,_,_,_,_,_,_,_); excecao(contrato(IdC,_,_,_,_,_,_,_,_,_))), R),
    comprimento(R,N).

% Verifica que nao ha conhecimento impreciso implicito com o mesmo id
solucoesIntervaloId(Predicado,Id) :- nao(intervaloImprecisoId(Predicado,Id,_)).

% Nao pode existir um termo igual ao novo com sinal oposto
solucoesSinalContrario(X) :- solucoes(X,-X,R), comprimento(R,0).

% Nao pode existir uma excecao do termo que se pretende inserir
solucoesExcecao(X,N) :- solucoes(excecao(X),excecao(X),R), comprimento(R,N).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Conhecimento Positivo

% Informacao positiva nao pode contrariar informacao negativa existente
+(X,positivo) :: solucoesSinalContrario(X).

% Informacao positiva nao pode contrariar excecoes
+(X,positivo) :: solucoesExcecao(X,0).

% ----- Adjudicantes -----

% Id do adjudicante unico e intransponivel
+(adjudicante(IdAd,_,_,_),positivo) :: 
    (solucoesIntervaloId(adjudicante,IdAd), solucoesAdjudicanteExcecaoId(IdAd,1)).

% NIF valido, unico e intransponivel
+(adjudicante(_,_,NIF,_),naoNegativo) ::
    (nifImperfeito(NIF);
    (nifValido(NIF), solucoes(NIF, adjudicante(_,_,NIF,_), R), comprimento(R,1))).

% Nao e permitido remover adjudicantes com contratos associados
-(adjudicante(IdAd,_,_,_),positivo) ::
    (solucoes(IdAd, contrato(_,IdAd,_,_,_,_,_,_,_,_), R),
    comprimento(R,0)).


% ----- Adjudicatarias -----

% Id da adjudicataria unico e intransponivel
+(adjudicataria(IdAda,_,_,_),positivo) :: 
    (solucoesIntervaloId(adjudicataria,IdAda), solucoesAdjudicatariaExcecaoId(IdAda,1)).

% NIF valido, unico e intransponivel
+(adjudicataria(_,_,NIF,_),naoNegativo) ::
    (nifImperfeito(NIF);
    (nifValido(NIF), solucoes(NIF, adjudicataria(_,_,NIF,_), R), comprimento(R,1))).

% Nao e permitido remover adjudicatarias com contratos associados
-(adjudicataria(IdAda,_,_,_),positivo) ::
    (solucoes(IdAda, contrato(_,_,IdAda,_,_,_,_,_,_,_), R),
    comprimento(R,0)).


% ----- Contratos -----

% Id do contrato unico e intransponivel
+(contrato(IdC,_,_,_,_,_,_,_,_,_),positivo) :: 
    (solucoesIntervaloId(contrato,IdC), solucoesContratoExcecaoId(IdC,1)).

% Id do adjudicante associado valido
+(contrato(_,IdAd,_,_,_,_,_,_,_,_),naoNegativo) :: 
    (idAdImperfeito(IdAd); solucoesAdjudicanteId(IdAd,1)).

% Id da adjudicataria associado valido
+(contrato(_,_,IdAda,_,_,_,_,_,_,_),naoNegativo) :: 
    (idAdaImperfeito(IdAda); solucoesAdjudicatariaId(IdAda,1)).

% Valor valido
+(contrato(_,_,_,_,_,_,V,_,_,_),naoNegativo) :: 
    (valorImperfeito(V); numeroValido(V)).

% Prazo valido
+(contrato(_,_,_,_,_,_,_,P,_,_),naoNegativo) :: 
    (prazoImperfeito(P); numeroValido(P)).

% Tipo de procedimento valido
+(contrato(_,_,_,_,TP,_,_,_,_,_),naoNegativo) :: 
    (procedimentoImperfeito(TP); tipoProcedimento(TP)).

% Data valida
+(contrato(_,_,_,_,_,_,_,_,_,D),naoNegativo) :: 
    (dataImperfeita(D); dataValida(D)).

% Condicoes de contrato por ajuste direto
+(contrato(_,_,_,TC,'Ajuste Direto',_,V,P,_,_),naoNegativo) ::
    ((tipoImperfeito(TC); valorImperfeito(V); prazoImperfeito(P));
    (V =< 5000, P =< 365, tipoContratoAjusteDireto(TC))).

% Regra dos 3 anos valida para todos os contratos
+(contrato(IdC,IdAd,IdAda,TC,_,_,Valor,_,_,D),naoNegativo) ::
    ((idAdImperfeito(IdAd); idAdaImperfeito(IdAda); tipoImperfeito(TC); valorImperfeito(Valor); dataImperfeita(D));
    (elementoData(D,ano,Ano), DoisAnosAtras is Ano-2,
    solucoes(V, (contrato(Id,IdAd,IdAda,TC,_,_,V,_,_,data(A,_,_)),
        Id =\= IdC, A =< Ano, A >= DoisAnosAtras), R),
    valorAcumulado(R,Total), Total < 75000)).

% Não remover contratos vigentes
-(contrato(_,_,_,_,_,_,_,P,_,D),positivo) :: prazoExpirado(D,P).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Conhecimento Negativo

% Informacao negativa nao pode contrariar informacao positiva existente
+(-X,negativo) :: (solucoes(-X,X,R), comprimento(R,0)).

% Nao permitir adjudicantes negativos repetidos
+(-adjudicante(IdAd,_,_,_),negativo) :: 
    (adjudicanteNegId(IdAd,R), diferentes(R,D), comprimento(R,N), !, D=:=N).

% Nao permitir adjudicatarias negativas repetidas
+(-adjudicataria(IdAda,_,_,_),negativo) :: 
    (adjudicatariaNegId(IdAda,R), diferentes(R,D), comprimento(R,N), !, D=:=N).

% Nao permitir contratos negativos repetidos
+(-contrato(IdC,_,_,_,_,_,_,_,_,_),negativo) ::
    (contratoNegId(IdC,R), diferentes(R,D), comprimento(R,N), !, D=:=N).

% Nao inserir adjudicante negativo igual a conhecimento imperfeito ja existente
+(-adjudicante(IdAd,N,NIF,M),negativo) ::
    (nao(solucoesIntervaloId(adjudicante,IdAd));
    (solucoesExcecao(adjudicante(IdAd,N,NIF,M),0);
    adjudicanteId(IdAd,adjudicante(_,P2,P3,P4)), nao(adjudiPerfeito(P2,P3,P4)))).

% Nao inserir adjudicataria negativa igual a conhecimento imperfeito ja existente
+(-adjudicataria(IdAda,N,NIF,M),negativo) ::
    (nao(solucoesIntervaloId(adjudicataria,IdAda));
    (solucoesExcecao(adjudicataria(IdAda,N,NIF,M),0);
    adjudicatariaId(IdAda,adjudicataria(_,P2,P3,P4)), nao(adjudiPerfeito(P2,P3,P4)))).

% Nao inserir contrato negativo igual a conhecimento imperfeito ja existente
+(-contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,D),negativo) ::
    (nao(solucoesIntervaloId(contrato,IdC));
    (solucoesExcecao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,D),0);
    contrato(IdC,contrato(_,P2,P3,P4,P5,P6,P7,P8,P9,P10)), nao(adjudiPerfeito(P2,P3,P4,P5,P6,P7,P8,P9,P10)))).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Conhecimento Imperfeito Incerto/Interdito

% Id do adjudicante unico e intransponivel
+(adjudicante(IdAd,_,_,_),incertoInterdito) :: 
    (solucoesIntervaloId(adjudicante,IdAd), solucoesAdjudicanteId(IdAd,1)).

% Nao podem existir excecoes com o id do novo termo
% Se a excecao que e necessario inserir ja existir, o novo termo inserido ja e considerado desconhecido por isso
% a lista de excecoes com tal id deve ter 1 elemento; caso contrario ainda nao e desconhecido e a lista deve ser vazia
+(adjudicante(IdAd,N,NIF,M),incertoInterdito) ::
    (solucoes(IdAd, excecao(adjudicante(IdAd,_,_,_)), R), comprimento(R,Num),
    ((existeExcecaoAdjudi(IdAd,N,NIF,M), Num =:= 1); Num =:= 0)).

% Id da adjudicataria unico e intransponivel
+(adjudicataria(IdAda,_,_,_),incertoInterdito) :: 
    (solucoesIntervaloId(adjudicataria,IdAda), solucoesAdjudicatariaId(IdAda,1)).

% Nao podem existir excecoes com o id do novo termo
+(adjudicataria(IdAda,N,NIF,M),incertoInterdito) :: 
    (solucoes(IdAda, excecao(adjudicataria(IdAda,_,_,_)), R), comprimento(R,Num),
    ((existeExcecaoAdjudi(IdAda,N,NIF,M), Num =:= 1); Num =:= 0)).

% Id do contrato unico e intransponivel
+(contrato(IdC,_,_,_,_,_,_,_,_,_),incertoInterdito) :: 
    (solucoesIntervaloId(contrato,IdC), solucoesContratoId(IdC,1)).

% Nao podem existir excecoes com o id do novo termo
+(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,D),incertoInterdito) :: 
    (solucoes(IdC, excecao(contrato(IdC,_,_,_,_,_,_,_,_,_)), R), comprimento(R,Num),
    ((existeExcecaoContrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,D), Num =:= 1); Num =:= 0)).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Conhecimento Imperfeito Impreciso - Explicito (Alternativas)

% Id do adjudicante unico e intransponivel
+(excecao(adjudicante(IdAd,_,_,_)),imprecisoExplicito) :: 
    (solucoesIntervaloId(adjudicante,IdAd), solucoesAdjudicanteId(IdAd,1)).

% Id da adjudicataria unico e intransponivel
+(excecao(adjudicataria(IdAd,_,_,_)),imprecisoExplicito) :: 
    (solucoesIntervaloId(adjudicataria,IdAda), solucoesAdjudicatariaId(IdAda,1)).

% Id do contrato unico e intransponivel
+(excecao(contrato(IdC,_,_,_,_,_,_,_,_,_)),imprecisoExplicito) :: 
    (solucoesIntervaloId(contrato,dC), solucoesContratoId(IdC,1)).

% Nao pode ser igual a um termo negativo existente
+(excecao(X),imprecisoExplicito) :: solucoesSinalContrario(X).

% Nao ha excecoes repetidas
+(excecao(X),imprecisoExplicito) :: solucoesExcecao(X,1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Conhecimento Imperfeito Impreciso - Implicito (Intervalos)

% Id do adjudicante unico e intransponivel
+(excecao(adjudicante(IdAd,_,_,_)),imprecisoImplicito) :: 
    (solucoesIntervaloId(adjudicante,IdAd), solucoesAdjudicanteExcecaoId(IdAd,0)).

% Id da adjudicataria unico e intransponivel
+(excecao(adjudicataria(IdAda,_,_,_)),imprecisoImplicito) :: 
    (solucoesIntervaloId(adjudicataria,IdAda), solucoesAdjudicatariaExcecaoId(IdAda,0)).

% Id do contrato unico e intransponivel
+(excecao(contrato(IdC,_,_,_,_,_,_,_,_,_)),imprecisoImplicito) :: 
    (solucoesIntervaloId(contrato,IdC), solucoesContratoExcecaoId(IdC,0)).

% Adjudicante com intervalo valido de valores para o NIF
+(excecao(adjudicante(IdAd,N,(Inf,Sup),M)),imprecisoImplicito) :: 
    intervaloNaoTodoNegativo(adjudicante(IdAd,N,(Inf,Sup),M)).

% Adjudicataria com intervalo valido de valores para o NIF
+(excecao(adjudicataria(IdAda,N,(Inf,Sup),M)),imprecisoImplicito) :: 
    intervaloNaoTodoNegativo(adjudicataria(IdAda,N,(Inf,Sup),M)).

% Contrato com intervalo valido de valores para o valor
+(excecao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,(Inf,Sup),P,L,D)),imprecisoImplicito) ::
    intervaloNaoTodoNegativo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,(Inf,Sup),P,L,D)).

% Contrato com intervalo valido de valores para o prazo
+(excecao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,(Inf,Sup),L,D)),imprecisoImplicito) ::
    intervaloNaoTodoNegativo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,(Inf,Sup),L,D)).

% Contrato com intervalo valido de valores para o ano da data
+(excecao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data((Inf,Sup),M,D))),imprecisoImplicito) ::
    intervaloNaoTodoNegativo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data((Inf,Sup),M,D))).

% Contrato com intervalo valido de valores para o mes da data
+(excecao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(A,(Inf,Sup),D))),imprecisoImplicito) ::
    intervaloNaoTodoNegativo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(A,(Inf,Sup),D))).

% Contrato com intervalo valido de valores para o dia da data
+(excecao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(A,M,(Inf,Sup)))),imprecisoImplicito) ::
    intervaloNaoTodoNegativo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(A,M,(Inf,Sup)))).