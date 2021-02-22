#Multas a pagar por atleta
create view MultasAPagar as SELECT m.idAtleta, a.nome, m.idMulta , m.valor, m.idTeste, m.flag
FROM Atleta a
INNER JOIN Multa m on a.idAtleta = m.idAtleta
where m.flag = 'N'
order by m.idAtleta ASC;  


select * from MultasAPagar;
Drop view MultasAPagar;

