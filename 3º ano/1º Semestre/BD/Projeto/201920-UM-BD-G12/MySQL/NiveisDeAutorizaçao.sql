Use mydb;
#DROP USER 'atleta'@'localhost';

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';

GRANT ALL ON mydb.* TO 'admin'@'localhost';

CREATE USER 'medico'@'localhost' IDENTIFIED BY 'medico';

GRANT SELECT ON mydb.Prova TO 'medico'@'localhost';
GRANT SELECT ON mydb.Categoria TO 'medico'@'localhost';
GRANT SELECT ON mydb.Modalidade TO 'medico'@'localhost';
GRANT SELECT, UPDATE ON mydb.Atleta TO 'medico'@'localhost';
GRANT SELECT, INSERT, UPDATE ON mydb.Teste TO 'medico'@'localhost';

CREATE USER 'atleta'@'localhost' IDENTIFIED BY 'atleta';

GRANT SELECT ON mydb.Atleta TO 'atleta'@'localhost';
GRANT SELECT ON mydb.Multa TO 'atleta'@'localhost';
GRANT SELECT ON mydb.Prova TO 'atleta'@'localhost';
GRANT SELECT ON mydb.Categoria TO 'atleta'@'localhost';
GRANT SELECT ON mydb.Modalidade TO 'atleta'@'localhost';
GRANT INSERT, DELETE ON mydb.provas_atleta TO 'atleta'@'localhost';
GRANT INSERT, UPDATE ON mydb.Teste TO 'atleta'@'localhost';

