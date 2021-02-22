#Marcar um teste
DELIMITER $$
CREATE PROCEDURE marcarTeste (IN idA VARCHAR(45),IN med VARCHAR(45), IN dat DATETIME)
BEGIN
    DECLARE test1 INT;
    DECLARE test2 INT;
    DECLARE test3 INT;
    DECLARE test4 INT;
    DECLARE pre DOUBLE;
    DECLARE sucesso BOOL DEFAULT 0;
	SET autocommit = 0;
    SET pre = (SELECT RAND()*(50-10)+10);
	SET test1 = (Select count(idAtleta) from Teste t where t.idAtleta= idA and t.flag='N' and t.data > now());
    SET test2 = (Select count(idAtleta) from Atleta a where a.idAtleta= idA);
    SET test3 = (Select count(idAtleta) from Multa m where m.idAtleta= idA and m.flag='N');
	IF dat > now() then set test4 = 0;# verifica se é uma data futura
    end if;
    START TRANSACTION;
    
		IF(test1=0 AND test2 = 1 AND test3=0 and test4 = 0) THEN 
			SET sucesso = 1;
			INSERT INTO Teste
			(idAtleta, medico, data, flag, preço)
			VALUES (idA,med,dat,'N',pre);
		END IF;
	
        IF sucesso THEN 
            select('Teste marcado!')
            COMMIT;
		ELSE 
            select('Marcação inválida!')
            ROLLBACK;
		END IF;
END $$

set @idA = 8;
set @med = 'Dr.Marco';
set @dat = '2020-01-04';
CALL marcarTeste (@idA,@med,@dat);
Select * from teste where idATleta = 8;

DROP PROCEDURE marcarTeste;

#Marcar uma prova
DELIMITER $$
CREATE PROCEDURE adicionarProva (IN idM INT,IN idC INT,IN nomeP VARCHAR(45), IN dat DATETIME)
BEGIN
    DECLARE test1 INT;
    DECLARE test2 INT;
    DECLARE test3 INT;
    DECLARE sucesso BOOL DEFAULT 0;
    
	SET autocommit = 0;
	SET test1 = (Select count(idProva) from Prova p where p.nome= nomeP and p.data = dat and p.flag='N' and p.idModalidade = idM and p.idCategoria = idC and p.data > now());
    SET test2 = (Select count(idCategoria) from Categoria c where c.idModalidade= idM and c.idCategoria = idC);
	IF dat > now() then set test3 = 0;
    end if;
    
    START TRANSACTION;
    
		IF(test1=0 AND test2 = 1 AND test3=0) THEN 
			SET sucesso = 1;
			INSERT INTO  Prova 
		(idModalidade, idCategoria, nome, flag, data, vencedor1, vencedor2, vencedor3) 
		VALUES 
		(idM, idC,nomeP,'N', dat, NULL, NULL, NULL);
		END IF;
	
        IF sucesso THEN 
            select('Prova marcado!')
            COMMIT;
		ELSE 
            select('Marcação inválida!')
            ROLLBACK;
		END IF;
                    
END $$

set @idM = 1;
set @idC = 1;
set @nomeP = 'Corrida';
set @dat = '2020-01-04';
CALL adicionarProva (@idM , @idC,@nomeP,@dat);

DROP PROCEDURE adicionarProva;

#Adicionar um atleta
DELIMITER $$
CREATE PROCEDURE addAtleta (IN nomeA VARCHAR(45), IN dat DATETIME, IN gen CHAR(1),IN nac VARCHAR(45), IN mor VARCHAR(45), IN modl VARCHAR(45))
BEGIN
    DECLARE test1 INT;
    DECLARE test2 INT;
    DECLARE test3 INT;
	DECLARE mol int;
    DECLARE sucesso BOOL DEFAULT 0;
    
	SET autocommit = 0;
	SET test1 = (Select count(idAtleta) from Atleta a where a.nome = nomeA and a.data_nascimento = dat);#ver se atleta existe
    SET test2 = (Select count(idModalidade) from Modalidade c where c.designacao= modl and c.genero = gen);#ver se Modalidade existe
	IF dat < now() then set test3 = 0;# verifica se é uma data passada
    END IF;
 
    
    START TRANSACTION;
    
		IF(test1=0 AND test2 = 1 AND test3=0) THEN 
			SET sucesso = 1;
			set mol = (select m.idModalidade from Modalidade m where m.designacao = modl and m.genero = gen);
			INSERT INTO Atleta 
		(nome, data_nascimento, genero, nacionalidade, morada, idModalidade) 
		VALUES 
        (nomeA,dat,gen,nac,mor,mol);
		END IF;
	
        IF sucesso THEN 
            select('Atleta adicionado!')
            COMMIT;
		ELSE 
            select('Adição inválida!')
            ROLLBACK;
		END IF;
                    
END $$

set @nomeA = 'Rui Torres';
set @dataN = '2010-06-30';
set @gen = 'M';
set @nac = 'Português';
set @loc = 'Barcelos';
set @modl = 'Velocidade';

CALL addAtleta (@nomeA,@dataN,@gen,@nac,@loc,@modl);

DROP PROCEDURE addAtleta;