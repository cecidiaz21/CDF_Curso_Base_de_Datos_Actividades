
CREATE SCHEMA UniversoLector;

CREATE TABLE Socio(
	id INT NOT NULL,
	dni INT NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	direccion VARCHAR(200) NOT NULL,
	localidad VARCHAR(100) NOT NULL,
	nro_telefono INT NOT NULL,
	PRIMARY KEY (id)
    );
    
CREATE TABLE Editorial (
	id INT NOT NULL,
	razon_social VARCHAR(100) NOT NULL,
	telefono VARCHAR(100) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE Prestamo(
	  id INT NOT NULL,
	  fecha DATETIME NOT NULL,
	  fecha_devolucion DATE NOT NULL,
	  fecha_tope DATE NOT NULL,
	  PRIMARY KEY (id)
  );
  
CREATE TABLE Autor(

	id INT NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE Libro(
	id INT NOT NULL,
	ISBN VARCHAR(13) NOT NULL,
	titulo VARCHAR(200) NOT NULL,
	anio_escritura DATE NOT NULL,
	anio_edicion DATE NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE Volumen(
id INT NOT NULL,
deteriorado TINYINT NOT NULL,
PRIMARY KEY (id)
);  

INSERT INTO Socio(id, dni, apellido, nombre, direccion, localidad, nro_telefono) 
VALUES ('1', '3000000', 'JOHNSON', 'PATRICIA', '28 MySQL Boulevard	', 'QLD', '54911-45636453'),
('2', '2988800', 'WILLIAMS', 'LINDA', '23 Workhaven Lane	', 'Alberta', '54-11-47867654'),
('3', '2500000', 'JONES', 'BARBARA', '1411 Lillydale Drive', 'QLD', '11498-2173'),
('4', '32980002', 'BUTLER', 'LOIS', '1688 Okara Way', 'Nothwest Border Prov', '11684736'),
('5', '2313909', 'HAYER', 'ROBIN', '262 A Corua (La Corua) Parkway', 'Dhaka', '2645887755');

INSERT INTO autor (id, apellido, nombre) VALUES ('1', 'Rowling', 'J.K.');

INSERT INTO Editorial (id, razon_social, telefono)
VALUES ('1', 'Bloomsbury Publishing', '54911564874'),
('2', 'Scholastic', '223483646'),
('3', 'Pottermore Limited', '5694839582'),
('4', 'Editorial Salamandra ', '011-239-2343');

ALTER TABLE libro
CHANGE COLUMN `ISBN` `ISBN` VARCHAR(23) NOT NULL ,
CHANGE COLUMN `anio_escritura` `anio_escritura` INT NOT NULL ,
CHANGE COLUMN `anio_edicion` `anio_edicion` INT NOT NULL ;

INSERT INTO libro (id, ISBN, titulo, anio_escritura, anio_edicion) 
VALUES ('1', '9781907545009', 'Harry Potter y la piedra filosofal', '1997', '1997'),
('2', '9789878000114', 'Harry Potter Y La Camara Secreta ', '2020', '2020');

ALTER TABLE prestamo
CHANGE COLUMN `fecha` `fecha` TIME NOT NULL ;

UPDATE prestamo
SET `fecha_devolucion` = '2020-01-07', `fecha_tope` = '2020-01-07' WHERE (`id` = '1');
INSERT INTO prestamo (id, fecha, fecha_devolucion, fecha_tope) 
VALUES ('2', '2020-01-07', '2020-01-15', '2020-01-16'),
('3', '2020-03-04', '2020-03-08', '2020-03-11');

SHOW CREATE TABLE `volumen`;
ALTER TABLE `volumen`
DROP FOREIGN KEY `fk_volumen_libro`,
DROP INDEX `fk_volumen_libro1_idx`;

INSERT INTO volumen (id, deteriorado, libro_id) 
VALUES ('1', '1', '0'),
('2', '1', '0'),
('3', '2', '0');

ALTER TABLE `volumen`
ADD CONSTRAINT `volumen_prestamonombre_de_restriccion_fk` 
FOREIGN KEY (`nombre_de_columna_fk`) 
REFERENCES `tabla_referenciada` (`nombre_de_columna_referenciada`);

DELETE FROM socio
WHERE nombre = "LOIS";

UPDATE socio
SET direccion = 'Monroe 860'
WHERE id = 3;




