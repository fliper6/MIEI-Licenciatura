DELIMITER $$
CREATE PROCEDURE atletasProva (IN idP INT)
BEGIN
	select a.nome, a.data_nascimento , a.genero, a.nacionalidade ,p.nome as NomeProva, p.data, m.designacao as Modalidade, c.designacao as Categoria
    from Provas_atleta pa
    INNER JOIN Atleta a on pa.idAtleta = a.idAtleta and pa.idProva = idP
    INNER JOIN prova p on p.idProva = idP 
    INNER JOIN modalidade m on m.idModalidade= p.idModalidade
	INNER JOIN categoria c on c.idCategoria= p.idCategoria;

END$$

SET @idP = 2;
CALL atletasProva(@idP);

DROP PROCEDURE atletasProva;