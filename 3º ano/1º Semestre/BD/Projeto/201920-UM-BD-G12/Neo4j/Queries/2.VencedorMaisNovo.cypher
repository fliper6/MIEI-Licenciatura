MATCH (p:Prova)-[:Disputada]->(a:Atleta)
where p.vencedor1 = a.idAtleta
return a.nome as atl, a.data_nascimento 
order by a.data_nascimento DESC , a.nome
Limit 1;