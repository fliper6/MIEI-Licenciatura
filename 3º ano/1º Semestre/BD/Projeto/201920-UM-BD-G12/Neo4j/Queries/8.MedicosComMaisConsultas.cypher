MATCH (p:Teste)
where p.flag = "S"
return p.medico as Médico , Count(p.medico) as NrDeConsultasDadas
order by NrDeConsultasDadas DESC , p.medico
Limit 3;