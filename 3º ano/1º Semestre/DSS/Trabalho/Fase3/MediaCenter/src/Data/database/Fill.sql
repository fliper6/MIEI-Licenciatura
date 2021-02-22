/*
Este ficheiro de FILL é usado para simular o funcionamento real do programa.
Apenas cria os utilizadores, todas as medias usadas devem ser carregadas pelos mesmos.
*/

/* GLOBAL VARS UTILITY */
SET GLOBAL log_bin_trust_function_creators = 1;
SET SQL_SAFE_UPDATES = 0;

/* CRIAR ADMINISTRADOR */
INSERT INTO Administrador (nomeAdmin,emailAdmin,pwAdmin) values('ADMIN','admin@uminho.pt','admin');

/* CRIAR UTILIZADORES */
INSERT into Utilizador (nomeUser,emailUser,pwUser) values ('Utilizador1','user1@uminho.pt','password1');
INSERT into Utilizador (nomeUser,emailUser,pwUser) values ('Utilizador2','user2@uminho.pt','password2');
INSERT into Utilizador (nomeUser,emailUser,pwUser) values ('Utilizador3','user3@uminho.pt','password3');
INSERT into Utilizador (nomeUser,emailUser,pwUser) values ('Utilizador4','user4@uminho.pt','password4');
INSERT into Utilizador (nomeUser,emailUser,pwUser) values ('Utilizador5','user5@uminho.pt','password5');
INSERT into Utilizador (nomeUser,emailUser,pwUser) values ('Utilizador6','user6@uminho.pt','password6');

/* ---------------------------------------------------------------------------------------------------------- */