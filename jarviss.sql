-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema jarvis
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema jarvis
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `jarvis` DEFAULT CHARACTER SET utf8mb3 ;
USE `jarvis` ;

-- -----------------------------------------------------
-- Table `jarvis`.`appareil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`appareil` (
  `idappareil` INT NOT NULL,
  `nom_appareil` VARCHAR(45) NULL,
  `type_appareil` VARCHAR(45) NULL,
  PRIMARY KEY (`idappareil`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `jarvis`.`domicile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`domicile` (
  `idDomicile` INT NOT NULL,
  `anneeConstructionl` DATE NULL DEFAULT NULL,
  `superficie` VARCHAR(45) NULL,
  PRIMARY KEY (`idDomicile`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `jarvis`.`utilisateur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`utilisateur` (
  `idU` INT NOT NULL,
  `prenomU` VARCHAR(45) NULL DEFAULT NULL,
  `nomU` VARCHAR(45) NULL DEFAULT NULL,
  `emailU` VARCHAR(45) NULL DEFAULT NULL,
  `mdpU` VARCHAR(8) NULL DEFAULT NULL,
  `sexeU` VARCHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (`idU`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `jarvis`.`proprietaire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`proprietaire` (
  `utilisateur_idU` INT NOT NULL,
  `idpro` INT NOT NULL,
  PRIMARY KEY (`utilisateur_idU`, `idpro`),
  CONSTRAINT `fk_proprietaire_utilisateur`
    FOREIGN KEY (`utilisateur_idU`)
    REFERENCES `jarvis`.`utilisateur` (`idU`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `jarvis`.`avoir`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`avoir` (
  `proprietaire_utilisateur_idU` INT NOT NULL,
  `proprietaire_idpro` INT NOT NULL,
  `Domicile_idDomicile` INT NOT NULL,
  PRIMARY KEY (`proprietaire_utilisateur_idU`, `proprietaire_idpro`, `Domicile_idDomicile`),
  INDEX `fk_proprietaire_has_Domicile_Domicile1_idx` (`Domicile_idDomicile` ASC) VISIBLE,
  INDEX `fk_proprietaire_has_Domicile_proprietaire1_idx` (`proprietaire_utilisateur_idU` ASC, `proprietaire_idpro` ASC) VISIBLE,
  CONSTRAINT `fk_proprietaire_has_Domicile_Domicile1`
    FOREIGN KEY (`Domicile_idDomicile`)
    REFERENCES `jarvis`.`domicile` (`idDomicile`),
  CONSTRAINT `fk_proprietaire_has_Domicile_proprietaire1`
    FOREIGN KEY (`proprietaire_utilisateur_idU` , `proprietaire_idpro`)
    REFERENCES `jarvis`.`proprietaire` (`utilisateur_idU` , `idpro`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `jarvis`.`pieces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`pieces` (
  `idpieces` INT NOT NULL,
  `nomPiece` VARCHAR(45) NULL,
  PRIMARY KEY (`idpieces`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `jarvis`.`appartenir`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`appartenir` (
  `Domicile_idDomicile` INT NOT NULL,
  `pieces_idpieces` INT NOT NULL,
  PRIMARY KEY (`Domicile_idDomicile`, `pieces_idpieces`),
  INDEX `fk_Domicile_has_pieces_pieces1_idx` (`pieces_idpieces` ASC) VISIBLE,
  INDEX `fk_Domicile_has_pieces_Domicile1_idx` (`Domicile_idDomicile` ASC) VISIBLE,
  CONSTRAINT `fk_Domicile_has_pieces_Domicile1`
    FOREIGN KEY (`Domicile_idDomicile`)
    REFERENCES `jarvis`.`domicile` (`idDomicile`),
  CONSTRAINT `fk_Domicile_has_pieces_pieces1`
    FOREIGN KEY (`pieces_idpieces`)
    REFERENCES `jarvis`.`pieces` (`idpieces`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `jarvis`.`coproprietaire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`coproprietaire` (
  `utilisateur_idU` INT NULL,
  `idcopro` INT NOT NULL,
  PRIMARY KEY (`utilisateur_idU`, `idcopro`),
  CONSTRAINT `fk_coproprietaire_utilisateur1`
    FOREIGN KEY (`utilisateur_idU`)
    REFERENCES `jarvis`.`utilisateur` (`idU`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `jarvis`.`membre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`membre` (
  `utilisateur_idU` INT NOT NULL,
  `idmembre` INT NOT NULL,
  `lienparente` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`utilisateur_idU`, `idmembre`),
  CONSTRAINT `fk_membre_utilisateur1`
    FOREIGN KEY (`utilisateur_idU`)
    REFERENCES `jarvis`.`utilisateur` (`idU`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `jarvis`.`se trouve`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`se trouve` (
  `pieces_idpieces` INT NOT NULL,
  `appareil_idappareil` INT NOT NULL,
  PRIMARY KEY (`pieces_idpieces`, `appareil_idappareil`),
  INDEX `fk_pieces_has_appareil_appareil1_idx` (`appareil_idappareil` ASC) VISIBLE,
  INDEX `fk_pieces_has_appareil_pieces1_idx` (`pieces_idpieces` ASC) VISIBLE,
  CONSTRAINT `fk_pieces_has_appareil_appareil1`
    FOREIGN KEY (`appareil_idappareil`)
    REFERENCES `jarvis`.`appareil` (`idappareil`),
  CONSTRAINT `fk_pieces_has_appareil_pieces1`
    FOREIGN KEY (`pieces_idpieces`)
    REFERENCES `jarvis`.`pieces` (`idpieces`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `jarvis`.`contenir`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`contenir` (
  `utilisateur_idU` INT NOT NULL,
  `Domicile_idDomicile` INT NOT NULL,
  PRIMARY KEY (`utilisateur_idU`, `Domicile_idDomicile`),
  INDEX `fk_utilisateur_has_Domicile_Domicile1_idx` (`Domicile_idDomicile` ASC) VISIBLE,
  INDEX `fk_utilisateur_has_Domicile_utilisateur1_idx` (`utilisateur_idU` ASC) VISIBLE,
  CONSTRAINT `fk_utilisateur_has_Domicile_Domicile1`
    FOREIGN KEY (`Domicile_idDomicile`)
    REFERENCES `jarvis`.`domicile` (`idDomicile`),
  CONSTRAINT `fk_utilisateur_has_Domicile_utilisateur1`
    FOREIGN KEY (`utilisateur_idU`)
    REFERENCES `jarvis`.`utilisateur` (`idU`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `jarvis`.`inviter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`inviter` (
  `utilisateur_idU` INT NULL,
  `proprietaire_utilisateur_idU` INT NOT NULL,
  `proprietaire_idpro` INT NOT NULL,
  PRIMARY KEY (`utilisateur_idU`, `proprietaire_utilisateur_idU`, `proprietaire_idpro`),
  INDEX `fk_utilisateur_has_proprietaire_proprietaire1_idx` (`proprietaire_utilisateur_idU` ASC, `proprietaire_idpro` ASC) VISIBLE,
  INDEX `fk_utilisateur_has_proprietaire_utilisateur1_idx` (`utilisateur_idU` ASC) VISIBLE,
  CONSTRAINT `fk_utilisateur_has_proprietaire_utilisateur1`
    FOREIGN KEY (`utilisateur_idU`)
    REFERENCES `jarvis`.`utilisateur` (`idU`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_utilisateur_has_proprietaire_proprietaire1`
    FOREIGN KEY (`proprietaire_utilisateur_idU` , `proprietaire_idpro`)
    REFERENCES `jarvis`.`proprietaire` (`utilisateur_idU` , `idpro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

USE `jarvis` ;

-- -----------------------------------------------------
-- Placeholder table for view `jarvis`.`vue_synthetique_coproprietaire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`vue_synthetique_coproprietaire` (`idU` INT, `idcopro` INT);

-- -----------------------------------------------------
-- Placeholder table for view `jarvis`.`vue_synthetique_membre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`vue_synthetique_membre` (`idU` INT, `idmembre` INT);

-- -----------------------------------------------------
-- Placeholder table for view `jarvis`.`vue_synthetique_proprietaire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`vue_synthetique_proprietaire` (`idU` INT, `idpro` INT);

-- -----------------------------------------------------
-- View `jarvis`.`vue_synthetique_coproprietaire`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jarvis`.`vue_synthetique_coproprietaire`;
USE `jarvis`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jarvis`.`vue_synthetique_coproprietaire` AS select `jarvis`.`utilisateur`.`idU` AS `idU`,`jarvis`.`coproprietaire`.`idcopro` AS `idcopro` from (`jarvis`.`utilisateur` join `jarvis`.`coproprietaire`) where (`jarvis`.`utilisateur`.`idU` = `jarvis`.`coproprietaire`.`utilisateur_idU`);

-- -----------------------------------------------------
-- View `jarvis`.`vue_synthetique_membre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jarvis`.`vue_synthetique_membre`;
USE `jarvis`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jarvis`.`vue_synthetique_membre` AS select `jarvis`.`utilisateur`.`idU` AS `idU`,`jarvis`.`membre`.`idmembre` AS `idmembre` from (`jarvis`.`utilisateur` join `jarvis`.`membre`) where (`jarvis`.`utilisateur`.`idU` = `jarvis`.`membre`.`utilisateur_idU`);

-- -----------------------------------------------------
-- View `jarvis`.`vue_synthetique_proprietaire`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jarvis`.`vue_synthetique_proprietaire`;
USE `jarvis`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jarvis`.`vue_synthetique_proprietaire` AS select `jarvis`.`utilisateur`.`idU` AS `idU`,`jarvis`.`proprietaire`.`idpro` AS `idpro` from (`jarvis`.`utilisateur` join `jarvis`.`proprietaire`) where (`jarvis`.`utilisateur`.`idU` = `jarvis`.`proprietaire`.`utilisateur_idU`);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
