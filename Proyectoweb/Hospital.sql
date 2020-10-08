-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Hospital` DEFAULT CHARACTER SET utf8 ;
USE `Hospital` ;

-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Usuario` (
  `codigo` VARCHAR(15) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(15) NULL,
  PRIMARY KEY (`codigo`, `contraseña`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Paciente` (
  `Usuario_codigo` VARCHAR(15) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(8) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `birth` DATE NOT NULL,
  `sexo` VARCHAR(10) NOT NULL,
  `peso` INT NOT NULL,
  `DPI` VARCHAR(15) NOT NULL,
  `tipo_sangre` VARCHAR(15) NOT NULL,
  `Usuario_contraseña` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Usuario_codigo`),
  INDEX `fk_Paciente_Usuario_idx` (`Usuario_codigo` ASC, `Usuario_contraseña` ASC) VISIBLE,
  CONSTRAINT `fk_Paciente_Usuario`
    FOREIGN KEY (`Usuario_codigo` , `Usuario_contraseña`)
    REFERENCES `Hospital`.`Usuario` (`codigo` , `contraseña`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Examen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Examen` (
  `codigo` VARCHAR(15) NOT NULL,
  `formato` VARCHAR(5) NOT NULL,
  `orden` VARCHAR(5),
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orden`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Orden` (
  `codigo` VARCHAR(15) NOT NULL,
  `orden` MEDIUMBLOB NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Medico` (
  `Usuario_codigo` VARCHAR(15) NOT NULL,
  `Usuario_contraseña` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `hora_inicio` TIME NOT NULL,
  `hora_salida` TIME NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(10) NOT NULL,
  `DPI` VARCHAR(15) NOT NULL,
  `numero_colegiado` VARCHAR(45) NOT NULL,
  `fecha_debut` DATE NOT NULL,
  PRIMARY KEY (`Usuario_codigo`, `Usuario_contraseña`),
  INDEX `fk_Medico_Usuario_idx` (`Usuario_codigo` ASC, `Usuario_contraseña` ASC) VISIBLE,
  CONSTRAINT `fk_Medico_Usuario`
    FOREIGN KEY (`Usuario_codigo` , `Usuario_contraseña`)
    REFERENCES `Hospital`.`Usuario` (`codigo` , `contraseña`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Cita` (
  `codigo_cita` VARCHAR(10) NOT NULL,
  `fecha` DATE NOT NULL,
  `hora` TIME NOT NULL,
  `consulta_especialidad` VARCHAR(45) NULL,
  `Examen_codigo` VARCHAR(15) NULL,
  `Orden_codigo` VARCHAR(15) NULL,
  `estado` VARCHAR(5) NOT NULL,
  `Paciente_Usuario_codigo` VARCHAR(15) NOT NULL,
  `Medico_Usuario_codigo` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`codigo_cita`),
  INDEX `fk_Cita_Examen_idx` (`Examen_codigo` ASC) VISIBLE,
  INDEX `fk_Cita_Orden_idx` (`Orden_codigo` ASC) VISIBLE,
  INDEX `fk_Cita_Paciente_idx` (`Paciente_Usuario_codigo` ASC) VISIBLE,
  INDEX `fk_Cita_Medico_idx` (`Medico_Usuario_codigo` ASC) VISIBLE,
  CONSTRAINT `fk_Cita_Examen`
    FOREIGN KEY (`Examen_codigo`)
    REFERENCES `Hospital`.`Examen` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cita_Orden`
    FOREIGN KEY (`Orden_codigo`)
    REFERENCES `Hospital`.`Orden` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cita_Paciente`
    FOREIGN KEY (`Paciente_Usuario_codigo`)
    REFERENCES `Hospital`.`Paciente` (`Usuario_codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cita_Medico`
    FOREIGN KEY (`Medico_Usuario_codigo`)
    REFERENCES `Hospital`.`Medico` (`Usuario_codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Especialidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Especialidad` (
  `Titulo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Titulo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Laboratorista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Laboratorista` (
  `Usuario_codigo` VARCHAR(15) NOT NULL,
  `Usuario_contraseña` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `DPI` VARCHAR(15) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(10) NOT NULL,
  `numero_registro` VARCHAR(45) NOT NULL,
  `fecha_registro` DATE NOT NULL,
  PRIMARY KEY (`Usuario_codigo`, `numero_registro`),
  INDEX `fk_Laboratorista_Usuario_idx` (`Usuario_codigo` ASC, `Usuario_contraseña` ASC) VISIBLE,
  CONSTRAINT `fk_Laboratorista_Usuario`
    FOREIGN KEY (`Usuario_codigo` , `Usuario_contraseña`)
    REFERENCES `Hospital`.`Usuario` (`codigo` , `contraseña`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Consulta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Consulta` (
  `costo` VARCHAR(45) NOT NULL,
  `Especialidad_Titulo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Especialidad_Titulo`),
  INDEX `fk_Consulta_Especialidad_idx` (`Especialidad_Titulo` ASC) VISIBLE,
  CONSTRAINT `fk_Consulta_Especialidad`
    FOREIGN KEY (`Especialidad_Titulo`)
    REFERENCES `Hospital`.`Especialidad` (`Titulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Reporte` (
  `codigo` VARCHAR(15) NOT NULL,
  `descripcion` VARCHAR(1000) NOT NULL,
  `Cita_codigo_cita` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`codigo`, `Cita_codigo_cita`),
  INDEX `fk_Reporte_Cita_idx` (`Cita_codigo_cita` ASC) VISIBLE,
  CONSTRAINT `fk_Reporte_Cita1`
    FOREIGN KEY (`Cita_codigo_cita`)
    REFERENCES `Hospital`.`Cita` (`codigo_cita`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Resultado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Resultado` (
  `codigo` INT NOT NULL,
  `Orden_codigo` VARCHAR(15) NULL,
  `Reporte_codigo` VARCHAR(15) NOT NULL,
  `Examen_codigo` VARCHAR(15) NOT NULL,
  `Laboratorista_Usuario_codigo` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`codigo`, `Reporte_codigo`, `Examen_codigo`, `Laboratorista_Usuario_codigo`),
  INDEX `fk_Resultado_Orden_idx` (`Orden_codigo` ASC) VISIBLE,
  INDEX `fk_Resultado_Reporte_idx` (`Reporte_codigo` ASC) VISIBLE,
  INDEX `fk_Resultado_Examen_idx` (`Examen_codigo` ASC) VISIBLE,
  INDEX `fk_Resultado_Laboratorista_idx` (`Laboratorista_Usuario_codigo` ASC) VISIBLE,
  CONSTRAINT `fk_Resultado_Orden`
    FOREIGN KEY (`Orden_codigo`)
    REFERENCES `Hospital`.`Orden` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Resultado_Reporte`
    FOREIGN KEY (`Reporte_codigo`)
    REFERENCES `Hospital`.`Reporte` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Resultado_Examen`
    FOREIGN KEY (`Examen_codigo`)
    REFERENCES `Hospital`.`Examen` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Resultado_Laboratorista`
    FOREIGN KEY (`Laboratorista_Usuario_codigo`)
    REFERENCES `Hospital`.`Laboratorista` (`Usuario_codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Administrador` (
  `DPI` VARCHAR(15) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `Usuario_codigo` VARCHAR(15) NOT NULL,
  `Usuario_contraseña` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Usuario_codigo`),
  CONSTRAINT `fk_Administrador_Usuario`
    FOREIGN KEY (`Usuario_codigo` , `Usuario_contraseña`)
    REFERENCES `Hospital`.`Usuario` (`codigo` , `contraseña`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`medico_tiene_especialidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`medico_tiene_especialidad` (
  `Medico_Usuario_codigo` VARCHAR(15) NOT NULL,
  `Especialidad_Titulo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Medico_Usuario_codigo`, `Especialidad_Titulo`),
  INDEX `fk_medico_tiene_especialidad_Medico_idx` (`Medico_Usuario_codigo` ASC) VISIBLE,
  INDEX `fk_medico_tiene_especialidad_Especialidad_idx` (`Especialidad_Titulo` ASC) VISIBLE,
  CONSTRAINT `fk_medico_tiene_especialidad_Medico`
    FOREIGN KEY (`Medico_Usuario_codigo`)
    REFERENCES `Hospital`.`Medico` (`Usuario_codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medico_tiene_especialidad_Especialidad1`
    FOREIGN KEY (`Especialidad_Titulo`)
    REFERENCES `Hospital`.`Especialidad` (`Titulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dia_laborales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`dia_laborales` (
  `dia` VARCHAR(10) NOT NULL,
  `Laboratorista_Usuario_codigo` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Laboratorista_Usuario_codigo`, `dia`),
  CONSTRAINT `fk_dias_laborales_Laboratorista`
    FOREIGN KEY (`Laboratorista_Usuario_codigo`)
    REFERENCES `Hospital`.`Laboratorista` (`Usuario_codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
