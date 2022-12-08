-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.30 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para redsocial
CREATE DATABASE IF NOT EXISTS `redsocial` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `redsocial`;

-- Volcando estructura para tabla redsocial.comentario
CREATE TABLE IF NOT EXISTS `comentario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `contenido` varchar(250) NOT NULL,
  `usuario_mail` varchar(60) NOT NULL,
  `publicacion_id` int NOT NULL,
  PRIMARY KEY (`id`,`usuario_mail`,`publicacion_id`),
  KEY `fk_comentario_usuario1_idx` (`usuario_mail`),
  KEY `fk_comentario_publicacion1_idx` (`publicacion_id`),
  CONSTRAINT `fk_comentario_publicacion1` FOREIGN KEY (`publicacion_id`) REFERENCES `publicacion` (`id`),
  CONSTRAINT `fk_comentario_usuario1` FOREIGN KEY (`usuario_mail`) REFERENCES `usuario` (`mail`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para procedimiento redsocial.Guardar_usuario
DELIMITER //
CREATE PROCEDURE `Guardar_usuario`(correo VARCHAR(60),name VARCHAR(45),apater VARCHAR (45),amater VARCHAR(45),cumple DATE,sexo VARCHAR (1) ,apodo VARCHAR (15),contrasena VARCHAR(16))
BEGIN

	INSERT INTO usuario VALUES (correo,name,apater,amater,cumple,sexo,apodo,contrasena);
	
	END//
DELIMITER ;

-- Volcando estructura para tabla redsocial.likes
CREATE TABLE IF NOT EXISTS `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `publicacion_id` int NOT NULL,
  `usuario_mail` varchar(60) NOT NULL,
  PRIMARY KEY (`id`,`publicacion_id`,`usuario_mail`),
  KEY `fk_likes_publicacion1_idx` (`publicacion_id`),
  KEY `fk_likes_usuario1_idx` (`usuario_mail`),
  CONSTRAINT `fk_likes_publicacion1` FOREIGN KEY (`publicacion_id`) REFERENCES `publicacion` (`id`),
  CONSTRAINT `fk_likes_usuario1` FOREIGN KEY (`usuario_mail`) REFERENCES `usuario` (`mail`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para procedimiento redsocial.login
DELIMITER //
CREATE PROCEDURE `login`(IN correo VARCHAR(60),IN contraseña VARCHAR(16))
BEGIN

	SELECT nombre FROM usuario WHERE mail = correo AND password = contraseña; 
	
	END//
DELIMITER ;

-- Volcando estructura para procedimiento redsocial.me_gusta
DELIMITER //
CREATE PROCEDURE `me_gusta`(publicacion INT,mailusuario VARCHAR (60))
BEGIN
	
	INSERT INTO likes(publicacion_id,usuario_mail) VALUES (publicacion,mailusuario);
	
END//
DELIMITER ;

-- Volcando estructura para tabla redsocial.publicacion
CREATE TABLE IF NOT EXISTS `publicacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `contenido` varchar(300) NOT NULL,
  `fecha` datetime NOT NULL,
  `usuariomail` varchar(60) NOT NULL,
  PRIMARY KEY (`id`,`usuariomail`),
  KEY `fk_publicacion_usuario1_idx` (`usuariomail`),
  CONSTRAINT `fk_publicacion_usuario1` FOREIGN KEY (`usuariomail`) REFERENCES `usuario` (`mail`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para procedimiento redsocial.seguimiento
DELIMITER //
CREATE PROCEDURE `seguimiento`(usuario1 VARCHAR(60),usuario2 VARCHAR(60))
BEGIN
	INSERT INTO sigue VALUES(usuario1,usuario2);
	
END//
DELIMITER ;

-- Volcando estructura para tabla redsocial.sigue
CREATE TABLE IF NOT EXISTS `sigue` (
  `mail1` varchar(60) NOT NULL,
  `mail2` varchar(60) NOT NULL,
  PRIMARY KEY (`mail1`,`mail2`),
  KEY `fk_usuario_has_usuario_usuario1_idx` (`mail2`),
  KEY `fk_usuario_has_usuario_usuario_idx` (`mail1`),
  CONSTRAINT `fk_usuario_has_usuario_usuario` FOREIGN KEY (`mail1`) REFERENCES `usuario` (`mail`),
  CONSTRAINT `fk_usuario_has_usuario_usuario1` FOREIGN KEY (`mail2`) REFERENCES `usuario` (`mail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla redsocial.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `mail` varchar(60) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `appaterno` varchar(45) NOT NULL,
  `apmaterno` varchar(45) DEFAULT NULL,
  `fnacimiento` date NOT NULL,
  `genero` varchar(1) NOT NULL,
  `nickname` varchar(15) NOT NULL,
  `password` varchar(16) NOT NULL,
  PRIMARY KEY (`mail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
