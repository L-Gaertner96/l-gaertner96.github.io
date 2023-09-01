-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pawsome_forum
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pawsome_forum
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pawsome_forum
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pawsome_forum` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `pawsome_forum` ;

-- -----------------------------------------------------
-- Table `pawsome_forum`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pawsome_forum`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pawsome_forum`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pawsome_forum`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(15) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `password` VARCHAR(256) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pawsome_forum`.`subcategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pawsome_forum`.`subcategories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `subcat_name` VARCHAR(45) NULL DEFAULT NULL,
  `categories_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subcategories_categories_idx` (`categories_id` ASC) VISIBLE,
  CONSTRAINT `fk_subcategories_categories`
    FOREIGN KEY (`categories_id`)
    REFERENCES `pawsome_forum`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pawsome_forum`.`posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pawsome_forum`.`posts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NULL DEFAULT NULL,
  `body` VARCHAR(8000) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `subcategories_id` INT NOT NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_posts_subcategories1_idx` (`subcategories_id` ASC) VISIBLE,
  INDEX `fk_posts_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_posts_subcategories1`
    FOREIGN KEY (`subcategories_id`)
    REFERENCES `pawsome_forum`.`subcategories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_posts_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `pawsome_forum`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pawsome_forum`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pawsome_forum`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(8000) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `users_id` INT NOT NULL,
  `posts_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comments_users1_idx` (`users_id` ASC) VISIBLE,
  INDEX `fk_comments_posts1_idx` (`posts_id` ASC) VISIBLE,
  CONSTRAINT `fk_comments_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `pawsome_forum`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_posts1`
    FOREIGN KEY (`posts_id`)
    REFERENCES `pawsome_forum`.`posts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
