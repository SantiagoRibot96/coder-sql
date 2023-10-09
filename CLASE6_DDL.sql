-- Sentencias DDL    CREATE  , DROP , ALTER   , TRUNCATE  


DROP SCHEMA IF  EXISTS   CODER_DDL ;-- Si hacemos un drop de un esquema que no existe, va a salir un error. Por eso se le pone el if exists
CREATE SCHEMA IF NOT EXISTS  CODER_DDL ;
USE CODER_DDL ;

DROP SCHEMA CODER_DDL;-- DROP elimina el esquema por completo. Por buena practica, antes de crearlo hay que borrarlo.
CREATE SCHEMA CODER_DDL;-- CREATE crea el esquema
USE CODER_DDL ;-- USE es para indicar que quiero usar ese esquema

/*
-- Datos numéricos
TINYINT
SMALLINT
MEDIUMINT
INT o INTEGER
BIGINT
-- Datos para guardar cadenas de caracteres (alfanuméricos)
CHAR
VARCHAR
BINARY
VARBINARY
TINYBLOB
TINYTEXT
BLOB
TEXT
MEDIUMBLOB
MEDIUMTEXT
LONGBLOB
LONGTEX
ENUM
SET
Datos para almacenar fechas y horas
DATE
DATETIME
TIME
TIMESTAMP
YEAR
Atributos de los campos
NULL
DEFAULT
BINARY
INDEX
PRIMARY KEY
AUTO_INCREMENT
UNIQUE
FULLTEXT
*/


CREATE TABLE`all_data_types` (
    `varchar` VARCHAR( 20 )  ,
    `tinyint` TINYINT  ,
    `text` TEXT  ,
    `date` DATE  ,
    `smallint` SMALLINT  ,
    `mediumint` MEDIUMINT  ,
    `int` INT  ,
    `bigint` BIGINT  ,
    `float` FLOAT( 10, 2 )  ,
    `double` DOUBLE  ,
    `decimal` DECIMAL( 10, 2 )  ,
    `datetime` DATETIME  ,
    `timestamp` TIMESTAMP  ,
    `time` TIME  ,
    `year` YEAR  ,
    `char` CHAR( 10 )  ,
    `tinyblob` TINYBLOB  ,
    `tinytext` TINYTEXT  ,
    `blob` BLOB  ,
    `mediumblob` MEDIUMBLOB  ,
    `mediumtext` MEDIUMTEXT  ,
    `longblob` LONGBLOB  ,
    `longtext` LONGTEXT  ,
    `enum` ENUM( '1', '2', '3' )  ,
    `set` SET( '1', '2', '3' )  ,
    `bool` BOOL  ,
    `binary` BINARY( 20 )  ,
    `varbinary` VARBINARY( 20 )
)  ;

DROP TABLE if exists `all_data_types`;

DROP TABLE  if exists provincia;
CREATE TABLE `provincia` (
  `Provincia` varchar(50) DEFAULT NULL,
  `ID_Provincia` int NOT NULL
  ,PRIMARY KEY (`ID_Provincia`)
) ;

DROP TABLE  if exists departamento;
CREATE TABLE `departamento` (
  `Departamento` varchar(50) DEFAULT NULL,
  `Provincia` varchar(50) DEFAULT NULL,
  `Provincia_Depto` varchar(100) DEFAULT NULL,
  `ID_Provincia` int DEFAULT NULL,
  `ID_Departamento` int NOT NULL
   ,PRIMARY KEY (`ID_Departamento`)
 -- , FOREIGN KEY (`ID_Provincia`) REFERENCES `provincia` (`ID_Provincia`)
);

DROP TABLE  if exists localidad ;
CREATE TABLE `localidad` (
  `Localidad` varchar(50) DEFAULT NULL,
  `Provincia` varchar(50) DEFAULT NULL,
  `Departamento` varchar(30) DEFAULT NULL,
  `ID_Provincia` int DEFAULT NULL,
  `ID_Departamento` int DEFAULT NULL,
  `ID_Localidad` int NOT NULL,
  PRIMARY KEY (`ID_Localidad`)
  -- ,FOREIGN KEY (`ID_Provincia`) REFERENCES `provincia` (`ID_Provincia`)

);

Drop table if  exists  videojuego ;
CREATE TABLE if not exists  videojuego (
   id INT (11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
   titulo VARCHAR(100) NOT NULL,
   lenguaje VARCHAR(5) NOT NULL,
   resumen TEXT NULL,
   nota DECIMAL (3,1),
   total_jugadores INT DEFAULT 0
);
 
 drop table if  exists  jugador;
CREATE TABLE if not exists  jugador(
   id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   nombre VARCHAR(80) NOT NULL,
   edad INT NOT NULL,
   es_famoso INT NOT NULL DEFAULT 0,
   id_videojuego INT NOT NULL,
   fecha_registro DATE NULL ,
   FOREIGN KEY(id_videojuego) REFERENCES videojuego(id)  
);

INSERT INTO departamento (`Departamento`,`Provincia`,`Provincia_Depto`,`ID_Provincia`,`ID_Departamento`) VALUES ('San Justo','Cordoba','Cordoba-San Justo',1,1);
INSERT INTO departamento (`Departamento`,`Provincia`,`Provincia_Depto`,`ID_Provincia`,`ID_Departamento`) VALUES ('San Jerónimo','Santa Fe','Santa Fe-San Jerónimo',2,2);
INSERT INTO departamento (`Departamento`,`Provincia`,`Provincia_Depto`,`ID_Provincia`,`ID_Departamento`) VALUES ('Las Colonias','Santa Fe','Santa Fe-Las Colonias',2,3);
INSERT INTO departamento (`Departamento`,`Provincia`,`Provincia_Depto`,`ID_Provincia`,`ID_Departamento`) VALUES ('San Justo','Santa Fe','Santa Fe-San Justo',2,4);
INSERT INTO departamento (`Departamento`,`Provincia`,`Provincia_Depto`,`ID_Provincia`,`ID_Departamento`) VALUES ('Belgrano','Santiago Del Estero','Santiago Del Estero-Belgrano',3,5);
INSERT INTO departamento (`Departamento`,`Provincia`,`Provincia_Depto`,`ID_Provincia`,`ID_Departamento`) VALUES ('Iriondo','Santa Fe','Santa Fe-Iriondo',2,6);
INSERT INTO departamento (`Departamento`,`Provincia`,`Provincia_Depto`,`ID_Provincia`,`ID_Departamento`) VALUES ('25 de Mayo','Buenos Aires','Buenos Aires-25 de Mayo',4,7);
INSERT INTO departamento (`Departamento`,`Provincia`,`Provincia_Depto`,`ID_Provincia`,`ID_Departamento`) VALUES ('Marcos Juarez','Cordoba','Cordoba-Marcos Juarez',1,8);
INSERT INTO departamento (`Departamento`,`Provincia`,`Provincia_Depto`,`ID_Provincia`,`ID_Departamento`) VALUES ('Rojas','Buenos Aires','Buenos Aires-Rojas',4,9);
INSERT INTO departamento (`Departamento`,`Provincia`,`Provincia_Depto`,`ID_Provincia`,`ID_Departamento`) VALUES ('San Martín','Santa Fe','Santa Fe-San Martín',2,10);
INSERT INTO departamento (`Departamento`,`Provincia`,`Provincia_Depto`,`ID_Provincia`,`ID_Departamento`) VALUES ('Castellanos','Santa Fe','Santa Fe-Castellanos',2,11);
INSERT INTO departamento (`Departamento`,`Provincia`,`Provincia_Depto`,`ID_Provincia`,`ID_Departamento`) VALUES ('Rosario','Santa Fe','Santa Fe-Rosario',2,12);
INSERT INTO departamento (`Departamento`,`Provincia`,`Provincia_Depto`,`ID_Provincia`,`ID_Departamento`) VALUES ('Victoria','Entre Rios','Entre Rios-Victoria',5,13);
INSERT INTO departamento (`Departamento`,`Provincia`,`Provincia_Depto`,`ID_Provincia`,`ID_Departamento`) VALUES ('Belgrano','Santa Fe','Santa Fe-Belgrano',2,14);
INSERT INTO departamento (`Departamento`,`Provincia`,`Provincia_Depto`,`ID_Provincia`,`ID_Departamento`) VALUES ('San Cristobal','Santa Fe','Santa Fe-San Cristobal',2,15);
INSERT INTO departamento (`Departamento`,`Provincia`,`Provincia_Depto`,`ID_Provincia`,`ID_Departamento`) VALUES ('Chivilcoy','Buenos Aires','Buenos Aires-Chivilcoy',4,16);
INSERT INTO departamento(`Departamento`,`Provincia`,`Provincia_Depto`,`ID_Provincia`,`ID_Departamento`) VALUES ('Alberti','Buenos Aires','Buenos Aires-Alberti',4,17);
INSERT INTO departamento (`Departamento`,`Provincia`,`Provincia_Depto`,`ID_Provincia`,`ID_Departamento`) VALUES ('Unión','Cordoba','Cordoba-Unión',1,18);
INSERT INTO departamento (`Departamento`,`Provincia`,`Provincia_Depto`,`ID_Provincia`,`ID_Departamento`) VALUES ('Caseros','Santa Fe','Santa Fe-Caseros',2,19);

INSERT INTO localidad (`Localidad`,`Provincia`,`Departamento`,`ID_Provincia`,`ID_Departamento`,`ID_Localidad`) VALUES ('Colonia Santa Rita (Luxardo-Dpto. San Ju','Cordoba','San Justo',1,1,1);
INSERT INTO localidad (`Localidad`,`Provincia`,`Departamento`,`ID_Provincia`,`ID_Departamento`,`ID_Localidad`) VALUES ('Colonia Eugenia','Cordoba','San Justo',1,1,2);
INSERT INTO localidad (`Localidad`,`Provincia`,`Departamento`,`ID_Provincia`,`ID_Departamento`,`ID_Localidad`) VALUES ('Colonia Piaggio','Santa Fe','San Jerónimo',2,2,3);
INSERT INTO localidad (`Localidad`,`Provincia`,`Departamento`,`ID_Provincia`,`ID_Departamento`,`ID_Localidad`) VALUES ('Santa Clara','Santa Fe','Las Colonias',2,3,4);
INSERT INTO localidad (`Localidad`,`Provincia`,`Departamento`,`ID_Provincia`,`ID_Departamento`,`ID_Localidad`) VALUES ('Vera Mujica','Santa Fe','San Justo',2,4,5);
INSERT INTO localidad (`Localidad`,`Provincia`,`Departamento`,`ID_Provincia`,`ID_Departamento`,`ID_Localidad`) VALUES ('Bandera','Santiago Del Estero','Belgrano',3,5,6);
INSERT INTO localidad (`Localidad`,`Provincia`,`Departamento`,`ID_Provincia`,`ID_Departamento`,`ID_Localidad`) VALUES ('Salto Grande','Santa Fe','Iriondo',2,6,7);
INSERT INTO localidad (`Localidad`,`Provincia`,`Departamento`,`ID_Provincia`,`ID_Departamento`,`ID_Localidad`) VALUES ('Laguna Las Mulitas','Buenos Aires','25 de Mayo',4,7,8);
INSERT INTO localidad (`Localidad`,`Provincia`,`Departamento`,`ID_Provincia`,`ID_Departamento`,`ID_Localidad`) VALUES ('Monte Buey','Cordoba','Marcos Juarez',1,8,9);
INSERT INTO localidad (`Localidad`,`Provincia`,`Departamento`,`ID_Provincia`,`ID_Departamento`,`ID_Localidad`) VALUES ('Haras San Jacinto','Buenos Aires','Rojas',4,9,10);
INSERT INTO localidad (`Localidad`,`Provincia`,`Departamento`,`ID_Provincia`,`ID_Departamento`,`ID_Localidad`) VALUES ('Piamonte','Santa Fe','San Martín',2,10,11);
INSERT INTO localidad (`Localidad`,`Provincia`,`Departamento`,`ID_Provincia`,`ID_Departamento`,`ID_Localidad`) VALUES ('Colonia Margarita','Santa Fe','Castellanos',2,11,12);
INSERT INTO localidad (`Localidad`,`Provincia`,`Departamento`,`ID_Provincia`,`ID_Departamento`,`ID_Localidad`) VALUES ('San Martin De Tours','Santa Fe','San Jerónimo',2,2,13);
INSERT INTO localidad (`Localidad`,`Provincia`,`Departamento`,`ID_Provincia`,`ID_Departamento`,`ID_Localidad`) VALUES ('San Jeronimo Del Sauce','Santa Fe','Las Colonias',2,3,14);


INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Cordoba',1);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Santa Fe',2);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Santiago Del Estero',3);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Buenos Aires',4);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Entre Rios',5);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Chaco',6);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('La Pampa',7);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('San Luis',8);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Corrientes',9);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Misiones',10);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('San Juan',11);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Santa Cruz',12);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Rio Negro',13);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Chubut',14);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Mendoza',15);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('La Rioja',16);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Catamarca',17);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Tucuman',18);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Neuquen',19);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Salta',20);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Formosa',21);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Jujuy',22);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Ciudad Autonoma de Buenos Aires',23);
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Tierra del Fuego',24);


SELECT * FROM LOCALIDAD ;
SELECT * FROM PROVINCIA;
TRUNCATE PROVINCIA ;




alter table departamento 
add FOREIGN KEY (`ID_Provincia`) REFERENCES `provincia` (`ID_Provincia`);

alter table departamento 
add FOREIGN KEY (`ID_Provincia`) REFERENCES `provincia` (`ID_Provincia`) ;

ALTER TABLE departamento ADD DEPART int;

ALTER TABLE departamento MODIFY DEPART VARCHAR(24);

ALTER TABLE departamento   DROP COLUMN DEPART;



-- Error Code: 1075. Incorrect table definition; there can be only one auto column and it must be defined as a key

-- MODIFICACIONES

ALTER TABLE pedidos_productos modify costo mediumint;
ALTER TABLE pedidos_productos modify cantidad smallint after id_producto;

ALTER TABLE productos modify peso_neto varchar (20);

ALTER TABLE PRODUCTOS ADD COLUMN COLUMN_NEW INT;

/*Funciones Propias de Mysql*/
/*Funciones Propias de Mysql*/
/*Funciones Propias de Mysql*/
/*Funciones Propias de Mysql*/
/*Funciones Propias de Mysql*/
/*Funciones Propias de Mysql*/
/*Funciones Propias de Mysql*/
/*Funciones Propias de Mysql*/

-- Fecha
select now();
select curdate(); 
select curtime();
select current_date();
select year(now());
select month(now());
select day(now());
select last_day(now());
select year('2022-11-03 21:59:37') ;
-- texto
select concat('mate' , 'maticas') ;
select concat_ws(';' , 'Teresa' ,'Natalia', 'Lola');
select lcase('Base de Datos');
select lower('Base de Datos');
select ucase('Base de Datos');
select upper('Base de Datos');
select ORD('@');
select length('Base de Datos');
select lpad('Base de Datos' , 5, '-');
select rpad('Base de Datos' , 25, '-');
select substring('lorenaperez' ,1, 6) ;
select substring('lorenaperez' ,7, 6) ;
select concat ( substring('lorenaperez' ,1, 6) , ' - ' , substring('lorenaperez' ,7, 6) ); 
select ltrim('     a      .  ' ) ;
select rtrim('     a      .  ' ) ;
select trim('     a      .  ' ) as con_trim  , '     a      .  '  as sin_trim;

-- matematicas 
select abs(-35);
select least(15,25,30,1);
select sqrt(25);
select round(12.28);
-- agregadas
select count(1) ;
select max(1);
select min(1);
select avg(1);
select sum(1);