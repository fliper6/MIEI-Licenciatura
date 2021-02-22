
Select a.nome , idade(a.data_nascimento) as idadeMin
from Prova p 
INNER JOIN Atleta a on p.vencedor1 = a.idAtleta
group by a.idAtleta
order by idadeMin ASC
LIMIT 1;
