create schema if not exists usuarios_47375;
create schema if not exists it_47375;

-- esta tabla se actualiza solo por el owner
create TABLE it_47375.it
(
id INT,
name VARCHAR(50)
);

-- esta vista se actualiza automaticamente salvo que haya un cambio de estructura!
-- ademas esta es una vista que se guarda en un esquema diferente
CREATE OR REPLACE VIEW gamer_47375.ww_it
as
(
SELECT * from it_47375.it
);

select * from class;
select * from game;
select * from play;

use compensaciones;
show tables;
show full tables;

-- 1. ejercicios de practica (siempre resolvemos la consulta --PRIMERO--)
CREATE or replace view usuarios_47375.VW_USER as
(
SELECT first_name, last_name, email
from system_user
where lower(email) like '%trip%'
);
-- 2. MUESTRE TODOS LOS DATOS DE LODE LOS JUEGOS QUE HAN FINALIZADO
create or replace view usuarios_47375.VW_GAME_PLAY_completo as
(
select g.*, count(*) 
from game as g join play as p
on g.id_game = p.id_game
where p.completed = 1
-- and p.id_system_user < 100
group by g.id_game
);
-- 3. muestre todos los juegos que tuvieron una votacion mayor a 9
create or replace view usuarios_47375.VW_VOTE_GAME_eval as
(
select g.*, count(v.value) as cant
from vote as v join game as g
on v.id_game = g.id_game
where v.value > 6
-- and v.value < 10
group by v.id_game
order by cant desc
);
-- 4. muestre nombre, apellido y mail de los usuarios que juegan fifa 22
create or replace view usuarios_47375.VW_USER_VOTE_GAME_filtro as
(
select s.first_name, s.last_name, s.email, g.name
from system_user as s join vote as v
on s.id_system_user = v.id_system_user
join game as g
on v.id_game = g.id_game
where g.name like lower('%fifa 22%')
);
