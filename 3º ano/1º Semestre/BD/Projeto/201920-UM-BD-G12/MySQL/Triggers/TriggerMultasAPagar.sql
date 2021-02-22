DELIMITER $$ 
create trigger after_Multa
after Update on Multa 
for each row 
BEGIN
	Declare nm VARCHAR(45);
    insert into MultasAPagar(idAtleta, idMulta , valor, idTeste, flag) values (NEW.idAtleta,NEW.idMulta,NEW.valor,NEW.idTeste,'N');
END $$

select * from MultasAPagar;
Drop Trigger after_Multa;
