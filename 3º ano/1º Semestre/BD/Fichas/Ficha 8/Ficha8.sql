/* (a) */
DELIMITER $$
CREATE PROCEDURE AtualizarPrecoEspecialidade(IN perc int, IN ano int)
BEGIN

DECLARE v_finished integer default 0;
DECLARE v_designacao varchar (100);
DECLARE v_media decimal(5,2);

DECLARE designacao_cursor CURSOR FOR

SELECT e.designacao, avg(c.preco)
FROM ESCPECIALIDADE e, MEDICO m, CONSULTA c
WHERE e.id_especialidade=m.especialidade and m.id_medico = c.id_medico and YEAR(c.data_hora) = ano
GROUP BY e.desigancao;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

OPEN designacao_cursor;
get_designacao:LOOP
    FETCH designacao_cursor into v_designacao, v_media;
    IF v_finished = 1 THEN
		LEAVE get_designacao;
	END IF;
    UPDATE ESPECIALIDADE SET preco = (v_media*(perc/100)) WHERE designacao = v_designacao;
    
END LOOP;
CLOSE designacao_cursor;

END$$

/* (b) */

SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER $$
CREATE FUNCTION TemConsultas(id int) RETURNS bool
NOT DETERMINISTIC
BEGIN

DECLARE temConsultas bool;
DECLARE val int;

SELECT count(1) into val
FROM MEDICO m, CONSULTA c
WHERE m.id_medico = c.id_medico and m.id_medico = id;

if (val < 1) THEN
SET temConsultas = false;
else
SET temConsultas = true;
END if;

RETURN temConsultas;
END
$$
DELIMITER ;

/* Testar */
Insert into MEDICO values (12,'medico1','rua','4700-001','1999-09-09',1,'2000-01-01');
DELETE FROM MEDICO WHERE temConsultas(id_medico) = false;
SELECT * FROM MEDICO;

/* (c) */
DELIMITER $$
CREATE FUNCTION CodigoPostalUsado(id int) RETURNS bool
NOT DETERMINISTIC
BEGIN

DECLARE usado bool;
DECLARE resultado int;

SELECT count(1) into resultado
FROM MEDICO m, PACIENTE p
WHERE m.cdigo_postal = CodPostal or p.codigo_postal = CodPostal;

if (resultado < 1) THEN
SET usado = false;
else
SET usado = true;
END if;

RETURN usado;
END
$$
DELIMITER ;

/* Testar */
DELETE FROM CODIGO_POSTAL WHERE CodigoPostalUsado(codigo_postal) = 0;
SELECT CodigoPostalUsado(codigo_postal), codigo_postal
from CODIGO_POSTAL;

/* (d) */
alter table MEDICO
ADD column totalfaturado decimal(10,2);

DELIMITER $$
CREATE TRIGGER acumularFaturado
AFTER INSERT ON CONSULTA
FOR EACH ROW
BEGIN

UPDATE MEDICO
SET totalFaturado = totalFaturado + new.preco;

END
$$

/* Testar */
SELECT nome, totalfaturado FROM MEDICO;

/* (e) */
SELECT * FROM MEDICO;

CREATE VIEW MEDICOS_ESPECIALIDADE AS
SELECT m.nome, e.designacao
FROM MEDICO m, ESPECIALIDADE e
WHERE m.especialidade = e.id_especialidade;

SELECT * FROM MEDICOS_ESPECIALIDADE;

CREATE VIEW PACIENTE_ACUMULADO AS
SELECT id_paciente, MONTH(data_hora) as mes, YEAR(data_hora) as ano, sum(preco) as valor
FROM CONSULTA c
GROUP BY c.id_paciente, mes, ano;

/* Testar */
SELECT * FROM PACIENTE_ACUMULADO;

/* (f) */
CREATE VIEW MensalEspecialidade AS
SELECT especialidade, MONTH(data_hora) as mes,
YEAR(data_hora) as ano, sum(preco) as valor
FROM MEDICO m, CONSULTA c
WHERE m.id_medico = c.id_medico
GROUP BY especialidade, mes, ano;

/* Testar */
SELECT * FROM MensalEspecialidade;