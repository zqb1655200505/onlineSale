/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50715
Source Host           : localhost:3306
Source Database       : onlinesale

Target Server Type    : MYSQL
Target Server Version : 50715
File Encoding         : 65001

Date: 2018-06-05 11:23:28
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
INSERT INTO `t_goods` VALUES ('3ada14e323ca43f0891d5e2d05976cc5', '三星(SAMSUNG) 860 EVO 500G SATA3 固态硬盘', 'c0e536f2adb240d1bda981f31e42dec7', '20000', '/upload/goods/c0e536f2adb240d1bda981f31e42dec7/487b5c598a914ef28e4630b1e0c69691.jpg', '1149.00', '（MZ-76E500B）', 0x31);
INSERT INTO `t_goods` VALUES ('437f12bfcf0e4943a409692c857857f2', '华为 HUAWEI P20 Pro', 'c1409d9c3b794b91867144e2aba05304', '23200', '/upload/goods/c1409d9c3b794b91867144e2aba05304/b483a6f8c3c64b07979948f92a82840c.jpg', '5488.00', '全面屏徕卡三摄 6GB +128GB 极光色 全网通版 移动联通电信4G手机 双卡双待', 0x31);
INSERT INTO `t_goods` VALUES ('43f3f10424af4b3596900bc142dba3e3', '金士顿(Kingston)DDR4 2400 8G 笔记本内存', 'c0e536f2adb240d1bda981f31e42dec7', '25000', '/upload/goods/c0e536f2adb240d1bda981f31e42dec7/69e050f58c314e0e8d1fb906d44abae6.jpg', '699.00', '', 0x31);
INSERT INTO `t_goods` VALUES ('4f102a554b5c40998410470cb1ed374f', '荣耀 畅玩6', 'c1409d9c3b794b91867144e2aba05304', '12700', '/upload/goods/c1409d9c3b794b91867144e2aba05304/ef836295118c4ea8a79642b12a7d90fc.jpg', '599.00', '2GB+16GB 金色 全网通4G手机 双卡双待', 0x31);
INSERT INTO `t_goods` VALUES ('70d0c52d3d0e427ca2ac1057af4b8a6d', '闪迪(SanDisk) 加强版 240G 固态硬盘', 'c0e536f2adb240d1bda981f31e42dec7', '19800', '/upload/goods/c0e536f2adb240d1bda981f31e42dec7/9bd9e7a48c9b405aaf2551e11c11fc0b.jpg', '449.00', '', 0x31);
INSERT INTO `t_goods` VALUES ('862a9981b62e4f27a78b862798be0630', '芝奇(G.Skill) Ripjaws 4系列台式机内存', 'c0e536f2adb240d1bda981f31e42dec7', '12800', '/upload/goods/c0e536f2adb240d1bda981f31e42dec7/95204690771b4d209f9b68d78f7105c5.jpg', '599.00', ' DDR4 2400频率 8G  (宾利黑)', 0x31);
INSERT INTO `t_goods` VALUES ('8d42aef900cc41c683b2afd51d0a570b', '金士顿(Kingston)A400系列 240G SATA3 固态硬盘', 'c0e536f2adb240d1bda981f31e42dec7', '12600', '/upload/goods/c0e536f2adb240d1bda981f31e42dec7/a311b510663f45f19b280ea2976eb1c7.jpg', '459.00', '', 0x31);
INSERT INTO `t_goods` VALUES ('a5a65be2a9af4e83bc07a660080e5c1b', 'Apple MacBook Air ', 'c1409d9c3b794b91867144e2aba05304', '18000', '/upload/goods/c1409d9c3b794b91867144e2aba05304/bd2c7aba075f4188981646f0e2b06f0b.jpg', '6588.00', '13.3英寸笔记本电脑 银色(2017款Core i5 处理器/8GB内存/128GB闪存 MQD32CH/A)', 0x31);
INSERT INTO `t_goods` VALUES ('a74e3c996932418bbb9fc8fb86b87737', '联想(Lenovo)小新潮7000 ', 'c1409d9c3b794b91867144e2aba05304', '25000', '/upload/goods/c1409d9c3b794b91867144e2aba05304/3a0b4ffc2af34ba3b6685ce5252b520e.jpg', '5599.00', '13.3英寸 超轻薄窄边框笔记本电脑(i5-8250U 8G 256G PCIE MX150 2G)花火银', 0x31);
INSERT INTO `t_goods` VALUES ('af2385a362a840b3b413a339b996e39e', '金士顿(Kingston) 笔记本内存', 'c0e536f2adb240d1bda981f31e42dec7', '12500', '/upload/goods/c0e536f2adb240d1bda981f31e42dec7/841ea08dd7784b62bac7e20afa77864c.jpg', '489.00', '低电压版 DDR3 1600 8GB', 0x31);
INSERT INTO `t_goods` VALUES ('d652f857d5f345a5a2dd4b71ee251abe', '联想(Lenovo)拯救者R720 ', 'c1409d9c3b794b91867144e2aba05304', '32300', '/upload/goods/c1409d9c3b794b91867144e2aba05304/460c967ec23449e28c6582de2c12b3ef.jpg', '7099.00', '15.6英寸大屏游戏笔记本电脑(i7-7700HQ 8G 1T+128G SSD GTX1050Ti 4G IPS 黑金)', 0x31);
INSERT INTO `t_goods` VALUES ('e4789a4314d94728a624eac8e42347d3', '荣耀9 全网通 尊享版', 'c1409d9c3b794b91867144e2aba05304', '12400', '/upload/goods/c1409d9c3b794b91867144e2aba05304/c2fd10b683cd4aa09624e90ae6e158dc.jpg', '2799.00', '6GB+128GB 魅海蓝 移动联通电信4G手机 双卡双待', 0x31);

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
INSERT INTO `t_order` VALUES ('0b6fd3e8c1fb4498b50e8a1ed936ae7b', 'c1409d9c3b794b91867144e2aba05304', '2', '6087.00', '2018-05-24 21:00:19', 0x31);
INSERT INTO `t_order` VALUES ('337c5cf65fe5458f9af546929694d485', 'c1409d9c3b794b91867144e2aba05304', '1', '4999.00', '2018-05-24 17:54:17', 0x31);
INSERT INTO `t_order` VALUES ('3bf90183036247a2bc5e1f5c2c4dd23b', 'c1409d9c3b794b91867144e2aba05304', '2', '449.00', '2018-04-29 20:15:11', 0x31);
INSERT INTO `t_order` VALUES ('5e8770f0df59486db50474710b3f8992', 'c1409d9c3b794b91867144e2aba05304', '2', '6588.00', '2018-04-29 20:17:22', 0x31);
INSERT INTO `t_order` VALUES ('6b7fb931ba6c4730a1c25b7bfb3c0856', 'c1409d9c3b794b91867144e2aba05304', '1', '2799.00', '2018-04-29 20:19:22', 0x31);
INSERT INTO `t_order` VALUES ('a0d044ad7bc8433fb9b33ec25207837d', 'c1409d9c3b794b91867144e2aba05304', '1', '6599.00', '2018-05-24 20:33:31', 0x31);
INSERT INTO `t_order` VALUES ('cde1ab21cb314beb8070be0fd22ebccb', 'c1409d9c3b794b91867144e2aba05304', '1', '4999.00', '2018-05-24 20:17:09', 0x31);
INSERT INTO `t_order` VALUES ('f141c856a79e4e3b8fe3a3e3964ba6a6', 'c1409d9c3b794b91867144e2aba05304', '1', '5488.00', '2018-04-29 20:18:43', 0x31);
INSERT INTO `t_order` VALUES ('f5d8743508fb46b08d2b8097dabfb7d5', 'c1409d9c3b794b91867144e2aba05304', '1', '6599.00', '2018-05-25 17:45:50', 0x31);

-- ----------------------------
-- Table structure for t_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_order_goods`;
CREATE TABLE `t_order_goods` (
  `id` varchar(63) NOT NULL,
  `order_id` varchar(63) NOT NULL,
  `goods_id` varchar(63) DEFAULT NULL,
  `goods_num` int(11) DEFAULT NULL,
  `is_seckill` bit(1) NOT NULL,
  `delete_flag` binary(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order_goods
-- ----------------------------
INSERT INTO `t_order_goods` VALUES ('3208bd3dd5b045a7893505816f3ab204', 'f141c856a79e4e3b8fe3a3e3964ba6a6', '437f12bfcf0e4943a409692c857857f2', '1', '\0', 0x31);
INSERT INTO `t_order_goods` VALUES ('4518a76d560b468c95dd2ac0b36cbd8b', '3bf90183036247a2bc5e1f5c2c4dd23b', '70d0c52d3d0e427ca2ac1057af4b8a6d', '2', '\0', 0x31);
INSERT INTO `t_order_goods` VALUES ('4a8ec240b5a74e7fa0a4f239bf90b8b7', '6b7fb931ba6c4730a1c25b7bfb3c0856', 'e4789a4314d94728a624eac8e42347d3', '1', '\0', 0x31);
INSERT INTO `t_order_goods` VALUES ('4bff8afbb60a4c8d9a1db497901e0016', '0b6fd3e8c1fb4498b50e8a1ed936ae7b', '437f12bfcf0e4943a409692c857857f2', '1', '\0', 0x31);
INSERT INTO `t_order_goods` VALUES ('810a3b0860f74111baf946d0bbd3f607', 'f5d8743508fb46b08d2b8097dabfb7d5', 'd652f857d5f345a5a2dd4b71ee251abe', '1', '', 0x31);
INSERT INTO `t_order_goods` VALUES ('adf694e68b1040e3b2d34ee95970da92', '0b6fd3e8c1fb4498b50e8a1ed936ae7b', '4f102a554b5c40998410470cb1ed374f', '1', '\0', 0x31);
INSERT INTO `t_order_goods` VALUES ('c597dcb53a9c4583a436f3dce7bcae0e', 'cde1ab21cb314beb8070be0fd22ebccb', '437f12bfcf0e4943a409692c857857f2', '1', '', 0x31);
INSERT INTO `t_order_goods` VALUES ('d60a5282dd8444a9919bad94a5efd931', '5e8770f0df59486db50474710b3f8992', 'a5a65be2a9af4e83bc07a660080e5c1b', '2', '\0', 0x31);
INSERT INTO `t_order_goods` VALUES ('e6f0e6b444d6429d8f7edc35ea4a4c1e', '337c5cf65fe5458f9af546929694d485', '437f12bfcf0e4943a409692c857857f2', '1', '', 0x31);
INSERT INTO `t_order_goods` VALUES ('f623837f03f2499580c3afe790ac2cb1', 'a0d044ad7bc8433fb9b33ec25207837d', 'd652f857d5f345a5a2dd4b71ee251abe', '1', '', 0x31);

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
  `seckill_end_time` datetime DEFAULT NULL,
  `delete_flag` binary(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_seckill
-- ----------------------------
INSERT INTO `t_seckill` VALUES ('8f0d1d3401974554ab85a4aabbc0e16a', '862a9981b62e4f27a78b862798be0630', '12010', '499.00', '2018-06-04 17:00:00', '2018-06-07 19:00:00', 0x31);
INSERT INTO `t_seckill` VALUES ('bf949f9a2c8143128d762acf8cf840e8', 'd652f857d5f345a5a2dd4b71ee251abe', '12800', '6599.00', '2018-06-04 17:00:00', '2018-06-07 19:00:00', 0x31);
INSERT INTO `t_seckill` VALUES ('c8c337c6e673494faec278f3f325c920', '437f12bfcf0e4943a409692c857857f2', '12500', '4999.00', '2018-06-04 17:00:00', '2018-06-07 19:00:00', 0x31);
INSERT INTO `t_seckill` VALUES ('f4548b98aade4f1f820887c36189f9ab', 'a74e3c996932418bbb9fc8fb86b87737', '12500', '4999.00', '2018-06-04 17:00:00', '2018-06-07 19:00:00', 0x31);

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
INSERT INTO `t_user` VALUES ('c0e536f2adb240d1bda981f31e42dec7', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '1', '/upload/image/defaultAvatar.jpg', null, 0x31);
INSERT INTO `t_user` VALUES ('c1409d9c3b794b91867144e2aba05304', '郑泉斌', 'e10adc3949ba59abbe56e057f20f883e', '1', '/upload/image/defaultAvatar.jpg', null, 0x31);
