%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Conhecimento perfeito positivo

% Adjudicante: #IdAd, Nome, NIF, Morada
adjudicante(1,'Municipio de Santarem',111111111,'Amiais de Baixo, 157').
adjudicante(2,'Municipio de Barcelos',222222222,'Santa Maria, 256').
adjudicante(3,'Municipio de Tras-os-Montes',333333333,'Vale de Gouvinhas, 87').
adjudicante(5,'Municipio de Estoril',555555555,'Torres Novas, 288').
adjudicante(6,'Municipio de Idanha-a-Nova',666666666,'Vila Nova da Barquinha, 302').
adjudicante(4,'Municipio de Algarve',444444444,'Ribeira de Nisa, 201').

% Adjudicataria: #IdAda, Nome, NIF, Morada
adjudicataria(1,'Advocacia Financeira Perantes',121212121,'Amares, 223').
adjudicataria(2,'Associacao Juridica MMS',232323232,'Sequeiros, 99').
adjudicataria(3,'Combustiveis ELF',343434343,'Paredes Secas, 82').
adjudicataria(4,'Combustiveis BP',454545454,'Figueiredo, 61').
adjudicataria(5,'Junta de Advogados Pereira',565656565,'Travassos, 87').
adjudicataria(6,'Camara Municipal de Ovar',676767676,'Aguas Santas, 138').

% Contrato: #IdC, #IdAd, #IdAda, Tipo, Procedimento, Descricao, Valor, Prazo, Local, Data
contrato(1,4,2,'Aquisicao de Servicos','Consulta Previa','Assessoria Juridica',13599,547,'Alto de Basto, 124',data(2018,6,12)).
contrato(2,3,1,'Aquisicao','Ajuste Direto','Construcao de Hospital',5000,242,'Crespos, 22',data(2020,1,21)).
contrato(3,4,4,'Empreitadas','Concurso Publico','Construcao de Estradas',14900,433,'Cunhados de Ouro, 101',data(2019,9,17)).
contrato(4,6,4,'Obras Publicas','Concurso Publico','Construcao de Estradas',15000,231,'Cabeceiras de Basto, 221',data(2019,6,1)).
contrato(5,2,3,'Locacao de Bens Moveis','Ajuste Direto','Movimento Mobiliario',4900,304,'Santa Maria, 94',data(2015,2,11)).
contrato(6,3,6,'Locacao de Bens Moveis','Ajuste Direto','Movimento Mobiliario',3333,362,'Barcelos, 32',data(2020,3,7)).
contrato(7,4,1,'Empreitadas','Consulta Previa','Assessoria Juridica',14023,502,'Sobradelo da Goma, 82',data(2017,9,12)).
contrato(8,2,4,'Aquisicao de Servicos','Concurso Publico','Construcao de Estradas',20000,206,'Geraz do Minho, 24',data(2019,11,29)).
contrato(9,2,4,'Aquisicao de Servicos','Concurso Publico','Construcao de Estradas',60000,206,'Geraz do Minho, 24',data(2019,11,29)).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Conhecimento perfeito negativo

% Adjudicante: #IdAd, Nome, NIF, Morada
-adjudicante(10,'Municipio de Amares',111222333,'Travassos, 28').
-adjudicante(11,'Municipio de Lanhoso',222333444,'Galegos, 90').
-adjudicante(12,'Municipio de Verim',333444555,'Vila Nova, 70').
-adjudicante(13,'Municipio de Esperanca',444555666,'Amares, 32').
-adjudicante(14,'Municipio de Ovar',555666000,'Ovar, 12').
-adjudicante(14,'Municipio de Ovar',555666001,'Ovar, 12').
-adjudicante(14,'Municipio de Ovar',555666002,'Ovar, 12').
-adjudicante(14,'Municipio de Ovar',555666003,'Ovar, 12').

% Adjudicataria: #IdAda, Nome, NIF, Morada
-adjudicataria(10,'Advocacia Financeira Perantes',100000000,'Sao Mamede, 12').
-adjudicataria(11,'Associacao Juridica MMS',100000001,'Souto, 99').
-adjudicataria(12,'Combustiveis ELF',100000002,'Moimenta (Santo Andre), 29').
-adjudicataria(13,'Junta de Advogados Pereira',100000003,'Vilar da Veiga, 101').

% Contrato: #IdC, #IdAd, #IdAda, Tipo, Procedimento, Descricao, Valor, Prazo, Local, Data
-contrato(21,1,3,'Obras Publicas','Consulta Previa','Construcao de Hospital',42350,523,'Sao Martinho, 24',data(2012,9,4)).
-contrato(25,2,4,'Obras Publicas','Consulta Previa','Movimento Mobiliario',12500,555,'Tamel S. Verissimo, 201',data(2013,1,23)).
-contrato(28,3,5,'Obras Publicas','Consulta Previa','Construcao de Escola',14500,209,'Vilar do Monte, 204',data(2011,2,14)).
-contrato(10,4,2,'Aquisicao de Servicos','Consulta Previa','Assessoria Juridica',13599,547,'Alvito S. Martinho, 303',data(2018,6,10)).
-contrato(11,4,2,'Aquisicao de Servicos','Ajuste Direto','Assessoria Juridica',13599,547,'Alvito S. Martinho, 303',data(2018,6,10)).
