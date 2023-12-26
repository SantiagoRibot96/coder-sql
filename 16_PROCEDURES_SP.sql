  /* 
 =============================================================================================== 
 =============================================================================================== 
 =============================================================================================== 
 =============================PROCEDIMEINTOS====================================================
 =============================================================================================== 
 =============================================================================================== 
 =============================================================================================== 
 =============================================================================================== 
 */ 
 
 
 USE GAMMER_47375 ;


DELIMITER //
CREATE PROCEDURE total_paises()
BEGIN
  SELECT COUNT(*)
  FROM GAME;
END //
DELIMITER ;

call total_paises;



DELIMITER //
CREATE PROCEDURE total_paises_nombrados_como
(IN palabra CHAR(20))
BEGIN
  SELECT COUNT(*) FROM GAME
  WHERE NAME LIKE palabra;
END //
DELIMITER ;

CALL total_paises_nombrados_como('%FIFA 22%');



drop procedure juegos_con_letra;
delimiter //
create procedure juegos_con_letra(in letra char(1),out numero int)
begin
select count(*)
into numero
from game
where name like concat('%',letra,'%');
end//
delimiter ;

call juegos_con_letra('j',@cantidad_j);
call juegos_con_letra('u',@cantidad_u);
call juegos_con_letra('a',@cantidad_a);
call juegos_con_letra('n',@cantidad_n);
select @cantidad_j as alumnos_con_j,@cantidad_u,@cantidad_a,@cantidad_n;



DELIMITER $$
DROP PROCEDURE IF EXISTS listar_productos$$
CREATE PROCEDURE listar_productos(IN juego VARCHAR(50))
BEGIN
  SELECT *
  FROM game
  WHERE  name  = juego;
END $$
DELIMITER ;

call listar_productos('FIFA 22');



DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_max_min_media$$
CREATE PROCEDURE calcular_max_min_media(
  IN juego VARCHAR(50),
    OUT maximo DECIMAL(15, 2),
  OUT minimo DECIMAL(15, 2),
    OUT media DECIMAL(15, 2)
)
BEGIN
  SET maximo = (
    SELECT MAX(ID_LEVEL)
    FROM GAME
        WHERE NAME = juego);
  
  SET minimo = (
    SELECT MIN(ID_LEVEL)
    FROM GAME
        WHERE NAME = juego);
  
  SET media = (
    SELECT AVG(ID_LEVEL)
    FROM GAME
        WHERE NAME = juego);
END
$$

DELIMITER ;
CALL calcular_max_min_media('FIFA 22', @maximo, @minimo, @media);
SELECT @maximo, @minimo, @media;




use corraloncoder ;
  
  

select distinct  
       codigo_pedido, 
        venta_total_mes ,
       venta_total_mes * 1.21  as con_iva
       from ventas 
       where venta_total_mes > 4000 
        and codigo_pedido = 3400
       ; 
       
       
        select distinct  
       codigo_pedido, 
        venta_total_mes ,
       venta_total_mes * P_ENTRADA1  as con_iva
       INTO 
       P_codigo_pedido , -- P_OUT1
       P_venta_total_mes,-- P_OUT2
       P_con_iva -- P_OUT3
       from ventas 
       where venta_total_mes > P_ENTRADA2 
        and codigo_pedido = P_ENTRADA3
       ; 
       
       
       
          select distinct 
       venta_total_mes * p_iva  into  con_iva 
       from ventas 
       where venta_total_mes > p_venta_total_mes        
       and codigo_pedido = p_codigo_pedido 
       ;
       

drop procedure if exists sp_calcula_iva ;
 
 delimiter // 
 create procedure sp_calcula_iva ( in p_iva decimal(4,2) ,
                                   in p_venta_total_mes int , 
								   in p_codigo_pedido int , 
                                   out con_iva int ,
                                   out  p_codigos_pedido int,
                                   out  p_ventas_total_mes int )
begin 

      select distinct 
       codigo_pedido    ,
	   venta_total_mes   , 
       venta_total_mes * p_iva   
       into   p_codigos_pedido , p_ventas_total_mes , con_iva 
       from ventas where venta_total_mes >
       p_venta_total_mes 
       and codigo_pedido = p_codigo_pedido 
       ;

end//
delimiter ;    
                              
 
 CALL sp_calcula_iva ( 1.21,4000,3400,
                       @con_iva , 
					   @p_codigos_pedido,
                       @p_ventas_total_mes ) ;

 SELECT @con_iva  AS con_iva , 
		@p_codigos_pedido as  codigo_pedido,
        @p_ventas_total_mes  as  venta_total_mes; 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 drop schema if exists procedimientos_funciones ;
create schema if not exists   procedimientos_funciones;
use procedimientos_funciones ;


 drop table if exists libros;

create table libros(
  codigo int auto_increment,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2),
  stock int,
  primary key(codigo)
);


 insert into libros(titulo,autor,editorial,precio,stock) 
  values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',20.00, 9);
 insert into libros(titulo,autor,editorial,precio,stock)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Plaza',35.00, 50);
 insert into libros(titulo,autor,editorial,precio,stock)
  values('Aprenda PHP','Mario Molina','Siglo XXI',40.00, 3);
 insert into libros(titulo,autor,editorial,precio,stock)
  values('El aleph','Borges','Emece',10.00, 18);
 insert into libros(titulo,autor,editorial,precio,stock)
  values('Ilusiones','Richard Bach','Planeta',15.00, 22);
 insert into libros(titulo,autor,editorial,precio,stock)
  values('Java en 10 minutos','Mario Molina','Siglo XXI',50.00, 7);
 insert into libros(titulo,autor,editorial,precio,stock)
  values('Martin Fierro','Jose Hernandez','Planeta',20.00, 3);
 insert into libros(titulo,autor,editorial,precio,stock)
  values('Martin Fierro','Jose Hernandez','Emece',30.00, 70);
 insert into libros(titulo,autor,editorial,precio,stock)
  values('Uno','Richard Bach','Planeta',10.00, 120);
  
  
 
   select  distinct 
	      codigo_pedido, 
	      venta_total_mes ,
         venta_total_mes * 1.21   as con_iva
       -- ,fn_calcula_iva(1.21, 4000,3400)as  v_con_iva 
       from corraloncoder.ventas 
       where venta_total_mes < 7000 
       and codigo_pedido = 2000
       ;
 
 delimiter //
 create procdeure sp_nombre (in out inout p_parametro tipo_Dato)
 begin
 -- SQL
 end//
 delimiter;
 
 drop procedure if exists sp_mayor;

delimiter //
create procedure sp_mayor(
  in valor1 int,
  in valor2 int,
  in valor3 int 
 --  ,out parametrodesalida int
 --  ,out variable1 varchar(255)
 --  ,out resultado varchar(255)  
 )
begin
  declare parametrodesalida int;
 declare variable1 varchar(255);
 declare resultado  varchar(255);
  if valor1 > valor2 then
    select valor1 ,valor2 ;
      elseif valor1 = valor2 then 
        select valor1 - valor2 ;          
		  elseif valor3 is not null then 
             select valor3 ;
				elseif valor2 is null then 
				  select valor1 * valor2 ;
                    else 
                     select valor2 ;

  end if;

   end //
delimiter ;

call sp_mayor(1, 1114000,3);

-- fuera de SP 
SELECT 
CODIGO_PEDIDO AS ID_TABLA  
 , VENTA_TOTAL_MES  AS VENTAS 
FROM corraloncoder.VENTAS LIMIT 1 ;


 select * from tabla 
order by columna_tres asc ;


-- SP 
SELECT 
CODIGO_PEDIDO  , VENTA_TOTAL_MES INTO ID_TABLA  ,VENTAS
FROM corraloncoder.VENTAS LIMIT 1 ;


 select * from tabla 
order by parametro_uno  parametro_dos ;

set variable =  select * from tabla  order by parametro_uno
 concat('select * from tabla  order by' , parametro_uno )
 ;

select concat('select * from tabla  order by ' , 'parametro_uno'  ) ;

SELECT CONCAT(CODIGO_PEDIDO ,''  -  '', VENTA_TOTAL_MES ) 
FROM corraloncoder.VENTAS LIMIT 1  ;


DROP PROCEDURE IF EXISTS  SP_LIMIT;
DELIMITER //
CREATE PROCEDURE SP_LIMIT (
OUT ID_TABLA INT ,OUT VENTAS INT ,
OUT SALIDA VARCHAR(255)
 )
BEGIN
			
SET  @SALIDA = CONCAT('SELECT CONCAT(CODIGO_PEDIDO ,''  -  '', VENTA_TOTAL_MES ) FROM corraloncoder.VENTAS LIMIT 1  ;' );
 
 PREPARE EJECUCION FROM @SALIDA;
 EXECUTE EJECUCION;
 DEALLOCATE PREPARE EJECUCION;    
 
 
 select * from tabla  order by parametro_uno

SELECT 
CODIGO_PEDIDO  , VENTA_TOTAL_MES INTO ID_TABLA  ,VENTAS
FROM corraloncoder.VENTAS LIMIT 1 ;

execute SP_LIMIT(ID_TABLA,VENTAS,SALIDA);
/*PREPARE EJECUCION FROM @CODIGO_PEDIDO;
 EXECUTE EJECUCION;
 DEALLOCATE PREPARE EJECUCION;   


PREPARE EJECUCION FROM @VENTA_TOTAL_MES;
 EXECUTE EJECUCION;
 DEALLOCATE PREPARE EJECUCION;   
 */
END//
DELIMITER ;

-- CALL SP_LIMIT(1,@P_CODIGO_PEDIDO , @P_VENTA_TOTAL_MES);
CALL SP_LIMIT(@ID_TABLA,@VENTAS,@SALIDA);
-- CALL SP_LIMIT(@SALIDA);
SELECT @ID_TABLA,@VENTAS;


select distinct  
        codigo_pedido, 
         venta_total_mes ,
       venta_total_mes * 1.21  as con_iva
       from corraloncoder.ventas 
       where venta_total_mes > 4000 
        and codigo_pedido = 3400
       ;   
  
   select distinct 
       codigo_pedido    ,
	   venta_total_mes   , 
       venta_total_mes * p_iva   
       into   p_codigos_pedido , p_ventas_total_mes , con_iva 
       from corraloncoder.ventas where venta_total_mes >
       p_venta_total_mes 
       and codigo_pedido = p_codigo_pedido 
       ;
       
 drop procedure if exists sp_calcula_iva ;
 
 delimiter // 
 create procedure sp_calcula_iva ( in p_iva decimal(4,2) ,
                                   in p_venta_total_mes int , 
								   in p_codigo_pedido int , 
                                   out con_iva decimal(10,2),
                                   out  p_codigos_pedido int,
                                   out  p_ventas_total_mes int )
begin 

      select distinct 
       codigo_pedido    ,
	   venta_total_mes   , 
       venta_total_mes * p_iva   
       into   p_codigos_pedido , p_ventas_total_mes , con_iva 
       from corraloncoder.ventas where venta_total_mes >
       p_venta_total_mes 
       and codigo_pedido = p_codigo_pedido 
       ;

end//
delimiter ;    

-- Error Code: 1264. Out of range value for column 'con_iva' at row 1


 CALL sp_calcula_iva ( 1.21,4000,3400,
                       @con_iva , 
					   @p_codigos_pedido,
                       @p_ventas_total_mes ) ;

 SELECT @con_iva  AS con_iva , 
		@p_codigos_pedido as  codigo_pedido,
        @p_ventas_total_mes  as  venta_total_mes; 
        
        
SHOW PROCEDURE STATUS 
WHERE Db = 'corraloncoder';  

SHOW CREATE PROCEDURE sp_calcula_iva;

 ALTER PROCEDURE sp_calcula_iva
COMMENT 'Obtiene EL CALCULO DEL IVA';




-- Concatena strings fijos + parámetros de entrada para guardar la query final en una variable
set @algo = CONCAT('SELECT * FROM ', nombreTabla, ' ORDER BY ', campoOrderBy, ' ', orderByTipo);
-- Precompila string con query completa
prepare param_stmt from @algo;
-- Ejecuta query
execute param_stmt;
-- Liberar statement compilado
deallocate prepare param_stmt;




-- Si el valor del parámetro ingresado es insert
IF agregarOEliminar = 'Insert' THEN
-- Generamos la query para insert

set @agregarEliminar = CONCAT('INSERT INTO clientes VALUES (NULL, ', agregarNombre, ', ', agregarDireccion, ')');
 insert into detalles values(13000,1,'lapiz',1,300);
-- Si no generamos la query para delete por id
ELSE
set @agregarEliminar = CONCAT('delete from clientes where domicilio = ', agregarDireccion );

END IF;

-- Precompila string con query completa
prepare param_stmt from @agregarEliminar;
-- Ejecuta query
execute param_stmt;
-- Liberar statement compilado
deallocate prepare param_stmt;