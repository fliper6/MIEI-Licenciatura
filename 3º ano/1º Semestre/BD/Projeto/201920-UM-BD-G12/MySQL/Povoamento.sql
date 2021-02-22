
-- ------------------------------------------------------
-- ------------------------------------------------------
-- Universidade do Minho
-- Mestrado Integrado em Engenharia Informática
-- Unidade Curricular de Bases de Dados
-- 
-- Caso de Estudo: Agendamento e realização de Testes Clínicos de atletas
-- de Atletismo de diferentes modalidades e categorias.
-- Povoamento inicial da base de dados
-- ------------------------------------------------------
-- ------------------------------------------------------

-- Esquema: "mydb"
USE `mydb` ;

--
-- Permissão para fazer operações de remoção de dados.
SET SQL_SAFE_UPDATES = 0;
SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER //
CREATE FUNCTION `idade` (dta date) RETURNS INT
BEGIN
RETURN TIMESTAMPDIFF(YEAR, dta, CURDATE());
END //
--
-- Povoamento da tabela "Modalidade"
INSERT INTO Modalidade
	(idModalidade, designacao, genero)
    VALUES
		(1,'Velocidade', 'M'),
		(2,'Velocidade', 'F'),
        (3,'Barreiras', 'M'),
        (4,'Barreiras', 'F'),
        (5,'Meio-fundo', 'M'),
        (6,'Meio-fundo', 'F'),
        (7,'Estafetas', 'M'),
        (8,'Estafetas', 'F'),
        (9,'Salto', 'M'),
        (10,'Salto', 'F'),
        (11,'Lançamento', 'M'),
        (12,'Lançamento', 'F')
        ;
--
-- DELETE FROM Modalidade;
-- SELECT * FROM Modalidade;

--
-- povoamento da tabela "Atleta"
INSERT INTO Atleta 
	(nome, data_nascimento, genero, nacionalidade, morada, idModalidade) 
	VALUES 
        ('Artur Correia','1990-04-20', 'M', 'português', 'Avenida do Cavado 34', 1),
        ('Manuel Oliveira','1999-04-20', 'M', 'inglês', 'Rua de Trás da Poça 10', 1),
        ('André Cardoso','2001-04-20', 'M', 'francês', 'Rua do Barreiro Gualtar 20', 1),
        ('Válter Ferreira','1985-04-20', 'M', 'português', 'Rua da Bela Vista Gualtar 31', 1),
		('Teresa Estevao', '1995-01-21', 'F', 'português', 'Rua dos pinheiros 33', 2),
        ('Teresa Forte', '1999-01-21', 'F', 'chinês', 'Rua da Lage Gualtar 33', 2),
        ('Inês Carvalho', '1993-01-21', 'F', 'português', 'Rua do Alto da Mourisca 4', 2),
        ('Francisco Maia', '1979-08-09', 'M', 'francês', 'Avenida da liberdade 89', 3),
        ('Gabriel Barbosa', '1998-08-09', 'M', 'espanhol', 'Rua da Mourisca Gualtar 9', 3),
        ('Diogo Coelho', '2003-08-09', 'M', 'dinamarquês', 'Rua Solar da Quinta 89', 3),
		('Anastasia Leite', '1996-05-29', 'F', 'holandês', 'Urbanizaçao Parkista 44', 4),
		('Francisca Vieira', '2000-05-29', 'F', 'austríaco', 'Urbanização Quinta da Vergadela 44', 4),
		('Sofia Santos', '1001-05-29', 'F', 'paquistanês', 'Rua Doutor Reis Costa 64', 4),
        ('Joao Alves', '1981-07-11', 'M', 'francês', 'Avenida da boavista 30', 5),
        ('Filipe Coutinho', '1998-07-11', 'M', 'português', 'Travessa Alvares Cabral 23', 5),
        ('Joao Sousa', '1989-07-11', 'M', 'português', 'Praça das Oliveiras 5', 5),
		('Irina Oliveira', '1988-11-17', 'F', 'português', 'Rua Fernando Pessoa 10', 6),
	    ('Maria Dores', '1976-11-17', 'F', 'chinês', 'Rua José Maria Rodrigues 25', 6),
		('Prescila Arado', '2003-11-17', 'F', 'português', 'Rua Óscar Dias Pereira 9', 6),
		('Antonio Banderas', '2000-11-05', 'M', 'espanhol', 'Avenida da confeiteira 23', 7),
        ('Antonio Bruno', '2000-11-05', 'M', 'português', 'Rua Doutor Artur Luís Navega Correia 2', 7),
        ('Joaquim Banderas', '2000-11-05', 'M', 'português', 'Rua Tenente Morais Sarmento 4', 7),
		('Adriana Felicidade', '1999-04-23', 'F', 'espanhol', 'Rua do Raio 1', 8),
        ('Felícia Felicidade', '1990-04-23', 'F', 'inglês', 'Rua do Diâmetro 23', 8),
        ('Mafalda Felicidade', '2002-04-23', 'F', 'inglês', 'Rua do Volume 3', 8),
		('Mario Castro', '1998-12-02', 'M', 'português', 'Rua de Barros 99', 9),
        ('Luís Ribeiro', '1990-12-02', 'M', 'português', 'Rua do Sume 9', 9),
        ('José Castro', '2000-12-02', 'M', 'austríaco', 'Rua dos Caramouços 8', 9),
        ('Eduarda Sapinho', '2005-02-08', 'F', 'inglês', 'Avenida Nestor 22', 10),
        ('Rafaela Alto', '2000-02-08', 'F', 'português', 'Rua das Gaiteiras 2', 10),
        ('Francisca Baixo', '2003-02-08', 'F', 'suíço', 'Rua de São Pedro 5', 10),
		('Rui Costa', '1990-11-05', 'M', 'português', 'Rua Manuel Francisco Duarte Martins 1', 11),
        ('Gonçalo Eugénio', '1995-11-05', 'M', 'português', 'Rua António Patrício 2', 11),
        ('Diogo Taxa', '1970-11-05', 'M', 'português', 'Rua Francisco Magalhães 98', 11),
		('Alexandra Santos', '2004-01-15', 'F', 'holandês', 'Rua Do Xico Esperto 50', 12),
		('Nuna Faria', '2002-01-23', 'F', 'francês', 'Rua Inteligencia Abstrata 14', 12),
		('Mariana Lopes', '1981-03-28', 'F', 'espanhol', 'Condominio da Boa Vida 4', 12),
		('Gabriel Ricardo', '1966-10-24', 'M', 'espanhol',  'Urbanizaçao Luxuosa 67', 3),
		('Felix Alves', '1983-09-14', 'M', 'português', 'Castelo de Guimaraes 1', 5),
		('Joao Pinheiro', '1975-07-11', 'M', 'francês', 'Avenida da boavista 30', 7)
        ;
--
-- DELETE FROM Atleta;
-- SELECT * FROM Atleta;        
--        
-- Povoamento da tabela "Categoria"
INSERT INTO Categoria
	(idCategoria, idModalidade, designacao)
    VALUES
		(1, 1, '100 metros'),
		(2, 1, '400 metros'),
        (3, 2, '100 metros'),
		(4, 2, '400 metros'),
		(5, 3, '100 metros'),
		(6, 3, '400 metros'),
        (7, 4, '100 metros'),
		(8, 4, '400 metros'),
		(9, 5, '1500 metros'),
		(10, 5, '3000 metros'),
        (11, 6, '1500 metros'),
		(12, 6, '3000 metros'),
        (13, 7, '4 x 100 metros'),
        (14, 7, '4 x 400 metros'),
        (15, 8, '4 x 100 metros'),
        (16, 8, '4 x 400 metros'),
        (17, 9, 'Altura'),
        (18, 9, 'Comprimento'),
        (19, 10, 'Altura'),
        (20, 10, 'Comprimento'),
        (21, 11, 'Disco'),
        (22, 11, 'Martelo'),
        (23, 11, 'Dardo'),
        (24, 11, 'Peso'),
		(25, 12, 'Disco'),
		(26, 12, 'Martelo'),
		(27, 12, 'Dardo'),
		(28, 12, 'Peso')
        ;
--
-- DELETE FROM Categoria;
-- SELECT * FROM Categoria;


--
-- Povoamento da tabela "Prova"
INSERT INTO  Prova 
	(idModalidade, idCategoria, nome, flag, data, vencedor1, vencedor2, vencedor3) 
    VALUES 
		(1, 1,'Prova_1','N', '2020-06-05', NULL, NULL, NULL),
        (1, 1,'Prova_2','N', '2019-06-30', 1, 2, 3),
        (1, 2,'Prova_3','S', '2019-07-28', 4, 2, 3),
        (1, 2,'Prova_4','N', '2020-01-05', NULL, NULL, NULL),
        (2, 3,'Prova_5','N', '2020-06-05', NULL, NULL, NULL),
        (2, 3,'Prova_6','N', '2020-06-05', NULL, NULL, NULL),
        (2, 3,'Prova_7','N', '2020-08-08', NULL, NULL, NULL),
        (2, 3,'Prova_8','N', '2018-04-03', 5, 6, 7),
        (2, 4,'Prova_9','N', '2017-12-30', 7, 6, 5),
        (2, 4,'Prova_10','N', '2020-08-08', NULL, NULL, NULL),
        (2, 4,'Prova_11','N', '2018-04-03', 6, 7, 5),
        (3, 5,'Prova_12','N', '2017-12-30', 9, 10, 8),
        (3, 5,'Prova_13','N', '2020-08-08', NULL, NULL, NULL),
        (3, 5,'Prova_14','N', '2018-04-03', 10, 8, 9),
        (3, 6,'Prova_15','N', '2020-06-05', NULL, NULL, NULL),
        (3, 6,'Prova_16','N', '2020-06-05', NULL, NULL, NULL),
        (3, 6,'Prova_17','N', '2020-06-05', NULL, NULL, NULL),
        (3, 6,'Prova_18','N', '2018-04-03', 10, 8, 9),
        (4, 7,'Prova_19','N', '2018-06-05', 11, 12, 13),
        (4, 7,'Prova_20','N', '2020-06-05', NULL, NULL, NULL),
        (4, 8,'Prova_21','N', '2018-04-03', 13, 11, 12),
        (4, 8,'Prova_22','N', '2020-03-04', NULL, NULL, NULL),
        (4, 8,'Prova_23','N', '2020-04-04', NULL, NULL, NULL),
        (5, 9,'Prova_24','N', '2018-04-03', 14, 15, 16),
        (5, 9,'Prova_25','N', '2020-06-05', NULL, NULL, NULL),
        (5, 9,'Prova_26','N', '2020-06-05', NULL, NULL, NULL),
        (5, 10,'Prova_27','N', '2018-04-03', 15, 14, 16),
        (5, 10,'Prova_28','N', '2020-06-05', NULL, NULL, NULL),
        (5, 10,'Prova_29','N', '2020-06-05', NULL, NULL, NULL),
        (6, 11,'Prova_30','N', '2018-04-03', 18, 17, 19),
        (6, 11,'Prova_31','N', '2020-06-05', NULL, NULL, NULL),
        (6, 11,'Prova_32','N', '2020-06-05', NULL, NULL, NULL),
        (6, 12,'Prova_33','N', '2018-04-03', 17, 18, 19),
        (6, 12,'Prova_34','N', '2020-06-05', NULL, NULL, NULL),
        (6, 12,'Prova_35','N', '2020-06-05', NULL, NULL, NULL),
        (7, 13,'Prova_36','N', '2018-04-03', 20, 21, 22),
        (7, 13,'Prova_37','N', '2020-06-05', NULL, NULL, NULL),
        (7, 13,'Prova_38','N', '2020-06-05', NULL, NULL, NULL),
        (7, 14,'Prova_39','N', '2018-04-03', 21, 20, 22),
        (7, 14,'Prova_40','N', '2020-06-05', NULL, NULL, NULL),
        (7, 14,'Prova_41','N', '2020-06-05', NULL, NULL, NULL),
        (8, 15,'Prova_42','N', '2018-04-03', 23, 24, 25),
        (8, 15,'Prova_43','N', '2020-06-05', NULL, NULL, NULL),
        (8, 15,'Prova_44','N', '2020-06-05', NULL, NULL, NULL),
        (8, 16,'Prova_45','S', '2018-04-03', 24, 25, 23),
        (8, 16,'Prova_46','N', '2020-06-05', NULL, NULL, NULL),
        (8, 16,'Prova_47','N', '2020-06-05', NULL, NULL, NULL),
        (9, 17,'Prova_48','N', '2018-04-03', 26, 28, 27),
        (9, 17,'Prova_49','N', '2020-06-05', NULL, NULL, NULL),
        (9, 17,'Prova_50','N', '2020-06-05', NULL, NULL, NULL),
        (9, 18,'Prova_51','N', '2018-04-03', 26, 27, 28),
        (9, 18,'Prova_52','N', '2020-06-05', NULL, NULL, NULL),
        (9, 18,'Prova_53','N', '2020-06-05', NULL, NULL, NULL),
        (10, 19,'Prova_54','N', '2018-04-03', 29, 31, 30),
        (10, 19,'Prova_55','N', '2020-06-05', NULL, NULL, NULL),
        (10, 19,'Prova_56','N', '2020-06-05', NULL, NULL, NULL),
        (10, 20,'Prova_57','N', '2018-04-03', 29, 30, 31),
        (10, 20,'Prova_58','N', '2020-06-05', NULL, NULL, NULL),
        (10, 20,'Prova_59','N', '2020-06-05', NULL, NULL, NULL),
        (11, 21,'Prova_60','N', '2018-04-03', 32, 34, 33),
        (11, 21,'Prova_61','N', '2020-06-05', NULL, NULL, NULL),
        (11, 21,'Prova_62','N', '2020-06-05', NULL, NULL, NULL),
        (11, 22,'Prova_63','S', '2018-04-03', 32, 33, 34),
        (11, 22,'Prova_64','N', '2020-06-05', NULL, NULL, NULL),
        (11, 22,'Prova_65','N', '2020-06-05', NULL, NULL, NULL),
        (11, 23,'Prova_66','S', '2018-04-03', 33, 32, 34),
        (11, 23,'Prova_67','N', '2020-06-05', NULL, NULL, NULL),
        (11, 23,'Prova_68','N', '2020-06-05', NULL, NULL, NULL),
        (11, 24,'Prova_69','S', '2018-04-03', 34, 32, 33),
        (11, 24,'Prova_70','N', '2020-06-05', NULL, NULL, NULL),
        (11, 24,'Prova_71','N', '2020-06-05', NULL, NULL, NULL),
        (12, 25,'Prova_72','S', '2018-04-03', 35, 37, 36),
        (12, 25,'Prova_73','N', '2020-06-05', NULL, NULL, NULL),
        (12, 25,'Prova_74','N', '2020-06-05', NULL, NULL, NULL),
        (12, 26,'Prova_75','S', '2018-04-03', 35, 37, 36),
        (12, 26,'Prova_76','N', '2020-06-05', NULL, NULL, NULL),
        (12, 26,'Prova_77','N', '2020-06-05', NULL, NULL, NULL),
        (12, 27,'Prova_78','S', '2018-04-03', 37, 35, 36),
        (12, 27,'Prova_79','N', '2020-06-05', NULL, NULL, NULL),
        (12, 27,'Prova_80','N', '2020-06-05', NULL, NULL, NULL),
        (12, 28,'Prova_81','S', '2018-04-03', 36, 37, 35),
        (12, 28,'Prova_82','N', '2020-06-05', NULL, NULL, NULL),
        (12, 28,'Prova_83','N', '2020-06-05', NULL, NULL, NULL)
        ;
--
-- DELETE FROM Prova;
-- SELECT * FROM Prova;        
        
--        
-- Povoamento da tabela "Provas_Atleta"
INSERT INTO Provas_Atleta
	(idProva, idAtleta)
    VALUES	
		(2,1),
		(2,2),
		(2,3),
		(3,4),
		(3,2),
		(3,3),
        (8, 5),
        (8, 6),
        (8, 7),
        (9, 7),
        (9, 6),
        (9, 5),
        (11, 6),
        (11, 7),
        (11, 5),
        (12, 9),
        (12, 10),
        (12, 8),
        (14, 10),
        (14, 8),
        (14, 9),
        (18, 10),
        (18, 8),
        (18, 9),
        (19, 11),
        (19, 12),
		(19, 13),
		(21, 13),
        (21, 12),
        (21, 11),
        (24, 14),
        (24, 15),
        (24, 16),
        (27, 15),
        (27, 14),
        (27, 16),
        (30, 18),
        (30, 17),
        (30, 19),
        (33, 17),
        (33, 18),
        (33, 19),
        (36, 20),
        (36, 21),
        (36, 22),
        (39, 21),
        (39, 20),
        (39, 22),
        (42, 23),
        (42, 24),
        (42, 25),
        (45, 24),
        (45, 25),
        (45, 23),
        (48, 26),
        (48, 27),
        (48, 28),
        (51, 26),
        (51, 27),
        (51, 28),
        (54, 29),
        (54, 31),
        (54, 30),
        (57, 29),
        (57, 31),
        (57, 30),
        (60, 32),
        (60, 34),
        (60, 33),
        (63, 32),
        (63, 33),
        (63, 34),
        (66, 32),
        (66, 33),
        (66, 34),
        (69, 34),
        (69, 32),
        (69, 33),
        (72, 35),
        (72, 36),
        (72, 37),
        (75, 35),
        (75, 36),
        (75, 37),
        (78, 35),
        (78, 36),
        (78, 37),
        (81, 37),
        (81, 35),
        (81, 36)
        ;
--
-- DELETE FROM Provas_Atleta;
-- SELECT * FROM Provas_Atleta;

--      
-- Povoamento da tabela "Teste"      
INSERT INTO Teste
	(idAtleta, medico, data, flag, preço)
	VALUES    
		(1, 'André Silva', '2020-01-03', 'N',10),
        (1, 'Manuela Ribeiro', '2020-03-02', 'C',18),
        (3, 'Válter Carvalho', '2018-01-03', 'S',15),
        (4, 'Manuel Oliveira', '2019-12-02', 'N',40),
        (4, 'Andreia Pando', '2019-01-03', 'S',50),
        (5, 'Liliana Rodrigues', '2019-11-02', 'S',40),
        (6, 'Liliana Rodrigues', '2020-12-21', 'C',35),
        (8, 'Andreia Pando', '2019-10-23', 'N',12),
        (9, 'Manuela Ribeiro', '2019-09-03', 'N',44),
        (10, 'Válter Carvalho', '2019-03-02', 'C',43),
        (10, 'André Silva', '2019-04-06', 'S',50),
        (10, 'André Silva', '2019-04-08', 'S',20),
        (11, 'André Silva', '2020-01-01', 'N',24),
        (12, 'Válter Carvalho', '2020-09-05', 'N',30),
        (15, 'Andreia Pando', '2018-06-02', 'C',10),
        (16, 'Válter Carvalho', '2017-12-21', 'C',27),
        (16, 'Liliana Rodrigues', '2020-01-03', 'N',29),
        (17, 'Andreia Pando', '2019-10-10', 'S',25),
        (19, 'Manuel Oliveira', '2020-07-03', 'N',26),
        (20, 'Válter Carvalho', '2020-03-12', 'C',20),
        (21, 'André Silva', '2019-07-07', 'N',45),
        (22, 'Manuel Oliveira', '2020-04-12', 'N',50),
        (23, 'André Silva', '2018-08-25', 'N',10),
        (24, 'Manuela Ribeiro', '2017-06-06', 'S',15),
        (26, 'André Silva', '2018-03-18', 'S',17),
        (28, 'Manuela Ribeiro', '2019-02-01', 'C',25),
        (28, 'Liliana Rodrigues', '2020-07-30', 'N',25),
        (29, 'Válter Carvalho', '2018-11-11', 'N',50),
        (30, 'Válter Carvalho', '2017-12-22', 'N',10),
        (31, 'Manuela Ribeiro', '2016-09-09', 'S',30),
        (32, 'André Silva', '2018-07-07', 'S',30),
        (34, 'Manuela Ribeiro', '2019-05-05', 'N',40),
        (34, 'André Silva', '2018-03-01', 'S',28),
        (37, 'Válter Carvalho', '2020-06-05', 'C',22),
        (38, 'Manuel Oliveira', '2020-03-03', 'N',38),
        (38, 'Manuela Ribeiro', '2019-11-13', 'S',33),
        (39, 'Manuel Oliveira', '2019-01-29', 'S',35),
        (40, 'Manuel Oliveira', '2018-10-02', 'S',17)
        ;
--
-- DELETE FROM Teste;
-- SELECT * FROM Teste;

--        
-- Povoamento da tabela "Multa"
INSERT INTO Multa
	(flag, valor, idTeste, idAtleta)
    VALUES
		('S', 50,4,4),
        ('N', 300,8,8), 
        ('S', 30,9,9),
        ('S', 50,15,15),
        ('N', 100,21,21),
        ('N', 300,23,23),
        ('S', 150,28,29),
        ('S', 150,29,30),
        ('N', 50,32,34),
        ('S', 50,5,4)
        ;
--
-- DELETE FROM Multa;
-- SELECT * FROM Multa;

	        
-- ------------------------------------------------------
-- <fim>
-- Grupo 12, 2019/2020
-- ------------------------------------------------------