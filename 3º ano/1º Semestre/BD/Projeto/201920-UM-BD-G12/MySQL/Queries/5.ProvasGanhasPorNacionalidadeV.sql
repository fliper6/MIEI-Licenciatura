#ProvasGanhasPorNacionalidade
create view ProvasGanhasPorNacionalidade as Select a.nacionalidade, count(p.vencedor1) as NtProvasGanhas
from Prova p
inner join Atleta a on a.idAtleta = p.vencedor1
group by a.nacionalidade
order by NtProvasGanhas desc;

select * from ProvasGanhasPorNacionalidade;
