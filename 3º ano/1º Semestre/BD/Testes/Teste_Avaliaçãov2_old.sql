#6.a ---------------------------------------------------
SELECT p.id_paciente, p.Nome
FROM PACIENTE p, CONSULTA c
WHERE p.id_paciente = c.id_paciente
AND c.id_paciente in ( 
		SELECT id_paciente
		FROM PACIENTE p, CODIGO_POSTAL cp
		WHERE p.codigo_postal = cp.codigo_postal
    	AND cp.localidade = 'Braga')
AND c.id_medico in ( 
		SELECT id_medico
		FROM MEDICO m, ESPECIALIDADE s
		WHERE m.especialidade = s.id_especialidade
    	AND s.designacao = 'Clinica Geral')
GROUP BY p.id_paciente; #só para não termos repetidos

#6.b ---------------------------------------------------
SELECT e.id_especialidade, e.designacao
FROM ESPECIALIDADE e, MEDICO m, CONSULTA c
WHERE e.id_especialidade = m.especialidade
AND m.id_medico = c.id_medico
AND idade( m.data_nascimento) > 50
AND c.id_paciente in (
	SELECT id_paciente
    FROM PACIENTE p, CODIGO_POSTAL cp
    WHERE p.codigo_postal = cp.codigo_postal
	AND cp.localidade = 'Vila Verde')
GROUP BY e.id_especialidade;

#6.c ---------------------------------------------------
SELECT nome
FROM MEDICO
WHERE idade(data_inicio_servico) > 15;

#7.a ---------------------------------------------------
SELECT @@sql_mode;
SET sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

SELECT m.nome, e.designacao
FROM MEDICO m, ESPECIALIDADE e, CONSULTA c
WHERE m.id_medico = c.id_medico
AND m.especialidade = e.id_especialidade
AND year(c.data_hora) = 2016
GROUP BY e.designacao;

#7.b. ---------------------------------------------------
SELECT m.nome, idade(m.data_nascimento)
FROM MEDICO m
WHERE m.nome not in(
	SELECT m.nome
	FROM MEDICO m, CONSULTA c
	WHERE m.id_medico = c.id_medico
	AND c.id_paciente in ( 
		SELECT id_paciente
		FROM PACIENTE p, CODIGO_POSTAL cp
		WHERE p.codigo_postal = cp.codigo_postal
    	AND cp.localidade = 'Guimarães')
	GROUP BY m.nome); 

#7.c. ---------------------------------------------------

#7.d. ---------------------------------------------------
SELECT count(c.id_medico) as Total #muda o título da coluna
FROM MEDICO m, CONSULTA c
WHERE m.nome = 'Zé Manel'
AND year(c.data_hora) = 2016;

#7.e (adicional - Apresentar todos os médicos, mesmo os que nunca tiveram uma consulta)

# Deste modo, não apresenta o médico sem consultas...
SELECT m.nome as Nome, count(c.id_medico) as Total
from MEDICO m, CONSULTA c
WHERE c.id_medico = m.id_medico
group by m.id_medico
order by Nome;

#... Mas deste modo já mostra.
/* Como faz LEFT JOIN, vai mostrar também os elementos da tabela da esquerda (MEDICO) que não foram selecionados, isto é, mesmo
				que não um médico não tenha feito nenhuma consulta, vai ser apresentado na mesma*/
SELECT m.nome as Nome, count(c.id_medico) as Total
from MEDICO m
LEFT JOIN CONSULTA c
ON c.id_medico = m.id_medico
group by m.id_medico
order by Nome;