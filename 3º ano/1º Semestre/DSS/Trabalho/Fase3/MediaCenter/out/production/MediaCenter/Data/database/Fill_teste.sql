/* 
Este ficheiro de FILL é usado para propósitos de teste e demonstração.
Introduz várias Medias "falsas" na base de dados e cria playlists com as mesmas.
Também altera a categoria de várias por parte dos utilizadores criados.
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

/* CRIAR MEDIA */ 
INSERT into Media (nomeMedia,artista,categoria,diretoria) values ('1','Toy','Pop','/home/dir');
INSERT into Media (nomeMedia,artista,categoria,diretoria) values ('2','Ghost','Metal','/home/dir');
INSERT into Media (nomeMedia,artista,categoria,diretoria) values ('3','Toy','Pop','/home/dir');
INSERT into Media (nomeMedia,artista,categoria,diretoria) values ('4','Ghost','Metal','/home/dir');
INSERT into Media (nomeMedia,artista,categoria,diretoria) values ('5','Kanye West','Rap','/home/dir');
INSERT into Media (nomeMedia,artista,categoria,diretoria) values ('6','Kanye West','Rap','/home/dir');
INSERT into Media (nomeMedia,artista,categoria,diretoria) values ('7','Kanye West','Rap','/home/dir');
INSERT into Media (nomeMedia,artista,categoria,diretoria) values ('8','Stevie Wonder','Jazz','/home/dir');
INSERT into Media (nomeMedia,artista,categoria,diretoria) values ('9','Stevie Wonder','Jazz','/home/dir');
INSERT into Media (nomeMedia,artista,categoria,diretoria) values ('10','Metallica','Rock','/home/dir');

/* CRIAR PLAYLISTS */
INSERT into Playlist (nomePlaylist,categoria,idUser) values ('PL1','Outros',4);
INSERT into Playlist (nomePlaylist,categoria,idUser) values ('PL2','Mix',1);
INSERT into Playlist (nomePlaylist,categoria,idUser) values ('PL3','Jazz',1);
INSERT into Playlist (nomePlaylist,categoria,idUser) values ('PL4','Jazz',2);
INSERT into Playlist (nomePlaylist,categoria,idUser) values ('PL5','Rap',5);
INSERT into Playlist (nomePlaylist,categoria,idUser) values ('PL6','Rock',2);
INSERT into Playlist (nomePlaylist,categoria,idUser) values ('PL7','Rock',3);
INSERT into Playlist (nomePlaylist,categoria,idUser) values ('PL8','Techno',3);

/* MEDIA DOS UTILIZADORES */ 
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (3,1,'APop');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (3,3,'ARock');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (3,6,'AMetal');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (1,9,'APop');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (5,2,'AJazz');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (5,6,'AJazz');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (4,5,'AOutros');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (2,2,'ATechno');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (2,3,'ARap');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (3,5,'ARap');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (4,1,'ARock');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (5,10,'ASoul');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (4,10,'ATechno');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (1,2,'ATechno');

/* MEDIA NAS PLAYLISTS */
INSERT into Media_Playlist (idMedia,idPlaylist) values (1,1);
INSERT into Media_Playlist (idMedia,idPlaylist) values (2,1);
INSERT into Media_Playlist (idMedia,idPlaylist) values (2,2);
INSERT into Media_Playlist (idMedia,idPlaylist) values (8,2);
INSERT into Media_Playlist (idMedia,idPlaylist) values (10,2);
INSERT into Media_Playlist (idMedia,idPlaylist) values (4,3);
INSERT into Media_Playlist (idMedia,idPlaylist) values (2,4);
INSERT into Media_Playlist (idMedia,idPlaylist) values (3,4);
INSERT into Media_Playlist (idMedia,idPlaylist) values (9,5);
INSERT into Media_Playlist (idMedia,idPlaylist) values (1,6);
INSERT into Media_Playlist (idMedia,idPlaylist) values (2,6);
INSERT into Media_Playlist (idMedia,idPlaylist) values (3,6);
INSERT into Media_Playlist (idMedia,idPlaylist) values (6,7);
INSERT into Media_Playlist (idMedia,idPlaylist) values (9,8);
INSERT into Media_Playlist (idMedia,idPlaylist) values (10,8);

/* ---------------------------------------------------------------------------------------------------------- */