#4.provas que certo atleta ficou no podio
DELIMITER $$
CREATE PROCEDURE provasGanhas (IN idA INT)
BEGIN
	select a.nome, p.data , p.nome, p.vencedor1 , p.vencedor2, p.vencedor3, m.designacao as Modalidade , c.designacao 
    from prova p , Atleta a, modalidade m , Categoria c
    where m.idModalidade = p.idModalidade and c.idCategoria = p.idCategoria and a.idAtleta = idA and (p.vencedor1 = idA or p.vencedor2 = idA or p.vencedor3 = idA);
    
END$$

SET @idA = 10;
CALL provasGanhas(@idA);

DROP PROCEDURE provasGanhas;