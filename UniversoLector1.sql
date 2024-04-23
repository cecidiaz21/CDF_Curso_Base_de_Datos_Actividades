-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema universolector
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `universolector` ;

-- -----------------------------------------------------
-- Schema universolector
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `universolector` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `universolector` ;

-- -----------------------------------------------------
-- Table `universolector`.`autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universolector`.`autor` (
  `id` INT NOT NULL,
  `apellido` VARCHAR(100) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universolector`.`editorial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universolector`.`editorial` (
  `id` INT NOT NULL,
  `razon_social` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universolector`.`libro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universolector`.`libro` (
  `id` INT NOT NULL,
  `ISBN` VARCHAR(23) NOT NULL,
  `titulo` VARCHAR(200) NOT NULL,
  `anio_escritura` INT NOT NULL,
  `anio_edicion` INT NOT NULL,
  `autor_id` INT NOT NULL,
  `editorial_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_libro_autor1_idx` (`autor_id` ASC) VISIBLE,
  INDEX `fk_libro_editorial1_idx` (`editorial_id` ASC) VISIBLE,
  CONSTRAINT `fk_libro_autor1`
    FOREIGN KEY (`autor_id`)
    REFERENCES `universolector`.`autor` (`id`),
  CONSTRAINT `fk_libro_editorial1`
    FOREIGN KEY (`editorial_id`)
    REFERENCES `universolector`.`editorial` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universolector`.`socio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universolector`.`socio` (
  `id` INT NOT NULL,
  `dni` INT NOT NULL,
  `apellido` VARCHAR(100) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(200) NOT NULL,
  `localidad` VARCHAR(100) NOT NULL,
  `nro_telefono` BIGINT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universolector`.`prestamo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universolector`.`prestamo` (
  `id` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `fecha_devolucion` DATE NOT NULL,
  `fecha_tope` DATE NOT NULL,
  `socio_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_prestamo_socio_idx` (`socio_id` ASC) VISIBLE,
  CONSTRAINT `fk_prestamo_socio`
    FOREIGN KEY (`socio_id`)
    REFERENCES `universolector`.`socio` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universolector`.`volumen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universolector`.`volumen` (
  `id` INT NOT NULL,
  `deteriorado` TINYINT NOT NULL,
  `libro_id` INT NOT NULL,
  `libro_id1` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_volumen_libro1_idx` (`libro_id` ASC) VISIBLE,
  INDEX `fk_volumen_libro1_idx1` (`libro_id1` ASC) VISIBLE,
  CONSTRAINT `fk_volumen_libro1`
    FOREIGN KEY (`libro_id1`)
    REFERENCES `universolector`.`libro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universolector`.`volumen_prestamo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universolector`.`volumen_prestamo` (
  `volumen_id` INT NOT NULL,
  `prestamo_id` INT NOT NULL,
  PRIMARY KEY (`volumen_id`, `prestamo_id`),
  INDEX `fk_volumen_has_prestamo_prestamo1_idx` (`prestamo_id` ASC) VISIBLE,
  INDEX `fk_volumen_has_prestamo_volumen1_idx` (`volumen_id` ASC) VISIBLE,
  CONSTRAINT `fk_volumen_has_prestamo_prestamo1`
    FOREIGN KEY (`prestamo_id`)
    REFERENCES `universolector`.`prestamo` (`id`),
  CONSTRAINT `fk_volumen_has_prestamo_volumen1`
    FOREIGN KEY (`volumen_id`)
    REFERENCES `universolector`.`volumen` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
