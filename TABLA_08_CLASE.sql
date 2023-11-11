DROP SCHEMA IF EXISTS CODER_TABLAS;
CREATE SCHEMA IF NOT EXISTS  CODER_TABLAS ; 
USE CODER_TABLAS ; 

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
CREATE TABLE IF NOT EXISTS TIPOS_DE_DATOS (
NUMERO INT ,
NUMERO_1 INTEGER ,
NUMERO_2 BIGINT ,
NUMERO_3 FLOAT ,
NUMERO_4 DOUBLE ,
NUMERO_5 REAL ,
NUMERO_6 DECIMAL(1,1),
NUMERO_7 NUMERIC(1,1) ,
FECHA DATE ,
FECHA_1 DATETIME, 
FECHA_2 TIMESTAMP ,
FECHA_3 TIME ,
FECHA_4 YEAR ,
CARACTER CHAR(1),
CARACTER_1 VARCHAR(250) ,
CARACTER_2 BLOB ,
CARACTER_3 LONGBLOB ,
CARACTER_4 LONGTEXT ,
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
 -- UNIQUE INDEX AK_VOTE (id_game,id_system_user),
 --   CONSTRAINT PK_VOTE PRIMARY KEY (id_vote)
--   CONSTRAINT PK_PLAY PRIMARY KEY (id_game,id_system_user)

) ;



CREATE TABLE Alumnos
 (
 IdAlumno int  primary key not null,
 Nombre varchar (25),
 Apellido Varchar (25),
 Edad int,
 Direccion_Residencia varchar (50)
 );
 
 INSERT INTO Alumnos (IdAlumno, Nombre, Apellido, Edad, Direccion_Residencia) 
VALUES 
(102, 'Franklin1', 'Garcia', '25', 'avenida 01'), 
(103, 'Franklin2', 'Garcia', '25', 'avenida 02'),  
(104, 'Franklin3', 'Garcia', '25', 'avenida 03');  


CREATE TABLE IF NOT EXISTS `clientes` (
  `nif` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria',
  `nombre` varchar(50) NOT NULL COMMENT 'nombre cliente',
  `apellidos` varchar(100) NOT NULL COMMENT 'Apellidos cliente',
  `telefono` int(9) NOT NULL COMMENT 'móvil',
  `codigo_postal` int(5) DEFAULT NULL,
  `edad` int(3) DEFAULT NULL,
  `sexo` char(1) NOT NULL,
  `profesion` text NOT NULL,
  PRIMARY KEY (`nif`),
  UNIQUE KEY `telefono` (`telefono`),
  KEY `nombre` (`nombre`),
  FULLTEXT KEY `apellidos` (`apellidos`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='tabla de clientes';


CREATE TABLE `doctores`(
    `id` int NOT NULL AUTO_INCREMENT,
    `nombre_apellido` varchar(75) NOT NULL,
    `cargo` varchar(35) NOT NULL,
    `direccion` varchar(250) NULL,
    `telefono` varchar(15) NULL,
    PRIMARY KEY(`id`)
);


CREATE TABLE `servicios`(
    `id` int NOT NULL AUTO_INCREMENT,
    `nombre` varchar(75) NOT NULL, 
    `costo` double(7, 2) NOT NULL,
    `detalle` text(2000) NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE `kardexs`(
    `id` int NOT NULL AUTO_INCREMENT,
    `codigo` varchar(25) NOT NULL,
    `enfermedades` varchar(250) NULL,
    `detalle` text(2000) NULL,
    `mascota_id` int,
    PRIMARY KEY(`id`),
    CONSTRAINT `mascota_id` FOREIGN KEY (`mascota_id`)
    REFERENCES `mascotas`(`id`)
);

CREATE TABLE `doctor-servicio`(
    `id` int NOT NULL AUTO_INCREMENT,
    `doctor_id` int NOT NULL,
    `servicio_id` int NOT NULL,
    PRIMARY KEY(`id`),
    CONSTRAINT `doctor_id` FOREIGN KEY (`doctor_id`)
    REFERENCES `doctores`(`id`),
    CONSTRAINT `servicio_id` FOREIGN KEY (`servicio_id`)
    REFERENCES `servicios`(`id`)
);

CREATE TABLE `mascota-servicio`(
    `id` int NOT NULL AUTO_INCREMENT,
    `fecha` datetime NOT NULL,
    `detalle` text(2000) NULL,
    `mascota_id` int NOT NULL,
    `servicio_id` int NOT NULL,
    PRIMARY KEY(`id`),
    CONSTRAINT `mascota_id_1` FOREIGN KEY (`mascota_id`)
    REFERENCES `mascotas`(`id`),
    CONSTRAINT `servicio_id_1` FOREIGN KEY (`servicio_id`)
    REFERENCES  `servicios`(`id`)
);

/*
ALTER TABLE CLASS ADD CONSTRAINT FK_CLASS_LEVEL_GAME 
 FOREIGN KEY FK_CLASS_LEVEL_GAME (id_level)
    REFERENCES LEVEL_GAME (id_level);
    
ALTER TABLE COMMENTARY ADD CONSTRAINT 
FK_COMMENTARY_COMMENT FOREIGN KEY FK_COMMENTARY_COMMENT 
(id_game,id_system_user)
    REFERENCES COMMENT (id_game,id_system_user);
    
    
 ALTER TABLE pedidos_productos modify costo mediumint;
ALTER TABLE pedidos_productos modify cantidad smallint after id_producto;

ALTER TABLE productos modify peso_neto varchar (20);

ALTER TABLE PRODUCTOS ADD COLUMN COLUMN_NEW INT;
    */