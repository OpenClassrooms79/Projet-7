CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` int NOT NULL,
  `enabled` tinyint unsigned NOT NULL,
  `contract` varchar(100) DEFAULT NULL,
  `entry_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `project` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `deadline` date DEFAULT NULL,
  `archived` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `status_project_FK` (`project_id`),
  CONSTRAINT `status_project_FK` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `task` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` text,
  `deadline` date DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `status_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `task_project_FK` (`project_id`),
  KEY `task_user_FK` (`user_id`),
  KEY `task_status_FK` (`status_id`),
  CONSTRAINT `task_project_FK` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `task_status_FK` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`),
  CONSTRAINT `task_user_FK` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `timeslot` (
  `id` int NOT NULL AUTO_INCREMENT,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `task_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `timeslot_task_FK` (`task_id`),
  KEY `timeslot_user_FK` (`user_id`),
  CONSTRAINT `timeslot_task_FK` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`),
  CONSTRAINT `timeslot_user_FK` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `project_user` (
  `project_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`project_id`,`user_id`),
  KEY `project_user_user_FK` (`user_id`),
  CONSTRAINT `project_user_project_FK` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `project_user_user_FK` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `task_tag` (
  `task_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`task_id`,`tag_id`),
  KEY `task_tag_tag_FK` (`tag_id`),
  CONSTRAINT `task_tag_tag_FK` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`),
  CONSTRAINT `task_tag_task_FK` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


