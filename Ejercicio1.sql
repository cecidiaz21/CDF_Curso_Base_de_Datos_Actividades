#crear la base de datos
DROP DATABASE IF EXISTS casadelfuturo;
CREATE DATABASE casadelfuturo;
USE casaDelFuturo;

# DROP DATABASE casadelfuturo;

#crear una tabla
DROP TABLE IF EXISTS Rol;
CREATE TABLE Rol (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	rol VARCHAR(20)
);

DROP TABLE IF EXISTS Domicilio;
CREATE TABLE Domicilio (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	provincia VARCHAR(20) NOT NULL,
    localidad VARCHAR(20) NOT NULL,
    calle VARCHAR(40) NOT NULL,
    altura INT NOT NULL,
    piso INT,
    departamento VARCHAR(5)
);
CREATE TABLE Usuario (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nombre VARCHAR(60) NOT NULL,
	apellido VARCHAR(60) NOT NULL,
	dni INT NOT NULL,
	correo VARCHAR(100),
	contrasenia VARCHAR(60),
	fecha_nacimiento DATE NOT NULL,
    id_rol INT NOT NULL,
    id_domicilio INT NOT NULL,
	
    FOREIGN KEY (id_rol) REFERENCES rol(id),
    FOREIGN KEY (id_domicilio) REFERENCES domicilio(id)
    );
    
# agregar datos a una tabla
# rol
INSERT INTO Rol (rol)
VALUES("Alumno"),
("Docente"),
("Editor"),
("Administrador");

INSERT INTO Rol VALUES(DEFAULT, "admin");
INSERT INTO Rol VALUES(DEFAULT, "alumno");
INSERT INTO Rol VALUES(DEFAULT, "tallerista");

# domicilio
INSERT INTO Domicilio VALUES(DEFAULT, "Mendoza", "Godoy Cruz", "Rafael Cubillos", 2222, NULL, NULL);

# usuario
INSERT INTO Usuario VALUES(DEFAULT, "Lucas", "Zarandón", 32435412, "luzaszarandon24@gmail.com", "i<3programar", "1997-07-01", 3, 1);

# drop table nos sirve para al importar borrar la tabla antes de crear
DROP TABLE IF EXISTS aula;
CREATE TABLE aula (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    aula VARCHAR(40)
);

DROP TABLE IF EXISTS categoria;
CREATE TABLE categoria (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    categoria VARCHAR(40)
);

DROP TABLE IF EXISTS modulos;
CREATE TABLE modulos(
	id INT NOT NULL,
	titulo VARCHAR(45) NOT NULL,
	descripcion VARCHAR(45) NOT NULL,
	duracion VARCHAR(45) NOT NULL,
	PRIMARY KEY (id)
  );
  
  DROP TABLE IF EXISTS cursos;
  CREATE TABLE cursos(
	id INT NOT NULL,
	titulo VARCHAR(45) NOT NULL,
	descripcion VARCHAR(45) NOT NULL,
	fecha_inicio DATE NOT NULL,
	fecha_fin DATE NOT NULL,
	dias_cursado VARCHAR(45) NOT NULL,
	programa VARCHAR(100) NOT NULL,
	imagen TINYTEXT NULL,
	PRIMARY KEY (id)categoria
);
  
#eliminar el rol de editor
DELETE FROM rol
WHERE rol = "Editor";


#eliminar el rol de Alumno
DELETE FROM rol
WHERE rol = "Alumno";



