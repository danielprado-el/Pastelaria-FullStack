CREATE TABLE `pastelaria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pasteis` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` varchar(510) NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  `imagem1` varchar(255) NOT NULL,
  `imagem2` varchar(255) DEFAULT NULL,
  `pastelaria` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_produtos_pastelaria_idx` (`pastelaria`),
  CONSTRAINT `fk_pasteis_pastelaria` FOREIGN KEY (`pastelaria`) REFERENCES `pastelaria` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `feeds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` datetime NOT NULL,
  `pastel` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_feeds_pasteis_idx` (`pastel`),
  CONSTRAINT `fk_feeds_pasteis` FOREIGN KEY (`pastel`) REFERENCES `pasteis` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `comentarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comentario` varchar(510) NOT NULL,
  `feed` int NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `conta` varchar(255) NOT NULL,
  `data` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_feed_idx` (`feed`),
  CONSTRAINT `fk_comentarios_feeds` FOREIGN KEY (`feed`) REFERENCES `feeds` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `feed` int NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_likes_feeds_idx` (`feed`),
  CONSTRAINT `fk_likes_feeds` FOREIGN KEY (`feed`) REFERENCES `feeds` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `pastelaria` VALUES (1,'Pastelaria','pastelLogo.png');
INSERT INTO `pasteis` VALUES (1,'Pastel de queijo','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',5.00,'pastel.jpg','pastel2.jpg',1),(2,'Pastel de frango','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',5.00,'pastel.jpg','pastel2.jpg',1),(3,'Pastel de carne','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',5.00,'pastel.jpg','pastel2.jpg',1),(4,'Pastel de\n calabresa','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',5.00,'pastel.jpg','pastel2.jpg',1),(5,'Pastel sabor pizza','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',5.00,'pastel.jpg','pastel2.jpg',1),(6,'Pastel de camarão','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',5.00,'pastel.jpg','pastel2.jpg',1),(7,'Pastel de queijo\n com goiabada','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',5.00,'pastel.jpg','pastel2.jpg',1),(8,'Pastel de\n brigadeiro','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',5.00,'pastel.jpg','pastel2.jpg',1);
INSERT INTO `feeds` VALUES (1,'2021-04-15 18:21:11',1),(2,'2021-04-16 18:21:11',2),(3,'2021-04-17 18:21:11',3),(4,'2021-04-18 18:21:11',4),(5,'2021-04-19 18:21:11',5),(6,'2021-04-20 18:21:11',6),(7,'2021-04-21 18:21:11',7),(8,'2021-04-22 18:21:11',8);
INSERT INTO `comentarios` VALUES (1,'teste',1,'Anônimo','anonimo@gmail.com','2021-04-16 21:32:35');
INSERT INTO `likes` VALUES (1,1,'anonimo@gmail.com');
