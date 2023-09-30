use gammer;

/*
Ejercicios:

select commentary
from commentary
where comment_date > '2018-12-31';

select 	id_system_user, commentary
from 	commentary
where 	id_game = 73;

select 	id_system_user, commentary
from 	commentary
where 	id_game <> 73;

select 	name
from 	game
where	id_level = 1;

select 	name
from 	game
where	id_level = 14 || id_level = 5 || id_level = 9;

select 	name
from 	game
where	id_level in (14, 5, 9);

select 	name
from 	game
where	name in ('Riders Republic', 'The Dark Pictures: House Of Ashes');

select 	name
from 	game
where	name like ('Gran%');

select 	name
from 	game
where	name like ('%field%');
*/

/*funciones nativas
count()
max()
min()
avg()
sum()*/

/*
select name, count(*) as cuenta
from game
where id_level in (14, 5, 9)
group by name -- es lo que nos permite agregar funciones a nuestra consulta
having count(*) > 1 -- nos permite filtrar la informacion que agrego con las funciones
order by name desc -- si no lleva el desc quiere decir que es asc
limit 15 -- limita a 5 las muestras (las primeras 5)
;
*/

select *
from commentary left join game -- siempre se coloca la tabla mas grande primero
on commentary.id_game = game.id_game; -- listo todas las columnas de la tabla 1 y la tabla 2 en una tabla. 