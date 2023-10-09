drop schema if  exists coder ;
create schema if not exists coder ;
use coder ;
drop table if  exists coder.departamentos ;
drop table if  exists coder.colaboradores ;
drop table if  exists coder.librosciencias;
drop table if  exists coder.librostecnicos;

create table if not exists coder.departamentos
(
iddepto int ,
nombre varchar (50) ,
primary key (iddepto) 
);

create table if not exists coder.colaboradores
(
id int ,
nombre varchar(50),
iddepto int ,
salario int, 
categoria varchar(100),
primary key (id),
foreign key (iddepto)  REFERENCES coder.departamentos (iddepto) 
);

create table coder.librosciencias
(
libro_id int ,
titulo varchar( 60) ,
autor_id int
);

create table  coder.librostecnicos
(
libro_id int ,
titulo varchar( 60) ,
autor_id int
);


select * from coder.departamentos ;
select * from coder.colaboradores;
select * from coder.librosciencias;
select * from coder.librostecnicos;



insert into  coder.departamentos (iddepto ,nombre ) values (1, 'RRHH') ;
insert into  coder.departamentos (iddepto ,nombre ) values (2, 'CONTABILIDAD') ;
insert into  coder.departamentos (iddepto ,nombre ) values (3, 'IT') ;
insert into  coder.departamentos (iddepto ,nombre ) values (4, 'RESTAURANTE') ;
insert into  coder.departamentos (iddepto ,nombre ) values (5, 'ESTACIONAMIENTO') ;
insert into  coder.departamentos (iddepto ,nombre ) values (6, 'GERENCIA') ;
insert into  coder.departamentos (iddepto ,nombre ) values (7, 'ANA') ;


insert into  coder.colaboradores (id,nombre,iddepto,salario,categoria ) values (1,'ana',1,200,'ventas') ; 
insert into  coder.colaboradores (id,nombre,iddepto,salario,categoria ) values (2,'pedro',2,201,'compras') ; 
insert into  coder.colaboradores (id,nombre,iddepto,salario,categoria ) values (3,'oscar',3,202,'telemarker') ; 
insert into  coder.colaboradores (id,nombre,iddepto,salario,categoria ) values (4,'carolina',4,203,'compras') ; 
insert into  coder.colaboradores (id,nombre,iddepto,salario,categoria ) values (5,'isabella',5,204,'ventas') ; 
insert into  coder.colaboradores (id,nombre,iddepto,salario,categoria ) values (6,'isabella',7,204,'ventas') ; 
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`coder`.`colaboradores`, CONSTRAINT `colaboradores_ibfk_1` FOREIGN KEY (`iddepto`) REFERENCES `departamentos` (`iddepto`))
 
insert into  coder.librosciencias (libro_id,titulo,autor_id)  values (205,'libro1',1) ;
insert into  coder.librosciencias (libro_id,titulo,autor_id)  values (206,'libro2',2) ;
insert into  coder.librosciencias (libro_id,titulo,autor_id)  values (207,'libro3',3) ;
insert into  coder.librosciencias (libro_id,titulo,autor_id)  values (208,'libro4',4) ;
insert into  coder.librosciencias (libro_id,titulo,autor_id)  values (209,'libro5',5) ;


insert into  coder.librostecnicos  (libro_id,titulo,autor_id) values (305,'1libro',6);
insert into  coder.librostecnicos  (libro_id,titulo,autor_id) values (306,'2libro',7);
insert into  coder.librostecnicos  (libro_id,titulo,autor_id) values (307,'3libro',8);
insert into  coder.librostecnicos  (libro_id,titulo,autor_id) values (308,'4libro',9);
insert into  coder.librostecnicos  (libro_id,titulo,autor_id) values (305,'5libro',10);


select * from coder.departamentos ;
select * from coder.colaboradores;
select * from coder.librosciencias;
select * from coder.librostecnicos;

-- union 
 /* 
 reglas a tener en cuenta : 
 
 1) la cantidad de columnas debe ser la misma para ambas consultas 
 2) el tipo de dato debe ser el mismo 
 */
 
select * , 'TABLA1' AS TABLA from coder.librosciencias
UNION 
select * , 'TABLA2' AS TABLA from coder.librostecnicos;

-- SUBCONSULTAS:
select ( consulta ) -- listaria esa info
from (consulta ) -- me traeria la info de ese lugar 
where ( consulta ) -- me filtraria el resultado de esa consulta




select id , nombre from colaboradores 
where iddepto = ( select  iddepto from departamentos where iddepto = 3) ;


select salario from colaboradores where salario = 
 ( select avg(salario) from colaboradores where salario in (select 204 ) ) 
 ;


select  nombre , max(iddepto)  
from departamentos  
where iddepto in (
                  select id   from colaboradores where categoria = 'ventas')
group by nombre
having max(iddepto) > 1
;