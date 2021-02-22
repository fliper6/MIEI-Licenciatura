#   Total faturado consultas + multas
SELECT ((Select Sum(t.preço) from Teste t where t.flag = 'S')+(Select Sum(m.valor) from Multa m where m.flag = 'S')) as TotalFaturado;