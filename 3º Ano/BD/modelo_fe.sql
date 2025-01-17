-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS,FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema driveIt
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema driveIt
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `driveIt`;
CREATE SCHEMA IF NOT EXISTS `driveIt` DEFAULT CHARACTER SET utf8 ;
USE `driveIt` ;

-- -----------------------------------------------------
-- Table `driveIt`.`Morada`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `driveIt`.`Morada` ;
CREATE TABLE IF NOT EXISTS `driveIt`.`Morada` (
  `idMorada` INT NOT NULL AUTO_INCREMENT,
  `Rua` VARCHAR(45) NOT NULL,
  `Localidade` VARCHAR(45) NOT NULL,
  `Código-Postal` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMorada`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `driveIt`.`Funcionario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `driveIt`.`Funcionario` ;
CREATE TABLE IF NOT EXISTS `driveIt`.`Funcionario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Nrº_Telemóvel` VARCHAR(9) NOT NULL,
  `Nrº_CC` VARCHAR(45) NOT NULL,
  `Morada_idMorada` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Funcionario_Morada1_idx` (`Morada_idMorada` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionario_Morada1`
    FOREIGN KEY (`Morada_idMorada`)
    REFERENCES `driveIt`.`Morada` (`idMorada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `driveIt`.`Aluno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `driveIt`.`Aluno` ;
CREATE TABLE IF NOT EXISTS `driveIt`.`Aluno` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Nrº_Telemóvel` VARCHAR(9) NOT NULL,
  `Nrº_CC` VARCHAR(45) NOT NULL,
  `NIF` CHAR(9) NOT NULL,
  `Pagamento` ENUM('S', 'N') NOT NULL,
  `Morada_idMorada` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Aluno_Morada1_idx` (`Morada_idMorada` ASC) VISIBLE,
  CONSTRAINT `fk_Aluno_Morada1`
    FOREIGN KEY (`Morada_idMorada`)
    REFERENCES `driveIt`.`Morada` (`idMorada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `driveIt`.`Instrutor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `driveIt`.`Instrutor` ;
CREATE TABLE IF NOT EXISTS `driveIt`.`Instrutor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Nrº_Telemóvel` VARCHAR(9) NOT NULL,
  `Nrº_CC` VARCHAR(45) NOT NULL,
  `Morada_idMorada` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Instrutor_Morada1_idx` (`Morada_idMorada` ASC) VISIBLE,
  CONSTRAINT `fk_Instrutor_Morada1`
    FOREIGN KEY (`Morada_idMorada`)
    REFERENCES `driveIt`.`Morada` (`idMorada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `driveIt`.`Carro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `driveIt`.`Carro` ;
CREATE TABLE IF NOT EXISTS `driveIt`.`Carro` (
  `Matricula` VARCHAR(45) NOT NULL,
  `Marca` VARCHAR(45) NOT NULL,
  `Modelo` VARCHAR(45) NOT NULL,
  `Ano` YEAR(4) NOT NULL,
  PRIMARY KEY (`Matricula`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `driveIt`.`Aula`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `driveIt`.`Aula` ;
CREATE TABLE IF NOT EXISTS `driveIt`.`Aula` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Data` DATE NOT NULL,
  `Hora` TIME NOT NULL,
  -- L : livre; R: realizada; M: marcada; D : decorrer
  `Estado` ENUM('L', 'R', 'M', 'D') NOT NULL,
  `Instrutor_Id` INT DEFAULT 0 NOT NULL,
  `Carro_Matricula` VARCHAR(45) NULL,
  `Funcionario_id` INT NULL,
  `Aluno_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `Instrutor_Id_idx` (`Instrutor_Id` ASC) VISIBLE,
  INDEX `fk_Aula_Carro1_idx` (`Carro_Matricula` ASC) VISIBLE,
  INDEX `fk_Aula_Funcionario1_idx` (`Funcionario_id` ASC) VISIBLE,
  INDEX `fk_Aula_Aluno1_idx` (`Aluno_id` ASC) VISIBLE,
  CONSTRAINT `Instrutor_Id`
    FOREIGN KEY (`Instrutor_Id`)
    REFERENCES `driveIt`.`Instrutor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Aula_Carro1`
    FOREIGN KEY (`Carro_Matricula`)
    REFERENCES `driveIt`.`Carro` (`Matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Aula_Funcionario1`
    FOREIGN KEY (`Funcionario_id`)
    REFERENCES `driveIt`.`Funcionario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Aula_Aluno1`
    FOREIGN KEY (`Aluno_id`)
    REFERENCES `driveIt`.`Aluno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
