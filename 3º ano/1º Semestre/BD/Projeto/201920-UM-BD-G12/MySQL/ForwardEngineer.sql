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
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Modalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Modalidade` (
  `idModalidade` INT NOT NULL,
  `designacao` VARCHAR(45) NOT NULL,
  `genero` CHAR NOT NULL,
  PRIMARY KEY (`idModalidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Atleta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Atleta` (
  `idAtleta` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `genero` CHAR(1) NOT NULL,
  `nacionalidade` VARCHAR(45) NOT NULL,
  `morada` VARCHAR(100) NOT NULL,
  `idModalidade` INT NOT NULL,
  PRIMARY KEY (`idAtleta`),
  INDEX `fk_Atleta_Modalidade1_idx` (`idModalidade` ASC) VISIBLE,
  CONSTRAINT `fk_Atleta_Modalidade1`
    FOREIGN KEY (`idModalidade`)
    REFERENCES `mydb`.`Modalidade` (`idModalidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Categoria` (
  `idCategoria` INT NOT NULL,
  `idModalidade` INT NOT NULL,
  `designacao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategoria`),
  INDEX `fk_Categoria_Modalidade1_idx` (`idModalidade` ASC) VISIBLE,
  CONSTRAINT `fk_Categoria_Modalidade1`
    FOREIGN KEY (`idModalidade`)
    REFERENCES `mydb`.`Modalidade` (`idModalidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Teste`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Teste` (
  `idTeste` INT NOT NULL AUTO_INCREMENT,
  `idAtleta` INT NOT NULL,
  `medico` VARCHAR(45) NOT NULL,
  `data` DATETIME NOT NULL,
  `flag` CHAR(1) NOT NULL,
  `preço` DOUBLE NOT NULL,
  PRIMARY KEY (`idTeste`),
  INDEX `fk_Testes_Atleta1_idx` (`idAtleta` ASC) VISIBLE,
  CONSTRAINT `fk_Testes_Atleta1`
    FOREIGN KEY (`idAtleta`)
    REFERENCES `mydb`.`Atleta` (`idAtleta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Prova`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Prova` (
  `idProva` INT NOT NULL AUTO_INCREMENT,
  `idModalidade` INT NOT NULL,
  `idCategoria` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `flag` CHAR(1) NOT NULL,
  `data` DATETIME NOT NULL,
  `vencedor1` INT NULL,
  `vencedor2` INT NULL,
  `vencedor3` INT NULL,
  PRIMARY KEY (`idProva`),
  INDEX `fk_Provas_Modalidade1_idx` (`idModalidade` ASC) VISIBLE,
  INDEX `fk_Prova_Categoria1_idx` (`idCategoria` ASC) VISIBLE,
  CONSTRAINT `fk_Provas_Modalidade1`
    FOREIGN KEY (`idModalidade`)
    REFERENCES `mydb`.`Modalidade` (`idModalidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prova_Categoria1`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `mydb`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Provas_Atleta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Provas_Atleta` (
  `idProva` INT NOT NULL,
  `idAtleta` INT NOT NULL,
  PRIMARY KEY (`idProva`, `idAtleta`),
  INDEX `fk_Provas_has_Atleta_Atleta1_idx` (`idAtleta` ASC) VISIBLE,
  INDEX `fk_Provas_has_Atleta_Provas1_idx` (`idProva` ASC) VISIBLE,
  CONSTRAINT `fk_Provas_has_Atleta_Provas1`
    FOREIGN KEY (`idProva`)
    REFERENCES `mydb`.`Prova` (`idProva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Provas_has_Atleta_Atleta1`
    FOREIGN KEY (`idAtleta`)
    REFERENCES `mydb`.`Atleta` (`idAtleta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Multa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Multa` (
  `idMulta` INT NOT NULL AUTO_INCREMENT,
  `flag` CHAR(1) NOT NULL,
  `valor` DOUBLE NOT NULL,
  `idTeste` INT NOT NULL,
  `idAtleta` INT NOT NULL,
  PRIMARY KEY (`idMulta`),
  INDEX `fk_Multa_Teste1_idx` (`idTeste` ASC) VISIBLE,
  INDEX `fk_Multa_Atleta1_idx` (`idAtleta` ASC) VISIBLE,
  CONSTRAINT `fk_Multa_Teste1`
    FOREIGN KEY (`idTeste`)
    REFERENCES `mydb`.`Teste` (`idTeste`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Multa_Atleta1`
    FOREIGN KEY (`idAtleta`)
    REFERENCES `mydb`.`Atleta` (`idAtleta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
