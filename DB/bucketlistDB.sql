-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bucketlistDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bucketlistDB` ;

-- -----------------------------------------------------
-- Schema bucketlistDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bucketlistDB` DEFAULT CHARACTER SET utf8 ;
USE `bucketlistDB` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `email` VARCHAR(100) NULL,
  `first_name` VARCHAR(100) NULL,
  `last_name` VARCHAR(100) NULL,
  `role` VARCHAR(45) NULL,
  `date_created` DATETIME NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `country` ;

CREATE TABLE IF NOT EXISTS `country` (
  `country_code` VARCHAR(3) NOT NULL,
  `country_name` VARCHAR(100) NOT NULL,
  `continent` VARCHAR(45) NULL,
  PRIMARY KEY (`country_code`),
  UNIQUE INDEX `country_code_UNIQUE` (`country_code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `location` ;

CREATE TABLE IF NOT EXISTS `location` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `city_area` VARCHAR(100) NOT NULL,
  `specific_location` VARCHAR(100) NULL,
  `country_code` VARCHAR(3) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_country_code_idx` (`country_code` ASC),
  CONSTRAINT `fk_country_code`
    FOREIGN KEY (`country_code`)
    REFERENCES `country` (`country_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category` ;

CREATE TABLE IF NOT EXISTS `category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `activity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `activity` ;

CREATE TABLE IF NOT EXISTS `activity` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `description` TEXT(2000) NULL,
  `category_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_category_id_idx` (`category_id` ASC),
  CONSTRAINT `fk_category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bucket_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bucket_item` ;

CREATE TABLE IF NOT EXISTS `bucket_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `activity_id` INT NOT NULL,
  `location_id` INT NULL,
  `created_by_user` INT NOT NULL,
  `date_created` DATETIME NOT NULL,
  `date_updated` DATETIME NOT NULL,
  `is_public_at_creation` TINYINT(1) NOT NULL DEFAULT 1,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_location_idx` (`location_id` ASC),
  INDEX `fk_activity_idx` (`activity_id` ASC),
  INDEX `fk_created_by_user_idx` (`created_by_user` ASC),
  CONSTRAINT `fk_activity`
    FOREIGN KEY (`activity_id`)
    REFERENCES `activity` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location`
    FOREIGN KEY (`location_id`)
    REFERENCES `location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_created_by_user`
    FOREIGN KEY (`created_by_user`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comment` ;

CREATE TABLE IF NOT EXISTS `comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comment_text` TEXT(1000) NULL,
  `date_created` DATETIME NULL,
  `date_updated` DATETIME NULL,
  `user_id` INT NOT NULL,
  `bucket_item_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_username_idx` (`user_id` ASC),
  INDEX `fk_public_bucket_item_id_idx` (`bucket_item_id` ASC),
  CONSTRAINT `fk_comment_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_bucket_item_id`
    FOREIGN KEY (`bucket_item_id`)
    REFERENCES `bucket_item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_bucket_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_bucket_item` ;

CREATE TABLE IF NOT EXISTS `user_bucket_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `bucket_item_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `date_added` DATETIME NOT NULL,
  `date_completed` DATETIME NOT NULL,
  `target_date` DATE NULL,
  `is_completed` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_username_idx` (`user_id` ASC),
  INDEX `fk_public_bucket_item_idx` (`bucket_item_id` ASC),
  CONSTRAINT `fk_userbucketitem_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_userbucketitem_bucket_item_id`
    FOREIGN KEY (`bucket_item_id`)
    REFERENCES `bucket_item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poll`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `poll` ;

CREATE TABLE IF NOT EXISTS `poll` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rating_stars` TINYINT(1) NULL,
  `cost_dollar_signs` TINYINT(1) NULL,
  `best_time_to_do` DATE NULL,
  `bucket_item_id` INT NULL,
  `user_id` INT NOT NULL,
  `date_created` DATETIME NOT NULL,
  `date_updated` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_public_bucket_item_id_idx` (`bucket_item_id` ASC),
  INDEX `fk_username_idx` (`user_id` ASC),
  CONSTRAINT `fk_bucket_item_id`
    FOREIGN KEY (`bucket_item_id`)
    REFERENCES `bucket_item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_poll_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `resource` ;

CREATE TABLE IF NOT EXISTS `resource` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(1000) NULL,
  `user_bucket_item` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_bucket_item_idx` (`user_bucket_item` ASC),
  CONSTRAINT `fk_resource_user_bucket_item`
    FOREIGN KEY (`user_bucket_item`)
    REFERENCES `user_bucket_item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `note`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `note` ;

CREATE TABLE IF NOT EXISTS `note` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `note_text` TEXT NULL,
  `user_bucket_item` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_bucket_item_idx` (`user_bucket_item` ASC),
  CONSTRAINT `fk_note_user_bucket_item`
    FOREIGN KEY (`user_bucket_item`)
    REFERENCES `user_bucket_item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS bucketlistuser@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'bucketlistuser'@'localhost' IDENTIFIED BY 'bucketlistuser';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'bucketlistuser'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `bucketlistDB`;
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`) VALUES (1, 'admin', 'adminbucketpass', NULL, 'Admin', 'Admin', NULL, NULL, 1);

COMMIT;

