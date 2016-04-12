-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema hornet
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hornet
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hornet` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `hornet` ;

-- -----------------------------------------------------
-- Table `hornet`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hornet`.`user` (
  `id` INT NOT NULL,
  `display_name` VARCHAR(45) NULL,
  `status_icon` VARCHAR(8) NULL,
  `created` DATETIME(3) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hornet`.`userlocation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hornet`.`userlocation` (
  `idlocations` INT(11) NOT NULL,
  `userId` INT NOT NULL,
  `lat` DOUBLE NOT NULL,
  `lon` DOUBLE NOT NULL,
  `error_km` DOUBLE NULL,
  `status` VARCHAR(15) NULL,
  `when` DATETIME(3) NOT NULL,
  PRIMARY KEY (`idlocations`),
  INDEX `user` (`userId` ASC),
  CONSTRAINT `user`
    FOREIGN KEY (`userId`)
    REFERENCES `hornet`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hornet`.`device`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hornet`.`device` (
  `UUID` VARCHAR(16) NOT NULL,
  `lat` DOUBLE NULL,
  `long` DOUBLE NULL,
  `userid` INT NULL,
  `lastLogin` DATETIME(3) NULL,
  PRIMARY KEY (`UUID`),
  INDEX `userid_idx` (`userid` ASC),
  CONSTRAINT `userid`
    FOREIGN KEY (`userid`)
    REFERENCES `hornet`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hornet`.`nickname`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hornet`.`nickname` (
  `idnickname` VARCHAR(30) NOT NULL,
  `userId` INT(13) NULL,
  PRIMARY KEY (`idnickname`),
  INDEX `user_idx` (`userId` ASC),
  CONSTRAINT `user`
    FOREIGN KEY (`userId`)
    REFERENCES `hornet`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hornet`.`photo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hornet`.`photo` (
  `idpicture` INT NOT NULL,
  `guid` VARCHAR(40) NOT NULL,
  `prefix` VARCHAR(5) NOT NULL,
  `userid` INT NOT NULL,
  `isMain` TINYINT(1) NOT NULL,
  `created` DATETIME NULL,
  PRIMARY KEY (`idpicture`),
  INDEX `user_idx` (`userid` ASC),
  CONSTRAINT `userq`
    FOREIGN KEY (`userid`)
    REFERENCES `hornet`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hornet`.`favourite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hornet`.`favourite` (
  `userOf` INT NOT NULL,
  `userTo` INT NOT NULL,
  PRIMARY KEY (`userOf`, `userTo`),
  INDEX `user2_idx` (`userTo` ASC),
  CONSTRAINT `user1`
    FOREIGN KEY (`userOf`)
    REFERENCES `hornet`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user2`
    FOREIGN KEY (`userTo`)
    REFERENCES `hornet`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hornet`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hornet`.`message` (
  `id` BIGINT(16) NOT NULL,
  `sender` INT NOT NULL,
  `recipient` INT NOT NULL,
  `data` VARCHAR(1000) NULL,
  `time` DATETIME(3) NOT NULL,
  `message_id` VARCHAR(25) NULL,
  `type` VARCHAR(12) NULL,
  `client_ref` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `id1_idx` (`sender` ASC),
  INDEX `id2_idx` (`recipient` ASC),
  CONSTRAINT `id1`
    FOREIGN KEY (`sender`)
    REFERENCES `hornet`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id2`
    FOREIGN KEY (`recipient`)
    REFERENCES `hornet`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hornet`.`geocode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hornet`.`geocode` (
  `latitude` DECIMAL(4,4) NOT NULL,
  `longitude` DECIMAL(4,4) NOT NULL,
  `Address` VARCHAR(150) NULL,
  `city` VARCHAR(30) NULL,
  `country` VARCHAR(15) NULL,
  PRIMARY KEY (`latitude`, `longitude`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hornet`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hornet`.`city` (
  `id` INT NOT NULL,
  `name` VARCHAR(25) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hornet`.`profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hornet`.`profile` (
  `userid` INT NOT NULL,
  `about_you` VARCHAR(100) NULL,
  `display_name` VARCHAR(45) NULL,
  `age` INT NULL,
  `height` INT NULL,
  `weight` INT NULL,
  `headline` VARCHAR(100) NULL,
  PRIMARY KEY (`userid`),
  CONSTRAINT `user2`
    FOREIGN KEY (`userid`)
    REFERENCES `hornet`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
