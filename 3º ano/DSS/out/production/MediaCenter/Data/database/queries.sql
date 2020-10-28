Use DSS;

SELECT pl.*, m.*
FROM Playlist pl
INNER JOIN Media_Playlist pt ON pl.idPlaylist = pt.idPlaylist 
INNER JOIN Media m ON m.nomeMedia = pt.nomeMedia;

# Tirar playlist de um user
SELECT u.*, p.idPlaylist, p.nomePlaylist from Utilizador u, Playlist p
where u.idUser=p.idUser and u.emailUser='cunha420@uminho.pt';

# Tirar media de uma playlist 
SELECT pl.nome, m.*
FROM Playlist pl
INNER JOIN Media_Playlist pt ON pl.idPlaylist = pt.idPlaylist 
INNER JOIN Media m ON m.nomeMedia = pt.nomeMedia
where pl.idPlaylist=1
order by m.nomeMedia;

# ....
SELECT * FROM DSS.Media;
SELECT * FROM DSS.media_playlist;
SELECT * FROM DSS.utilizador_media;
select MAX(idPlaylist) from dss.playlist;

DELETE from DSS.Media where idMedia = '11';