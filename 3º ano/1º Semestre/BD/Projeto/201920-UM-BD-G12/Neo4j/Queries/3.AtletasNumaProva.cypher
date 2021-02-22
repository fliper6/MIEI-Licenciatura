MATCH (p:Prova)-[r:Disputada]->(a:Atleta)-[:Pratica]->(m:Modalidade)
where p.idProva = 2 
return p.idProva, a.nome, a.data_nascimento, a.nacionalidade ,m.designacao;