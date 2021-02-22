use mydb;

#1 meu
select PagCaderneta from (
	select j.Nr as Numero from Jogador j, Equipa e, Posicao p
    where j.Equipa = e.Id
    and (e.Designacao = 'Sporting Clube de Braga' or e.Designacao = 'Rio Ave Futebol Clube')
    and p.Id = j.Posicao 
    and p.Designacao = 'Defesa') as Jogadores_Equipa, Cromo cr
where Jogadores_Equipa.Numero = cr.Nr;

#1 do stor 
select j.nome, e.Designacao, c.PagCaderneta
from Equipa e, Jogador j, Cromo c, Posicao p 
where (e.Designacao = 'Sporting Clube de Braga' or e.Designacao = 'Rio Ave Futebol Clube')
	and p.designacao = 'Defesa'
    and j.Posicao = p.Id
    and e.id = j.Equipa 
    and c.Jogador = j.Nr;

#2 do stor
select j.nome
from Jogador j, Equipa e
where j.nr not in (select j.nr
	from Jogador j, Posicao p, Equipa e 
    where j.posicao = p.id and (p.designacao = 'Defesa' or p.designacao = 'Médio'))
    and e.id = j.equipa 
    and (e.treinador = 'Jorge Jesus' or e.treinador = 'Nuno Espírito Santo');
    
#3 do stor 
# a view nao e materializada, ou seja, caso mudemos algum dos campos nas tabelas originais (mudar Boavista Futebol Clube
# para Futebol Clube Boavista p.e, ela muda sozinha.
create view CromoEmFalta as select j.Nome, e.designacao, c.Nr
from Equipa e, Jogador j, Cromo c
where e.id = j.equipa 
and c.jogador = j.nr and c.Adquirido = 'N';

select * from CromoEmFalta;

#4 do stor
DELIMITER // 
create procedure ex4 (IN equipaX VARCHAR(45))
BEGIN 
	select c.*
    from Equipa e, Cromo c, Jogador j 
    where c.jogador = j.Nr and j.equipa = e.id 
		and e.designacao = equipaX
	order by c.PagCaderneta, c.Nr ASC;
END 
//
DELIMITER ;

# os delimiters nao precisam de ter nomes diferentes, pus diferentes ate agora mas o erro era outro
CALL ex4('Sport Lisboa e Benfica');

#5 do stor
DELIMITER //
create procedure ex5 ()
BEGIN 
	select Cromo.Nr, TipoCromo.Descricao, Jogador.Nome, Equipa.designacao, Cromo.Adquirido
    from Cromo
    LEFT OUTER JOIN Jogador ON Cromo.jogador = Jogador.nr #todos sem correspondencia a direita ficam null, mas sao adicionados
    LEFT OUTER JOIN Equipa ON Jogador.Equipa = Equipa.id # " " " " " 
    INNER JOIN TipoCromo ON Cromo.Tipo = TipoCromo.nr; # todos os com correspondencia sao adicionados, se nao, nao sao
END 
//
DELIMITER ; 

call ex5();

#6 do stor
DELIMITER // 
create function ex6(NrCromo INT)
returns char(1) not deterministic
BEGIN
	declare adquirido char(1);
    select Cromo.adquirido INTO adquirido
    from Cromo where Cromo.Nr = nrCromo;
    
    return adquirido;
END
//
DELIMITER ;

#7 do stor
DELIMITER // 
create function ex7(NrCromo INT)
returns varchar(200) NOT DETERMINISTIC
BEGIN
	declare tipo varchar(75);
    declare jogador varchar(75);
    declare equipa varchar(45);
    
    select TipoCromo.descricao, Jogador.nome, Equipa.designacao into tipo, jogador, equipa
    from TipoCromo, Jogador, Equipa, Cromo 
    where Cromo.tipo = TipoCromo.nr
    and Cromo.jogador = Jogador.nr
    and Jogador.equipa = Equipa.id 
    and Cromo.nr = nrCromo;
    
    RETURN (concat(tipo,",",jogador,",",equipa));
END //
DELIMITER ;

select ex7(87); # chamar a funcao   

CREATE TABLE audCromos (numeroCromo int, date DATETIME);
DELIMITER $$ 
create trigger after_cromo_update
after update on Cromo 
for each row 
BEGIN 
	if(old.Adquirido = 'N' and new.Adquirido = 'S')
    then insert into audCromos values (NEW.Nr, NOW());
    end if;
END $$
DELIMITER ;

update Cromo set Adquirido = 'S' where Cromo.nr = 37;
select * from audCromos;
