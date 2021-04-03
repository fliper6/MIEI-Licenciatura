%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Funcoes exclusivamente sobre datas

% Extrai um elemento da data
elementoData(data(A,_,_),ano,A).
elementoData(data(_,M,_),mes,M).
elementoData(data(_,_,D),dia,D).

% Calcula o prazo de um contrato
calculaPrazo(A,M,D,0,data(A,M,D)).

calculaPrazo(A,M,D,P,R) :-
    pertence(M,[1,3,5,7,8,10]), NovoPrazo is P-(31-D+1), NovoPrazo >= 0, NovoMes is M+1, calculaPrazo(A,NovoMes,1, NovoPrazo, R).
calculaPrazo(A,M,D,P,R) :- pertence(M,[1,3,5,7,8,10]), NovoDia is D+P, calculaPrazo(A,M,NovoDia, 0, R).

calculaPrazo(A,M,D,P,R) :-
    pertence(M,[4,6,9,11]), NovoPrazo is P-(30-D+1), NovoPrazo >= 0, NovoMes is M+1, calculaPrazo(A,NovoMes,1, NovoPrazo, R).
calculaPrazo(A,M,D,P,R) :- pertence(M,[4,6,9,11]), NovoDia is D+P, calculaPrazo(A,M,NovoDia, 0, R).

calculaPrazo(A,M,D,P,R) :-
    M =:= 12, NovoPrazo is P-(31-D+1), NovoPrazo >= 0, NovoAno is A+1, calculaPrazo(NovoAno,1,1, NovoPrazo, R).
calculaPrazo(A,M,D,P,R) :- M =:= 12, NovoDia is D+P, calculaPrazo(A,M,NovoDia, 0, R).

calculaPrazo(A,M,D,P,R) :-
    M =:= 2, mod(A,4) =:= 0, NovoPrazo is P-(29-D+1), NovoPrazo >= 0, calculaPrazo(A,3,1, NovoPrazo, R).
calculaPrazo(A,M,D,P,R) :- M =:= 2, mod(A,4) =:= 0, NovoDia is D+P, calculaPrazo(A,M,NovoDia, 0, R).

calculaPrazo(A,M,D,P,R) :-
    M =:= 2, NovoPrazo is P-(28-D+1), NovoPrazo >= 0, calculaPrazo(A,3,1, NovoPrazo, R).
calculaPrazo(A,M,D,P,R) :- M =:= 2, NovoDia is D+P, calculaPrazo(A,M,NovoDia, 0, R).

% Verifica se a segunda data e anterior a primeira
comparaDatas(datime(AH,MH,DH,_,_,_),data(AP,MP,DP)) :-
    AP < AH;
    (AP =:= AH, (MP < MH;
                (MP =:= MH, DP < DH))).

% Verifica se uma data e valida
dataValida(data(A,M,D)) :-
    (pertence(M,[1,3,5,7,8,10,12]), D >= 1, D =< 31);
    (pertence(M,[4,6,9,11]), D >= 1, D =< 30);
    (M =:= 2, (mod(A,4) =:= 0, D >= 1, D =< 29);
                              (D >= 1, D =< 28)).

% Verifica se um contrato ainda esta em vigor
prazoExpirado(data(A,M,D), P) :-
    calculaPrazo(A,M,D,P,Prazo),
    datime(Hoje), !,
    comparaDatas(Hoje,Prazo).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Outros predicados auxiliares para os invariantes

% Verifica se o NIF dado pertence a um predicado de conhecimento perfeito
nifImperfeito(NIF) :- NIF = nifIncerto; NIF = nifInterdito.

% Verifica se o id de adjudicante dado pertence a um predicado de conhecimento perfeito
idAdImperfeito(IdAd) :- IdAd = idAdIncerto; IdAd = idAdInterdito.

% Verifica se o id de adjudicataria dado pertence a um predicado de conhecimento perfeito
idAdaImperfeito(IdAda) :- IdAda = idAdaIncerto; IdAda = idAdaInterdito.

% Verifica se o valor dado pertence a um predicado de conhecimento perfeito
valorImperfeito(V) :- V = valorIncerto; V = valorInterdito.

% Verifica se o prazo dado pertence a um predicado de conhecimento perfeito
prazoImperfeito(P) :- P = prazoIncerto; P = prazoInterdito.

% Verifica se o tipo de contrato dado pertence a um predicado de conhecimento perfeito
tipoImperfeito(TC) :- TC = tipoIncerto; TC = tipoInterdito.

% Verifica se o tipo de procedimento dado pertence a um predicado de conhecimento perfeito
procedimentoImperfeito(TP) :- TP = procedimentoIncerto; TP = procedimentoInterdito.

% Verifica se a data dada pertence a um predicado de conhecimento perfeito
dataImperfeita(D) :- D = dataIncerta; D = dataInterdita.

% Verifica os parametros de um adjudicante/adjudicataria para averiguar se e conhecimento perfeito
adjudiPerfeito(Nome,NIF,Morada) :-
    Nome \= nomeIncerto, Nome \= nomeInterdito,
    NIF \= nifIncerto, NIF \= nifInterdito,
    Morada \= moradaIncerta, Morada \= moradaInterdita.

% Verifica os parametros de um contrato para averiguar se e conhecimento perfeito
contratoPerfeito(IdAd,IdAda,TipoContrato,TipoProcedimento,Descricao,Valor,Prazo,Local,Data) :-
    IdAd \= idAdIncerto, IdAd \= idAdInterdito,
    IdAda \= idAdaIncerto, IdAda \= idAdaInterdito,
    TipoContrato \= tipoIncerto, TipoContrato \= tipoInterdito,
    TipoProcedimento \= procedimentoIncerto, TipoProcedimento \= procedimentoInterdito,
    Descricao \= descricaoIncerta, Descricao \= descricaoInterdita,
    Valor \= valorIncerto, Valor \= valorInterdito,
    Prazo \= prazoIncerto, Prazo \= prazoInterdito,
    Local \= localIncerto, Local \= localInterdito,
    Data \= dataIncerta, Data \= dataInterdita.

% Usado ao inserir conhecimento incerto ou interdito, verifica se a excecao que se deve inserir ja existe na
% base de conhecimento ou nao; se existir, o demo da desconhecido, senao da falso
existeExcecaoAdjudi(IdAd,N,NIF,M) :-
    ((N = nomeIncerto; N = nomeInterdito), demo(adjudicante(IdAd,teste,NIF,M), desconhecido));
    ((NIF = nifIncerto; NIF = nifIncerto), demo(adjudicante(IdAd,N,teste,M), desconhecido));
    ((M = moradaIncerta; M = moradaIncerta), demo(adjudicante(IdAd,N,NIF,teste), desconhecido)).

% Usado ao inserir conhecimento incerto ou interdito, verifica se a excecao que se deve inserir ja existe na
% base de conhecimento ou nao; se existir, o demo da desconhecido, senao da falso
existeExcecaoContrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,D) :-
    ((IdAd = idAdIncerto; IdAd = idAdInterdito), demo(contrato(IdC,teste,IdAda,TC,TP,Desc,V,P,L,D), desconhecido));
    ((IdAda = idAdaIncerto; IdAda = idAdaInterdito), demo(contrato(IdC,IdAd,teste,TC,TP,Desc,V,P,L,D), desconhecido));
    ((TC = tipoIncerto; TC = tipoInterdito), demo(contrato(IdC,IdAd,IdAda,teste,TP,Desc,V,P,L,D), desconhecido));
    ((TP = procedimentoIncerto; TP = procedimentoInterdito), demo(contrato(IdC,IdAd,IdAda,TC,teste,Desc,V,P,L,D), desconhecido));
    ((Desc = descricaoIncerta; Desc = descricaoInterdita), demo(contrato(IdC,IdAd,IdAda,TC,TP,teste,V,P,L,D), desconhecido));
    ((V = valorIncerto; V = valorInterdito), demo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,teste,P,L,D), desconhecido));
    ((P = prazoIncerto; P = prazoInterdito), demo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,teste,L,D), desconhecido));
    ((L = localIncerto; L = localInterdito), demo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,teste,D), desconhecido));
    ((D = dataIncerta; D = dataInterdita), demo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,teste), desconhecido)).

% NIF valido
nifValido(NIF) :- number(NIF), NIF >= 100000000, NIF =< 999999999.

% Numero >= 0
numeroValido(N) :- number(N), N >= 0.

% Tipo de procedimento valido
tipoProcedimento('Ajuste Direto').
tipoProcedimento('Consulta Previa').
tipoProcedimento('Concurso Publico').

% Tipo de contrato valido por ajuste direto
tipoContratoAjusteDireto('Aquisicao').
tipoContratoAjusteDireto('Locacao de Bens Moveis').
tipoContratoAjusteDireto('Aquisicao de Servicos').

% Valor acumulado dos contratos celebrados no ano da data D ou nos dois anteriores
valorAcumulado([],0).
valorAcumulado([V|T],R) :- valorAcumulado(T,R1), R is R1+V.

% Verifica quantos valores do intervalo estao entre os limites dados
entreLimites([],_,_,0).
entreLimites([X|T], Inf, Sup, N) :-
    X >= Inf, X =< Sup, entreLimites(T,Inf,Sup,N1), N is N1+1.
entreLimites([_|T], Inf, Sup, N) :-
    entreLimites(T,Inf,Sup,N).

% Verifica se algum dos termos contidos no intervalo nao e negativo
intervaloNaoTodoNegativo(adjudicante(IdAd,N,(Inf,Sup),M)) :-
    nifsAdjudicantesNeg((IdAd,N,M),NIFS),
    Maximo is Sup-Inf+1,
    nao(entreLimites(NIFS,Inf,Sup,Maximo)).

intervaloNaoTodoNegativo(adjudicataria(IdAda,N,(Inf,Sup),M)) :-
    nifsAdjudicatariasNeg((IdAda,N,M),NIFS),
    Maximo is Sup-Inf+1,
    nao(entreLimites(NIFS,Inf,Sup,Maximo)).

intervaloNaoTodoNegativo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,(Inf,Sup),P,L,D)) :-
    valoresContratosNeg((IdC,IdAd,IdAda,TC,TP,Desc,P,L,D),Valores),
    Maximo is Sup-Inf+1,
    nao(entreLimites(Valores,Inf,Sup,Maximo)).

intervaloNaoTodoNegativo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,(Inf,Sup),L,D)) :-
    prazosContratosNeg((IdC,IdAd,IdAda,TC,TP,Desc,V,L,D),Prazos),
    Maximo is Sup-Inf+1,
    nao(entreLimites(Prazos,Inf,Sup,Maximo)).

intervaloNaoTodoNegativo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data((Inf,Sup),M,D))) :-
    anosContratosNeg((IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,M,D),Anos),
    Maximo is Sup-Inf+1,
    nao(entreLimites(Anos,Inf,Sup,Maximo)).

intervaloNaoTodoNegativo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(A,(Inf,Sup),D))) :-
    mesesContratosNeg((IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,A,D),Meses),
    Maximo is Sup-Inf+1,
    nao(entreLimites(Meses,Inf,Sup,Maximo)).

intervaloNaoTodoNegativo(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(A,M,(Inf,Sup)))) :-
    diasContratosNeg((IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,A,M),Dias),
    Maximo is Sup-Inf+1,
    nao(entreLimites(Dias,Inf,Sup,Maximo)).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Predicados auxiliares para identificacoes

% Adiciona adjudicante de cada contrato a lista resultado - pode ter repetidos
listaAdjudicantesComRepetidos([],[]).
listaAdjudicantesComRepetidos([contrato(_,IdAd,_,_,_,_,_,_,_,_)|T],[Adjudicante|R]) :-
    adjudicanteId(IdAd,Adjudicante),
    listaAdjudicantesComRepetidos(T,R).

% Retorna lista dos adjudicantes que participaram nos contratos em questao, sem repetidos
adjudicantesDosContratos(Contratos,Adjudicantes) :-
    listaAdjudicantesComRepetidos(Contratos,ListaRepetidos),
    eliminaRepetidos(ListaRepetidos,Adjudicantes).

% Adiciona adjudicataria de cada contrato a lista resultado - pode ter repetidos
listaAdjudicatariasComRepetidos([],[]).
listaAdjudicatariasComRepetidos([contrato(_,_,IdAda,_,_,_,_,_,_,_)|T],[Adjudicataria|R]) :-
    adjudicatariaId(IdAda,Adjudicataria),
    listaAdjudicatariasComRepetidos(T,R).

% Retorna lista dos adjudicatarias que participaram nos contratos em questao, sem repetidos
adjudicatariasDosContratos(Contratos,Adjudicatarias) :-
    listaAdjudicatariasComRepetidos(Contratos,ListaRepetidos),
    eliminaRepetidos(ListaRepetidos,Adjudicatarias).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Predicados auxiliares a gestao de conhecimento
    
insercao( Termo ) :- assert( Termo ). % o assert insere o termo na base de conhecimento
insercao( Termo ) :- retract( Termo ), !,fail. % se nao o conseguir inserir direito, tem de o remover
            
remocao( Termo ) :- retract( Termo ).
remocao( Termo ) :- assert( Termo ),!,fail.

teste( [] ).
teste( [R|LR] ) :-  % verifica se todos os testes ao invariante sao positivos
    R,   
    teste( LR ).

% Testar conhecimento {V,F,D}
demo(Questao,verdadeiro) :- Questao.
demo(Questao,falso) :- -Questao.
demo(Questao,desconhecido) :- nao(Questao), nao(-Questao).

% Extensao do meta-predicado nao: Questao -> {V,F}
nao( Questao ) :- Questao, !, fail.
nao( _ ).

solucoes( X,Y,Z ) :- findall( X,Y,Z ).

% Comprimento de uma lista
comprimento(S,N) :- length(S,N).

% Verifica se um elemento pertence a uma lista
pertence(X,[X|_]).
pertence(X,[_|T]) :- pertence(X,T).

% Conta o numero de elementos diferentes numa lista
diferentes([],0).
diferentes([H|T],N) :- pertence(H,T), diferentes(T,N).
diferentes([H|T],N) :- diferentes(T,N1), N is N1+1.

% Elimina os elementos repetidos numa lista
eliminaRepetidos(L,R) :- eliminaRepAux(L,[],R).

eliminaRepAux([],Temp,Temp).
eliminaRepAux([H|T],Temp,R) :- pertence(H,Temp), eliminaRepAux(T,Temp,R).
eliminaRepAux([H|T],Temp,R) :- eliminaRepAux(T,[H|Temp],R).