START TRANSACTION;

CREATE TABLE `channels` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE `genres` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE `programs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE `seasons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `program_id` int NOT NULL,
  `season_number` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `season_program_id` (`program_id`),
  CONSTRAINT `fk_season_program_id` FOREIGN KEY (`program_id`) REFERENCES `programs` (`id`)
) ENGINE=InnoDB;


CREATE TABLE `episodes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `season_id` int DEFAULT NULL,
  `episode_number` int DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `duration_min` int NOT NULL,
  `release_date` date DEFAULT NULL,
  `views` int DEFAULT NULL,
  `is_singleEp` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `episode_season_id` (`season_id`),
  CONSTRAINT `fk_episode_season_id` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB;


CREATE TABLE `program_genres` (
  `id` int NOT NULL AUTO_INCREMENT,
  `program_id` int NOT NULL,
  `genre_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `program_genre_unique` (`program_id`, `genre_id`),
  KEY `program_genre_program_id` (`program_id`),
  KEY `program_genre_genre_id` (`genre_id`),
  CONSTRAINT `fk_program_genre_program_id` FOREIGN KEY (`program_id`) REFERENCES `programs` (`id`),
  CONSTRAINT `fk_program_genre_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`)
) ENGINE=InnoDB;

CREATE TABLE `channel_programs` (
   `id` int NOT NULL AUTO_INCREMENT,
  `channel_id` int NOT NULL,
  `episode_id` int NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `views` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `channel_programs_channel_id` (`channel_id`),
  KEY `channel_programs_episode_id` (`episode_id`),
  CONSTRAINT `fk_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`),
  CONSTRAINT `fk_episode_id` FOREIGN KEY (`episode_id`) REFERENCES `episodes` (`id`)
) ENGINE=InnoDB;

COMMIT;