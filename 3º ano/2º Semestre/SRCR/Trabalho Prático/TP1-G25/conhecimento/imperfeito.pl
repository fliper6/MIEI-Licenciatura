% -----------------------------------------------------------------------------------------------------------
% Representacao de Conhecimento Imperfeito

% -----------------------------------------------------------------------------------------------------------
% Conhecimento Imperfeito Incerto

% Entidade adjudicante
% Nao se sabe a morada da entidade adjudicante 'Municipio de Sintra', cujo ID e 20 e cujo NIF e 200000000.
adjudicante(20,'Municipio de Sintra',200000000,moradaIncerta).
% Nao se sabe o NIF da entidade adjudicante 'Municipio de Beja' com ID 21 localizada na 'Rua do Bastonario, 125'.
adjudicante(21,'Municipio de Beja',nifIncerto,'Rua do Bastonario, 125').
% Nao se sabe o nome da entidade adjudicante cujo ID e 22, com o NIF 220000000 e localizada em 'Vila Nova de Gaia, 167'.
adjudicante(22,nomeIncerto,220000000,'Vila Nova de Gaia, 167').

excecao(adjudicante(IdAd,Nome,Nif,Morada)) :- adjudicante(IdAd,Nome,Nif,moradaIncerta).
excecao(adjudicante(IdAd,Nome,Nif,Morada)) :- adjudicante(IdAd,Nome,nifIncerto,Morada).
excecao(adjudicante(IdAd,Nome,Nif,Morada)) :- adjudicante(IdAd,nomeIncerto,Nif,Morada).

% Entidade adjudicataria
% Nao se sabe a morada da entidade adjudicataria 'Santos, Teixeira e Patricio LDA.', cujo ID e 20 e cujo NIF e 230000000.
adjudicataria(20,'Santos, Teixeira e Patricio LDA.',230000000,moradaIncerta).
% Nao se sabe o NIF da entidade adjudicataria 'GALP Combustiveis' com ID 21 localizada em 'Sao Pedro de Afins, 198'.
adjudicataria(21,'GALP Combustiveis',nifIncerto,'Sao Pedro de Afins, 198').
% Nao se sabe o nome da entidade adjudicataria cujo ID e 22, com o NIF 250000000 e localizada em 'Rio Covo, 91'.
adjudicataria(22,nomeIncerto,250000000,'Rio Covo, 91').

excecao(adjudicataria(IdAda,Nome,Nif,Morada)) :- adjudicataria(IdAda,Nome,Nif,moradaIncerta).
excecao(adjudicataria(IdAda,Nome,Nif,Morada)) :- adjudicataria(IdAda,Nome,nifIncerto,Morada).
excecao(adjudicataria(IdAda,Nome,Nif,Morada)) :- adjudicataria(IdAda,nomeIncerto,Nif,Morada).

% Entidade contrato
% Nao se sabe a data em que o contrato com ID 20, (...) foi estabelecido.
contrato(20,4,3,'Obras Publicas','Consulta Previa','Construcao de Hospital',16500,502,'Sao Martinho, 165',dataIncerta).
% Sabe-se que o local em que o contrato com ID 21, (...) foi estabelecido nao e 'Sao Martinho'
% O termo negativo esta declarado no ficheiro perfeito.pl
contrato(21,1,3,'Obras Publicas','Consulta Previa','Construcao de Hospital',42350,523,localIncerto,data(2012,9,4)).
% Nao se sabe o prazo com que o contrato com ID 22, (...) foi estabelecido.
contrato(22,3,4,'Obras Publicas','Consulta Previa','Construcao de Estradas',340,prazoIncerto,'Monte de Fralães, 42',data(2014,3,19)).
% Nao se sabe o valor com que o contrato com ID 23, (...) foi estabelecido.
contrato(23,4,2,'Obras Publicas','Consulta Previa','Construcao de Escola',valorIncerto,522,'Vilar de Figos, 198',data(2013,7,6)).
% Nao se sabe a descricao definida para o contrato com ID 24, (...).
contrato(24,1,5,'Obras Publicas','Consulta Previa',descricaoIncerta,18500,543,'Macieira de Rates, 152',data(2013,8,12)).
% Nao se sabe o procedimento com que o contrato com ID 25, (...) foi estabelecido, mas sabe-se que nao foi 'Consulta Previa'
% O termo negativo esta declarado no ficheiro perfeito.pl
contrato(25,2,4,'Obras Publicas',procedimentoIncerto,'Movimento Mobiliario',12500,555,'Tamel S. Verissimo, 201',data(2013,1,23)).
% Nao se sabe o tipo do contrato com ID 26, (...).
contrato(26,5,3,tipoIncerto,'Consulta Previa','Construcao de Estradas',9000,404,'Matosinhos, 172',data(2016,6,4)).
% Nao se sabe o id da entidade adjudicataria cujo contrato com ID 27, (...) foi estabelecido.
contrato(27,4,idAdaIncerto,'Obras Publicas','Consulta Previa','Construcao de Estradas',12000,406,'Fonte Coberta, 87',data(2012,6,21)).
% Sabe-se que o id da entidade adjudicante nao e 28 no contrato com ID 987131, (...).
% O termo negativo esta declarado no ficheiro perfeito.pl
contrato(28,idAdIncerto,5,'Obras Publicas','Consulta Previa','Construcao de Escola',14500,209,'Vilar do Monte, 204',data(2011,2,14)).

excecao(contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D)) :- contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,dataIncerta).
excecao(contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D)) :- contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,localIncerto,D).
excecao(contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D)) :- contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,prazoIncerto,L,D). 
excecao(contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D)) :- contrato(IdC,IdAd,IdAda,T,Proc,Desc,valorIncerto,Pra,L,D). 
excecao(contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D)) :- contrato(IdC,IdAd,IdAda,T,Proc,descricaoIncerta,V,Pra,L,D). 
excecao(contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D)) :- contrato(IdC,IdAd,IdAda,T,procedimentoIncerto,Desc,V,Pra,L,D). 
excecao(contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D)) :- contrato(IdC,IdAd,IdAda,tipoIncerto,Proc,Desc,V,Pra,L,D). 
excecao(contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D)) :- contrato(IdC,IdAd,idAdaIncerto,T,Proc,Desc,V,Pra,L,D). 
excecao(contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D)) :- contrato(IdC,idAdIncerto,IdAda,T,Proc,Desc,V,Pra,L,D).

% -----------------------------------------------------------------------------------------------------------
% Conhecimento Imperfeito Impreciso

% Entidade adjudicante
% Nao se sabe se a entidade adjudicante 'Empreiteira Goncalves' com ID 30 e localizada em 'Vila Nova de Gaia, 271' tem NIF 300000001 ou 300000002
excecao(adjudicante(30,'Empreiteira Goncalves',300000001,'Vila Nova de Gaia, 271')).
excecao(adjudicante(30,'Empreiteira Goncalves',300000002,'Vila Nova de Gaia, 271')).

% Nao se sabe ao certo o NIF da entidade adjudicante 'Municipio de Lage' com ID 30 e localizada em 'Vila Nova de Gaia', mas sabe-se que
% esta entre 333333333 e 444444444
excecao(adjudicante(31,'Municipio de Lage',NIF,'Vila Nova de Gaia, 275')) :- NIF>=333333333, NIF=<444444444.
intervalo(adjudicante,31,nif,(333333333,444444444)).

% Nao se sabe ao certo se a morada do adjudicante 32 ('Municipio do Minho') e 'Braga, Amares, 41' ou 'Guimaraes, Taipas, 124'
excecao(adjudicante(32,'Municipio do Minho',320000000,'Braga, Amares, 41')).
excecao(adjudicante(32,'Municipio do Minho',320000000,'Guimaraes, Taipas, 124')).

% Entidade adjudicataria
% Nao se sabe se a entidade adjudicataria 'Mobiliaria Jacintos' com ID 30 e localizada em 'Braga' tenha NIF 300000003 ou 300000004
excecao(adjudicataria(30,'Mobiliaria Jacintos',300000003,'Areias de Vilar, 292')).
excecao(adjudicataria(30,'Mobiliaria Jacintos',300000004,'Areias de Vilar, 292')).

% Nao se sabe se a entidade adjudicataria com ID 31, localizada em 'Abade de Neiva, 192' e com NIF 310000000 se chama 'Mobiliaria Pinheiro'
% ou 'Mobiliaria Pinhal'
excecao(adjudicataria(31,'Mobiliaria Pinheiro',310000000,'Abade de Neiva, 192')).
excecao(adjudicataria(31,'Mobiliaria Pinhal',310000000,'Abade de Neiva, 192')).

% Nao se sabe ao certo o NIF da entidade adjudicataria 'Combustiveis McQueen', com ID 32 e localizada em 'Rota 66', mas sabe-se que
% esta entre 200000000 e 800000000
excecao(adjudicataria(32,'Combustiveis McQueen',NIF,'Rota 66')) :- NIF>=200000000, NIF=<800000000.
intervalo(adjudicataria,32,nif,(200000000,800000000)).

% Nao se sabe ao certo qual foi a entidade adjudicataria a assinar o contrato cujo ID e 35, (...), mas sabe-se que tinha ID 
% 2, 4 ou 6
excecao(contrato(35,1,2,'Empreitadas','Ajuste Direto','Obras Publicas',20000,281,'Povoa de Varzim, 180',data(2007,6,19))).
excecao(contrato(35,1,4,'Empreitadas','Ajuste Direto','Obras Publicas',20000,281,'Povoa de Varzim, 180',data(2007,6,19))).
excecao(contrato(35,1,6,'Empreitadas','Ajuste Direto','Obras Publicas',20000,281,'Povoa de Varzim, 180',data(2007,6,19))).

% -----------------------------------------------------------------------------------------------------------
% Conhecimento Imperfeito Interdito

nuloInterdito(moradaInterdita).
nuloInterdito(nifInterdito).
nuloInterdito(nomeInterdito).

nuloInterdito(dataInterdita). 
nuloInterdito(localInterdito). 
nuloInterdito(prazoInterdito). 
nuloInterdito(valorInterdito).
nuloInterdito(descricaoInterdita). 
nuloInterdito(procedimentoInterdito). 
nuloInterdito(tipoInterdito). 
nuloInterdito(idAdaInterdito). 
nuloInterdito(idAdInterdito). 

% Entidade adjudicante
% E impossivel saber a morada da entidade adjudicante 'Municipio de Lousada', cujo ID e 40 e cujo NIF e 400000000.
adjudicante(40,'Municipio de Lousada',400000000,moradaInterdita).
% E impossivel saber o NIF da entidade adjudicante 'Municipio de Braganca' com ID 41 localizada na 'Rua de Caravaes, 120'.
adjudicante(41,'Municipio de Braganca',nifInterdito,'Rua de Caravaes, 120').
% E impossivel saber o nome da entidade adjudicante cujo ID e 42, com o NIF 4200000000 e localizada em 'Sao Joao da Pesqueira, 293'.
adjudicante(42,nomeInterdito,4200000000,'Sao Joao da Pesqueira, 293').

excecao(adjudicante(IdAd,Nome,Nif,Morada)) :- adjudicante(IdAd,Nome,Nif,moradaInterdita).
excecao(adjudicante(IdAd,Nome,Nif,Morada)) :- adjudicante(IdAd,Nome,nifInterdito,Morada).
excecao(adjudicante(IdAd,Nome,Nif,Morada)) :- adjudicante(IdAd,nomeInterdito,Nif,Morada).

+adjudicante(IdAd,Nome,Nif,Morada) ::
    (solucoes((IdAd,Nome,Nif,Morada), 
    (adjudicante(40,'Municipio de Lousada',400000000,moradaInterdita), nao(nuloInterdito(moradaInterdita))), R),
    comprimento(R,0)).

+adjudicante(IdAd,Nome,Nif,Morada) ::
    (solucoes((IdAd,Nome,Nif,Morada), 
    (adjudicante(41,'Municipio de Braganca',nifInterdito,'Rua de Caravaes, 120'), nao(nuloInterdito(nifInterdito))), R),
    comprimento(R,0)).

+adjudicante(IdAd,Nome,Nif,Morada) ::
    (solucoes((IdAd,Nome,Nif,Morada), 
    (adjudicante(42,nomeInterdito,420000000,'Sao Joao da Pesqueira, 293'), nao(nuloInterdito(nomeInterdito))), R),
    comprimento(R,0)).

% Entidade adjudicataria
% E impossivel saber a morada da entidade adjudicataria 'Advogados Lambert LDA.', cujo ID e 40 e cujo NIF e 430000000.
adjudicataria(43,'Advogados Lambert LDA.',430000000,moradaInterdita).
% E impossivel saber o NIF da entidade adjudicataria 'Trofa Combustiveis' com ID 41 localizada na 'Oliveira de Frades, 89'.
adjudicataria(44,'Trofa Combustiveis',nifInterdito,'Oliveira de Frades, 89').
% E impossivel saber o nome da entidade adjudicataria cujo ID e 42, com o NIF 987274303 e localizada em 'Carregal do Sal, 145'.
adjudicataria(45,nomeInterdito,450000000,'Carregal do Sal, 145').

excecao(adjudicataria(IdAda,Nome,Nif,Morada)) :- adjudicataria(IdAda,Nome,Nif,moradaInterdita).
excecao(adjudicataria(IdAda,Nome,Nif,Morada)) :- adjudicataria(IdAda,Nome,nifInterdito,Morada).
excecao(adjudicataria(IdAda,Nome,Nif,Morada)) :- adjudicataria(IdAda,nomeInterdito,Nif,Morada).
                                                                                              
+adjudicataria(IdAda,Nome,Nif,Morada) ::
    (solucoes((IdAda,Nome,Nif,Morada), 
    (adjudicataria(43,'Advogados Lambert LDA.',430000000,moradaInterdita), nao(nuloInterdito(moradaInterdita))), R),
    comprimento(R,0)).

+adjudicataria(IdAda,Nome,Nif,Morada) ::
    (solucoes((IdAda,Nome,Nif,Morada), 
    (adjudicataria(44,'Trofa Combustiveis',nifInterdito,'Oliveira de Frades, 89'), nao(nuloInterdito(nifInterdito))), R),
    comprimento(R,0)).

+adjudicataria(IdAda,Nome,Nif,Morada) ::
    (solucoes((IdAda,Nome,Nif,Morada), 
    (adjudicataria(45,nomeInterdito,450000000,'Carregal do Sal, 145'), nao(nuloInterdito(nomeInterdito))), R),
    comprimento(R,0)).    

% Entidade contrato
% E impossivel saber  a data em que o contrato com ID 50, (...) foi estabelecido.
contrato(50,1,2,'Obras Publicas','Consulta Previa','Construcao de Hospital',18500,532,'Sao Pedro do Sul, 82',dataInterdita).
% E impossivel saber o local em que o contrato com ID 51, (...) foi estabelecido.
contrato(51,2,3,'Obras Publicas','Consulta Previa','Construcao de Hospital',23400,403,localInterdito,data(2016,12,4)).
% E impossivel saber o prazo com que o contrato com ID 52, (...) foi estabelecido.
contrato(52,4,3,'Obras Publicas','Consulta Previa','Construcao de Estradas',34000,prazoInterdito,'Moimenta da Beira, 82',data(2015,2,29)).
% E impossivel saber o valor com que o contrato com ID 53, (...) foi estabelecido.
contrato(53,3,4,'Obras Publicas','Consulta Previa','Construcao de Hopistal',valorInterdito,492,'Vila do Bispo, 192',data(2011,8,26)).
% E impossivel saber a descricao definida para o contrato com ID 54, (...).
contrato(54,1,4,'Obras Publicas','Consulta Previa',descricaoInterdita,19700,443,'Castro Marim, 170',data(2009,10,11)).
% E impossivel saber o procedimento com que o contrato com ID 55, (...) foi estabelecido.
contrato(55,5,1,'Obras Publicas',procedimentoInterdito,'Movimento Mobiliario',22500,255,'Sao Bras de Alportel, 131',data(2017,1,23)).
% E impossivel saber o tipo do contrato com ID 56, (...).
contrato(56,1,5,tipoInterdito,'Consulta Previa','Construcao de Escola',19000,484,'Miranda do Douro, 91',data(2014,9,14)).
% E impossivel saber o id da entidade adjudicataria cujo contrato com ID 57, (...) foi estabelecido.
contrato(57,2,idAdaInterdito,'Obras Publicas','Consulta Previa','Construcao de Hospital',14200,426,'Alfandega da Fe, 292',data(2013,3,25)).
% E impossivel saber o id da entidade adjudicante no contrato com ID 58, (...).
contrato(58,idAdInterdito,2,'Obras Publicas','Consulta Previa','Construcao de Escola',13700,219,'Macedo de Cavaleiros, 192',data(2013,2,16)).

excecao(contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D)) :- contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,dataInterdita).
excecao(contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D)) :- contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,localInterdito,D).
excecao(contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D)) :- contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,prazoInterdito,L,D). 
excecao(contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D)) :- contrato(IdC,IdAd,IdAda,T,Proc,Desc,valorInterdito,Pra,L,D). 
excecao(contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D)) :- contrato(IdC,IdAd,IdAda,T,Proc,descricaoInterdita,V,Pra,L,D). 
excecao(contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D)) :- contrato(IdC,IdAd,IdAda,T,procedimentoInterdito,Desc,V,Pra,L,D). 
excecao(contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D)) :- contrato(IdC,IdAd,IdAda,tipoInterdito,Proc,Desc,V,Pra,L,D). 
excecao(contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D)) :- contrato(IdC,IdAd,idAdaInterdito,T,Proc,Desc,V,Pra,L,D). 
excecao(contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D)) :- contrato(IdC,idAdInterdito,IdAda,T,Proc,Desc,V,Pra,L,D).

+contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D) ::
    (solucoes((IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D), 
    (contrato(50,1,2,'Obras Publicas','Consulta Previa','Construcao de Hospital',18500,532,'Sao Pedro do Sul, 82',dataInterdita), 
        nao(nuloInterdito(dataInterdita))), R),
    comprimento(R,0)).
                                                                                             
+contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D) ::
    (solucoes((IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D), 
    (contrato(51,2,3,'Obras Publicas','Consulta Previa','Construcao de Hospital',23400,403,localInterdito,data(2016,12,4)), 
        nao(nuloInterdito(localInterdito))), R),
    comprimento(R,0)).

+contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D) ::
    (solucoes((IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D), 
    (contrato(52,4,3,'Obras Publicas','Consulta Previa','Construcao de Estradas',34000,prazoInterdito,'Moimenta da Beira, 82',data(2015,2,29)), 
        nao(nuloInterdito(prazoInterdito))), R),
    comprimento(R,0)).

+contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D) ::
    (solucoes((IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D), 
    (contrato(53,3,4,'Obras Publicas','Consulta Previa','Construcao de Hopistal',valorInterdito,492,'Vila do Bispo, 192',data(2011,8,26)), 
        nao(nuloInterdito(valorInterdito))), R),
    comprimento(R,0)).

+contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D) ::
    (solucoes((IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D), 
    (contrato(54,1,4,'Obras Publicas','Consulta Previa',descricaoInterdita,19700,443,'Castro Marim, 170',data(2009,10,11)), 
        nao(nuloInterdito(descricaoInterdita))), R),
    comprimento(R,0)).

+contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D) ::
    (solucoes((IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D), 
    (contrato(55,5,1,'Obras Publicas',procedimentoInterdito,'Movimento Mobiliario',22500,255,'Sao Bras de Alportel, 131',data(2017,1,23)), 
        nao(nuloInterdito(procedimentoInterdito))), R),
    comprimento(R,0)).                                            

+contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D) ::
    (solucoes((IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D), 
    (contrato(56,1,5,tipoInterdito,'Consulta Previa','Construcao de Escola',19000,484,'Miranda do Douro, 91',data(2014,9,14)), 
        nao(nuloInterdito(tipoInterdito))), R),
    comprimento(R,0)).

+contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D) ::
    (solucoes((IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D), 
    (contrato(57,2,idAdaInterdito,'Obras Publicas','Consulta Previa','Construcao de Hospital',14200,426,'Alfandega da Fe, 292',data(2013,3,25)), 
        nao(nuloInterdito(idAdaInterdito))), R),
    comprimento(R,0)).

+contrato(IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D) ::
    (solucoes((IdC,IdAd,IdAda,T,Proc,Desc,V,Pra,L,D), 
    (contrato(58,idAdInterdito,2,'Obras Publicas','Consulta Previa','Construcao de Escola',13700,219,'Macedo de Cavaleiros, 192',data(2013,2,16)), 
        nao(nuloInterdito(idAdInterdito))), R),
    comprimento(R,0)).