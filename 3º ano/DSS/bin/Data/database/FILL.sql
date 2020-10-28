/* GLOBAL VARS UTILITY */
SET GLOBAL log_bin_trust_function_creators = 1;
SET SQL_SAFE_UPDATES = 0;

/* CRIAR ADMINISTRADOR */
INSERT INTO Administrador (nomeAdmin,emailAdmin,pwAdmin) values('ADMIN','admin@uminho.pt','admin');

/* CRIAR CATEGORIA 
INSERT into Categoria (designacao) values ("Outros");
INSERT into Categoria (designacao) values ("Mix");
INSERT into Categoria (designacao) values ("Vídeo");
INSERT into Categoria (designacao) values ("Rap");
INSERT into Categoria (designacao) values ("Jazz");
INSERT into Categoria (designacao) values ("Pop");
INSERT into Categoria (designacao) values ("Soul");
INSERT into Categoria (designacao) values ("House");
INSERT into Categoria (designacao) values ("Techno");
INSERT into Categoria (designacao) values ("Rock");
INSERT into Categoria (designacao) values ("Metal");
*/
/* CRIAR UTILIZADORES */
INSERT into Utilizador (nomeUser,emailUser,pwUser) values ('João Cunhz','cunha420@uminho.pt','brincz');
INSERT into Utilizador (nomeUser,emailUser,pwUser) values ('Filipa Apex','apexlegends@uminho.pt','nachopickle');
INSERT into Utilizador (nomeUser,emailUser,pwUser) values ('Hugo Paisana','cornegra@uminho.pt','roubarcoisas');
INSERT into Utilizador (nomeUser,emailUser,pwUser) values ('Válter Saídas','jantardecurso@uminho.pt','antissocial');
INSERT into Utilizador (nomeUser,emailUser,pwUser) values ('Luís Reles','arrependimento@uminho.pt','morethanonce');
INSERT into Utilizador (nomeUser,emailUser,pwUser) values ('Ivo Gomes','eventualmente@uminho.pt','bipolaridade');

/* CRIAR MEDIA */ 
INSERT into Media (nomeMedia,artista,categoria,diretoria) values ('1','Toy','Pop',':D/quim');
INSERT into Media (nomeMedia,artista,categoria,diretoria) values ('2','Ghost','Metal',':D/quim');
INSERT into Media (nomeMedia,artista,categoria,diretoria) values ('3','Toy','Pop',':D/quim');
INSERT into Media (nomeMedia,artista,categoria,diretoria) values ('4','Ghost','Metal',':D/quim');
INSERT into Media (nomeMedia,artista,categoria,diretoria) values ('5','Kanye West','Rap',':D/quim');
INSERT into Media (nomeMedia,artista,categoria,diretoria) values ('6','Kanye West','Rap',':D/quim');
INSERT into Media (nomeMedia,artista,categoria,diretoria) values ('7','Kanye West','Rap',':D/quim');
INSERT into Media (nomeMedia,artista,categoria,diretoria) values ('8','Stevie Wonder','Jazz',':D/quim');
INSERT into Media (nomeMedia,artista,categoria,diretoria) values ('9','Stevie Wonder','Jazz',':D/quim');
INSERT into Media (nomeMedia,artista,categoria,diretoria) values ('10','Metallica','Rock',':D/quim');

/* CRIAR PEDIDOS */
INSERT into Pedidos (emailUser,pwUser,nomeUser,idAdmin) values ('novoUser1@uminho.pt','novapw1','Novo 1',1);
INSERT into Pedidos (emailUser,pwUser,nomeUser,idAdmin) values ('novoUser2@uminho.pt','novapw2','Novo 2',1);
INSERT into Pedidos (emailUser,pwUser,nomeUser,idAdmin) values ('novoUser3@uminho.pt','novapw3','Novo 3',1);
INSERT into Pedidos (emailUser,pwUser,nomeUser,idAdmin) values ('novoUser4@uminho.pt','novapw4','Novo 4',1);
INSERT into Pedidos (emailUser,pwUser,nomeUser,idAdmin) values ('novoUser5@uminho.pt','novapw5','Novo 5',1);

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
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (3,1,'Pop');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (3,3,'Rock');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (3,6,'Metal');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (1,9,'Pop');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (5,2,'Jazz');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (5,6,'Jazz');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (4,5,'Outros');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (2,2,'Techno');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (2,3,'Rap');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (3,5,'Rap');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (4,1,'Rock');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (5,10,'Soul');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (4,10,'Techno');
INSERT into Utilizador_Media (idUser,idMedia,categoria) values (1,2,'Techno');

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