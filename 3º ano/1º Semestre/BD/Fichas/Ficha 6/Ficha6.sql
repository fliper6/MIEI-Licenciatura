#2.a
SELECT nome FROM MEDICO WHERE idade (data_inicio_servico) > 10;

#2.b
SELECT * FROM MEDICO m
INNER JOIN ESPECIALIDADE e
ON e.id_especialidade = m.especialidade;
#ou
SELECT m.nome, e.designacao
FROM MEDICO m, ESPECIALIDADE e
where e.id_especialidade = m.especialidade;

#2.c
SELECT p.nome, p.morada
FROM PACIENTE p, CODIGO_POSTAL c
where p.codigo_postal = c.codigo_postal and c.localidade = 'Braga';

#2.d
SELECT m.nome
FROM MEDICO m, ESPECIALIDADE e
where m.especialidade = e.id_especialidade and e.designacao = 'Oftalmologia';

#2.e
SELECT m.nome, idade(m.data_nascimento) as Idade
FROM MEDICO m, ESPECIALIDADE e
where idade(m.data_nascimento) > 40 and m.especialidade = e.id_especialidade and e.designacao = 'Clinica geral';

#2.f
SELECT m.nome
FROM MEDICO m, ESPECIALIDADE e, PACIENTE p, CONSULTA cs, CODIGO_POSTAL cp
where m.especialidade = e.id_especialidade and e.designacao = 'Oftalmologia' and
cs.id_medico = m.id_medico and cs.id_paciente = p.id_paciente and
p.codigo_postal = cp.codigo_postal and cp.localidade = 'Braga';

SELECT distinct m.nome 
from MEDICO m, CONSULTA c
where m.id_medico=c.id_medico
and c.id_medico in ( 
	SELECT id_medico
    from MEDICO m, ESPECIALIDADE e
    where m.especialidade = e.id_especialidade
    and e.designacao = 'Oftalmologia')
and c.id_paciente in (
	SELECT id_paciente
    from PACIENTE p, CODIGO_POSTAL cp
    where cp.codigo_postal = p.codigo_postal
    and cp.localidade = 'Braga');

#2.g
SELECT distinct m.nome, idade(m.data_inicio_servico)
from CONSULTA c, MEDICO m, PACIENTE p
where c.id_medico = m.id_medico
and c.id_paciente = p.id_paciente
and c.id_medico in (SELECT id_medico from MEDICO where idade(data_nascimento) > 50)
and c.id_paciente in (SELECT id_paciente from PACIENTE where idade(data_nascimento) < 20)
and hour(data_hora) > 13;

#2.h
SELECT distinct p.nome, idade(p.data_nascimento)
from MEDICO m, CONSULTA c, PACIENTE p, ESPECIALIDADE e
where c.id_paciente = p.id_paciente
and m.id_medico = c.id_medico
and e.id_especialidade = m.especialidade
and idade(p.data_nascimento) > 10
and c.id_paciente not in (
  SELECT p.id_paciente
    from MEDICO m, CONSULTA c, PACIENTE p, ESPECIALIDADE e
    where c.id_paciente = p.id_paciente
    and m.id_medico = c.id_medico
    and e.id_especialidade = m.especialidade
    and e.designacao = 'Oftalmologia');
    
#2.i
select distinct e.designacao
from CONSULTA c, MEDICO m, ESPECIALIDADE e
where e.id_especialidade = m.especialidade
and c.id_medico = m.id_medico
and month(data_hora) = 1
and year(data_hora) = 2016;

#2.j
SELECT nome
from MEDICO 
where idade(data_nascimento) > 30
or idade(data_inicio_servico) < 5;

#2.k
select distinct m.id_medico nome, idade(data_nascimento)
from MEDICO m, ESPECIALIDADE e, CONSULTA c
where m.especialidade = e.id_especialidade
and e.designacao = 'Clinica Geral'
and c.id_medico = m.id_medico
and c.id_medico not in (select c.id_medico from CONSULTA c where month(data_hora) = 1 and year(data_hora) = 2016);

#2.l
select id_paciente
from consulta
where id_medico in (select id_medico from MEDICO) group by id_paciente having COUNT(*) = (select COUNT(*) from MEDICO);

#2.m
select distinct e.designacao
from CONSULTA c
INNER JOIN MEDICO m
on m.id_medico = c.id_medico
INNER JOIN ESPECIALIDADE e
on e.id_especialidade = m.especialidade
where month(data_hora) = 1 or month(data_hora) = 3 or year(data_hora) = 2016;

#2.n
SELECT distinct m.nome
from CONSULTA c, MEDICO m
where c.id_medico = m.id_medico
and c.id_paciente not in (
	SELECT p.id_paciente
    from PACIENTE p, CODIGO_POSTAL cp, CONSULTA C 
    where c.id_paciente = p.id_paciente
    and cp.codigo_postal = p.codigo_postal
    and cp.localidade = 'Braga');

#2.o
select distinct p.id_paciente, p.nome
from PACIENTE p, CONSULTA c
where p.id_paciente = c.id_paciente
and c.id_paciente not in (
  select p.id_paciente
  from PACIENTE p, CONSULTA c, MEDICO m, ESPECIALIDADE e
  where p.id_paciente = c.id_paciente
  and m.especialidade = e.id_especialidade
  and m.id_medico = c.id_medico
  and c.id_medico not in (
    select id_medico
    from MEDICO m, ESPECIALIDADE e
    where m.especialidade = e.id_especialidade
    and e.designacao = 'Clinica Geral'
  )
);