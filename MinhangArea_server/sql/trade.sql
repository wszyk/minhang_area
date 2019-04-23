/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50520
Source Host           : localhost:3306
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2019-04-19 16:35:33
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `trade`
-- ----------------------------
DROP TABLE IF EXISTS `trade`;
CREATE TABLE `trade` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '交易ID',
  `areaId` int(11) DEFAULT NULL COMMENT '区ID',
  `flg` int(11) DEFAULT NULL COMMENT '标识符',
  `lat` double DEFAULT NULL COMMENT '经度',
  `lng` double DEFAULT NULL COMMENT '纬度',
  `tradeCode` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '交易对应的字符',
  `tradeName` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '交易名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of trade
-- ----------------------------
INSERT INTO trade VALUES ('1', '2', '0', '31.404384', '121.459539', 'DCBZH', '大场北中环');
INSERT INTO trade VALUES ('2', '2', '1', '31.386629', '121.499783', 'DCBZHDHHC', '大场北中环大华虎城');
INSERT INTO trade VALUES ('3', '2', '1', '31.384656', '121.528529', 'DCBZHYJ', '大场北中环宜家');
INSERT INTO trade VALUES ('4', '2', '1', '31.431009', '121.465289', 'GKWDGC', '共康万达广场');
INSERT INTO trade VALUES ('5', '2', '0', '31.378737', '121.480236', 'GKDQ', '共康地区');
INSERT INTO trade VALUES ('6', '2', '1', '31.397479', '121.503233', 'GKHTYGC', '共康红太阳商业广场');
INSERT INTO trade VALUES ('7', '2', '0', '31.434953', '121.45264', 'GCDQ', '顾村地区');
INSERT INTO trade VALUES ('8', '2', '1', '31.362951', '121.538878', 'GCZDBFC', '顾村正大缤纷城');
INSERT INTO trade VALUES ('9', '2', '0', '31.33828', '121.495184', 'LDDQ', '罗店地区');
INSERT INTO trade VALUES ('10', '2', '0', '31.347163', '121.445741', 'LJDQ', '罗泾地区');
INSERT INTO trade VALUES ('11', '2', '0', '31.403397', '121.406647', 'SDDQ', '上大地区');
INSERT INTO trade VALUES ('12', '2', '0', '31.366898', '121.468738', 'SQDQ', '盛桥地区');
INSERT INTO trade VALUES ('13', '2', '0', '31.324462', '121.492884', 'SBDQ', '淞宝地区');
INSERT INTO trade VALUES ('14', '2', '1', '31.339267', '121.531979', 'SBHJGC', '淞宝黄金广场');
INSERT INTO trade VALUES ('15', '2', '1', '31.368871', '121.489435', 'SBBLH', '淞宝宝乐汇');
INSERT INTO trade VALUES ('16', '2', '1', '31.376764', '121.433093', 'SBNYXTD', '淞宝诺亚新天地');
INSERT INTO trade VALUES ('17', '2', '0', '31.336306', '121.482536', 'YHDQ', '杨行地区');
INSERT INTO trade VALUES ('18', '2', '0', '31.353084', '121.554975', 'YGXL', '殷高西路');
INSERT INTO trade VALUES ('19', '2', '0', '31.376764', '121.404347', 'YPDQ', '月浦地区');
INSERT INTO trade VALUES ('20', '2', '0', '31.345189', '121.473337', 'SNXWJC', '淞南小五角场');
