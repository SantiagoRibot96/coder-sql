-- -----------------------------------------------------
-- Creación de la BASE.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS ModeloRestaurant;
USE ModeloRestaurant;
-- -----------------------------------------------------
-- Creación de las TABLAS.
-- -----------------------------------------------------
-- --------Tabla CLIENTE ---------
CREATE TABLE IF NOT EXISTS Cliente(
		id_cliente INT NOT NULL PRIMARY KEY,
		nombre VARCHAR(255) NOT NULL,
		documento INT NOT NULL,
		telefono INT)
		ENGINE = InnoDB;
    
-- -------Tabla MOZOS -----------    
CREATE TABLE IF NOT EXISTS Mozos(
		id_mozo INT NOT NULL PRIMARY KEY,
	    nombre VARCHAR(255) NOT NULL,
		documento INT NOT NULL,
		direccion VARCHAR(255),
		telefono INT,
		email VARCHAR(255),
		comision INT NOT NULL)
		ENGINE = InnoDB;
    
-- -------Tabla PEDIDO -----------      
CREATE TABLE IF NOT EXISTS Pedido(
		id_pedido INT NOT NULL PRIMARY KEY,
		mesa INT NOT NULL,
		fecha DATETIME,
		id_cliente INT NOT NULL,
		id_mozo INT NOT NULL,
		personas INT NOT NULL,
		comentarios VARCHAR(255),
		FOREIGN KEY(id_cliente) REFERENCES Cliente(id_cliente),
		FOREIGN KEY(id_mozo) REFERENCES Mozos(id_mozo))
		ENGINE = InnoDB;
    
-- -------Tabla MENÚ -----------      
CREATE TABLE IF NOT EXISTS Menu(
		id_plato INT NOT NULL PRIMARY KEY,
		plato VARCHAR(255) NOT NULL,
		porciones INT NOT NULL,
		precio INT NOT NULL)
		ENGINE = InnoDB;
    
-- -------Tabla DETALLE ---------      
CREATE TABLE IF NOT EXISTS Detalle(
		id_detalle INT NOT NULL PRIMARY KEY,
		id_pedido INT NOT NULL,
		id_plato INT NOT NULL,
		cantidad INT NOT NULL,
		FOREIGN KEY(id_pedido) REFERENCES Pedido(id_pedido),
		FOREIGN KEY(id_plato) REFERENCES Menu(id_plato))
		ENGINE = InnoDB;
-- -------------------------------------------------------------------------------------------
-- INSERCIÓN DE DATOS
-- -------------------------------------------------------------------------------------------
INSERT INTO Cliente (id_cliente,nombre,documento,telefono)
VALUES 	(1,'Juan Perez',1234567,095123456), 
		(2,'Lucia Rodriguez',5356789,093467934),
		(3,'Jose Garcia',4568945,098486393),
		(4,'Natalia Benitez',3458694,097934584),
		(5,'Pedro Fernandez',2435456,092356954);
-- -------------------------------------------------------------------------------------------
INSERT INTO Mozos (id_mozo,nombre,documento,direccion,telefono,email,comision)
VALUES 	(31,'Maria Garcia',3456789,'Libertad 123',091345678,'mariagarcia@orueba.com',10),
		(32,'Santiago Jimenez',3456788,'Masini 5678',095675352,'santjim@orueba.com',15),
		(33,'Fernanda Vazquez',5678975,'Marti 767',097457474,'vazquezfernanda@orueba.com',10),
		(34,'Sandra Martinez',1246645,'Benito Blanco 4343',096788433,'sanmar56@orueba.com',20),
		(35,'Martin Gimenez',2456785,'San Jose 3456',093557568,'tinchogim09@orueba.com',10);
-- -------------------------------------------------------------------------------------------
INSERT INTO Pedido (id_pedido,mesa,fecha,id_cliente,id_mozo,personas,comentarios)
VALUES 	(51,4,'2022-04-10 21:10:00',1,32,2,'muy bueno'),
		(52,2,'2022-04-10 21:11:00',2,33,3,'aceptable'),
		(53,3,'2022-04-10 21:12:00',3,34,5,'excelente'),
		(54,4,'2022-04-10 21:13:00',4,34,1,'comida fria'),
		(55,5,'2022-04-10 21:14:00',5,31,2,'rico');
-- -------------------------------------------------------------------------------------------
INSERT INTO Menu (id_plato,plato,porciones,precio)
VALUES 	(351,'Milanesa con pure',20,500),
		(352,'Tallarines',30,600),
		(353,'Chivito',50,750),
		(354,'Salmon con papas fritas',40,800),
		(355,'Ensalada',20,300);
-- -------------------------------------------------------------------------------------------
INSERT INTO Detalle (id_detalle,id_pedido,id_plato,cantidad)
VALUES 	(23,51,351,2),
		(24,52,352,3),
		(25,53,353,4),
		(26,54,354,1),
		(27,55,355,5);
-- -------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------