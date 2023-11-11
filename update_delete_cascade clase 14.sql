drop   schema if exists update_delete_cascade ;
create schema update_delete_cascade ;
use update_delete_cascade ;


create table person(
personId bigint(12) primary key,
name varchar(20),
age int(3));

create table orders(
orderId bigint(12) primary key,
orderName varchar(20),
personId bigint(20),
 foreign key(personId) references person(personId)  -- ON DELETE CASCADE
 -- ,foreign key(personId) references person2(personId)
-- ON DELETE / UPDATE  CASCADE 
);


select * from person ;
select * from orders ;
					  --  PK
insert into person values(1,"vasu",26);
insert into person values(2,"Ayush",26);
insert into person values(3,"sushmits",25);
insert into person values(7,"sushmits",25);
insert into person values(22,"adicion",34);
								 -- FK  
insert into orders values(1,"Shoes", 1);
insert into orders values(2,"Jeans", 1);
insert into orders values(3,"Tshirt", 3);
insert into orders values(4,"Jacket",2 );
insert into orders values(5,"Jacket",22 );

select * from person ;
select * from orders ;

-- foreign key(personId) references person(personId)           -- ON DELETE CASCADE 

delete from person where personId=7; -- madre 


delete from person where personId=1; -- madre

-- Error Code: 1451. Cannot delete or update a 
-- parent row: a foreign key constraint fails (`update_delete_cascade`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`personId`) REFERENCES `person` (`personId`))

delete from orders where personId=1; -- hija1

/* 
delete from orders where personId=1; -- hija1 
delete from orders where personId=1; -- hija2 
delete from orders where personId=1; -- hija3 
delete from orders where personId=1; -- hija4 
delete from orders where personId=1; -- hija5 
delete from orders where personId=1; -- hija6 
delete from orders where personId=1; -- hija7 
*/

select * from person ;
select * from orders ;

/*
create table orders(orderId bigint(12) primary key,
orderName varchar(20),
personId bigint(20),
foreign key(personId) references person(personId)
ON DELETE CASCADE ); 
-- ON DELETE CASCADE: permite eliminar de manera simultanea info en 
-- tabla/as madre y tabla/as hija.
*/



drop   schema update_delete_cascade ;
create schema update_delete_cascade ;
use update_delete_cascade ;

create table person(personId bigint(12) primary key,
name varchar(20),
age int(3));

-- ON DELETE NO ACTION: En esta cascada, 
-- no se realiza ninguna acción de eliminación referencial.
create table orders(
orderId bigint(12) primary key,
orderName varchar(20),
personId bigint(20),
foreign key(personId) references person(personId) 
ON DELETE NO ACTION  ); 

 -- ON DELETE/UPDATE  RESTRICT: no podemos eliminar la fila de la tabla principal
 -- si tiene alguna fila referenciada con la misma identificación.
drop table orders ;

create table orders(orderId bigint(12) primary key,
orderName varchar(20),
personId bigint(20),
foreign key(personId) references person(personId)
ON UPDATE  RESTRICT );




insert into person values(1,"vasu",26);
insert into person values(2,"Ayush",26);
insert into person values(3,"sushmits",25);
insert into person values(7,"sushmits",25);
 
insert into orders values(1,"Shoes", 1);
insert into orders values(2,"Jeans", 1);
insert into orders values(3,"Tshirt", 3);
insert into orders values(4,"Jacket",2 );

delete from person where personId=1; -- madre 
-- Error Code: 1451. Cannot delete or update a parent row:
--  a foreign key constraint fails (`update_delete_cascade`.`orders`,
--  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`personId`) REFERENCES `person` (`personId`))

delete from orders where personId=1; -- hija 

drop table if exists person;
create table person(personId bigint(12) primary key,
name varchar(20),
age int(3));


-- Error Code: 3730. Cannot drop table 'person' referenced by a 
-- foreign key constraint 'orders_ibfk_1' on table 'orders'.
 
select * from person ;
select * from orders ;

drop table if exists orders;
create table orders(orderId bigint(12) primary key, orderName varchar(20),
personId bigint(20),
foreign key(personId) references person(personId)
 ON UPDATE CASCADE
 );

SET  FOREIGN_KEY_CHECKS = 0; 

drop table if exists orders;
create table orders(orderId bigint(12) primary key, orderName varchar(20),
personId bigint(20),
foreign key(personId) references person(personId) ON DELETE CASCADE
 );

insert into person values(1,"vasu",1);
insert into person values(2,"Ayush",2);
insert into person values(3,"sushmits",3);
 
insert into orders values(1,"Shoes", 1);
insert into orders values(2,"Jeans", 1);
insert into orders values(3,"Tshirt", 3);
insert into orders values(4,"Jacket",2 );


select * from person ;
select * from orders ;

-- update orders set personId = 55 where personId = 3;
update person set personId = 55 where personId = 3;

DELETE FROM person WHERE  personId = 55;

DELETE FROM ORDERS  WHERE  ORDERID = 2;
select * from person ; -- PK: 1, 2 , 3, 4 , 7 -- DELETE /UPDATE 
select * from orders ; -- PK: 1,3,4  --------  PK_TABLA_MADRE : 1,3,2 , 55  -- DELETE / UPDATE  CASCADE 

-- DELETE / UPDATE -- > HIJA -- LIBREMENTE 
-- DELETE / UPDATE -- > MADRE -- CASCADE EN LA TABLA HJA

ALTER TABLE orders  ADD foreign key(personId) 
references person(personId) ON DELETE CASCADE;


ALTER TABLE orders ADD foreign key(personId) 
references person(personId) ;

drop   schema update_delete_cascade ;
create schema update_delete_cascade ;
use update_delete_cascade ;

drop table if exists person ;
create table person(personId bigint(12) primary key,
name varchar(20),age int(3));

drop table if exists orders ;
create table orders(orderId bigint(12) primary key,
orderName varchar(20),
personId bigint(20) ,
foreign key(personId) references person(personId)
ON DELETE SET NULL ); 
-- ON DELETE SET NULL: esta cascada se usa para establecer el valor
--  de las entidades referenciadas en nulo si eliminamos 
-- la entidad de la tabla principal.

drop table if exists orders ;
create table orders(orderId bigint(12) primary key,
orderName varchar(20),
personId bigint(20) ,
foreign key(personId) references person(personId)
ON DELETE SET NULL ); 

select * from person ;
select * from orders ;


insert into person values(1,"vasu",26);
insert into person values(2,"Ayush",26);
insert into person values(3,"sushmits",25);
 
insert into orders values(1,"Shoes", 1);
insert into orders values(2,"Jeans", 1);
insert into orders values(3,"Tshirt", 3);
insert into orders values(4,"Jacket",2 );


select * from person ;
select * from orders ;

delete from person where personId=1; -- madre 
delete from ORDERS where personId=1;-- HIJA
 
 
UPDATE   PERSON   SET personId= 5 WHERE personId = 2 ;

-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`update_delete_cascade`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`personId`) REFERENCES `person` (`personId`) ON DELETE SET NULL)
 
select * from person ;
select * from orders ;


DROP TABLE IF EXISTS  orders ;
create table orders(orderId bigint(12) primary key,
orderName varchar(20),
personId bigint(20),
foreign key(personId) references person(personId)
ON UPDATE SET null
-- ON UPDATE CASCADE
); -- ON DELETE SET DEFAULT: esta cascada se utiliza para establecer el valor 
      -- predeterminado de las entidades a las que se hace referencia 
      -- si eliminamos la entidad de la tabla principal.

insert into orders values(1,"Shoes", 2);
insert into orders values(2,"Jeans", 3);
insert into orders values(3,"Tshirt", 3);
insert into orders values(4,"Jacket",2 );

select * from person ;
select * from orders ;

update person set personId = 6 where personId = 3;


ALTER TABLE update_delete_cascade.ORDERS 
ADD CONSTRAINT `NOMBRE_FK` foreign key(personId) references person(personId)
ON DELETE CASCADE;




ALTER TABLE update_delete_cascade.ORDERS
DROP foreign key NOMBRE_FK;


select * from person ;
select * from orders ;


insert into orders values(5,"Tshirt", 3);
insert into orders values(6,"Jacket",77 );


select * from person ;
select * from orders ;

delete from person where personId=2; -- madre 
-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`update_delete_cascade`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`personId`) REFERENCES `person` (`personId`) ON UPDATE SET NULL)
 
update person set personId = 5 where personId = 3;

select * from person ;
select * from orders ;



/*
CREATE TABLE EMPLOYEE ( 
    Fname VARCHAR(15) NOT NULL, 
    Minit CHAR, Lname VARCHAR(15) NOT NULL, 
    Ssn CHAR(9) NOT NULL DEFAULT '123456789',
    Bdate DATE, ADDRESS VARCHAR(30), 
    Sex CHAR, Salary DECIMAL(10,2), 
    Super_Ssn CHAR(9) NOT NULL DEFAULT '123456789', 
    Dno INT NOT NULL DEFAULT -99,
    PRIMARY KEY (Ssn), 
    FOREIGN KEY (Super_Ssn) REFERENCES COMPANY.EMPLOYEE(Ssn) 
        ON UPDATE CASCADE  
) ;
*/






