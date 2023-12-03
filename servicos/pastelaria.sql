DROP TABLE IF EXISTS `comentarios`;

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


LOCK TABLES `comentarios` WRITE;

INSERT INTO `comentarios` VALUES (1,'teste',1,'Luis Paulo','luispscarvalho@gmail.com','2021-04-16 21:32:35');

UNLOCK TABLES;

DROP TABLE IF EXISTS `pastelaria`;

CREATE TABLE `pastelaria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `pastelaria` WRITE;

INSERT INTO `pastelaria` VALUES (1,'Pastelaria','pasteLogo.png');
UNLOCK TABLES;

DROP TABLE IF EXISTS `feeds`;

CREATE TABLE `feeds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` datetime NOT NULL,
  `pastel` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_feeds_pasteis_idx` (`pastel`),
  CONSTRAINT `fk_feeds_pasteis` FOREIGN KEY (`pastel`) REFERENCES `pasteis` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `feeds` WRITE;
INSERT INTO `feeds` VALUES (1,'2021-04-14 18:21:11',1),(2,'2021-04-14 18:21:11',2),(3,'2021-04-14 18:21:11',3),(4,'2021-04-14 18:21:11',4),(5,'2021-04-14 18:21:11',5),(6,'2021-04-14 18:21:11',6),(7,'2021-04-14 18:21:11',7);
UNLOCK TABLES;


DROP TABLE IF EXISTS `likes`;

CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `feed` int NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_likes_feeds_idx` (`feed`),
  CONSTRAINT `fk_likes_feeds` FOREIGN KEY (`feed`) REFERENCES `feeds` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `likes` WRITE;

INSERT INTO `likes` VALUES (8,1,'luispscarvalho@gmail.com');

UNLOCK TABLES;


DROP TABLE IF EXISTS `produtos`;

CREATE TABLE `pasteis` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` varchar(510) NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  `imagem1` varchar(255) NOT NULL,
  `imagem2` varchar(255) DEFAULT NULL,
  `imagem3` varchar(255) DEFAULT NULL,
  `pastelaria` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_produtos_pastelaria_idx` (`pastelaria`),
  CONSTRAINT `fk_pasteis_pastelaria` FOREIGN KEY (`pastelaria`) REFERENCES `pastelaria` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `pasteis` WRITE;

INSERT INTO `pasteis` VALUES (1,'Pastel de queijo','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',5.00,'pastel1.jpeg','pastel2.jpeg',1),(2,'Pastel de frango','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',5.00,'pastel1.jpeg','pastel2.jpeg',1),(3,'Pastel de carne','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',5.00,'pastel1.jpeg','pastel2.jpeg',1),(4,'Pastel de calabresa','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',5.00,'pastel1.jpeg','pastel2.jpeg',1),(5,'Pastel sabor pizza','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',5.00,'pastel1.jpeg','pastel2.jpeg',1),(6,'Pastel de camarão','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',5.00,'pastel1.jpeg','pastel2.jpeg',1),(7,'Pastel de queijo com goiabada','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',5.00,'pastel1.jpeg','pastel2.jpeg',1),(8,'Pastel de brigadeiro','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',5.00,'pastel1.jpeg','pastel2.jpeg',1),(9,'Pastel de banana','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',5.00,'pastel1.jpeg','pastel2.jpeg',1),(10,'Pastel de doce de leite','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',5.00,'pastel1.jpeg','pastel2.jpeg',1);

UNLOCK TABLES;

