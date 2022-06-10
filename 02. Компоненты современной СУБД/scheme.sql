-- Adminer 4.8.1 MySQL 8.0.29 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;

DROP DATABASE IF EXISTS `myshop`;
CREATE DATABASE `myshop` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `myshop`;

DROP TABLE IF EXISTS `Customer`;
CREATE TABLE `Customer` (
                            `Id` int NOT NULL AUTO_INCREMENT,
                            `Firstname` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
                            `Secondname` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
                            `Middlename` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
                            `Phone` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
                            PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `CustomerAddress`;
CREATE TABLE `CustomerAddress` (
                                   `Id` int NOT NULL AUTO_INCREMENT,
                                   `PostIndex` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
                                   `Country` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
                                   `City` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
                                   `Street` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
                                   `Building` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
                                   `Apartment` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
                                   `Comment` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
                                   PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `Customer_CustomerAddress`;
CREATE TABLE `Customer_CustomerAddress` (
                                            `Id` int NOT NULL AUTO_INCREMENT,
                                            `CustomerId` int NOT NULL,
                                            `CustomerAddressId` int NOT NULL,
                                            PRIMARY KEY (`Id`),
                                            KEY `FK_96` (`CustomerId`),
                                            KEY `FK_99` (`CustomerAddressId`),
                                            CONSTRAINT `FK_Customer_CustomerAddress` FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`Id`),
                                            CONSTRAINT `FK_CustomerAddress_Customer` FOREIGN KEY (`CustomerAddressId`) REFERENCES `CustomerAddress` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `Manufacturer`;
CREATE TABLE `Manufacturer` (
                                `Id` int NOT NULL AUTO_INCREMENT,
                                `Name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
                                `Phone` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
                                `Address` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
                                PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `Order`;
CREATE TABLE `Order` (
                         `Id` int NOT NULL AUTO_INCREMENT,
                         `CreatedAt` datetime NOT NULL,
                         `CustomerId` int NOT NULL,
                         `Status` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
                         `Address` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
                         `FinishedAt` datetime DEFAULT NULL,
                         PRIMARY KEY (`Id`),
                         KEY `FK_118` (`CustomerId`),
                         CONSTRAINT `FK_Customer_Order` FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `OrderItem`;
CREATE TABLE `OrderItem` (
                             `Id` int NOT NULL AUTO_INCREMENT,
                             `Quantity` int NOT NULL,
                             `OrderId` int NOT NULL,
                             `ProductId` int NOT NULL,
                             `Price` decimal(10,0) NOT NULL,
                             PRIMARY KEY (`Id`),
                             KEY `FK_126` (`ProductId`),
                             KEY `FK_129` (`OrderId`),
                             CONSTRAINT `FK_OrderItem_Order` FOREIGN KEY (`OrderId`) REFERENCES `Order` (`Id`),
                             CONSTRAINT `FK_OrderItem_Product` FOREIGN KEY (`ProductId`) REFERENCES `Product` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `Price`;
CREATE TABLE `Price` (
                         `Id` int NOT NULL AUTO_INCREMENT,
                         `Value` decimal(10,0) NOT NULL,
                         `ProductId` int NOT NULL,
                         `Discount` decimal(10,0) NOT NULL,
                         PRIMARY KEY (`Id`),
                         KEY `FK_105` (`ProductId`),
                         CONSTRAINT `FK_Price_Product` FOREIGN KEY (`ProductId`) REFERENCES `Product` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `Product`;
CREATE TABLE `Product` (
                           `Id` int NOT NULL AUTO_INCREMENT,
                           `Name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
                           `SupplierId` int NOT NULL,
                           `ManufacturerId` int NOT NULL,
                           `IsInStock` bit(1) NOT NULL,
                           `Description` varchar(2048) COLLATE utf8_unicode_ci NOT NULL,
                           `PhotoUrl` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
                           `Code` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
                           PRIMARY KEY (`Id`),
                           KEY `FK` (`ManufacturerId`),
                           KEY `FK_79` (`SupplierId`),
                           CONSTRAINT `FK_Product_Manufacturer` FOREIGN KEY (`ManufacturerId`) REFERENCES `Manufacturer` (`Id`),
                           CONSTRAINT `FK_Product_Supplier` FOREIGN KEY (`SupplierId`) REFERENCES `Supplier` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `ProductCategory`;
CREATE TABLE `ProductCategory` (
                                   `Id` int NOT NULL AUTO_INCREMENT,
                                   `Name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
                                   PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `Product_ProductCategory`;
CREATE TABLE `Product_ProductCategory` (
                                           `Id` int NOT NULL AUTO_INCREMENT,
                                           `ProductId` int NOT NULL,
                                           `CategoryId` int NOT NULL,
                                           PRIMARY KEY (`Id`),
                                           KEY `FK_57` (`ProductId`),
                                           KEY `FK_65` (`CategoryId`),
                                           CONSTRAINT `FK_Product_ProductCategory` FOREIGN KEY (`ProductId`) REFERENCES `Product` (`Id`),
                                           CONSTRAINT `FK_ProductCategory_Product` FOREIGN KEY (`CategoryId`) REFERENCES `ProductCategory` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `Supplier`;
CREATE TABLE `Supplier` (
                            `Id` int NOT NULL AUTO_INCREMENT,
                            `Name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
                            `Phone` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
                            PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


-- 2022-06-10 15:59:40