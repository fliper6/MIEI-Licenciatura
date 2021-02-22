Use mydb;

/* 1 */
create table ListaFaltas (
	NrCromo INT PRIMARY KEY
);

/* 2 */
insert into ListaFaltas (NrCromo) select Nr from Cromo where adquirido = 'N';

select * from ListaFaltas;

/* 3 - explicação */ 
SET AUTOCOMMIT = OFF;

UPDATE Cromo set adquirido = 'S' where nr = 70;
SELECT * from Cromo where nr = 70;

ROLLBACK

/* 3 - Resolução */
DELIMITER //
CREATE PROCEDURE ex3(IN_NrCromo INT)
BEGIN
	DECLARE erro BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET erro = 1;
    
    SET AUTOCOMMIT = OFF;
    -- Começa uma nova transação
    START TRANSACTION;
    
    -- Lógica
    UPDATE Cromo set adquirido = 'S' where nr = _NrCromo;
    DELETE FROM ListaFaltas WHERE NrCromo = _NrCromo;
    
    -- Handle ERROR by doing the rollback to a previous valid state
    IF (erro) THEN
		ROLLBACK;
	END IF;
    
    -- if everything is OK then COMMIT DIE
    COMMIT;

END//

DELIMITER ;

/* 4 */
DELIMITER //
CREATE PROCEDURE ex4(IN_NrCromo INT)
BEGIN
	DECLARE erro BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET erro = 1;
    
    SET AUTOCOMMIT = OFF;
    -- Começa uma nova transação
    START TRANSACTION;
    
    -- Lógica
    UPDATE Cromo set adquirido = 'N' where nr = _NrCromo;
    INSERT INTO ListaFaltas values (_NrCromo);
    
    -- Handle ERROR by doing the rollback to a previous valid state
    IF (erro) THEN
		ROLLBACK;
	END IF;
    
    -- if everything is OK then COMMIT DIE
    COMMIT;

END//

DELIMITER ;

/* 5 */
DELIMITER **
CREATE TRIGGER atualizaListaFaltas AFTER UPDATE ON Cromo
	FOR EACH ROw
    BEGIN
		IF (OLD.Adquirido = 'N' AND NEW.Adquirido = 'S') THEN
			DELETE FROM ListaFaltas WHERE NrCromo = OLD.Nr;
		END IF;
	END **

DELIMITER ;
/* 6 */

DELIMITER //
CREATE PROCEDURE listagem(IN idEquipa CHAR(3), OUT result_list varchar(2000))
	BEGIN
    
    DECLARE v_finished integer default 0;
    DECLARE v_treinador varchar(50);
    DECLARE v_nome_equipa varchar(45);
    DECLARE v_nome_jogador varchar(75);
    DECLARE v_posicao varchar(20);
    
    DECLARE jogador_cursor CURSOR FOR
		SELECT j.Nome, p.Designacao FROM Jogador j, Posicao P WHERE j.posicao = p.id and j.Equipa = idEquipa;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;
    
        
	SELECT treinador, designacao into v_treinador, v_nome_equipa
		FROM Equipa WHERE Id = idEquipa;
    
    SET result_list = CONCAT(v_nome_equipa,";",v_treinador);
    
    OPEN jogador_cursor;
    get_jogador : LOOP
		FETCH jogador_cursor into v_nome_jogador, v_posicao;
        IF v_finished = 1 THEN
			LEAVE get_jogador;
		END IF;
        
        SET result_list = CONCAT(v_nome_jogador,":",v_posicao,";",result_list);
	END LOOP;
    CLOSE jogador_cursor;
END //

DELIMITER ;

/* Testar */
SET @res = "";
CALL listagem('SLB',@res);
SELECT @res;

