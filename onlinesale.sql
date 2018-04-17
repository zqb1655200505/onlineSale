/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50715
Source Host           : localhost:3306
Source Database       : onlinesale

Target Server Type    : MYSQL
Target Server Version : 50715
File Encoding         : 65001

Date: 2018-04-17 21:40:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment` (
  `id` varchar(63) NOT NULL,
  `goods_id` varchar(63) NOT NULL,
  `father_id` varchar(63) NOT NULL COMMENT '外键本表',
  `user_id` varchar(63) DEFAULT NULL,
  `comment` varchar(511) NOT NULL,
  `comment_time` datetime DEFAULT NULL,
  `have_children` bit(2) DEFAULT NULL COMMENT '默认为0；0-没有',
  `level` int(255) DEFAULT NULL,
  `delete_flag` binary(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_comment
-- ----------------------------

-- ----------------------------
-- Table structure for t_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_goods`;
CREATE TABLE `t_goods` (
  `id` varchar(63) NOT NULL,
  `goods_name` varchar(255) NOT NULL,
  `user_id` varchar(63) NOT NULL COMMENT '所属商家',
  `goods_num` int(11) NOT NULL,
  `goods_pic` varchar(255) DEFAULT NULL,
  `goods_price` decimal(10,2) DEFAULT NULL,
  `goods_description` varchar(511) DEFAULT NULL,
  `delete_flag` binary(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_goods
-- ----------------------------

-- ----------------------------
-- Table structure for t_message
-- ----------------------------
DROP TABLE IF EXISTS `t_message`;
CREATE TABLE `t_message` (
  `id` varchar(63) NOT NULL,
  `send_user` varchar(63) NOT NULL,
  `receive_user` varchar(63) NOT NULL,
  `send_time` datetime DEFAULT NULL,
  `message` varchar(511) NOT NULL,
  `delete_flag` binary(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message
-- ----------------------------

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `id` varchar(63) NOT NULL,
  `buyer` varchar(63) NOT NULL,
  `goods_num` int(11) DEFAULT NULL,
  `order_price` decimal(10,2) DEFAULT NULL,
  `order_time` datetime DEFAULT NULL,
  `delete_flag` binary(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order
-- ----------------------------

-- ----------------------------
-- Table structure for t_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_order_goods`;
CREATE TABLE `t_order_goods` (
  `id` varchar(63) NOT NULL,
  `order_id` varchar(63) NOT NULL,
  `goods_id` varchar(63) DEFAULT NULL,
  `goods_num` int(11) DEFAULT NULL,
  `is_seckill` bit(2) NOT NULL,
  `delete_flag` binary(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order_goods
-- ----------------------------

-- ----------------------------
-- Table structure for t_seckill
-- ----------------------------
DROP TABLE IF EXISTS `t_seckill`;
CREATE TABLE `t_seckill` (
  `id` varchar(63) NOT NULL,
  `goods_id` varchar(63) NOT NULL,
  `rest_num` int(11) NOT NULL,
  `seckill_price` decimal(10,2) NOT NULL,
  `seckill_begin_time` datetime NOT NULL,
  `seckill_end_time` datetime NOT NULL,
  `delete_flag` binary(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_seckill
-- ----------------------------

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` varchar(63) NOT NULL,
  `user_name` varchar(63) NOT NULL,
  `user_password` varchar(63) NOT NULL,
  `user_type` tinyint(2) NOT NULL,
  `user_pic` varchar(255) DEFAULT NULL,
  `user_mobile` varchar(16) DEFAULT NULL,
  `delete_flag` binary(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('207c60fcefeb401baef63d3ee011aa16', 'zqb', 'e10adc3949ba59abbe56e057f20f883e', '0', '/upload/image/defaultAvatar.jpg', null, 0x31);
INSERT INTO `t_user` VALUES ('c1409d9c3b794b91867144e2aba05304', 'zqb1', 'e10adc3949ba59abbe56e057f20f883e', '1', '/upload/image/defaultAvatar.jpg', null, 0x31);
