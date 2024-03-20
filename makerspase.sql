-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema makerspace
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema makerspace
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `makerspace` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `makerspace` ;

-- -----------------------------------------------------
-- Table `makerspace`.`Telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `makerspace`.`Telefone` (
  `idTelefone` INT NOT NULL,
  `Telefonecol` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idTelefone`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `makerspace`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `makerspace`.`usuario` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(255) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `Telefone_idTelefone` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `Email` (`Email` ASC) VISIBLE,
  INDEX `fk_usuario_Telefone1_idx` (`Telefone_idTelefone` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_Telefone1`
    FOREIGN KEY (`Telefone_idTelefone`)
    REFERENCES `makerspace`.`Telefone` (`idTelefone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `makerspace`.`material`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `makerspace`.`material` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(255) NOT NULL,
  `Descricao` TEXT NULL DEFAULT NULL,
  `Preco` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `makerspace`.`equipamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `makerspace`.`equipamento` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(255) NOT NULL,
  `Descricao` TEXT NULL DEFAULT NULL,
  `Disponibilidade` TINYINT(1) NOT NULL,
  `material_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_equipamento_material1_idx` (`material_ID` ASC) VISIBLE,
  CONSTRAINT `fk_equipamento_material1`
    FOREIGN KEY (`material_ID`)
    REFERENCES `makerspace`.`material` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `makerspace`.`agendamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `makerspace`.`agendamento` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ID_Usuario` INT NULL DEFAULT NULL,
  `ID_Equipamento` INT NULL DEFAULT NULL,
  `Data_Hora_Inicio` DATETIME NULL DEFAULT NULL,
  `Data_Hora_Termino` DATETIME NULL DEFAULT NULL,
  `Valor_Cobrado` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `ID_Usuario` (`ID_Usuario` ASC) VISIBLE,
  INDEX `ID_Equipamento` (`ID_Equipamento` ASC) VISIBLE,
  CONSTRAINT `agendamento_ibfk_1`
    FOREIGN KEY (`ID_Usuario`)
    REFERENCES `makerspace`.`usuario` (`ID`),
  CONSTRAINT `agendamento_ibfk_2`
    FOREIGN KEY (`ID_Equipamento`)
    REFERENCES `makerspace`.`equipamento` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `makerspace`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `makerspace`.`curso` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(255) NOT NULL,
  `Descricao` TEXT NULL DEFAULT NULL,
  `Data_Hora` DATETIME NULL DEFAULT NULL,
  `Valor_Inscricao` DECIMAL(10,2) NULL DEFAULT NULL,
  `Professor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `makerspace`.`evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `makerspace`.`evento` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(255) NOT NULL,
  `Descricao` TEXT NULL DEFAULT NULL,
  `Data_Hora` DATETIME NULL DEFAULT NULL,
  `Local` VARCHAR(255) NULL DEFAULT NULL,
  `Palestrante` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `makerspace`.`evento_has_agendamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `makerspace`.`evento_has_agendamento` (
  `evento_ID` INT NOT NULL,
  `agendamento_ID` INT NOT NULL,
  PRIMARY KEY (`evento_ID`, `agendamento_ID`),
  INDEX `fk_evento_has_agendamento_agendamento1_idx` (`agendamento_ID` ASC) VISIBLE,
  INDEX `fk_evento_has_agendamento_evento1_idx` (`evento_ID` ASC) VISIBLE,
  CONSTRAINT `fk_evento_has_agendamento_evento1`
    FOREIGN KEY (`evento_ID`)
    REFERENCES `makerspace`.`evento` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evento_has_agendamento_agendamento1`
    FOREIGN KEY (`agendamento_ID`)
    REFERENCES `makerspace`.`agendamento` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `makerspace`.`curso_has_agendamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `makerspace`.`curso_has_agendamento` (
  `curso_ID` INT NOT NULL,
  `agendamento_ID` INT NOT NULL,
  PRIMARY KEY (`curso_ID`, `agendamento_ID`),
  INDEX `fk_curso_has_agendamento_agendamento1_idx` (`agendamento_ID` ASC) VISIBLE,
  INDEX `fk_curso_has_agendamento_curso1_idx` (`curso_ID` ASC) VISIBLE,
  CONSTRAINT `fk_curso_has_agendamento_curso1`
    FOREIGN KEY (`curso_ID`)
    REFERENCES `makerspace`.`curso` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curso_has_agendamento_agendamento1`
    FOREIGN KEY (`agendamento_ID`)
    REFERENCES `makerspace`.`agendamento` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
