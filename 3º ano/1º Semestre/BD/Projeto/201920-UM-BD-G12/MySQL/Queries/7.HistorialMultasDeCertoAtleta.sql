DELIMITER $$
CREATE PROCEDURE historialMultas (IN idA INT)
BEGIN
	SELECT a.nome as Nome ,m.idMulta, t.medico as Médico, t.data as Data, t.preço as PreçoConsulta,
           m.valor as ValorMulta , m.flag as Flag
    from Atleta a, Multa m, Teste t
	where a.idAtleta = idA and m.idAtleta = idA and t.idTeste = m.idTeste;
END$$

#definir variavel para passar à função
SET @idA = 4;
CALL historialMultas(@idA);

#para apagar o procedure
DROP PROCEDURE historialMultas;