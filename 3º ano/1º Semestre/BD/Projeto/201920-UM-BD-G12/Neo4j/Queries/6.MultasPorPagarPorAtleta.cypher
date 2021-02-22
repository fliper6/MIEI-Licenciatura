MATCH (m:Multa)-[r:Paga_por]->(a:Atleta)
where m.idAtleta = a.idAtleta and m.flag = 'N'
return a.nome, m.idMulta, m.valor, m.flag
order by a.nome;