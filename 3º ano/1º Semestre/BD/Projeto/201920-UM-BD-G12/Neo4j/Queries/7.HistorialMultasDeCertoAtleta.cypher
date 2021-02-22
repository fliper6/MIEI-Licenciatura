MATCH (m:Multa)-[r:Paga_por]->(a:Atleta)
where m.idAtleta = 4
return a.nome, m.idMulta, m.valor, m.flag
order by a.nome;