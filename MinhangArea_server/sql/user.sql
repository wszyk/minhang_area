/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50520
Source Host           : localhost:3306
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2019-04-19 16:35:42
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `areaId` int(11) DEFAULT NULL COMMENT '区ID',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '用户简介',
  `loginName` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '密码',
  `role` int(11) DEFAULT NULL COMMENT '用户角色',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO user VALUES ('2', '2', '超级管理员，具有所有的权限，整个系统只有一个admin用户。注意……', 'admin', '123456', '0');
INSERT INTO user VALUES ('3', '2', '宝山区的查看用户，只能查看，不能对数据进行操作。', 'baoshan', 'baoshanadmin@', '1');
INSERT INTO user VALUES ('4', '3', '上海徐汇区数据展示用户', 'xujiahui', 'xujiahuiadmin', '1');
INSERT INTO user VALUES ('5', '3', '测试', 'system', '123456', '1');
