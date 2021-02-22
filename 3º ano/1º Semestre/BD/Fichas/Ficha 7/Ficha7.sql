#2.a
SELECT AVG(idade(data_nascimento)) FROM MEDICO
where idade(data_inicio_servico) > 15;

#2.b
SELECT e.designacao as Especialidade,
AVG(idade(data_inicio_servico)) as Média
from MEDICO m, ESPECIALIDADE e
WHERE m.especialidade = e.id_especialidade
group by e.id_especialidade
order by Especialidade;
#order by Média DESC - ordenar por ordem decrescente
#limit 1; - mostrar apenas a primeira coluna

#2.c
#apresentar todos os médicos, mesmo os que nunca tiveram uma consulta
#queremos fazer um left join, porque queremos TODOS os médicos mas apenas as consultas em comum
SELECT m.nome as Nome, count(c.id_medico) as Total
from MEDICO m
LEFT JOIN CONSULTA c
ON c.id_medico = m.id_medico
group by m.id_medico
order by Nome;

#2.d
SELECT AVG(idade(p.data_nascimento)) as Média, cp.localidade as Localidade
from PACIENTE p, CODIGO_POSTAL cp
where p.codigo_postal = cp.codigo_postal
group by cp.localidade
order by cp.localidade;

#2.e
select m.nome as Nome, ifnull(sum(c.preco),0) as Total_Faturado #ifnull substitui null por 0
from MEDICO m
left join CONSULTA c
on m.id_medico = c.id_medico
#'on' funciona como um where, por isso podemos usar 'and' a seguir para aparecerem os médicos que não faturaram
and year(c.data_hora) = 2016
group by m.nome
order by Total_Faturado desc;

#2.f
select e.designacao as Especialidade, count(m.id_medico) as Numero_Medicos
from ESPECIALIDADE e, MEDICO m
where e.id_especialidade = m.especialidade
group by e.designacao
order by Numero_Medicos;

#2.g
select partial_table.designacao as Especialidade, min(c.preco) as Minimo, max(c.preco) as Maximo, avg(c.preco) as Media
from (select designacao, e.id_especialidade, count(m.id_medico) as Total
from ESPECIALIDADE e, MEDICO m
where e.id_especialidade = m.especialidade
group by e.id_especialidade) as partial_table,
MEDICO m, CONSULTA c
where c.id_medico = m.id_medico
and m.especialidade = partial_table.id_especialidade
and partial_table.total < 2
group by partial_table.id_especialidade;

#2.h
select m.nome as Nome, sum(preco) as Faturado
from CONSULTA c, MEDICO m
where c.id_medico = m.id_medico and year(c.data_hora) = 2016
group by m.id_medico
having sum(preco) > (select avg(faturado2016.faturado)
from (select m.nome, sum(preco) as faturado
		from CONSULTA c, MEDICO m
        where c.id_medico = m.id_medico
        and year(c.data_hora) = 2016
        group by m.id_medico) as faturado2016);
        
#2.i
select designacao as Especialidade, sum(c.preco) as Faturado
from CONSULTA c
inner join MEDICO m
on c.id_medico = m.id_medico
inner join ESPECIALIDADE e
where year(c.data_hora) = 2016
group by id_especialidade
order by sum(c.preco) desc
limit 1;

#2.j
select m.nome as Nome, count(m.id_medico) as Total #ou count(1) as Total
from MEDICO m, CONSULTA c
where m.id_medico = c.id_medico
and year(c.data_hora) = 2016
group by c.id_medico
order by Total desc, m.nome
limit 3;