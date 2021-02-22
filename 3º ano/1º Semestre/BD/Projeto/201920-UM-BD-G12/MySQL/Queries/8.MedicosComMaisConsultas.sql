# Apresente os nomes dos três médicos que fizeram mais testes.
SELECT t.medico as NomeMedico, count(t.idTeste) as TotalTestes # ou count(m.id_medico) / count(c.id_medico)
from Teste t
where t.flag = 'S'
group by t.medico
order by TotalTestes DESC, t.medico
LIMIT 3;



