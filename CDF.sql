-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema casadelfuturo
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `casadelfuturo` ;

-- -----------------------------------------------------
-- Schema casadelfuturo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `casadelfuturo` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `casadelfuturo` ;

-- -----------------------------------------------------
-- Table `casadelfuturo`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casadelfuturo`.`categoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `categoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `casadelfuturo`.`modulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casadelfuturo`.`modulos` (
  `id` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `duracion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `casadelfuturo`.`cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casadelfuturo`.`cursos` (
  `id` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NOT NULL,
  `dias_cursado` VARCHAR(45) NOT NULL,
  `programa` VARCHAR(100) NOT NULL,
  `imagen` TINYTEXT NULL DEFAULT NULL,
  `categoria_id` INT NOT NULL,
  `modulos_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cursos_categoria1_idx` (`categoria_id` ASC) VISIBLE,
  INDEX `fk_cursos_modulos1_idx` (`modulos_id` ASC) VISIBLE,
  CONSTRAINT `fk_cursos_categoria1`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `casadelfuturo`.`categoria` (`id`),
  CONSTRAINT `fk_cursos_modulos1`
    FOREIGN KEY (`modulos_id`)
    REFERENCES `casadelfuturo`.`modulos` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `casadelfuturo`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casadelfuturo`.`rol` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rol` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `casadelfuturo`.`domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casadelfuturo`.`domicilio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `provincia` VARCHAR(20) NOT NULL,
  `localidad` VARCHAR(20) NOT NULL,
  `calle` VARCHAR(40) NOT NULL,
  `altura` INT NOT NULL,
  `piso` INT NULL DEFAULT NULL,
  `departamento` VARCHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `casadelfuturo`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casadelfuturo`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `apellido` VARCHAR(60) NOT NULL,
  `dni` INT NOT NULL,
  `correo` VARCHAR(100) NULL DEFAULT NULL,
  `contrasenia` VARCHAR(60) NULL DEFAULT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `id_rol` INT NOT NULL,
  `id_domicilio` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_rol` (`id_rol` ASC) VISIBLE,
  INDEX `id_domicilio` (`id_domicilio` ASC) VISIBLE,
  CONSTRAINT `usuario_ibfk_1`
    FOREIGN KEY (`id_rol`)
    REFERENCES `casadelfuturo`.`rol` (`id`),
  CONSTRAINT `usuario_ibfk_2`
    FOREIGN KEY (`id_domicilio`)
    REFERENCES `casadelfuturo`.`domicilio` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `casadelfuturo`.`cursos_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casadelfuturo`.`cursos_usuario` (
  `cursos_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`cursos_id`, `usuario_id`),
  INDEX `fk_cursos_has_usuario_usuario1_idx` (`usuario_id` ASC) VISIBLE,
  INDEX `fk_cursos_has_usuario_cursos1_idx` (`cursos_id` ASC) VISIBLE,
  CONSTRAINT `fk_cursos_has_usuario_cursos1`
    FOREIGN KEY (`cursos_id`)
    REFERENCES `casadelfuturo`.`cursos` (`id`),
  CONSTRAINT `fk_cursos_has_usuario_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `casadelfuturo`.`usuario` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
