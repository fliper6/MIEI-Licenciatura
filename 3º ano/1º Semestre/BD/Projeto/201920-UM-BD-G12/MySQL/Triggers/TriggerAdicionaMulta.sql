DELIMITER $$ 
create trigger after_Teste_update
after update on Teste 
for each row 
BEGIN 
	if(new.flag = 'N' and new.data < now())
    then insert into Multa (flag, valor, idTeste, idAtleta) values ('N',NEW.preço,NEW.idTeste,NEW.idAtleta);
    end if;
END $$

select * from Multa;
DROP TRIGGER after_Teste_update;

