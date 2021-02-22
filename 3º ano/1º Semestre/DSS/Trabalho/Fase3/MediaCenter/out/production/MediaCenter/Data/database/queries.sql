Use DSS;

SELECT pl.*, m.*
FROM Playlist pl
INNER JOIN Media_Playlist pt ON pl.idPlaylist = pt.idPlaylist 
INNER JOIN Media m ON m.nomeMedia = pt.nomeMedia;

SELECT * from DSS.Playlist where nomePlaylist = "TrimTrimJáMeVim";

select m.* from Media m, Playlist p, Media_Playlist pm 
                      where pm.idPlaylist = p.idPlaylist and m.idMedia = pm.idMedia
                      order by m.nomeMedia;
select * from DSS.Media where categoria = "Jazz";
SELECT * from DSS.Utilizador_Media where idUser = 1;
DELETE from DSS.Utilizador_Media where idUser= 3 and idMedia = 30;
# Tirar playlist de um user
SELECT u.*, p.idPlaylist, p.nomePlaylist from Utilizador u, Playlist p
where u.idUser=p.idUser and u.emailUser='cornegra@uminho.pt';

DELETE from DSS.Media where idMedia=12;
DELETE from DSS.Media where idMedia=13;
DELETE from DSS.Media where idMedia=14;
DELETE from DSS.Media where idMedia=15;
DELETE from DSS.Media where idMedia=16;
DELETE from DSS.Media where idMedia=17;
DELETE from DSS.Media where idMedia=18;
DELETE from DSS.Media where idMedia=19;
DELETE from DSS.Media where idMedia=20;
DELETE from DSS.Media where idMedia=21;
DELETE from DSS.Media where idMedia=22;
DELETE from DSS.Media where idMedia=23;
DELETE from DSS.Media where idMedia=24;
DELETE from DSS.Media where idMedia=25;
DELETE from DSS.Media where idMedia=26;
DELETE from DSS.Media where idMedia=27;
DELETE from DSS.Media where idMedia=28;
DELETE from DSS.Media where idMedia=29;
DELETE from DSS.Media where idMedia=30;
DELETE from DSS.Media where idMedia=31;
DELETE from DSS.Media where idMedia=32;
DELETE from DSS.Media where idMedia=33;

SELECT * from Media;

# Tirar media de uma playlist 
SELECT pl.nomePlaylist, m.*
FROM Playlist pl
INNER JOIN Media_Playlist pt ON pl.idPlaylist = pt.idPlaylist 
INNER JOIN Media m ON m.nomeMedia = pt.nomeMedia
where pl.idPlaylist=1
order by m.nomeMedia;

# ....
SELECT * FROM DSS.Media;
SELECT * FROM DSS.Media_Playlist;
SELECT * FROM DSS.Utilizador_Media;
select MAX(idPlaylist) from dss.playlist;

DELETE from DSS.Media where idMedia = '11';