MATCH (p:Prova)-[:Disputada]->(a:Atleta)
where p.vencedor1 = a.idAtleta
return a.nome as atl,Count(p.vencedor1) as cnt
order by cnt DESC, a.nome
Limit 3;