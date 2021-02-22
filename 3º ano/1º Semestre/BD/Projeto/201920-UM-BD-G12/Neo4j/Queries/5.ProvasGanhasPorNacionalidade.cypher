MATCH (p:Prova)-[r:Disputada]->(a:Atleta)
where p.vencedor1 = a.idAtleta 
return a.nacionalidade , Count(a.nacionalidade) as cnt
order by cnt DESC;