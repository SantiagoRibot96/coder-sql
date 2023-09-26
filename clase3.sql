use gammer;

/* 
select: columnas de las tablas que quiero ver. Colocando * puedo ver todas las columnas sin necesidad de describirlas
from: el nombre de la tabla que quiero consultar
where: te ayuda a filtrar alguna columna
*/

select 	id_commentary,
		id_system_user,
        commentary
from 	commentary;

select 	*
from 	commentary;

select 	*
from 	game
where 	id_game < 8;