MATCH (p:Prova)-[r:Disputada]->(a:Atleta)-[:Pratica]->(m:Modalidade)
where a.idAtleta = 10 and (p.vencedor1 = 10 or p.vencedor2 = 10 or p.vencedor3 = 10) 
return a.nome, p , m.designacao;