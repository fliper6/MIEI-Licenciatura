#atualizar flag de teste (meter que o cliente apareceu ou cancelar)
DELIMITER $$
CREATE PROCEDURE atualizarTeste (IN idT INT, IN flag CHAR(1))
BEGIN
	declare test INT;
    set test = (Select count(idTeste) from Teste t where t.idTeste = idT and t.flag = 'N') ;
	if test = 1 
    then 
    UPDATE Teste set flag = flag where idTeste = idT;
	end if;
END$$

SET @idT = 13;
SET @flg = 'N';
CALL atualizarTeste(@idT,@flg);
select * from teste where idTeste = 13;
DROP PROCEDURE atualizarTeste;


#pagar uma Multa
DELIMITER $$
CREATE PROCEDURE pagarMulta (IN idM INT)
BEGIN
	declare test INT;
    set test = (Select count(idMulta) from Multa t where t.idMulta = idM and t.flag = 'N') ;
	if test = 1 
    then 
    UPDATE Multa set flag = 'S' where idMulta = idM;
	end if;
END$$


CALL pagarMulta(1);
select * from Multa where idMulta = 1;
DROP PROCEDURE pagarMulta;


#inscrever um atleta numa prova
DELIMITER $$
CREATE PROCEDURE inscreverProva (IN idP INT,IN idA INT)
BEGIN
	declare test1 INT;
    declare test2 INT;
	declare test3 INT;
    declare test4 INT;
    set test1 = (Select count(idAtleta) from Multa m where m.idAtleta = idP and m.flag = 'N');
    set test2 = (Select count(idProva) from Prova t where t.idProva = idP and t.flag = 'N' and t.data > now());
    set test3 = (Select count(idAtleta) from Atleta t where t.idAtleta = idA);
    set test4 = (Select count(idTeste) from Teste t where t.idAtleta = idA and (t.data >=  NOW() - INTERVAL 1 WEEK) and t.flag = 'S');
    
	if (test1 = 0 and test2 = 1 and test3 = 1 and test4 = 1)
    then 
	INSERT INTO Provas_Atleta
	(idProva, idAtleta)
    VALUES	(idP,idA);
	end if;
END$$

set @idP = 1;
set @idA = 11;
CALL inscreverProva(@idP,@idA);
select * from Provas_Atleta;

DROP PROCEDURE inscreverProva;


#um atleta desiste de uma prova
DELIMITER $$
CREATE PROCEDURE desistirProva (IN idP INT,IN idA INT)
BEGIN
	declare test1 INT;
	declare test2 INT;
	declare test3 INT;
    set test1 = (Select count(idProva) from Provas_Atleta t where t.idProva = idP and t.idAtleta = idA) ;
    set test2 = (Select count(idProva) from Prova t where t.idProva = idP and t.flag = 'N' and t.data >= now());
    set test3 = (Select count(idAtleta) from Atleta t where t.idAtleta = idA);
	if (test1 = 1 and test2 = 1 and test3 = 1)
    then 
	Delete From Provas_Atleta 
    where idProva = idP and idAtleta = idA;
	end if;
END$$

set @idP = 1;
set @idA = 11;
CALL desistirProva(@idP,@idA);
select * from Provas_Atleta;

DROP PROCEDURE desistirProva;

#atualizar flag de prova para indicar que foi cancelada
DELIMITER $$
CREATE PROCEDURE cancelarProva (IN idP INT)
BEGIN
	declare test INT;
    set test = (Select count(idProva) from Prova t where t.idProva = idP and t.flag = 'N' and t.data >= now());
	if test = 1 
    then 
	UPDATE Prova set flag = 'S' where idProva = idP;
	end if;
END$$

set @idP = 5;
CALL cancelarProva(@idP);
select * from Prova where idProva = 5;

DROP PROCEDURE cancelarProva;


#atualizar vencedores de uma prova
DELIMITER $$
CREATE PROCEDURE atualizarVencedoresProva (IN idP INT, IN idA1 INT, IN idA2 INT, IN idA3 INT)
BEGIN
	declare test INT;
    declare test1 INT;
    declare test2 INT;
    declare test3 INT;
    set test = (Select count(idProva) from Prova t where t.idProva = idP and t.flag = 'N') ;
    set test1 = (Select count(idAtleta) from Atleta t where t.idAtleta = idA1);
    set test2 = (Select count(idAtleta) from Atleta t where t.idAtleta = idA2);
    set test3 = (Select count(idAtleta) from Atleta t where t.idAtleta = idA3);
    
	if (test = 1 and test1 = 1 and test2 = 1 and test3 = 1)
    then 
	UPDATE Prova t set t.vencedor1 = idA1 , t.vencedor2 = idA2 , t.vencedor3 = idA3 where t.idProva = idP;
	end if;
END$$

set @idP = 6;
set @idA1 = 9;
set @idA2 = 1;
set @idA3 = 2;
CALL atualizarVencedoresProva(@idP,@idA1,@idA2,@idA3);
select * from Prova where idProva = 6;

DROP PROCEDURE atualizarVencedoresProva;