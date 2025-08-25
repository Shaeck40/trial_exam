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
-- Table `mydb`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Doctor` (
  `Name` VARCHAR(25) NOT NULL,
  `Date of birth` DATE NOT NULL,
  `Salary` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Phonenumber` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Name`, `Phonenumber`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medical` (
  `Overtime_rate` DECIMAL(2) NOT NULL,
  `Doctor_Name` VARCHAR(25) NOT NULL,
  `Doctor_Phonenumber` VARCHAR(15) NOT NULL,
  INDEX `fk_Medical_Doctor1_idx` (`Doctor_Name` ASC, `Doctor_Phonenumber` ASC) VISIBLE,
  CONSTRAINT `fk_Medical_Doctor1`
    FOREIGN KEY (`Doctor_Name` , `Doctor_Phonenumber`)
    REFERENCES `mydb`.`Doctor` (`Name` , `Phonenumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Specialist` (
  `Field_area` VARCHAR(25) NOT NULL,
  `Doctor_Name` VARCHAR(25) NOT NULL,
  `Doctor_Phonenumber` VARCHAR(15) NOT NULL,
  INDEX `fk_Specialist_Doctor1_idx` (`Doctor_Name` ASC, `Doctor_Phonenumber` ASC) VISIBLE,
  CONSTRAINT `fk_Specialist_Doctor1`
    FOREIGN KEY (`Doctor_Name` , `Doctor_Phonenumber`)
    REFERENCES `mydb`.`Doctor` (`Name` , `Phonenumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `Name` VARCHAR(45) NOT NULL,
  `Adress` VARCHAR(45) NOT NULL,
  `Phonenumber` VARCHAR(25) NOT NULL,
  `Dateof birth` DATE NOT NULL,
  PRIMARY KEY (`Name`, `Dateof birth`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Doctor_has_Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Doctor_has_Patient` (
  `Doctor_Name` VARCHAR(25) NOT NULL,
  `Doctor_Phonenumber` VARCHAR(15) NOT NULL,
  `Patient_Name` VARCHAR(45) NOT NULL,
  `Patient_Dateof birth` DATE NOT NULL,
  PRIMARY KEY (`Doctor_Name`, `Doctor_Phonenumber`, `Patient_Name`, `Patient_Dateof birth`),
  INDEX `fk_Doctor_has_Patient_Patient1_idx` (`Patient_Name` ASC, `Patient_Dateof birth` ASC) VISIBLE,
  INDEX `fk_Doctor_has_Patient_Doctor_idx` (`Doctor_Name` ASC, `Doctor_Phonenumber` ASC) VISIBLE,
  CONSTRAINT `fk_Doctor_has_Patient_Doctor`
    FOREIGN KEY (`Doctor_Name` , `Doctor_Phonenumber`)
    REFERENCES `mydb`.`Doctor` (`Name` , `Phonenumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Doctor_has_Patient_Patient1`
    FOREIGN KEY (`Patient_Name` , `Patient_Dateof birth`)
    REFERENCES `mydb`.`Patient` (`Name` , `Dateof birth`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Appointment` (
  `Date` DATE NOT NULL,
  `time` VARCHAR(45) NOT NULL,
  `Patient_Name` VARCHAR(45) NOT NULL,
  `Patient_Dateof birth` DATE NOT NULL,
  `Doctor_has_Patient_Doctor_Name` VARCHAR(25) NOT NULL,
  `Doctor_has_Patient_Doctor_Phonenumber` VARCHAR(15) NOT NULL,
  `Doctor_has_Patient_Patient_Name` VARCHAR(45) NOT NULL,
  `Doctor_has_Patient_Patient_Dateof birth` DATE NOT NULL,
  PRIMARY KEY (`Date`, `time`, `Patient_Name`, `Patient_Dateof birth`, `Doctor_has_Patient_Doctor_Name`, `Doctor_has_Patient_Doctor_Phonenumber`, `Doctor_has_Patient_Patient_Name`, `Doctor_has_Patient_Patient_Dateof birth`),
  INDEX `fk_Appointment_Patient1_idx` (`Patient_Name` ASC, `Patient_Dateof birth` ASC) VISIBLE,
  INDEX `fk_Appointment_Doctor_has_Patient1_idx` (`Doctor_has_Patient_Doctor_Name` ASC, `Doctor_has_Patient_Doctor_Phonenumber` ASC, `Doctor_has_Patient_Patient_Name` ASC, `Doctor_has_Patient_Patient_Dateof birth` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_Patient1`
    FOREIGN KEY (`Patient_Name` , `Patient_Dateof birth`)
    REFERENCES `mydb`.`Patient` (`Name` , `Dateof birth`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_Doctor_has_Patient1`
    FOREIGN KEY (`Doctor_has_Patient_Doctor_Name` , `Doctor_has_Patient_Doctor_Phonenumber` , `Doctor_has_Patient_Patient_Name` , `Doctor_has_Patient_Patient_Dateof birth`)
    REFERENCES `mydb`.`Doctor_has_Patient` (`Doctor_Name` , `Doctor_Phonenumber` , `Patient_Name` , `Patient_Dateof birth`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
