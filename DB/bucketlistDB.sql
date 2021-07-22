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
  `image_url` MEDIUMTEXT NULL,
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
  `specific_location` TEXT NULL,
  `country_code` VARCHAR(3) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_country_code_idx` (`country_code` ASC),
  CONSTRAINT `fk_location_country_code`
    FOREIGN KEY (`country_code`)
    REFERENCES `country` (`country_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bucket_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bucket_item` ;

CREATE TABLE IF NOT EXISTS `bucket_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `description` TEXT NULL,
  `location_id` INT NULL,
  `created_by_user` INT NOT NULL,
  `date_created` DATETIME NULL,
  `date_updated` DATETIME NULL,
  `is_public_at_creation` TINYINT NOT NULL DEFAULT 1,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  `image_url` MEDIUMTEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_location_idx` (`location_id` ASC),
  INDEX `fk_created_by_user_idx` (`created_by_user` ASC),
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
  `comment_text` TEXT NULL,
  `date_created` DATETIME NULL,
  `date_updated` DATETIME NULL,
  `user_id` INT NOT NULL,
  `bucket_item_id` INT NOT NULL,
  `image_url` VARCHAR(1000) NULL,
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
-- Table `category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category` ;

CREATE TABLE IF NOT EXISTS `category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL DEFAULT 'Other',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_bucket_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_bucket_item` ;

CREATE TABLE IF NOT EXISTS `user_bucket_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `bucket_item_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `date_added` DATETIME NULL,
  `date_completed` DATETIME NULL,
  `target_date` DATE NULL,
  `is_completed` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_username_idx` (`user_id` ASC),
  INDEX `fk_public_bucket_item_idx` (`bucket_item_id` ASC),
  CONSTRAINT `fk_user_bucket_item_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_bucket_item_bucket_item_id`
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
  `best_time_todo` VARCHAR(45) NULL,
  `bucket_item_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `date_created` DATETIME NULL,
  `date_updated` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_public_bucket_item_id_idx` (`bucket_item_id` ASC),
  INDEX `fk_username_idx` (`user_id` ASC),
  CONSTRAINT `fk_poll_bucket_item_id`
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
  CONSTRAINT `fk_resource_user_bucket_item_id`
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
  `note_title` VARCHAR(100) NULL,
  `note_text` TEXT NULL,
  `user_bucket_item_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_bucket_item_idx` (`user_bucket_item_id` ASC),
  CONSTRAINT `fk_note_user_bucket_item_id`
    FOREIGN KEY (`user_bucket_item_id`)
    REFERENCES `user_bucket_item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bucket_item_has_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bucket_item_has_category` ;

CREATE TABLE IF NOT EXISTS `bucket_item_has_category` (
  `bucket_item_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`bucket_item_id`, `category_id`),
  INDEX `fk_bucket_item_has_category_category1_idx` (`category_id` ASC),
  INDEX `fk_bucket_item_has_category_bucket_item1_idx` (`bucket_item_id` ASC),
  CONSTRAINT `fk_bucket_item_has_category_bucket_item1`
    FOREIGN KEY (`bucket_item_id`)
    REFERENCES `bucket_item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bucket_item_has_category_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `category` (`id`)
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
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`, `image_url`) VALUES (1, 'admin', 'adminpass', 'admin@buckitlist.fun', 'Admin', 'Admin', 'admin', NULL, 1, 'https://i.pinimg.com/236x/a1/66/06/a166064b290b061beb1a048c15b9a180--all-things-buckets.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`, `image_url`) VALUES (2, 'brandon-f', 'brandonpass', 'brandon@buckitlist.fun', 'Brandon', 'Files', 'user', NULL, 1, 'https://i.pinimg.com/236x/a1/66/06/a166064b290b061beb1a048c15b9a180--all-things-buckets.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`, `image_url`) VALUES (3, 'mick-l', 'mickpass', 'mick@buckitlist.fun', 'Mick', 'LaGassey', 'user', NULL, 1, 'https://i.pinimg.com/236x/a1/66/06/a166064b290b061beb1a048c15b9a180--all-things-buckets.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`, `image_url`) VALUES (4, 'steven-l', 'stevenpass', 'steven@buckitlist.fun', 'Steven', 'Laupan', 'user', NULL, 1, 'https://i.pinimg.com/236x/a1/66/06/a166064b290b061beb1a048c15b9a180--all-things-buckets.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`, `image_url`) VALUES (5, 'gabriel-a', 'gabrielpass', 'gabriel@buckitlist.fun', 'Gabriel', 'Avila', 'user', NULL, 1, 'https://i.pinimg.com/236x/a1/66/06/a166064b290b061beb1a048c15b9a180--all-things-buckets.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`, `image_url`) VALUES (6, 'jiori5', '6XyAwWG8X', 'jiori5@people.com.cn', 'Johannah', 'Iori', 'user', NULL, 1, 'https://i.pinimg.com/236x/a1/66/06/a166064b290b061beb1a048c15b9a180--all-things-buckets.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`, `image_url`) VALUES (7, 'cpryde6', 'J7dIFehT', 'cpryde6@examiner.com', 'Chickie', 'Pryde', 'user', NULL, 1, 'https://i.pinimg.com/236x/a1/66/06/a166064b290b061beb1a048c15b9a180--all-things-buckets.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`, `image_url`) VALUES (8, 'aughetti7', '7NpvzgHmei', 'aughetti7@cbsnews.com', 'Adrianne', 'Ughetti', 'user', NULL, 1, 'https://i.pinimg.com/236x/a1/66/06/a166064b290b061beb1a048c15b9a180--all-things-buckets.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`, `image_url`) VALUES (9, 'tblinco8', 'XHXOfLH', 'tblinco8@cloudflare.com', 'Tina', 'Blinco', 'user', NULL, 1, 'https://i.pinimg.com/236x/a1/66/06/a166064b290b061beb1a048c15b9a180--all-things-buckets.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`, `image_url`) VALUES (10, 'pohanley9', 'LBdATXrBkGIj', 'pohanley9@usatoday.com', 'Perren', 'O\'Hanley', 'user', NULL, 1, 'https://i.pinimg.com/236x/a1/66/06/a166064b290b061beb1a048c15b9a180--all-things-buckets.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`, `image_url`) VALUES (11, 'mandresa', 'EenwXcpH', 'mandresa@bloglines.com', 'Merle', 'Andres', 'user', NULL, 1, 'https://i.pinimg.com/236x/a1/66/06/a166064b290b061beb1a048c15b9a180--all-things-buckets.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`, `image_url`) VALUES (12, 'sgordenb', 'z43vGJiWwk', 'sgordenb@acquirethisname.com', 'Silvia', 'Gorden', 'user', NULL, 1, 'https://i.pinimg.com/236x/a1/66/06/a166064b290b061beb1a048c15b9a180--all-things-buckets.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`, `image_url`) VALUES (13, 'bkirsoppc', 'pSdKqBJp', 'bkirsoppc@hugedomains.com', 'Beverie', 'Kirsopp', 'user', NULL, 1, 'https://i.pinimg.com/236x/a1/66/06/a166064b290b061beb1a048c15b9a180--all-things-buckets.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`, `image_url`) VALUES (14, 'kpittfordd', 'svo5i6XVv', 'kpittfordd@4shared.com', 'Kirstyn', 'Pittford', 'user', NULL, 1, 'https://i.pinimg.com/236x/a1/66/06/a166064b290b061beb1a048c15b9a180--all-things-buckets.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`, `image_url`) VALUES (15, 'aclemenzie', 'vBnrcW', 'aclemenzie@adobe.com', 'Arabel', 'Clemenzi', 'user', NULL, 1, 'https://i.pinimg.com/236x/a1/66/06/a166064b290b061beb1a048c15b9a180--all-things-buckets.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`, `image_url`) VALUES (16, 'lsinnockef', 'B9Q4o6UgxM', 'lsinnockef@nature.com', 'Lucita', 'Sinnocke', 'user', NULL, 1, 'https://i.pinimg.com/236x/a1/66/06/a166064b290b061beb1a048c15b9a180--all-things-buckets.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`, `image_url`) VALUES (17, 'mmackeggg', 'tc3zlK', 'mmackeggg@vkontakte.ru', 'Marcie', 'MacKegg', 'user', NULL, 1, 'https://i.pinimg.com/236x/a1/66/06/a166064b290b061beb1a048c15b9a180--all-things-buckets.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`, `image_url`) VALUES (18, 'cweinhamh', '7Vk3MhRzs', 'cweinhamh@mysql.com', 'Celestia', 'Weinham', 'user', NULL, 1, 'https://i.pinimg.com/236x/a1/66/06/a166064b290b061beb1a048c15b9a180--all-things-buckets.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`, `image_url`) VALUES (19, 'lcharteri', 'BXVzymjlQEHu', 'lcharteri@msn.com', 'Lorenzo', 'Charter', 'user', NULL, 1, 'https://i.pinimg.com/236x/a1/66/06/a166064b290b061beb1a048c15b9a180--all-things-buckets.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `date_created`, `is_active`, `image_url`) VALUES (20, 'nnordassj', 'ky75LT', 'nnordassj@scientificamerican.com', 'Nolan', 'Nordass', 'user', NULL, 1, 'https://i.pinimg.com/236x/a1/66/06/a166064b290b061beb1a048c15b9a180--all-things-buckets.jpg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `country`
-- -----------------------------------------------------
START TRANSACTION;
USE `bucketlistDB`;
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('AFG', 'Afghanistan, Islamic Republic of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ABW', 'Aruba', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('AGO', 'Angola, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('AIA', 'Anguilla', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ALB', 'Albania, Republic of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('AND', 'Andorra, Principality of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ANT', 'Netherlands Antilles', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ARE', 'United Arab Emirates', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ARG', 'Argentina, Argentine Republic', 'South America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ARM', 'Armenia, Republic of', 'Asia - Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ASM', 'American Samoa', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ATA', 'Antarctica (the territory South of 60 deg S)', 'Antarctica');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ATF', 'French Southern Territories', 'Antarctica');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ATG', 'Antigua and Barbuda', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('AUS', 'Australia, Commonwealth of', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('AUT', 'Austria, Republic of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('AZE', 'Azerbaijan, Republic of', 'Asia - Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BDI', 'Burundi, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BEL', 'Belgium, Kingdom of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BEN', 'Benin, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BES', 'Bonaire, Sint Eustatius and Saba', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BFA', 'Burkina Faso', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BGD', 'Bangladesh, People\'s Republic of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BGR', 'Bulgaria, Republic of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BHR', 'Bahrain, Kingdom of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BHS', 'Bahamas, Commonwealth of the', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BIH', 'Bosnia and Herzegovina', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BLM', 'Saint Barthelemy', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BLR', 'Belarus, Republic of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BLZ', 'Belize', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BMU', 'Bermuda', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BOL', 'Bolivia, Republic of', 'South America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BRA', 'Brazil, Federative Republic of', 'South America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BRB', 'Barbados', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BRN', 'Brunei Darussalam', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BTN', 'Bhutan, Kingdom of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BVT', 'Bouvet Island (Bouvetoya)', 'Antarctica');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('BWA', 'Botswana, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('CAF', 'Central African Republic', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('CAN', 'Canada', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('CCK', 'Cocos (Keeling) Islands', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('CHE', 'Switzerland, Swiss Confederation', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('CHL', 'Chile, Republic of', 'South America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('CHN', 'China, People\'s Republic of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('CIV', 'Cote d\'Ivoire, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('CMR', 'Cameroon, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('COD', 'Congo, Democratic Republic of the', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('COG', 'Congo, Republic of the', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('COK', 'Cook Islands', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('COL', 'Colombia, Republic of', 'South America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('COM', 'Comoros, Union of the', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('CPV', 'Cape Verde, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('CRI', 'Costa Rica, Republic of', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('CUB', 'Cuba, Republic of', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('CUW', 'CuraÃ§ao', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('CXR', 'Christmas Island', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('CYM', 'Cayman Islands', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('CYP', 'Cyprus, Republic of', 'Asia - Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('CZE', 'Czech Republic', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('DEU', 'Germany, Federal Republic of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('DJI', 'Djibouti, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('DMA', 'Dominica, Commonwealth of', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('DNK', 'Denmark, Kingdom of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('DOM', 'Dominican Republic', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('DZA', 'Algeria, People\'s Democratic Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ECU', 'Ecuador, Republic of', 'South America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('EGY', 'Egypt, Arab Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ERI', 'Eritrea, State of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ESH', 'Western Sahara', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ESP', 'Spain, Kingdom of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('EST', 'Estonia, Republic of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ETH', 'Ethiopia, Federal Democratic Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('FIN', 'Finland, Republic of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('FJI', 'Fiji, Republic of the Fiji Islands', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('FLK', 'Falkland Islands (Malvinas)', 'South America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('FRA', 'France, French Republic', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('FRO', 'Faroe Islands', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('FSM', 'Micronesia, Federated States of', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('GAB', 'Gabon, Gabonese Republic', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('GBR', 'United Kingdom of Great Britain & Northern Ireland', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('GEO', 'Georgia', 'Asia - Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('GGY', 'Guernsey, Bailiwick of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('GHA', 'Ghana, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('GIB', 'Gibraltar', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('GIN', 'Guinea, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('GLP', 'Guadeloupe', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('GMB', 'Gambia, Republic of the', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('GNB', 'Guinea-Bissau, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('GNQ', 'Equatorial Guinea, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('GRC', 'Greece, Hellenic Republic', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('GRD', 'Grenada', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('GRL', 'Greenland', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('GTM', 'Guatemala, Republic of', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('GUF', 'French Guiana', 'South America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('GUM', 'Guam', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('GUY', 'Guyana, Co-operative Republic of', 'South America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('HKG', 'Hong Kong, Special Administrative Region of China', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('HMD', 'Heard Island and McDonald Islands', 'Antarctica');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('HND', 'Honduras, Republic of', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('HRV', 'Croatia, Republic of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('HTI', 'Haiti, Republic of', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('HUN', 'Hungary, Republic of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('IDN', 'Indonesia, Republic of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('IMN', 'Isle of Man', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('IND', 'India, Republic of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('IOT', 'British Indian Ocean Territory (Chagos Archipelago)', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('IRL', 'Ireland', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('IRN', 'Iran, Islamic Republic of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('IRQ', 'Iraq, Republic of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ISL', 'Iceland, Republic of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ISR', 'Israel, State of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ITA', 'Italy, Italian Republic', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('JAM', 'Jamaica', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('JEY', 'Jersey, Bailiwick of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('JOR', 'Jordan, Hashemite Kingdom of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('JPN', 'Japan', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('KAZ', 'Kazakhstan, Republic of', 'Asia - Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('KEN', 'Kenya, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('KGZ', 'Kyrgyz Republic', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('KHM', 'Cambodia, Kingdom of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('KIR', 'Kiribati, Republic of', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('KNA', 'Saint Kitts and Nevis, Federation of', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('KOR', 'Korea, Republic of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('KWT', 'Kuwait, State of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('LAO', 'Lao People\'s Democratic Republic', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('LBN', 'Lebanon, Lebanese Republic', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('LBR', 'Liberia, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('LBY', 'Libyan Arab Jamahiriya', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('LCA', 'Saint Lucia', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('LIE', 'Liechtenstein, Principality of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('LKA', 'Sri Lanka, Democratic Socialist Republic of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('LSO', 'Lesotho, Kingdom of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('LTU', 'Lithuania, Republic of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('LUX', 'Luxembourg, Grand Duchy of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('LVA', 'Latvia, Republic of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MAC', 'Macao, Special Administrative Region of China', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MAF', 'Saint Martin', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MAR', 'Morocco, Kingdom of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MCO', 'Monaco, Principality of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MDA', 'Moldova, Republic of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MDG', 'Madagascar, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MDV', 'Maldives, Republic of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MEX', 'Mexico, United Mexican States', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MHL', 'Marshall Islands, Republic of the', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MKD', 'Macedonia, The Former Yugoslav Republic of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MLI', 'Mali, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MLT', 'Malta, Republic of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MMR', 'Myanmar, Union of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MNE', 'Montenegro, Republic of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MNG', 'Mongolia', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MNP', 'Northern Mariana Islands, Commonwealth of the', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MOZ', 'Mozambique, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MRT', 'Mauritania, Islamic Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MSR', 'Montserrat', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MTQ', 'Martinique', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MUS', 'Mauritius, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MWI', 'Malawi, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MYS', 'Malaysia', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('MYT', 'Mayotte', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('NAM', 'Namibia, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('NCL', 'New Caledonia', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('NER', 'Niger, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('NFK', 'Norfolk Island', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('NGA', 'Nigeria, Federal Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('NIC', 'Nicaragua, Republic of', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('NIU', 'Niue', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('NLD', 'Netherlands, Kingdom of the', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('NOR', 'Norway, Kingdom of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('NPL', 'Nepal, State of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('NRU', 'Nauru, Republic of', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('NZL', 'New Zealand', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('OMN', 'Oman, Sultanate of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('PAK', 'Pakistan, Islamic Republic of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('PAN', 'Panama, Republic of', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('PCN', 'Pitcairn Islands', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('PER', 'Peru, Republic of', 'South America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('PHL', 'Philippines, Republic of the', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('PLW', 'Palau, Republic of', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('PNG', 'Papua New Guinea, Independent State of', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('POL', 'Poland, Republic of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('PRI', 'Puerto Rico, Commonwealth of', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('PRK', 'Korea, Democratic People\'s Republic of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('PRT', 'Portugal, Portuguese Republic', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('PRY', 'Paraguay, Republic of', 'South America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('PSE', 'Palestinian Territory, Occupied', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('PYF', 'French Polynesia', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('QAT', 'Qatar, State of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('REU', 'Reunion', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ROU', 'Romania', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('RUS', 'Russian Federation', 'Asia - Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('RWA', 'Rwanda, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SAU', 'Saudi Arabia, Kingdom of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SDN', 'Sudan, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SEN', 'Senegal, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SGP', 'Singapore, Republic of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SGS', 'South Georgia and the South Sandwich Islands', 'Antarctica');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SHN', 'Saint Helena', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SJM', 'Svalbard & Jan Mayen Islands', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SLB', 'Solomon Islands', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SLE', 'Sierra Leone, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SLV', 'El Salvador, Republic of', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SMR', 'San Marino, Republic of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SOM', 'Somalia, Somali Republic', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SPM', 'Saint Pierre and Miquelon', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SRB', 'Serbia, Republic of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SSD', 'South Sudan', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('STP', 'Sao Tome and Principe, Democratic Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SUR', 'Suriname, Republic of', 'South America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SVK', 'Slovakia (Slovak Republic)', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SVN', 'Slovenia, Republic of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SWE', 'Sweden, Kingdom of', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SWZ', 'Swaziland, Kingdom of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SXM', 'Sint Maarten (Netherlands)', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SYC', 'Seychelles, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('SYR', 'Syrian Arab Republic', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('TCA', 'Turks and Caicos Islands', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('TCD', 'Chad, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('TGO', 'Togo, Togolese Republic', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('THA', 'Thailand, Kingdom of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('TJK', 'Tajikistan, Republic of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('TKL', 'Tokelau', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('TKM', 'Turkmenistan', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('TLS', 'Timor-Leste, Democratic Republic of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('TON', 'Tonga, Kingdom of', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('TTO', 'Trinidad and Tobago, Republic of', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('TUN', 'Tunisia, Tunisian Republic', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('TUR', 'Turkey, Republic of', 'Asia - Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('TUV', 'Tuvalu', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('TWN', 'Taiwan', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('TZA', 'Tanzania, United Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('UGA', 'Uganda, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('UKR', 'Ukraine', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('URY', 'Uruguay, Eastern Republic of', 'South America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('USA', 'United States of America', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('UZB', 'Uzbekistan, Republic of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('VAT', 'Holy See (Vatican City State)', 'Europe');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('VCT', 'Saint Vincent and the Grenadines', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('VEN', 'Venezuela, Bolivarian Republic of', 'South America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('VGB', 'British Virgin Islands', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('VIR', 'United States Virgin Islands', 'North America');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('VNM', 'Vietnam, Socialist Republic of', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('VUT', 'Vanuatu, Republic of', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('WLF', 'Wallis and Futuna', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('WSM', 'Samoa, Independent State of', 'Oceania');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('YEM', 'Yemen', 'Asia');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ZAF', 'South Africa, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ZMB', 'Zambia, Republic of', 'Africa');
INSERT INTO `country` (`country_code`, `country_name`, `continent`) VALUES ('ZWE', 'Zimbabwe, Republic of', 'Africa');

COMMIT;


-- -----------------------------------------------------
-- Data for table `location`
-- -----------------------------------------------------
START TRANSACTION;
USE `bucketlistDB`;
INSERT INTO `location` (`id`, `city_area`, `specific_location`, `country_code`) VALUES (1, 'Paris', NULL, 'FRA');
INSERT INTO `location` (`id`, `city_area`, `specific_location`, `country_code`) VALUES (2, 'Colorado', 'Aspen', 'USA');

COMMIT;


-- -----------------------------------------------------
-- Data for table `bucket_item`
-- -----------------------------------------------------
START TRANSACTION;
USE `bucketlistDB`;
INSERT INTO `bucket_item` (`id`, `name`, `description`, `location_id`, `created_by_user`, `date_created`, `date_updated`, `is_public_at_creation`, `is_active`, `image_url`) VALUES (1, 'Climb the Eiffel Tower', 'Lookout from the top of the Eiffel Tower', 1, 6, NULL, NULL, 1, 1, 'data:image/jpeg;base64,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');
INSERT INTO `bucket_item` (`id`, `name`, `description`, `location_id`, `created_by_user`, `date_created`, `date_updated`, `is_public_at_creation`, `is_active`, `image_url`) VALUES (2, 'Hunt a Moose', 'Fill the freezer', 2, 7, NULL, NULL, 0, 1, 'https://cdn.britannica.com/57/92857-050-8D5A0A8E/bull-moose-water.jpg');
INSERT INTO `bucket_item` (`id`, `name`, `description`, `location_id`, `created_by_user`, `date_created`, `date_updated`, `is_public_at_creation`, `is_active`, `image_url`) VALUES (3, 'Go Skydiving', 'Don\'t forget to open the parachute', NULL, 8, NULL, NULL, 1, 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSp54UYy6ERJFWFPYY1RAmBwn0XDY44HJdxTg&usqp=CAU');

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `bucketlistDB`;
INSERT INTO `comment` (`id`, `comment_text`, `date_created`, `date_updated`, `user_id`, `bucket_item_id`, `image_url`) VALUES (1, 'Roaring Fork Valley is full of moose', NULL, NULL, 1, 2, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `category`
-- -----------------------------------------------------
START TRANSACTION;
USE `bucketlistDB`;
INSERT INTO `category` (`id`, `category_name`) VALUES (1, 'Just For Fun');
INSERT INTO `category` (`id`, `category_name`) VALUES (2, 'Food');
INSERT INTO `category` (`id`, `category_name`) VALUES (3, 'Travel');
INSERT INTO `category` (`id`, `category_name`) VALUES (4, 'Adventure');
INSERT INTO `category` (`id`, `category_name`) VALUES (5, 'Fitness');
INSERT INTO `category` (`id`, `category_name`) VALUES (6, 'Sports');
INSERT INTO `category` (`id`, `category_name`) VALUES (7, 'Music');
INSERT INTO `category` (`id`, `category_name`) VALUES (8, 'Hobbies');
INSERT INTO `category` (`id`, `category_name`) VALUES (9, 'Entertainment');
INSERT INTO `category` (`id`, `category_name`) VALUES (10, 'Personal Development');
INSERT INTO `category` (`id`, `category_name`) VALUES (11, 'Education');
INSERT INTO `category` (`id`, `category_name`) VALUES (12, 'Financial');
INSERT INTO `category` (`id`, `category_name`) VALUES (13, 'Relationships');
INSERT INTO `category` (`id`, `category_name`) VALUES (14, 'Lifestyle');
INSERT INTO `category` (`id`, `category_name`) VALUES (15, 'Spirituality');
INSERT INTO `category` (`id`, `category_name`) VALUES (16, 'Contributions');
INSERT INTO `category` (`id`, `category_name`) VALUES (17, 'Miscellaneous');
INSERT INTO `category` (`id`, `category_name`) VALUES (DEFAULT, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_bucket_item`
-- -----------------------------------------------------
START TRANSACTION;
USE `bucketlistDB`;
INSERT INTO `user_bucket_item` (`id`, `bucket_item_id`, `user_id`, `date_added`, `date_completed`, `target_date`, `is_completed`) VALUES (1, 1, 2, NULL, NULL, NULL, 0);
INSERT INTO `user_bucket_item` (`id`, `bucket_item_id`, `user_id`, `date_added`, `date_completed`, `target_date`, `is_completed`) VALUES (2, 2, 2, NULL, NULL, NULL, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `poll`
-- -----------------------------------------------------
START TRANSACTION;
USE `bucketlistDB`;
INSERT INTO `poll` (`id`, `rating_stars`, `cost_dollar_signs`, `best_time_todo`, `bucket_item_id`, `user_id`, `date_created`, `date_updated`) VALUES (1, NULL, NULL, 'Fall', 2, 1, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `resource`
-- -----------------------------------------------------
START TRANSACTION;
USE `bucketlistDB`;
INSERT INTO `resource` (`id`, `url`, `user_bucket_item`) VALUES (1, 'https://cpw.state.co.us/moose-country', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `note`
-- -----------------------------------------------------
START TRANSACTION;
USE `bucketlistDB`;
INSERT INTO `note` (`id`, `note_title`, `note_text`, `user_bucket_item_id`) VALUES (1, 'Get Tag', 'Apply for big game tag', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `bucket_item_has_category`
-- -----------------------------------------------------
START TRANSACTION;
USE `bucketlistDB`;
INSERT INTO `bucket_item_has_category` (`bucket_item_id`, `category_id`) VALUES (3, 4);
INSERT INTO `bucket_item_has_category` (`bucket_item_id`, `category_id`) VALUES (1, 3);
INSERT INTO `bucket_item_has_category` (`bucket_item_id`, `category_id`) VALUES (2, 17);

COMMIT;

