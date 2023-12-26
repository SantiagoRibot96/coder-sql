 /* 
 =============================================================================================== 
 =============================================================================================== 
 =============================================================================================== 
 =============================FUNCIONES====================================================
 =============================================================================================== 
 =============================================================================================== 
 =============================================================================================== 
 =============================================================================================== 
 */ 

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

-- CREATE OR REPLACE VIEW VW_VISTA AS (
select * from libros
-- WHERE CODIGO < 7 -- DATO_DE_ENTRADA. -- 2, 7,5,1, 
order by editorial asc  
-- LIMIT 1 -- PARAMETRO2
-- )
;   

/*
DELIMITER 
CREATE FUNCTION FN_NOMBRE (  )
DETERMINISTIC
RETURNS  
 BEGIN
-- SQL
 END
DELIMETER 
*/
 DROP FUNCTION IF EXISTS FN_CALCULAR_PINTURA ;
 DELIMITER $$ 
 CREATE FUNCTION FN_CALCULAR_PINTURA ( P_LARGO INT ,
                                       P_ALTURA INT ,
                                       P_TOTAL_A_UTILIZAR  INT )
RETURNS FLOAT 
DETERMINISTIC                             
BEGIN 

    DECLARE V_RESULTADO  FLOAT ; 
    DECLARE V_LITROS_X_M2 FLOAT; 
    SET  V_RESULTADO = ((P_LARGO * P_ALTURA)  * P_TOTAL_A_UTILIZAR) ;
	SET  V_LITROS_X_M2 = 0.10;
    SET  V_RESULTADO = V_RESULTADO * V_LITROS_X_M2 ;
  RETURN   V_RESULTADO ;
END$$
DELIMITER ;         


SELECT FN_CALCULAR_PINTURA( 15,23,14 ) AS CALCULO_PINTURA ;

-- CREATE OR REPLACE VIEW 
SELECT * FROM   corraloncoder.ventas 
  where venta_total_mes > 6000 
    and codigo_pedido = 3401
    ;

  select  distinct 
	     -- codigo_pedido, 
	     -- venta_total_mes ,
         venta_total_mes * 1.21   as con_iva
       -- ,fn_calcula_iva(1.21, 4000,3400)as  v_con_iva 
       from corraloncoder.ventas 
       where venta_total_mes < 7000 
       and codigo_pedido = 2000
       ;

    select distinct 
       venta_total_mes * p_iva as con_iva 
       from corraloncoder.ventas 
       where venta_total_mes > p_venta_total_mes 
       and codigo_pedido = p_codigo_pedido ;

 
drop function if exists  fn_calcula_iva ;

 delimiter $$ 
 create function fn_calcula_iva (p_iva decimal(4,2) , 
                                 p_venta_total_mes int,
                                 p_codigo_pedido int)
 returns  int 
 deterministic 
 begin
 
 declare v_con_iva int ;
 set v_con_iva =  
      (select distinct venta_total_mes * p_iva 
       as con_iva from corraloncoder.ventas where venta_total_mes <
       p_venta_total_mes and codigo_pedido = p_codigo_pedido
		) 
       ;
   return  v_con_iva;   
 end$$ 
 delimiter ;
 
 
 select fn_calcula_iva(1.21, 7000,2000)
 as  v_con_iva 
  ;
 

  
drop function if exists fn_pedido;

delimiter //
create function fn_pedido (cost int)
returns varchar (10)
deterministic
begin 
	case
		when cost > 100 then
		-- return "alto";
       insert into libros(titulo,autor,editorial,precio,stock) 
   values('CAMILO en el pais de las maravillas','Lewis Carroll','Emece',20.00, 9);
 
		 when cost = 50 then
		  -- return "medio" ;
      insert into libros(titulo,autor,editorial,precio,stock) 
  values('LINA en el pais de las maravillas','Lewis Carroll','Emece',20.00, 9);
 
		when cost < 50 then
		--  return "bajo";
 insert into libros(titulo,autor,editorial,precio,stock) 
  ('JUAN en el pais de las maravillas','Lewis Carroll','Emece',20.00, 9);
 
	end case;
end //
delimiter ;  
  
 select  fn_pedido(15);
 SELECT * FROM libros ;
 
 select TIMESTAMPDIFF(YEAR,'1982-07-14',CURDATE()) as edad  ;
 
 
 
 drop function if exists calculo_edad;
delimiter //
create function calculo_edad(var date) returns int
deterministic
begin
declare edad int;
select TIMESTAMPDIFF(YEAR,var,CURDATE())  into edad ;
return edad;
end //  
delimiter ; 

select calculo_edad( DATE ('1983-01-10'));



drop function if exists precioDeVenta;
delimiter //
create function precioDeVenta(precio_total float, ganancia float) returns float
deterministic
begin
declare precioCalculado float;
set precioCalculado = precio_total +(precio_total * (ganancia/100));
return precioCalculado;
end //

select precioDeVenta(10,20);


drop FUNCTION  if exists fn_p_mensaje ;
DELIMITER //

CREATE FUNCTION fn_p_mensaje ( p_mensaje varchar(255) 
                               , fecha date 
                               )
RETURNS varchar(255)
DETERMINISTIC
BEGIN

   DECLARE v_mensaje varchar(255);
   DECLARE a VARCHAR(20);
   
     IF fecha % 4 = 0 AND (fecha % 100 !=0 OR fecha % 400=0) THEN
    RETURN 'Es bisiesto';
  ELSE
      RETURN 'NO es bisiesto';
END IF; 

   IF  p_mensaje  = ''
   THEN
    insert into libros(titulo,autor,editorial,precio,stock) 
   values('CAMILO en el pais de las maravillas','Lewis Carroll','Emece',20.00, 9);
 
      SET v_mensaje = 'ERROR';
  
   ELSE
      SET v_mensaje = 'OK';

   END IF;
    RETURN v_mensaje;
 
   
    END; //

DELIMITER ;
SELECT * FROM libros ;

SELECT fn_p_mensaje('a' ,curdate()) as mensaje_validacion;

DROP FUNCTION IF EXISTS FN_CARGAR_PARAMETROS ;
 DELIMITER $$
 CREATE FUNCTION FN_CARGAR_PARAMETROS ( P_PARA1 INT ,
                                       P_PARA2 DATE  -- ,
                                       -- P_PARA3  VARCHAR(200) 
                                       )
RETURNS CHAR(2)  
DETERMINISTIC                             
BEGIN 

    DECLARE V_RESULTADO  CHAR(2) ; 
    DECLARE V_CUENTA INT ;
    

                                   
                                   
  SET V_CUENTA = (   SELECT  COUNT(*)  FROM  gammer.BKP_COMMENTARY 
                      WHERE ID_COMMENTARY = P_PARA1 
                      -- AND COMMENTARY = P_PARA2
                       AND COMMENT_DATE = P_PARA2
				 );
                 
    IF V_CUENTA = 1 THEN  
    SET  V_RESULTADO = 'SI' ;
    ELSE 
         INSERT INTO gammer.BKP_COMMENTARY ( ID_COMMENTARY ,
                                   ID_GAME,
                                   ID_SYSTEM_USER,
                                   COMMENT_DATE ,
                                   COMMENTARY  
                                    ) 
            VALUES               (  P_PARA1 ,
                                    1,
                                    1,
								   P_PARA2 ,
                                  'FUNCIONES' ) ;
    SET  V_RESULTADO = 'NO' ;
    
    END IF ;
    
    
    
  RETURN   V_RESULTADO ;
END$$
DELIMITER ; 

 SELECT FN_CARGAR_PARAMETROS ( 10023 , curdate()  );


SELECT  *  FROM  gammer.BKP_COMMENTARY 
                      WHERE ID_COMMENTARY = 10023
                     --  AND COMMENTARY = P_PARA2
                       AND COMMENT_DATE = curdate()
                       ;

create schema calculadora ;
use calculadora ;


-- suma , resta. , multip , divi. 

drop function if exists fn_calculadora ;
delimiter //
create function fn_calculadora ( p_dato1 int ,
                                 p_operacion char(1),
                                 p_dato2 int 
								)
returns int 
deterministic 
  begin
  
  declare v_resultado int ;
  
  -- suma +
  if p_operacion = '+' then  
   set v_resultado =  p_dato1 + p_dato2 ;
  -- resta -
   elseif p_operacion = '-' then 
    set v_resultado =  p_dato1 - p_dato2 ;
   -- multiplicacion *
    elseif  p_operacion = '*' then 
    set v_resultado =  p_dato1 * p_dato2 ;
  -- division /
   elseif p_operacion = '/' then 
   set v_resultado =  p_dato1 / p_dato2 ;
   else 
     set v_resultado = 0;
   end if
  ;
   
 return v_resultado ;
  end//
  delimiter ;
  
select fn_calculadora(4,'*',2)
as resultado ;


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