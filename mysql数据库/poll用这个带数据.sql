/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50620
Source Host           : localhost:3306
Source Database       : poll

Target Server Type    : MYSQL
Target Server Version : 50620
File Encoding         : 65001

Date: 2020-08-08 17:42:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `poll_option`
-- ----------------------------
DROP TABLE IF EXISTS `poll_option`;
CREATE TABLE `poll_option` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(11) unsigned NOT NULL COMMENT '发布投票id',
  `option_text` varchar(64) NOT NULL COMMENT '选项描述',
  `option_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '被投票数量',
  `option_state` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '选项状态 0正常 1已删除',
  PRIMARY KEY (`id`),
  KEY `poll_option_ibfk_1` (`post_id`),
  CONSTRAINT `poll_option_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of poll_option
-- ----------------------------
INSERT INTO `poll_option` VALUES ('1', '1', '博士以上高水准', '0', '0');
INSERT INTO `poll_option` VALUES ('2', '1', '硕士研究生水准', '1', '0');
INSERT INTO `poll_option` VALUES ('3', '1', '本科文化', '1', '0');
INSERT INTO `poll_option` VALUES ('4', '1', '大专文化', '1', '0');
INSERT INTO `poll_option` VALUES ('5', '1', '高中及其中专文化', '0', '0');
INSERT INTO `poll_option` VALUES ('6', '1', '初中文凭', '0', '0');
INSERT INTO `poll_option` VALUES ('7', '1', '小学及其以下', '0', '0');
INSERT INTO `poll_option` VALUES ('8', '2', '40岁以上', '0', '0');
INSERT INTO `poll_option` VALUES ('9', '2', '30到40岁', '0', '0');
INSERT INTO `poll_option` VALUES ('10', '2', '22到30岁', '2', '0');
INSERT INTO `poll_option` VALUES ('11', '2', '18到22岁', '0', '0');
INSERT INTO `poll_option` VALUES ('12', '2', '18岁以下未成年', '0', '0');

-- ----------------------------
-- Table structure for `poll_record`
-- ----------------------------
DROP TABLE IF EXISTS `poll_record`;
CREATE TABLE `poll_record` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL COMMENT '投此票用户的id',
  `option_id` int(11) unsigned NOT NULL COMMENT '投票选项id',
  `poll_num` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '投票数量',
  `poll_date` datetime NOT NULL COMMENT '投票时间',
  `poll_ip` int(11) unsigned NOT NULL COMMENT '投票的IP',
  `poll_mac` char(12) NOT NULL COMMENT '投票的MAC',
  `poll_state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '投票状态 0正常 1取消',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_2` (`user_id`,`option_id`) USING BTREE,
  KEY `option_id` (`option_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `poll_record_ibfk_3` FOREIGN KEY (`option_id`) REFERENCES `poll_option` (`id`),
  CONSTRAINT `poll_record_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of poll_record
-- ----------------------------
INSERT INTO `poll_record` VALUES ('1', '2', '3', '1', '2020-08-08 17:11:03', '111222333', 'mac', '0');
INSERT INTO `poll_record` VALUES ('3', '3', '4', '1', '2020-08-08 17:22:08', '111222333', 'mac', '0');
INSERT INTO `poll_record` VALUES ('4', '1', '2', '1', '2020-08-08 17:28:28', '111222333', 'mac', '0');
INSERT INTO `poll_record` VALUES ('5', '2', '10', '1', '2020-08-08 17:29:36', '111222333', 'mac', '0');
INSERT INTO `poll_record` VALUES ('6', '3', '10', '1', '2020-08-08 17:29:56', '111222333', 'mac', '0');

-- ----------------------------
-- Table structure for `post`
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL COMMENT '用户id',
  `title` varchar(32) NOT NULL COMMENT '标题',
  `introduce` text NOT NULL COMMENT '内容',
  `poll_type` tinyint(4) unsigned NOT NULL COMMENT '投票类型 0单选 1多选 2多次',
  `open_show` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否可以搜索到 0公开显示 1不公开显示',
  `open_poll` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否可以不登录投票 0都可投票 1登录后可投票',
  `open_result` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否公开投票结果 0公开投票结果 1不公开投票结果',
  `max_poll` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '最多选择/投票数量',
  `post_state` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '发布状态 0正常 1暂停 2删除',
  `post_date` datetime NOT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES ('1', '1', '大家都是什么学历呢？', '统计下大家都一般什么学历呢！', '0', '0', '0', '0', '1', '0', '2020-08-08 17:01:42');
INSERT INTO `post` VALUES ('2', '1', '你们都在什么年龄段呢？', '统计下大家的年龄段，谢谢大家配合', '0', '0', '0', '0', '1', '0', '2020-08-08 17:03:49');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL COMMENT '用户名',
  `pwd` varchar(16) NOT NULL COMMENT '密码',
  `gender` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '性别 0女 1男',
  `year` int(11) unsigned NOT NULL DEFAULT '1900' COMMENT '出生年',
  PRIMARY KEY (`id`),
  UNIQUE KEY `NAME` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'user1', '123456', '1', '2002');
INSERT INTO `user` VALUES ('2', 'user2', '123456', '1', '2003');
INSERT INTO `user` VALUES ('3', 'user3', '123456', '0', '2004');
