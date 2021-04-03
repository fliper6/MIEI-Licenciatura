%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

% Sistema de representação de conhecimento e raciocínio com capacidade
% para caracterizar um universo de discurso na área da contratação pública
% para a realização de contratos para a prestação de serviços

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:- op(900,xfy,'::').

:- dynamic (::)/2. % Tornar possivel a insercao de invariantes no caso de conhecimento interdito
:- dynamic '-'/1.
:- dynamic adjudicante/4. % idAdjudicante,Nome,NIF,Morada -> {V,F,D}
:- dynamic adjudicataria/4. % idAdjudicataria,Nome,NIF,Morada -> {V,F,D}
:- dynamic contrato/10. % idContrato,idAdjudicante,idAdjudicataria,TipoContrato,TipoProcedimento,Descricao,Valor,Prazo,Local,Data -> {V,F,D}
:- dynamic intervalo/4. % nomePredicado,id,nomeParametroImpreciso,(limiteInf,limiteSup)
:- dynamic excecao/1.
:- dynamic nuloInterdito/1.
    
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Carregar predicados de ficheiros auxiliares
:- include('invariantes.pl').
:- include('funcAux.pl').

:- include('identificacoes/gerais.pl').
:- include('identificacoes/perfeito.pl').
:- include('identificacoes/imperfeito.pl').

:- include('gestaoConhecimento/perfeito.pl').
:- include('gestaoConhecimento/escreverPerfeito.pl').
:- include('gestaoConhecimento/imperfeitoImpreciso.pl').
:- include('gestaoConhecimento/imperfeitoIncerto.pl').
:- include('gestaoConhecimento/imperfeitoInterdito.pl').

:- include('conhecimento/perfeito.pl').
:- include('conhecimento/imperfeito.pl').

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Modulo para obter a data atual
:- use_module(library(system)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ADICIONAR CONHECIMENTO

% ----- Perfeito ----
% O primeiro argumento deve indicar se o conhecimento e positivo ou negativo

inserirAdjudicante(pos,(IdAd,N,NIF,M)) :- evolucaoPos(adjudicante(IdAd,N,NIF,M)).
inserirAdjudicante(neg,(IdAd,N,NIF,M)) :- evolucaoNeg(adjudicante(IdAd,N,NIF,M)).

inserirAdjudicataria(pos,(IdAda,N,NIF,M)) :- evolucaoPos(adjudicataria(IdAda,N,NIF,M)).
inserirAdjudicataria(neg,(IdAda,N,NIF,M)) :- evolucaoNeg(adjudicataria(IdAda,N,NIF,M)).

inserirContrato(pos,(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,D)) :- evolucaoPos(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,D)).
inserirContrato(neg,(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,D)) :- evolucaoNeg(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,D)).

% ----- Imperfeito Incerto ----
% Deve usar as keywords abaixo correspondentes ao parametro incerto que se pretende inserir, caso contrario nao funcionara

inserirAdjudicante(IdAd,nomeIncerto,NIF,M) :- evolucao(adjudicante(IdAd,nomeIncerto,NIF,M)).
inserirAdjudicante(IdAd,N,nifIncerto,M) :- evolucao(adjudicante(IdAd,N,nifIncerto,M)).
inserirAdjudicante(IdAd,N,NIF,moradaIncerta) :- evolucao(adjudicante(IdAd,N,NIF,moradaIncerta)).

inserirAdjudicataria(IdAda,nomeIncerto,NIF,M) :- evolucao(adjudicataria(IdAda,nomeIncerto,NIF,M)).
inserirAdjudicataria(IdAda,N,nifIncerto,M) :- evolucao(adjudicataria(IdAda,N,nifIncerto,M)).
inserirAdjudicataria(IdAda,N,NIF,moradaIncerta) :- evolucao(adjudicataria(IdAda,N,NIF,moradaIncerta)).

inserirContrato(IdC,idAdIncerto,IdAda,TC,TP,Desc,V,P,L,D) :- evolucao(contrato(IdC,idAdIncerto,IdAda,TC,TP,Desc,V,P,L,D)).
inserirContrato(IdC,IdAd,idAdaIncerto,TC,TP,Desc,V,P,L,D) :- evolucao(contrato(IdC,IdAd,idAdaIncerto,TC,TP,Desc,V,P,L,D)).
inserirContrato(IdC,IdAd,IdAda,tipoIncerto,TP,Desc,V,P,L,D) :- evolucao(contrato(IdC,IdAd,IdAda,tipoIncerto,TP,Desc,V,P,L,D)).
inserirContrato(IdC,IdAd,IdAda,TC,procedimentoIncerto,Desc,V,P,L,D) :- evolucao(contrato(IdC,IdAd,IdAda,TC,procedimentoIncerto,Desc,V,P,L,D)).
inserirContrato(IdC,IdAd,IdAda,TC,TP,descricaoIncerta,V,P,L,D) :- evolucao(contrato(IdC,IdAd,IdAda,TC,TP,descricaoIncerta,V,P,L,D)).
inserirContrato(IdC,IdAd,IdAda,TC,TP,Desc,valorIncerto,P,L,D) :- evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,valorIncerto,P,L,D)).
inserirContrato(IdC,IdAd,IdAda,TC,TP,Desc,V,prazoIncerto,L,D) :- evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,prazoIncerto,L,D)).
inserirContrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,localIncerto,D) :- evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,localIncerto,D)).
inserirContrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,dataIncerta) :- evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,dataIncerta)).

% ----- Imperfeito Impreciso ----

% Predicados completos que constituem conhecimento impreciso
inserirAdjudicante(impreciso,(IdAd,N,NIF,M)) :- evolucaoImprecisoExplicito(adjudicante(IdAd,N,NIF,M)).
inserirAdjudicataria(impreciso,(IdAda,N,NIF,M)) :- evolucaoImprecisoExplicito(adjudicataria(IdAda,N,NIF,M)).
inserirContrato(impreciso,(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,D)) :- evolucaoImprecisoExplicito(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,D)).

% Predicados que possuem parametros entre certos valores
% Adjudicante - NIF
inserirAdjudicante(IdAd,N,(Inf,Sup),M) :- evolucao(adjudicante(IdAd,N,(Inf,Sup),M)).
% Adjudicataria - NIF
inserirAdjudicataria(IdAda,N,(Inf,Sup),M) :- evolucao(adjudicataria(IdAda,N,(Inf,Sup),M)).
% Contrato - Valor
inserirContrato(IdC,IdAd,IdAda,TC,TP,Desc,(Inf,Sup),P,L,D) :- evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,(Inf,Sup),P,L,D)).
% Contrato - Prazo
inserirContrato(IdC,IdAd,IdAda,TC,TP,Desc,V,(Inf,Sup),L,D) :- evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,(Inf,Sup),L,D)).
% Contrato - Ano da data
inserirContrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,(data((Inf,Sup),Mes,Dia))) :- evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data((Inf,Sup),Mes,Dia))).
% Contrato - Mes da data
inserirContrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,(data(Ano,(Inf,Sup),Dia))) :- evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(Ano,(Inf,Sup),Dia))).
% Contrato - Dia da data
inserirContrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,(data(Ano,Mes,(Inf,Sup)))) :- evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,data(Ano,Mes,(Inf,Sup)))).

% ----- Imperfeito Interdito ----
% Deve usar as keywords abaixo correspondentes ao parametro interdito que se pretende inserir

inserirAdjudicante(IdAd,nomeInterdito,NIF,M) :- evolucao(adjudicante(IdAd,nomeInterdito,NIF,M)).
inserirAdjudicante(IdAd,N,nifInterdito,M) :- evolucao(adjudicante(IdAd,N,nifInterdito,M)).
inserirAdjudicante(IdAd,N,NIF,moradaInterdita) :- evolucao(adjudicante(IdAd,N,NIF,moradaInterdita)).

inserirAdjudicataria(IdAda,nomeInterdito,NIF,M) :- evolucao(adjudicataria(IdAda,nomeInterdito,NIF,M)).
inserirAdjudicataria(IdAda,N,nifInterdito,M) :- evolucao(adjudicataria(IdAda,N,nifInterdito,M)).
inserirAdjudicataria(IdAda,N,NIF,moradaInterdita) :- evolucao(adjudicataria(IdAda,N,NIF,moradaInterdita)).

inserirContrato(IdC,idAdInterdito,IdAda,TC,TP,Desc,V,P,L,D) :- evolucao(contrato(IdC,idAdInterdito,IdAda,TC,TP,Desc,V,P,L,D)).
inserirContrato(IdC,IdAd,idAdaInterdito,TC,TP,Desc,V,P,L,D) :- evolucao(contrato(IdC,IdAd,idAdaInterdito,TC,TP,Desc,V,P,L,D)).
inserirContrato(IdC,IdAd,IdAda,tipoInterdito,TP,Desc,V,P,L,D) :- evolucao(contrato(IdC,IdAd,IdAda,tipoInterdito,TP,Desc,V,P,L,D)).
inserirContrato(IdC,IdAd,IdAda,TC,procedimentoInterdito,Desc,V,P,L,D) :- evolucao(contrato(IdC,IdAd,IdAda,TC,procedimentoInterdito,Desc,V,P,L,D)).
inserirContrato(IdC,IdAd,IdAda,TC,TP,descricaoInterdita,V,P,L,D) :- evolucao(contrato(IdC,IdAd,IdAda,TC,TP,descricaoInterdita,V,P,L,D)).
inserirContrato(IdC,IdAd,IdAda,TC,TP,Desc,valorInterdito,P,L,D) :- evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,valorInterdito,P,L,D)).
inserirContrato(IdC,IdAd,IdAda,TC,TP,Desc,V,prazoInterdito,L,D) :- evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,prazoInterdito,L,D)).
inserirContrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,localInterdito,D) :- evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,localInterdito,D)).
inserirContrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,dataInterdita) :- evolucao(contrato(IdC,IdAd,IdAda,TC,TP,Desc,V,P,L,dataInterdita)).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% REMOVER CONHECIMENTO

% ----- Perfeito ----
% O primeiro argumento deve indicar se o conhecimento e positivo ou negativo

removerAdjudicante(pos,IdAd) :- adjudicanteId(IdAd,Adjudicante), involucaoPos(Adjudicante).
removerAdjudicante(neg,IdAd) :- adjudicanteNegId(IdAd,Lista), involucaoListaNeg(Lista).

removerAdjudicataria(pos,IdAda) :- adjudicatariaId(IdAda,Adjudicataria), involucaoPos(Adjudicataria).
removerAdjudicataria(neg,IdAda) :- adjudicatariaNegId(IdAda,Lista), involucaoListaNeg(Lista).

removerContrato(pos,IdC) :- contratoId(IdC,Contrato), involucaoPos(Contrato).
removerContrato(neg,IdC) :- contratoNegId(IdC,Lista), involucaoListaNeg(Lista).

% ----- Imperfeito Incerto ----
% Deve usar as keywords abaixo correspondentes ao parametro incerto que se pretende remover, caso contrario nao funcionara

removerAdjudicante(nomeIncerto,IdAd) :- adjudicanteId(IdAd,Adjudicante), involucao(Adjudicante).
removerAdjudicante(nifIncerto,IdAd) :- adjudicanteId(IdAd,Adjudicante), involucao(Adjudicante).
removerAdjudicante(moradaIncerta,IdAd) :- adjudicanteId(IdAd,Adjudicante), involucao(Adjudicante).

removerAdjudicataria(nomeIncerto,IdAda) :- adjudicatariaId(IdAda,Adjudicataria), involucao(Adjudicataria).
removerAdjudicataria(nifIncerto,IdAda) :- adjudicatariaId(IdAda,Adjudicataria), involucao(Adjudicataria).
removerAdjudicataria(moradaIncerta,IdAda) :- adjudicatariaId(IdAda,Adjudicataria), involucao(Adjudicataria).

removerContrato(idAdIncerto,IdC) :- contratoId(IdC,Contrato), involucao(Contrato).
removerContrato(idAdaIncerto,IdC) :- contratoId(IdC,Contrato), involucao(Contrato).
removerContrato(tipoIncerto,IdC) :- contratoId(IdC,Contrato), involucao(Contrato).
removerContrato(procedimentoIncerto,IdC) :- contratoId(IdC,Contrato), involucao(Contrato).
removerContrato(descricaoIncerta,IdC) :- contratoId(IdC,Contrato), involucao(Contrato).
removerContrato(valorIncerto,IdC) :- contratoId(IdC,Contrato), involucao(Contrato).
removerContrato(prazoIncerto,IdC) :- contratoId(IdC,Contrato), involucao(Contrato).
removerContrato(localIncerto,IdC) :- contratoId(IdC,Contrato), involucao(Contrato).
removerContrato(dataIncerta,IdC) :- contratoId(IdC,Contrato), involucao(Contrato).

% ----- Imperfeito Impreciso ----

% Predicados completos que constituem conhecimento impreciso
removerAdjudicante(imprecisoExplicito,IdAd) :- adjudicantesImprecisosExplicitosId(IdAd,Lista), involucaoImprecisoExplicito(Lista).
removerAdjudicataria(imprecisoExplicito,IdAda) :- adjudicatariasImprecisasExplicitosId(IdAda,Lista), involucaoImprecisoExplicito(Lista).
removerContrato(imprecisoExplicito,IdC) :- contratosImprecisosExplicitosId(IdC,Lista), involucaoImprecisoExplicito(Lista).

% Predicados que possuem parametros entre certos valores
removerAdjudicante(imprecisoImplicito,IdAd) :- intervaloImprecisoId(adjudicante,IdAd,Intervalo), involucao(Intervalo).
removerAdjudicataria(imprecisoImplicito,IdAda) :- intervaloImprecisoId(adjudicataria,IdAda,Intervalo), involucao(Intervalo).
removerContrato(imprecisoImplicito,IdC) :- intervaloImprecisoId(contrato,IdC,Intervalo), involucao(Intervalo).

% ----- Imperfeito Interdito ----
% Deve usar as keywords abaixo correspondentes ao parametro interdito que se pretende remover

removerAdjudicante(nomeInterdito,IdAd) :- adjudicanteId(IdAd,Adjudicante), involucao(Adjudicante).
removerAdjudicante(nifInterdito,IdAd) :- adjudicanteId(IdAd,Adjudicante), involucao(Adjudicante).
removerAdjudicante(moradaInterdita,IdAd) :- adjudicanteId(IdAd,Adjudicante), involucao(Adjudicante).

removerAdjudicataria(nomeInterdito,IdAda) :- adjudicatariaId(IdAda,Adjudicataria), involucao(Adjudicataria).
removerAdjudicataria(nifInterdito,IdAda) :- adjudicatariaId(IdAda,Adjudicataria), involucao(Adjudicataria).
removerAdjudicataria(moradaInterdita,IdAda) :- adjudicatariaId(IdAda,Adjudicataria), involucao(Adjudicataria).

removerContrato(idAdInterdito,IdC) :- contratoId(IdC,Contrato), involucao(Contrato).
removerContrato(idAdaInterdito,IdC) :- contratoId(IdC,Contrato), involucao(Contrato).
removerContrato(tipoInterdito,IdC) :- contratoId(IdC,Contrato), involucao(Contrato).
removerContrato(procedimentoInterdito,IdC) :- contratoId(IdC,Contrato), involucao(Contrato).
removerContrato(descricaoInterdita,IdC) :- contratoId(IdC,Contrato), involucao(Contrato).
removerContrato(valorInterdito,IdC) :- contratoId(IdC,Contrato), involucao(Contrato).
removerContrato(prazoInterdito,IdC) :- contratoId(IdC,Contrato), involucao(Contrato).
removerContrato(localInterdito,IdC) :- contratoId(IdC,Contrato), involucao(Contrato).
removerContrato(dataInterdita,IdC) :- contratoId(IdC,Contrato), involucao(Contrato).