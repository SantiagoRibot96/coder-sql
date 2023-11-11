drop database if exists  workshop_uno;
CREATE DATABASE IF NOT EXISTS workshop_uno;
USE workshop_uno;

/*
Los pasos serán:
Crear la base de datos
Comenzar a usarla
Introducir 3 datos de ejemplo
Mostrar todos los datos
Mostrar los datos que tienen un cierto nombre
Mostrar los datos que comienzan por una cierta inicial
Ver sólo el nombre y el precio de los que cumplen una condición (precio > 22)
Ver el precio medio de aquellos cuyo nombre comienza con "Silla"
Modificar la estructura de la tabla para añadir un nuevo campo: "categoría"
Dar el valor "utensilio" a la categoría de todos los productos existentes
Modificar los productos que comienza por la palabra "Silla", para que su categoría sea "silla"
Ver la lista categorías (sin que aparezcan datos duplicados)
Ver la cantidad de productos que tenemos en cada categoría
*/


create database productos1;
use productos1;
create table productos (
  codigo varchar(3),
  nombre varchar(30),
  precio decimal(6,2),
  fechaalta date,
  primary key (codigo)
);

insert into productos values ('a01','Afilador', 2.50, '2007-11-02');
insert into productos values ('s01','Silla mod. ZAZ', 20, '2007-11-03');
insert into productos values ('s02','Silla mod. XAX', 25, '2007-11-03');

select * from productos;
select * from productos where nombre='Afilador';
select * from productos where nombre like 'S%';
select nombre, precio from productos where precio > 22;
select avg(precio) from productos where left(nombre,5) = 'Silla';
alter table productos add categoria varchar(10);
select * from productos;
update productos set categoria='utensilio';
update productos set categoria='silla' where left(nombre,5) = 'Silla';
select distinct categoria from productos;
select categoria, count(*) from productos group by categoria;




create table ciudades (
  codigo varchar(3),
  nombre varchar(30),
  primary key (codigo)
);

create table personas (
  nombre varchar(20),
  direccion varchar(40),
  edad decimal(3),
  codciudad varchar(3)
);

insert into ciudades values ('a', 'alicante');
insert into ciudades values ('b', 'barcelona');
insert into ciudades values ('m', 'madrid');

insert into personas values ('juan', 'su casa', 25, 'a');
insert into personas values ('pedro', 'su calle', 23, 'm');
insert into personas values ('alberto', 'calle uno', 22, 'b');

select * from personas;
select nombre, direccion from personas;
select nombre, direccion from personas where nombre = 'juan';
select nombre, direccion from personas where direccion like '%calle%';
select nombre, direccion 
from personas 
where direccion like '%calle%'
order by nombre, direccion desc;








select personas.nombre, direccion, ciudades.nombre from personas, ciudades;

select personas.nombre, direccion, ciudades.nombre
from personas, ciudades 
where personas.codciudad = ciudades.codigo;

select personas.nombre, direccion, edad 
from personas, ciudades 
where ciudades.nombre='madrid' 
and personas.codciudad = ciudades.codigo;

select personas.nombre, direccion, ciudades.nombre 
from personas, ciudades 
where ciudades.nombre like 'b%' 
and personas.codciudad = ciudades.codigo;

select distinct direccion from personas;



show databases;

show tables;
show columns from personas;

-- drop database
-- drop database  if exists;
-- drop table personas if exists;
-- delete from personas where nombre = 'juan';
-- truncate table personas;


alter table ciudades add habitantes decimal(7);
alter table ciudades change habitantes numhabitantes bigint;
alter table ciudades modify habitantes bigint;
alter table ciudades drop column numhabitantes;
alter table ciudades rename ciudad;
ALTER TABLE ciudades ADD PRIMARY KEY(codigo);




select count(*) from personas where direccion like 's%';

select count(*), edad from personas group by edad;

select count(*), edad from personas group by edad having edad > 24;

SELECT MAX(codigo) FROM ciudades;

SELECT * FROM personas WHERE codciudad= maxCodigo;

SELECT * FROM personas WHERE codciudad= (
  SELECT MAX(codigo) FROM ciudades
);

SELECT codigo FROM ciudades 
WHERE SUBSTRING(nombre,2,1)='a';

SELECT * FROM personas 
WHERE codciudad IN 
(
  SELECT codigo FROM ciudades WHERE SUBSTRING(nombre,2,1)='a'
);


create table capacidad(
  codigo varchar(4),
  nombre varchar(20),
  primary key(codigo)
);


create table persona(
  codigo varchar(4),
  nombre varchar(20),
  codcapac varchar(4),
  primary key(codigo)
);


insert into capacidad values
  ('c','Progr.C'),
  ('pas','Progr.Pascal'),
  ('j','Progr.Java'),
  ('sql','Bases datos SQL');
  
insert into persona values
  ('ju','Juan','c'),
  ('ja','Javier','pas'),
  ('jo','Jose','perl'),
  ('je','Jesus','html');
  
  select * from capacidad;
  select * from persona;
  
  
  select nombre from persona
where nombre like '%o%'
union
select nombre from persona
where nombre like '%e%';


select nombre from persona
where nombre like '%o%' 
or nombre like '%e%';


select nombre from persona
union
select nombre from capacidad;


select concat('Persona: ', nombre) as detalle
from persona
union
select concat('Habilidad: ', upper(nombre)) as detalle
from capacidad;



select persona.nombre, capacidad.nombre
from persona right outer join capacidad
on persona.codcapac = capacidad.codigo
union
select persona.nombre, capacidad.nombre
from persona left outer join capacidad
on persona.codcapac = capacidad.codigo;




select * from
(
select persona.nombre , capacidad.nombre habilidad
from persona right outer join capacidad
on persona.codcapac = capacidad.codigo
union
select persona.nombre, capacidad.nombre
from persona left outer join capacidad
on persona.codcapac = capacidad.codigo
) resultado
order by nombre;


  
  select * from capacidad, persona
where persona.codcapac = capacidad.codigo;

select persona.nombre, capacidad.nombre
from persona, capacidad
where persona.codcapac = capacidad.codigo;

select persona.nombre, capacidad.nombre
from persona, capacidad;


select persona.nombre, capacidad.nombre
from persona inner join capacidad
on persona.codcapac = capacidad.codigo;


select persona.nombre, capacidad.nombre
from persona left outer join capacidad
on persona.codcapac = capacidad.codigo;


select persona.nombre, capacidad.nombre
from persona right outer join capacidad
on persona.codcapac = capacidad.codigo;


select persona.nombre, capacidad.nombre
from capacidad left outer join persona
on persona.codcapac = capacidad.codigo;
  
  
 create view personasycapac as
select persona.nombre nompers, capacidad.nombre nomcapac
from persona left outer join capacidad
on persona.codcapac = capacidad.codigo;

select * from personasycapac
where substring(nompres,3,1) = 's'
order by nompres desc;

 

/*
10.1. Funciones de conversión a mayúsculas/minúsculas
LOWER o LCASE convierte una cadena a minúsculas: SELECT LOWER('Hola'); ⇒ hola
UPPER o UCASE convierte una cadena a mayúsculas: SELECT UPPER('Hola'); ⇒ HOLA

10.2. Funciones de extracción de parte de la cadena
LEFT(cadena, longitud) extrae varios caracteres del comienzo (la parte izquierda) de la cadena: SELECT LEFT('Hola',2); ⇒ Ho
RIGHT(cadena, longitud) extrae varios caracteres del final (la parte derecha) de la cadena: SELECT RIGHT('Hola',2); ⇒ la
MID(cadena, posición, longitud), SUBSTR(cadena, posición, longitud) o SUBSTRING(cadena, posición, longitud) extrae varios caracteres de cualquier posición de una cadena, tantos como se indique en "longitud": SELECT SUBSTRING('Hola',2,3); ⇒ ola (Nota: a partir MySQL 5 se permite un valor negativo en la posición, y entonces se comienza a contar desde la derecha -el final de la cadena-)
CONCAT une (concatena) varias cadenas para formar una nueva: SELECT CONCAT('Ho', 'la'); ⇒ Hola
CONCAT_WS une (concatena) varias cadenas para formar una nueva, usando un separador que se indique (With Separator): SELECT CONCAT_WS('-','Ho','la','Que','tal'); ⇒ Ho-la-Que-tal
LTRIM devuelve la cadena sin los espacios en blanco que pudiera contener al principio (en su parte izquierda): SELECT LTRIM(' Hola'); ⇒ Hola
RTRIM devuelve la cadena sin los espacios en blanco que pudiera contener al final (en su parte derecha): SELECT RTRIM('Hola '); ⇒ Hola
TRIM devuelve la cadena sin los espacios en blanco que pudiera contener al principio ni al final: SELECT TRIM(' Hola '); ⇒ Hola (Nota: realmente, TRIM puede eliminar cualquier prefijo, no sólo espacios; mira el manual de MySQL para más detalles)

10.3. Funciones de conversión de base numérica
BIN convierte un número decimal a binario: SELECT BIN(10); ⇒ 1010
HEX convierte un número decimal a hexadecimal: SELECT HEX(10); ⇒ 'A' (Nota: HEX también tiene un uso alternativo menos habitual: puede recibir una cadena, y entonces mostrará el código ASCII en hexadecimal de sus caracteres: SELECT HEX('Hola'); ⇒ '486F6C61')
OCT convierte un número decimal a octal: SELECT OCT(10); ⇒ 12
CONV(número,baseInicial,baseFinal) convierte de cualquier base a cualquier base: SELECT CONV('F3',16,2); ⇒ 11110011
UNHEX convierte una serie de números hexadecimales a una cadena ASCII, al contrario de lo que hace HEX: SELECT UNHEX('486F6C61'); ⇒ 'Hola')

10.4. Otras funciones de modificación de la cadena
INSERT(cadena,posición,longitud,nuevaCadena) inserta en la cadena otra cadena: SELECT INSERT('Hola', 2, 2, 'ADIOS'); ⇒ HADIOSa
REPLACE(cadena,de,a) devuelve la cadena pero cambiando ciertas secuencias de caracteres por otras: SELECT REPLACE('Hola', 'l', 'LLL'); ⇒ HoLLLa
REPEAT(cadena,numero) devuelve la cadena repetida varias veces: SELECT REPEAT(' Hola',3); ⇒ HolaHolaHola
REVERSE(cadena) devuelve la cadena "del revés": SELECT REVERSE('Hola'); ⇒ aloH
SPACE(longitud) devuelve una cadena formada por varios espacios en blanco: SELECT SPACE(3); ⇒ "   "

10.5. Funciones de información sobre la cadena
CHAR_LENGTH o CHARACTER_LENGTH devuelve la longitud de la cadena en caracteres
LENGTH devuelve la longitud de la cadena en bytes
BIT_LENGTH devuelve la longitud de la cadena en bits
INSTR(cadena,subcadena) o LOCATE(subcadena,cadena,posInicial) devuelve la posición de una subcadena dentro de la cadena: SELECT INSTR('Hola','ol'); ⇒ 2


*/





/*
   Si ya tienes una base de datos, sólo copia lo siguiente
*/
CREATE TABLE tblUsuarios (
   idx INT PRIMARY KEY AUTO_INCREMENT,
   usuario VARCHAR(20),
   nombre VARCHAR(20),
   sexo VARCHAR(1),
   nivel TINYINT,
   email VARCHAR(50),
   telefono VARCHAR(20),
   marca VARCHAR(20),
   compañia VARCHAR(20),
   saldo FLOAT,
   activo BOOLEAN
);

INSERT INTO tblUsuarios 
VALUES 
('1','BRE2271','BRENDA','M','2','brenda@live.com','655-330-5736','SAMSUNG','IUSACELL','100','1'),
('2','OSC4677','OSCAR','H','3','oscar@gmail.com','655-143-4181','LG','TELCEL','0','1'),
('3','JOS7086','JOSE','H','3','francisco@gmail.com','655-143-3922','NOKIA','MOVISTAR','150','1'),
('4','LUI6115','LUIS','H','0','enrique@outlook.com','655-137-1279','SAMSUNG','TELCEL','50','1'),
('5','LUI7072','LUIS','H','1','luis@hotmail.com','655-100-8260','NOKIA','IUSACELL','50','0'),
('6','DAN2832','DANIEL','H','0','daniel@outlook.com','655-145-2586','SONY','UNEFON','100','1'),
('7','JAQ5351','JAQUELINE','M','0','jaqueline@outlook.com','655-330-5514','BLACKBERRY','AXEL','0','1'),
('8','ROM6520','ROMAN','H','2','roman@gmail.com','655-330-3263','LG','IUSACELL','50','1'),
('9','BLA9739','BLAS','H','0','blas@hotmail.com','655-330-3871','LG','UNEFON','100','1'),
('10','JES4752','JESSICA','M','1','jessica@hotmail.com','655-143-6861','SAMSUNG','TELCEL','500','1'),
('11','DIA6570','DIANA','M','1','diana@live.com','655-143-3952','SONY','UNEFON','100','0'),
('12','RIC8283','RICARDO','H','2','ricardo@hotmail.com','655-145-6049','MOTOROLA','IUSACELL','150','1'),
('13','VAL6882','VALENTINA','M','0','valentina@live.com','655-137-4253','BLACKBERRY','AT&T','50','0'),
('14','BRE8106','BRENDA','M','3','brenda2@gmail.com','655-100-1351','MOTOROLA','NEXTEL','150','1'),
('15','LUC4982','LUCIA','M','3','lucia@gmail.com','655-145-4992','BLACKBERRY','IUSACELL','0','1'),
('16','JUA2337','JUAN','H','0','juan@outlook.com','655-100-6517','SAMSUNG','AXEL','0','0'),
('17','ELP2984','ELPIDIO','H','1','elpidio@outlook.com','655-145-9938','MOTOROLA','MOVISTAR','500','1'),
('18','JES9640','JESSICA','M','3','jessica2@live.com','655-330-5143','SONY','IUSACELL','200','1'),
('19','LET4015','LETICIA','M','2','leticia@yahoo.com','655-143-4019','BLACKBERRY','UNEFON','100','1'),
('20','LUI1076','LUIS','H','3','luis2@live.com','655-100-5085','SONY','UNEFON','150','1'),
('21','HUG5441','HUGO','H','2','hugo@live.com','655-137-3935','MOTOROLA','AT&T','500','1');



/* 
Consultas
Listar los nombres de los usuarios
Calcular el saldo máximo de los usuarios de sexo “Mujer”
Listar nombre y teléfono de los usuarios con teléfono NOKIA, BLACKBERRY o SONY
Contar los usuarios sin saldo o inactivos
Listar el login de los usuarios con nivel 1, 2 o 3
Listar los números de teléfono con saldo menor o igual a 300
Calcular la suma de los saldos de los usuarios de la compañia telefónica NEXTEL
Contar el número de usuarios por compañía telefónica
Contar el número de usuarios por nivel
Listar el login de los usuarios con nivel 2
Mostrar el email de los usuarios que usan gmail
Listar nombre y teléfono de los usuarios con teléfono LG, SAMSUNG o MOTOROLA
*/


# Listar los nombres de los usuarios
SELECT nombre FROM tblUsuarios;

# Calcular el saldo máximo de los usuarios de sexo "Mujer"
SELECT MAX(saldo) FROM tblUsuarios WHERE sexo = 'M';

#Listar nombre y teléfono de los usuarios con teléfono NOKIA, BLACKBERRY o SONY
SELECT nombre, telefono FROM tblUsuarios WHERE marca IN('NOKIA', 'BLACKBERRY', 'SONY');

#Contar los usuarios sin saldo o inactivos
SELECT COUNT(*) FROM tblUsuarios WHERE NOT activo OR saldo <= 0;

#Listar el login de los usuarios con nivel 1, 2 o 3
SELECT usuario FROM tblUsuarios WHERE nivel IN(1, 2, 3);

#Listar los números de teléfono con saldo menor o igual a 300
SELECT telefono FROM tblUsuarios WHERE saldo <= 300;

#Calcular la suma de los saldos de los usuarios de la compañia telefónica NEXTEL
SELECT SUM(saldo) FROM tblUsuarios WHERE compañia = 'NEXTEL';

#Contar el número de usuarios por compañía telefónica
SELECT compañia, COUNT(*) FROM tblUsuarios GROUP BY compañia;

#Contar el número de usuarios por nivel
SELECT nivel, COUNT(*) FROM tblUsuarios GROUP BY nivel;

#Listar el login de los usuarios con nivel 2
SELECT usuario FROM tblUsuarios WHERE nivel = 2;

#Mostrar el email de los usuarios que usan gmail
SELECT email FROM tblUsuarios WHERE email LIKE '%gmail.com';

#Listar nombre y teléfono de los usuarios con teléfono LG, SAMSUNG o MOTOROLA
SELECT nombre, telefono FROM tblUsuarios WHERE marca IN('LG', 'SAMSUNG', 'MOTOROLA');


/*
Consultas
Listar nombre y teléfono de los usuarios con teléfono que no sea de la marca LG o SAMSUNG
Listar el login y teléfono de los usuarios con compañia telefónica IUSACELL
Listar el login y teléfono de los usuarios con compañia telefónica que no sea TELCEL
Calcular el saldo promedio de los usuarios que tienen teléfono marca NOKIA
Listar el login y teléfono de los usuarios con compañia telefónica IUSACELL o AXEL
Mostrar el email de los usuarios que no usan yahoo
Listar el login y teléfono de los usuarios con compañia telefónica que no sea TELCEL o IUSACELL
Listar el login y teléfono de los usuarios con compañia telefónica UNEFON
Listar las diferentes marcas de celular en orden alfabético descendentemente
Listar las diferentes compañias en orden alfabético aleatorio
Listar el login de los usuarios con nivel 0 o 2
Calcular el saldo promedio de los usuarios que tienen teléfono marca LG
*/


# Listar nombre y teléfono de los usuarios con teléfono que no sea de la marca LG o SAMSUNG
SELECT nombre, telefono FROM tblUsuarios WHERE marca NOT IN('LG', 'SAMSUNG');

# Listar el login y teléfono de los usuarios con compañia telefónica IUSACELL
SELECT usuario, telefono FROM tblUsuarios WHERE compañia = 'IUSACELL';

# Listar el login y teléfono de los usuarios con compañia telefónica que no sea TELCEL
SELECT usuario, telefono FROM tblUsuarios WHERE compañia <> "TELCEL";

# Calcular el saldo promedio de los usuarios que tienen teléfono marca NOKIA
SELECT AVG(saldo) FROM tblUsuarios WHERE marca = 'NOKIA';

# Listar el login y teléfono de los usuarios con compañia telefónica IUSACELL o AXEL
SELECT usuario, telefono FROM tblUsuarios WHERE compañia IN('IUSACELL', 'AXEL');

# Mostrar el email de los usuarios que no usan yahoo
SELECT email FROM tblUsuarios WHERE email NOT LIKE '%yahoo.com';

# Listar el login y teléfono de los usuarios con compañia telefónica que no sea TELCEL o IUSACELL
SELECT usuario, telefono FROM tblUsuarios WHERE compañia NOT IN('TELCEL', 'IUSACELL');

# Listar el login y teléfono de los usuarios con compañia telefónica UNEFON
SELECT usuario, telefono FROM tblUsuarios WHERE compañia = 'UNEFON';

# Listar las diferentes marcas de celular en orden alfabético descendentemente
SELECT DISTINCT marca FROM tblUsuarios ORDER BY marca DESC;

# Listar las diferentes compañias en orden alfabético aleatorio
SELECT DISTINCT compañia FROM tblUsuarios ORDER BY RAND();

# Listar el login de los usuarios con nivel 0 o 2
SELECT usuario FROM tblUsuarios WHERE nivel IN(0, 2);

# Calcular el saldo promedio de los usuarios que tienen teléfono marca LG
SELECT AVG(saldo) FROM tblUsuarios WHERE marca = 'LG';

/*

Listar el login de los usuarios con nivel 1 o 3
Listar nombre y teléfono de los usuarios con teléfono que no sea de la marca BLACKBERRY
Listar el login de los usuarios con nivel 3
Listar el login de los usuarios con nivel 0
Listar el login de los usuarios con nivel 1
Contar el número de usuarios por sexo
Listar el login y teléfono de los usuarios con compañia telefónica AT&T
Listar las diferentes compañias en orden alfabético descendentemente
Listar el logn de los usuarios inactivos
Listar los números de teléfono sin saldo
Calcular el saldo mínimo de los usuarios de sexo “Hombre”
Listar los números de teléfono con saldo mayor a 300

*/


# Listar el login de los usuarios con nivel 1 o 3
SELECT usuario FROM tblUsuarios WHERE nivel IN(1, 3);

# Listar nombre y teléfono de los usuarios con teléfono que no sea de la marca BLACKBERRY 
SELECT nombre, telefono FROM tblUsuarios WHERE marca <> "BLACKBERRY";

# Listar el login de los usuarios con nivel 3
SELECT usuario FROM tblUsuarios WHERE nivel = 3;

# Listar el login de los usuarios con nivel 0
SELECT usuario FROM tblUsuarios WHERE nivel = 0;

# Listar el login de los usuarios con nivel 1
SELECT usuario FROM tblUsuarios WHERE nivel = 1;

# Contar el número de usuarios por sexo
SELECT sexo, COUNT(*) FROM tblUsuarios GROUP BY sexo;

# Listar el login y teléfono de los usuarios con compañia telefónica AT&T
SELECT usuario, telefono FROM tblUsuarios WHERE compañia = "AT&T";

# Listar las diferentes compañias en orden alfabético descendentemente
SELECT DISTINCT compañia FROM tblUsuarios ORDER BY compañia DESC;

# Listar el login de los usuarios inactivos
SELECT usuario FROM tblUsuarios WHERE NOT activo;

# Listar los números de teléfono sin saldo
SELECT telefono FROM tblUsuarios WHERE saldo <= 0;

# Calcular el saldo mínimo de los usuarios de sexo "Hombre"
SELECT MIN(saldo) FROM tblUsuarios WHERE sexo = 'H';

# Listar los números de teléfono con saldo mayor a 300
SELECT telefono FROM tblUsuarios WHERE saldo > 300;

/*
Contar el número de usuarios por marca de teléfono
Listar nombre y teléfono de los usuarios con teléfono que no sea de la marca LG
Listar las diferentes compañias en orden alfabético ascendentemente
Calcular la suma de los saldos de los usuarios de la compañia telefónica UNEFON
Mostrar el email de los usuarios que usan hotmail
Listar los nombres de los usuarios sin saldo o inactivos
Listar el login y teléfono de los usuarios con compañia telefónicaIUSACELL o TELCEL
Listar las diferentes marcas de celular en orden alfabético ascendentemente
Listar las diferentes marcas de celular en orden alfabético aleatorio
Listar el login y teléfono de los usuarios con compañia telefónica IUSACELL o UNEFON
Listar nombre y teléfono de los usuarios con teléfono que no sea de la marca MOTOROLA o NOKIA
Calcular la suma de los saldos de los usuarios de la compañia telefónica TELCEL

*/


# Contar el número de usuarios por marca de teléfono
SELECT marca, COUNT(*) FROM tblUsuarios GROUP BY marca;

# Listar nombre y teléfono de los usuarios con teléfono que no sea de la marca LG
SELECT nombre, telefono FROM tblUsuarios WHERE marca <> "LG";

# Listar las diferentes compañias en orden alfabético ascendentemente
SELECT DISTINCT compañia FROM tblUsuarios ORDER BY compañia ASC;

# Calcular la suma de los saldos de los usuarios de la compañia telefónica UNEFON
SELECT SUM(saldo) FROM tblUsuarios WHERE compañia = 'UNEFON';

# Mostrar el email de los usuarios que usan hotmail
SELECT email FROM tblUsuarios WHERE email LIKE "%hotmail.com";

# Listar los nombres de los usuarios sin saldo o inactivos
SELECT nombre FROM tblUsuarios WHERE NOT activo OR saldo <= 0;

# Listar el login y teléfono de los usuarios con compañia telefónica IUSACELL o TELCEL
SELECT usuario, telefono FROM tblUsuarios WHERE compañia IN('IUSACELL', 'TELCEL');

# Listar las diferentes marcas de celular en orden alfabético ascendentemente
SELECT DISTINCT marca FROM tblUsuarios ORDER BY marca DESC;

# Listar las diferentes marcas de celular en orden alfabético aleatorio
SELECT DISTINCT marca FROM tblUsuarios ORDER BY RAND();

# Listar el login y teléfono de los usuarios con compañia telefónica IUSACELL o UNEFON
SELECT usuario, telefono FROM tblUsuarios WHERE compañia IN('IUSACELL', 'UNEFON');

# Listar nombre y teléfono de los usuarios con teléfono que no sea de la marca MOTOROLA o NOKIA
SELECT nombre, telefono FROM tblUsuarios WHERE marca NOT IN('MOTOROLA', 'NOKIA');

# Calcular la suma de los saldos de los usuarios de la compañia telefónica TELCEL
SELECT SUM(saldo) FROM tblUsuarios WHERE compañia = 'TELCEL';





/*
cliente , venta , producto 

PRODUCTO
#id_producto
*descripcion
*precio
CLIENTE
#id_cliente
*nombre
*direccion
*telefono
*ciudad
VENTA
#id_venta
generada *cantidad de
a
generador
de
contenido
*/

CREATE TABLE CLIENTE(
id_cliente int  PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
direccion VARCHAR(50) NOT NULL,
telefono VARCHAR(50) NOT NULL,
ciudad VARCHAR(50) NOT NULL
);
CREATE TABLE PRODUCTO(
id_producto int PRIMARY KEY,
descripcion VARCHAR(200) NOT NULL,
precio NUMERIC(10) NOT NULL
);
CREATE TABLE VENTA(
id_venta int PRIMARY KEY,
cantidad int NOT NULL,
id_cliente int  NOT NULL REFERENCES CLIENTE,
id_producto int NOT NULL REFERENCES PRODUCTO
);

INSERT INTO CLIENTE VALUES(123,'Simon Bolivar', 'Kra11#9-56', '7702291', 'Cali');
INSERT INTO CLIENTE VALUES(456,'Mark Zuckerberg', 'Cll 21#95-52', '+57-315291', 'Medellin');
INSERT INTO CLIENTE VALUES(789,'Drew Barrymore', 'Kra52#65-05', '3125359456', 'Cali');
INSERT INTO CLIENTE VALUES(741,'Larry Page', 'Cll 05#52-95', '7872296', 'Tunja');



INSERT INTO CLIENTE VALUES(147,'Tom Delonge', 'Cll 52#65-56', '7992293', 'Medellin');
INSERT INTO CLIENTE VALUES(852,'Simon Bolivar', 'Kra 21#65-52', '982295', 'Bogota');
INSERT INTO CLIENTE VALUES(258,'Mark Hoppus', 'Cll 11#95-9', '8952294', 'Bogota');
INSERT INTO CLIENTE VALUES(963,'Britney Spears', 'Cll 05#52-56', '7705295', 'Tunja');
INSERT INTO CLIENTE VALUES(369,'John Forbes Nash', 'Kra 21#05-56', '776622966', 'Cali');
INSERT INTO CLIENTE VALUES(159,'Tom Delonge', 'Kra05#65-05', '6702293','Medellin');
INSERT INTO CLIENTE VALUES(753,'Sergey Brin', 'Cll 11#65-11', '9702299', 'Medellin');
INSERT INTO CLIENTE VALUES(153,'Emma Watson', 'Kra 9#9-95', '31569638', 'Tunja');
INSERT INTO PRODUCTO VALUES(1,'Coca-Cola 2L',2400);
INSERT INTO PRODUCTO VALUES(2,'Doritos',1000);
INSERT INTO PRODUCTO VALUES(3,'Salchicha',3600);
INSERT INTO PRODUCTO VALUES(4,'Pan',500);
INSERT INTO PRODUCTO VALUES(5,'Queso',1000);
INSERT INTO PRODUCTO VALUES(6,'Sandia',8000);
INSERT INTO PRODUCTO VALUES(7,'Leche 1L',4563);
INSERT INTO PRODUCTO VALUES(8,'Atun',1800);
INSERT INTO PRODUCTO VALUES(9,'Pescado',7856);
INSERT INTO PRODUCTO VALUES(10,'Cicla Estatica',1800);
INSERT INTO PRODUCTO VALUES(11,'Camiseta',12000);
INSERT INTO PRODUCTO VALUES(12,'Blue-Jean',7800);
INSERT INTO PRODUCTO VALUES(13,'Papaya',1400);
INSERT INTO PRODUCTO VALUES(14,'Agua en Bolsa',1800);
INSERT INTO PRODUCTO VALUES(15,'Red Bull',1200);
INSERT INTO VENTA VALUES(1,5,123,1);
INSERT INTO VENTA VALUES(2,6,123,2);
INSERT INTO VENTA VALUES(3,7,123,3);
INSERT INTO VENTA VALUES(4,8,123,4);
INSERT INTO VENTA VALUES(5,2,456,5);
INSERT INTO VENTA VALUES(6,4,741,6);
INSERT INTO VENTA VALUES(7,5,456,7);
INSERT INTO VENTA VALUES(8,600,741,8);
INSERT INTO VENTA VALUES(9,69,852,9);
INSERT INTO VENTA VALUES(10,15,789,10);
INSERT INTO VENTA VALUES(11,11,456,5);
INSERT INTO VENTA VALUES(12,22,789,6);
INSERT INTO VENTA VALUES(13,11,753,7);
INSERT INTO VENTA VALUES(14,10,963,12);
INSERT INTO VENTA VALUES(15,65,963,11);
INSERT INTO VENTA VALUES(16,12,852,10);
INSERT INTO VENTA VALUES(17,65,741,9);
INSERT INTO VENTA VALUES(18,78,147,8);
INSERT INTO VENTA VALUES(19,92,258,9);
INSERT INTO VENTA VALUES(20,12,258,6);
INSERT INTO VENTA VALUES(21,32,147,3);
INSERT INTO VENTA VALUES(22,3,789,1);
INSERT INTO VENTA VALUES(23,45,456,2);
INSERT INTO VENTA VALUES(24,5,123,3);
INSERT INTO VENTA VALUES(25,5,789,4);
INSERT INTO VENTA VALUES(26,6,456,1);
INSERT INTO VENTA VALUES(27,4,123,2);
INSERT INTO VENTA VALUES(28,7,789,12);
INSERT INTO VENTA VALUES(29,8,258,13);
INSERT INTO VENTA VALUES(30,9,852,14);
INSERT INTO VENTA VALUES(31,9,753,15);
INSERT INTO VENTA VALUES(32,6,753,10);
INSERT INTO VENTA VALUES(33,7,159,9);
INSERT INTO VENTA VALUES(34,8,963,10);
INSERT INTO VENTA VALUES(35,9,369,8);
INSERT INTO VENTA VALUES(36,15,369,7);
INSERT INTO VENTA VALUES(37,5,123,5);
INSERT INTO VENTA VALUES(38,6,123,6);
INSERT INTO VENTA VALUES(39,7,123,7);
INSERT INTO VENTA VALUES(40,8,123,8);
INSERT INTO VENTA VALUES(41,5,123,9);
INSERT INTO VENTA VALUES(42,6,123,10);
INSERT INTO VENTA VALUES(43,7,123,11); 
INSERT INTO VENTA VALUES(44,8,123,12);
INSERT INTO VENTA VALUES(45,5,123,13);
INSERT INTO VENTA VALUES(46,6,123,14);
INSERT INTO VENTA VALUES(47,7,123,15); 
