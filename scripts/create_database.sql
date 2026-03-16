-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema gestion_solicitudes
-- -----------------------------------------------------
-- sistema que permita registrar, controlar y dar seguimiento a las solicitudes
-- de mantenimiento que realizan los usuarios.

-- -----------------------------------------------------
-- Schema gestion_solicitudes
--
-- sistema que permita registrar, controlar y dar seguimiento a las solicitudes
-- de mantenimiento que realizan los usuarios.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gestion_solicitudes` ;
USE `gestion_solicitudes` ;

-- -----------------------------------------------------
-- Table `gestion_solicitudes`.`Funcionario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gestion_solicitudes`.`Funcionario` ;

CREATE TABLE IF NOT EXISTS `gestion_solicitudes`.`Funcionario` (
  `id_funcionario` INT NOT NULL COMMENT 'Identificador único, necesario para relaciones',
  `nombre` VARCHAR(100) NOT NULL COMMENT 'Se compone de nombre y apellido, pero se lee como un solo campo.',
  `departamento` VARCHAR(50) NULL COMMENT 'Para reportes administrativos',
  `telefono` VARCHAR(20) NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_funcionario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gestion_solicitudes`.`Tecnico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gestion_solicitudes`.`Tecnico` ;

CREATE TABLE IF NOT EXISTS `gestion_solicitudes`.`Tecnico` (
  `id_tecnico` INT NOT NULL COMMENT 'Identificador único',
  `nombre` VARCHAR(100) NOT NULL,
  `especialidad` VARCHAR(50) NULL COMMENT 'Para asignar casos según conocimiento',
  `telefono` VARCHAR(20) NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_tecnico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gestion_solicitudes`.`Equipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gestion_solicitudes`.`Equipo` ;

CREATE TABLE IF NOT EXISTS `gestion_solicitudes`.`Equipo` (
  `id_equipo` INT NOT NULL,
  `tipo` VARCHAR(50) NOT NULL COMMENT 'Saber qué tipo de equipo falla',
  `ubicacion` VARCHAR(100) NULL COMMENT 'Para localizar el equipo',
  `numero_serie` VARCHAR(50) NOT NULL COMMENT 'Identificador del fabricante',
  PRIMARY KEY (`id_equipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gestion_solicitudes`.`Orden`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gestion_solicitudes`.`Orden` ;

CREATE TABLE IF NOT EXISTS `gestion_solicitudes`.`Orden` (
  `id_orden` INT NOT NULL,
  `descripcion` TEXT(100) NOT NULL COMMENT 'DEtalle del problema',
  `fecha_creacion` DATETIME NOT NULL COMMENT 'SAber cuando se reporto',
  `estado` ENUM('Pendiente', 'En proceso', 'Finalizado') NOT NULL COMMENT 'Para filtrar reportes por estado',
  `fecha_completado` DATETIME NULL,
  `id_funcionario` INT NOT NULL COMMENT 'Quien reporto',
  `id_equipo` INT NOT NULL COMMENT 'Que equipo falla',
  PRIMARY KEY (`id_orden`),
  CONSTRAINT `fk_Orden_Funcionario`
    FOREIGN KEY (`id_funcionario`)
    REFERENCES `gestion_solicitudes`.`Funcionario` (`id_funcionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orden_Equipo`
    FOREIGN KEY (`id_equipo`)
    REFERENCES `gestion_solicitudes`.`Equipo` (`id_equipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Orden_Funcionario_idx` ON `gestion_solicitudes`.`Orden` (`id_funcionario` ASC) VISIBLE;

CREATE INDEX `fk_Orden_Equipo_idx` ON `gestion_solicitudes`.`Orden` (`id_equipo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `gestion_solicitudes`.`Historial`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gestion_solicitudes`.`Historial` ;

CREATE TABLE IF NOT EXISTS `gestion_solicitudes`.`Historial` (
  `id_historial` INT NOT NULL,
  `fecha_actualizacion` DATETIME NOT NULL COMMENT 'Para ordenar cronológicamente\n',
  `descripcion` TEXT(100) NOT NULL COMMENT 'Que acciones se realizaron',
  `id_orden` INT NOT NULL COMMENT 'A qué orden pertenece\n',
  `id_tecnico` INT NOT NULL COMMENT 'Quién hizo la acción\n',
  PRIMARY KEY (`id_historial`),
  CONSTRAINT `fk_Historial_Orden`
    FOREIGN KEY (`id_orden`)
    REFERENCES `gestion_solicitudes`.`Orden` (`id_orden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Historial_Tecnico`
    FOREIGN KEY (`id_tecnico`)
    REFERENCES `gestion_solicitudes`.`Tecnico` (`id_tecnico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Historial_Orden_idx` ON `gestion_solicitudes`.`Historial` (`id_orden` ASC) VISIBLE;

CREATE INDEX `fk_Historial_Tecnico_idx` ON `gestion_solicitudes`.`Historial` (`id_tecnico` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `gestion_solicitudes`.`Orden_Tecnico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gestion_solicitudes`.`Orden_Tecnico` ;

CREATE TABLE IF NOT EXISTS `gestion_solicitudes`.`Orden_Tecnico` (
  `id_tecnico` INT NOT NULL,
  `id_orden` INT NOT NULL,
  `fecha_asignacion` DATETIME NULL COMMENT 'Registra la fecha en que el técnico fue asignado a la orden\n (información relevante para el historial)',
  PRIMARY KEY (`id_tecnico`, `id_orden`),
  CONSTRAINT `fk_Tecnico_has_Orden_Tecnico`
    FOREIGN KEY (`id_tecnico`)
    REFERENCES `gestion_solicitudes`.`Tecnico` (`id_tecnico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tecnico_has_Orden_Orden`
    FOREIGN KEY (`id_orden`)
    REFERENCES `gestion_solicitudes`.`Orden` (`id_orden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Orden_Tecnico_idx` ON `gestion_solicitudes`.`Orden_Tecnico` (`id_orden` ASC) VISIBLE;

CREATE INDEX `fk_Tecnico_Orden_idx` ON `gestion_solicitudes`.`Orden_Tecnico` (`id_tecnico` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
