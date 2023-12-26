DROP SCHEMA  IF EXISTS  TRIGGERSS;
CREATE SCHEMA  IF NOT EXISTS TRIGGERSS;
USE TRIGGERSS;
-- SET SQL_SAFE_UPDATES = 0;
drop table if  exists PROVINCIA ;
CREATE TABLE IF NOT EXISTS `provincia` (
  `Provincia` varchar(50) DEFAULT NULL,
  `ID_Provincia` int NOT NULL
  ,PRIMARY KEY (`ID_Provincia`)
) ;

drop table if  exists LOG_AUDITORIA;
CREATE TABLE IF NOT EXISTS LOG_AUDITORIA 
(
ID_LOG INT AUTO_INCREMENT ,-- pk de la tabla 
NOMBRE_DE_ACCION VARCHAR(10) ,-- irira si es insert , update ,delete
NOMBRE_TABLA VARCHAR(50) ,-- provincia , class , departamento , etc..
USUARIO VARCHAR(100) , -- quien ejecuta la sentencia DML
FECHA_UPD_INS_DEL DATE , -- momento exacto en el que se genera DML
PRIMARY KEY (ID_LOG)
)
;

drop table if  exists LOG_AUDITORIA_2;
CREATE TABLE IF NOT EXISTS LOG_AUDITORIA_2 
(
ID_LOG INT AUTO_INCREMENT ,
 PROVINCIA varchar(50) DEFAULT NULL,
 ID_PROVINCIA int NOT NULL ,
-- CAMPONUEVO_CAMPOANTERIOR VARCHAR(N)
NOMBRE_DE_ACCION VARCHAR(10) ,
NOMBRE_TABLA VARCHAR(50) ,
USUARIO VARCHAR(100) ,
FECHA_UPD_INS_DEL DATE    ,
PRIMARY KEY (ID_LOG)
)
;

-- SINTAXIS 
/*
create trigger TRG_nombre-del-trigger
  [before / after] [insert / delete / update] 
  on nombre-de-la-tabla_a_la_que_quiero_auditar
  for each row
begin
 todo el código / instrucciones-sql;
end
*/


DELIMITER //
CREATE TRIGGER TRG_LOG_PROVINCIA AFTER INSERT ON TRIGGERSS.PROVINCIA
FOR EACH ROW 
BEGIN

INSERT INTO LOG_AUDITORIA (NOMBRE_DE_ACCION , NOMBRE_TABLA , USUARIO,FECHA_UPD_INS_DEL)
VALUES ( 'INSERT' , 'PROVINCIA' ,CURRENT_USER() , NOW());

END//
DELIMITER ;

DROP TRIGGER IF EXISTS TRG_LOG_PROVINCIA_2 ;

DELIMITER //
CREATE TRIGGER  TRG_LOG_PROVINCIA_2 AFTER INSERT ON TRIGGERSS.PROVINCIA
FOR EACH ROW 
BEGIN

INSERT INTO LOG_AUDITORIA_2 (PROVINCIA , ID_PROVINCIA, NOMBRE_DE_ACCION , NOMBRE_TABLA ,USUARIO, FECHA_UPD_INS_DEL)
VALUES ( NEW.PROVINCIA  ,NEW.ID_PROVINCIA, 'INSERT' , 'PROVINCIA' ,CURRENT_USER(), NOW());
       
END//
DELIMITER ;

SELECT * FROM LOG_AUDITORIA ;
SELECT * FROM LOG_AUDITORIA_2 ;


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
INSERT INTO provincia (`Provincia`,`ID_Provincia`) VALUES ('Tierra',25); 
SELECT * FROM LOG_AUDITORIA ;
SELECT * FROM LOG_AUDITORIA_2 ;
SELECT * FROM PROVINCIA ;

 DROP TRIGGER IF EXISTS TRG_LOG_PROVINCIA_3 ;
DELIMITER //
CREATE TRIGGER TRG_LOG_PROVINCIA_3 BEFORE UPDATE ON TRIGGERSS.PROVINCIA
FOR EACH ROW 
BEGIN

INSERT INTO LOG_AUDITORIA_2 (PROVINCIA,ID_PROVINCIA, NOMBRE_DE_ACCION , NOMBRE_TABLA , FECHA_UPD_INS_DEL)
VALUES ( 'OLD.PROVINCIA - NEW.PROVINCIA' ,'OLD.ID_PROVINCIA-NEW.ID_PROVINCIA', 'UPDATE' , 'PROVINCIA' , NOW());

END//
DELIMITER 

SELECT * FROM PROVINCIA; 
UPDATE TRIGGERSS.PROVINCIA SET PROVINCIA = 'BOGOTÁ' WHERE ID_Provincia = 2 ; 
SELECT * FROM LOG_AUDITORIA_2 ;

DROP TRIGGER IF EXISTS TRG_LOG_PROVINCIA_4 ;
DELIMITER //
CREATE TRIGGER TRG_LOG_PROVINCIA_4 AFTER  UPDATE ON TRIGGERSS.PROVINCIA
FOR EACH ROW 
BEGIN


INSERT INTO LOG_AUDITORIA_2 (PROVINCIA,ID_PROVINCIA, NOMBRE_DE_ACCION , NOMBRE_TABLA , FECHA_UPD_INS_DEL)
VALUES ( CONCAT('CAMPO ANTERIOR : ', OLD.PROVINCIA ,'  CAMPO NUEVO : ' , NEW.PROVINCIA ),
		NEW.ID_PROVINCIA ,
		'UPDATE' , 
        'PROVINCIA' ,
         NOW()
        );

END//
DELIMITER ;
UPDATE TRIGGERSS.PROVINCIA SET PROVINCIA = 'Santa Fe' WHERE ID_Provincia = 2 ; 

SELECT * FROM LOG_AUDITORIA_2 ;


DROP TRIGGER IF EXISTS TRG_LOG_PROVINCIA_5 ;
DELIMITER //
CREATE TRIGGER TRG_LOG_PROVINCIA_5 BEFORE  DELETE  ON TRIGGERSS.PROVINCIA
 FOR EACH ROW 
BEGIN


INSERT INTO LOG_AUDITORIA_2 (PROVINCIA,ID_PROVINCIA, NOMBRE_DE_ACCION , NOMBRE_TABLA , FECHA_UPD_INS_DEL)
VALUES ( CONCAT('', OLD.PROVINCIA ,'' , OLD.PROVINCIA ),
		OLD.ID_PROVINCIA ,
		'DELETE' , 
        'PROVINCIA' ,
         NOW()
        );

END//
DELIMITER ;


SELECT * FROM LOG_AUDITORIA_2 ;

SELECT * FROM TRIGGERSS.PROVINCIA WHERE ID_PROVINCIA = 5 ;
DELETE FROM TRIGGERSS.PROVINCIA 
WHERE ID_PROVINCIA = 5 ;

-- Error Code: 1406. Data too long for column 'PROVINCIA' at row 1



/*==============================================================================================*/

drop table if  exists libros ;

create table if not exists libros 
(
codigo int ,
titulo varchar(60) ,
autor varchar(60) ,
editorial varchar(60) ,
precio int ,
stock int 

);

insert libros  ( codigo , titulo , autor , editorial , precio , stock )
values (1, 'uno' , 'richard txt' , 'plaenta',15,1000), 
       (2, 'ilusiones' , 'richard txt' , 'plaenta',25,150),
       (3, 'el aleph' , 'borges' , 'editorial',35,10),
       (4, 'aprende php' , 'rmolina ' , 'editorial',45,101);


drop table if  exists ventas ; 
create  table if not  exists ventas 
(  codigolibro int  ,
    precio int ,
    cantidad int 
 ) ;   

select  * from libros ;
select  * from ventas ;

drop trigger if exists before_ventas_delete;
delimiter //
create trigger before_ventas_delete 
before delete 
on ventas 
for each row 
begin 
update libros set stock = libros.stock + old.cantidad
where old.codigolibro = libros.codigo ;
end//
delimiter ; 

drop trigger if exists before_ventas_insert;  

 delimiter //
 create trigger before_ventas_insert
   before insert
   on ventas
   for each row
 begin
   update libros set stock=libros.stock-new.cantidad
     where new.codigolibro=libros.codigo; 
 end //
 delimiter ;

insert into ventas values  ( 1,15,7) ;

select  * from libros ;
select  * from ventas ;

-- SET SQL_SAFE_UPDATES = 0;
 update  ventas   set  cantidad = 2 where  codigolibro =1; 
delete from ventas where codigolibro =1;  

select  * from ventas ;
select  * from libros ;


/*==============================================================================================*/

-- Necesitamos almacenar en una tabla llamada "usuarios" los datos de los usuarios de un sitio web. 
-- Cada vez que el usuario cambia su clave se debe almacenar en otra tabla llamada "clavesanteriores"
--  el dato de la clave vieja.

-- Borramos las dos tablas si existen:

drop table if exists usuarios;
drop table if exists clavesanteriores;


create table usuarios(
 nombre varchar(30),
 clave varchar(30),
 primary key (nombre)
);

create table clavesanteriores(
 numero int auto_increment,
 nombre varchar(30),
 clave varchar(30),
 primary key (numero)
);


drop trigger if exists before_usuarios_update;

delimiter //
create trigger before_usuarios_update
  before update
  on usuarios
  for each row
begin
  insert into clavesanteriores(nombre, clave) values (old.nombre, old.clave); 
end //
delimiter ;

insert into usuarios(nombre,clave) values ('marcos','123abc');
select * from usuarios;
update usuarios set clave='999zzz' where nombre='marcos';

select * from clavesanteriores;

update usuarios set clave='123456' where nombre='marcos';

select * from clavesanteriores;

select * from usuarios;
/*==============================================================================================*/


DROP TABLE IF EXISTS APUNTES;
CREATE TABLE APUNTES (
 ASIENTO INT(8) DEFAULT 0,
LINEA SMALLINT(5) DEFAULT 0,
FECHA DATE DEFAULT '2006-01-01', 
TEXTO VARCHAR(40) default '',
 CUENTA CHAR(10) default '',
 DEBE DOUBLE(10,2) DEFAULT 0,
HABER DOUBLE(10,2) DEFAULT 0,
 PRIMARY KEY (ASIENTO,LINEA),
KEY K2(CUENTA, FECHA) )
;

DROP TABLE IF EXISTS SALDO;
CREATE TABLE SALDO (
CUENTA CHAR(10) NOT NULL default '',
ANO SMALLINT(4) DEFAULT 0,
MES TINYINT(2) DEFAULT 0,
DEBE DOUBLE(10,2) DEFAULT 0,
HABER DOUBLE(10,2) DEFAULT 0,
PRIMARY KEY (CUENTA,ANO,MES) )
;

DELIMITER //
CREATE TRIGGER APTS_I  AFTER INSERT ON APUNTES
FOR EACH ROW
BEGIN
INSERT INTO SALDO SET
SALDO.CUENTA=NEW.CUENTA,
SALDO.ANO=YEAR(NEW.FECHA),
SALDO.MES=MONTH(NEW.FECHA),
SALDO.DEBE=NEW.DEBE,
SALDO.HABER=NEW.HABER
ON DUPLICATE KEY UPDATE 
SALDO.DEBE=SALDO.DEBE+NEW.DEBE,
SALDO.HABER=SALDO.HABER+NEW.HABER ;
END;//

DELIMITER ;


DELIMITER //
CREATE TRIGGER APTS_U  AFTER UPDATE ON APUNTES
FOR EACH ROW
BEGIN
    INSERT INTO SALDO SET
     SALDO.CUENTA=OLD.CUENTA,
     SALDO.ANO=YEAR(OLD.FECHA),
     SALDO.MES=MONTH(OLD.FECHA),
	SALDO.DEBE=OLD.DEBE*(-1),
    SALDO.HABER=OLD.HABER*(-1)
    ON DUPLICATE KEY UPDATE 
    SALDO.DEBE=SALDO.DEBE+(OLD.DEBE*(-1)),
    SALDO.HABER=SALDO.HABER+(OLD.HABER*(-1)) ;

    INSERT INTO SALDO SET
    SALDO.CUENTA=NEW.CUENTA,
	SALDO.ANO=YEAR(NEW.FECHA),
    SALDO.MES=MONTH(NEW.FECHA),
    SALDO.DEBE=NEW.DEBE,
    SALDO.HABER=NEW.HABER
	ON DUPLICATE KEY UPDATE 
    SALDO.DEBE=SALDO.DEBE+NEW.DEBE,
    SALDO.HABER=SALDO.HABER+NEW.HABER ;

END;//
DELIMITER ;


DELIMITER //
CREATE TRIGGER APTS_D  AFTER DELETE ON APUNTES
FOR EACH ROW
BEGIN
  INSERT INTO SALDO SET
  SALDO.CUENTA=OLD.CUENTA,
  SALDO.ANO=YEAR(OLD.FECHA),
  SALDO.MES=MONTH(OLD.FECHA),
  SALDO.DEBE=OLD.DEBE*(-1),
  SALDO.HABER=OLD.HABER*(-1)
  ON DUPLICATE KEY UPDATE 
  SALDO.DEBE=SALDO.DEBE+(OLD.DEBE*(-1)),
  SALDO.HABER=SALDO.HABER+(OLD.HABER*(-1)) ;

END;//
DELIMITER ;


INSERT INTO APUNTES VALUES (1,1,'2006-02-07','Fra.112 PEPE PALO','4300000001',1160,0);
INSERT INTO APUNTES VALUES (1,2,'2006-02-07','Fra.112 PEPE PALO','4770000001',0,160);
INSERT INTO APUNTES VALUES (1,3,'2006-02-07','Fra.112 PEPE PALO','7000000000',0,1000);
INSERT INTO APUNTES VALUES (2,1,'2006-03-20','Cobro Fra.112 PEPE PALO','5700000000',1160,0);
INSERT INTO APUNTES VALUES (2,2,'2006-03-20','Cobro Fra.112 PEPE PALO','4300000001',0,1160);


SELECT * FROM SALDO ;