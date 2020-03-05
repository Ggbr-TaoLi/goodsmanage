/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : localhost:3306
 Source Schema         : goodsmanage

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 05/03/2020 09:31:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `goods_Id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_Name` varchar(255) DEFAULT NULL,
  `goods_Unit` varchar(255) DEFAULT NULL,
  `goods_Num` int(11) DEFAULT NULL,
  `goods_Type` int(11) NOT NULL,
  `goods_Desc` varchar(255) DEFAULT NULL,
  `goods_Date` date DEFAULT NULL,
  PRIMARY KEY (`goods_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------
BEGIN;
INSERT INTO `goods` VALUES (1, '联想电脑', '台', 6, 1, '啦啦啦啦啦', '2020-03-16');
INSERT INTO `goods` VALUES (2, '钢笔', '支', 10, 2, '啦啦啦啦啦', '2020-03-02');
INSERT INTO `goods` VALUES (3, 'iPhoneX', '部', 10, 3, '啦啦啦啦啦啦', '2020-03-02');
INSERT INTO `goods` VALUES (4, 'Mac电脑', '台', 9, 1, '啦啦啦啦啦', '2020-03-08');
INSERT INTO `goods` VALUES (6, '铅笔', '支', 10, 2, '啦啦啦啦啦', '2020-03-02');
COMMIT;

-- ----------------------------
-- Table structure for records
-- ----------------------------
DROP TABLE IF EXISTS `records`;
CREATE TABLE `records` (
  `records_Id` int(11) NOT NULL AUTO_INCREMENT,
  `records_Goods` int(11) DEFAULT NULL,
  `records_Name` varchar(255) DEFAULT NULL,
  `records_Date` date DEFAULT NULL,
  `records_Num` int(11) DEFAULT NULL,
  `records_Desc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`records_Id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of records
-- ----------------------------
BEGIN;
INSERT INTO `records` VALUES (1, 1, '张三', '2020-03-11', 1, '啦啦啦啦啦');
INSERT INTO `records` VALUES (2, 1, '小刚', '2020-03-09', 2, '啦啦啦啦啦啦');
INSERT INTO `records` VALUES (3, 2, '小王', '2020-03-10', 2, '哈哈哈哈哈哈哈');
INSERT INTO `records` VALUES (4, 4, '小倩', '2020-03-10', 1, '哈哈哈哈哈哈哈哈哈哈哈');
INSERT INTO `records` VALUES (5, 1, '小红', '2020-03-03', 1, '啦啦啦啦啦');
INSERT INTO `records` VALUES (6, 1, '小刚', '2020-03-01', 1, '发发发发发');
COMMIT;

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type` (
  `type_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '种类id',
  `type_Name` varchar(255) NOT NULL COMMENT '种类名称',
  PRIMARY KEY (`type_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of type
-- ----------------------------
BEGIN;
INSERT INTO `type` VALUES (1, '电脑');
INSERT INTO `type` VALUES (2, '办公用品');
INSERT INTO `type` VALUES (3, '配件');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
