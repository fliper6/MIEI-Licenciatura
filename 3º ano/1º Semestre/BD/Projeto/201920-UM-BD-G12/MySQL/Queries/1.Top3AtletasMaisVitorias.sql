# Top 3 Atletas que ganharam mais provas
SELECT  a.nome , a.data_nascimento, a.genero, a.nacionalidade, m.designacao , Count(p.vencedor1) as TotalProvasGanhas 
from Prova p
INNER JOIN Atleta a on a.idAtleta = p.vencedor1
INNER JOIN Modalidade m on m.idModalidade = a.idModalidade
group by p.vencedor1
order by TotalProvasGanhas DESC, a.nome ASC
LIMIT 3;


