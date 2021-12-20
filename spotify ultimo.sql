-- 1. Mostrar la cantidad de canciones que pertenecen a ambos géneros pop y rock
-- cuyo nombre contiene la letra “m”.

select count(cancion.idCancion), genero.Genero from cancion
join generoxcancion on generoxcancion.IdCancion = cancion.idCancion
join genero on genero.idGenero = generoxcancion.IdGenero
where cancion.titulo like "%m%" and genero.Genero in ("pop", "rock")
group by genero.Genero;


-- 2. Listar todas las canciones que pertenezcan a más de una playlist. Incluir en el
-- listado el nombre de la canción, el código y a cuántas playlists pertenecen.

select cancion.titulo, cancion.idCancion, count(playlist.idPlaylist) from cancion
join playlistxcancion on playlistxcancion.Idcancion = cancion.idCancion
join playlist on playlist.idPlaylist = playlistxcancion.IdPlaylist
group by cancion.titulo, cancion.idCancion;


-- 3. Generar un reporte con el nombre del artista y el nombre de la canción que no
-- pertenecen a ninguna lista, ordenados alfabéticamente por el nombre del
-- artista.

select artista.Nombre, cancion.titulo, playlistxcancion.IdPlaylist
from artista
join album on album.idArtista = artista.idArtista
join cancion on cancion.IdAlbum = album.idAlbum
left join playlistxcancion on playlistxcancion.Idcancion = cancion.idCancion
where isnull(playlistxcancion.Idcancion);




-- 4. Modificar el país de todos los usuarios con el código postal “7600” a “Argentina”.

update usuario
set usuario.Pais_idPais = (select pais.idPais from pais where pais.Pais = "Argentina")
where usuario.CP = "7600";



-- 5. Listar todos los álbumes que tengan alguna canción que posea más de un
-- género.

select album.*, count(generoxcancion.IdGenero)
from album
join cancion on album.idAlbum = cancion.idCancion
join generoxcancion on cancion.idCancion = generoxcancion.IdCancion
group by cancion.idCancion;


-- 6. Crear un índice agrupado para las canciones cuyo identificador sea el ID.

