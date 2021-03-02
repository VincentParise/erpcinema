-- -----------------------------------------------------
-- Schema erpcinema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema erpcinema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `erpcinema` DEFAULT CHARACTER SET utf8 ;
USE `erpcinema` ;

-- -----------------------------------------------------
-- Table `erpcinema`.`Cinemas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `erpcinema`.`Cinemas` (
  `idCinema` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `adresse` VARCHAR(45) NOT NULL,
  `codepostal` INT NOT NULL,
  `ville` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCinema`));

-- -----------------------------------------------------
-- Table `erpcinema`.`Projections`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `erpcinema`.`Projections` (
  `idProjection` INT NOT NULL AUTO_INCREMENT,
  `Libelle` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idProjection`));

-- -----------------------------------------------------
-- Table `erpcinema`.`Salles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `erpcinema`.`Salles` (
  `idSalle` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(50) NOT NULL,
  `Cinemas_id` INT NOT NULL,
  `Projections_id` INT NOT NULL,
  PRIMARY KEY (`idSalle`, `Cinemas_id`),
  CONSTRAINT `fk_Salles_Cinemas`
    FOREIGN KEY (`Cinemas_id`)
    REFERENCES `erpcinema`.`Cinemas` (`idCinema`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Salles_Projections`
    FOREIGN KEY (`Projections_id`)
    REFERENCES `erpcinema`.`Projections` (`idProjection`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `mydb`.`Places`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `erpcinema`.`Places` (
  `idPlace` INT NOT NULL AUTO_INCREMENT,
  `numero` INT NOT NULL,
  `libelle` VARCHAR(45) NOT NULL,
  `reserve` TINYINT NOT NULL,
  `Salles_id` INT NOT NULL,
  PRIMARY KEY (`idPlace`),
  CONSTRAINT `fk_Places_Salles`
    FOREIGN KEY (`Salles_id`)
    REFERENCES `erpcinema`.`Salles` (`idSalle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `erpcinema`.`Films`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `erpcinema`.`Films` (
  `idFilm` INT NOT NULL AUTO_INCREMENT,
  `libelle` VARCHAR(45) NOT NULL,
  `description` LONGTEXT NOT NULL,
  `realisateur` VARCHAR(45) NOT NULL,
  `duree` DATETIME NOT NULL,
  PRIMARY KEY (`idFilm`));

-- -----------------------------------------------------
-- Table `erpcinema`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `erpcinema`.`Clients` (
  `idClient` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(45) NOT NULL,
  `dateanniversaire` DATETIME NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idClient`));

-- -----------------------------------------------------
-- Table `erpcinema`.`Seances`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `erpcinema`.`Seances` (
  `idSeance` INT NOT NULL AUTO_INCREMENT,
  `horaire` DATETIME NOT NULL,
  `Films_id` INT NOT NULL,
  `Salles_id` INT NOT NULL,
  PRIMARY KEY (`idSeance`),
  CONSTRAINT `fk_Seances_Films`
    FOREIGN KEY (`Films_id`)
    REFERENCES `erpcinema`.`Films` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Seances_Salles`
    FOREIGN KEY (`Salles_id`)
    REFERENCES `erpcinema`.`Salles` (`idSalle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `erpcinema`.`Tarifs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `erpcinema`.`Tarifs` (
  `idTarif` INT NOT NULL AUTO_INCREMENT,
  `libelle` VARCHAR(45) NOT NULL,
  `prix` DECIMAL(2) NOT NULL,
  `Cinemas_id` INT NOT NULL,
  PRIMARY KEY (`idTarif`),
  CONSTRAINT `fk_Tarifs_Cinemas`
    FOREIGN KEY (`Cinemas_id`)
    REFERENCES `erpcinema`.`Cinemas` (`idCinema`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `erpcinema`.`reserver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `erpcinema`.`reserver` (
  `Clients_id` INT NOT NULL,
  `Seances_id` INT NOT NULL,
  PRIMARY KEY (`Clients_id`, `Seances_id`),
  CONSTRAINT `fk_Clients_reserver_Clients`
    FOREIGN KEY (`Clients_id`)
    REFERENCES `erpcinema`.`Clients` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Clients_reserver_Seances`
    FOREIGN KEY (`Seances_id`)
    REFERENCES `erpcinema`.`Seances` (`idSeance`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `erpcinema`.`concerner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `erpcinema`.`concerner` (
  `Tarifs_id` INT NOT NULL,
  `Seances_id` INT NOT NULL,
  PRIMARY KEY (`Tarifs_id`, `Seances_id`),
  CONSTRAINT `fk_Tarifs_concerner_Tarifs`
    FOREIGN KEY (`Tarifs_id`)
    REFERENCES `erpcinema`.`Tarifs` (`idTarif`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tarifs_concerner_Seances`
    FOREIGN KEY (`Seances_id`)
    REFERENCES `erpcinema`.`Seances` (`idSeance`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `erpcinema`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `erpcinema`.`Users` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUser`));
