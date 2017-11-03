/*
Navicat Oracle Data Transfer
Oracle Client Version : 10.2.0.5.0

Source Server         : 192.168.0.102gafker2020
Source Server Version : 110200
Source Host           : dell:1521
Source Schema         : GAFKER2020

Target Server Type    : ORACLE
Target Server Version : 110200
File Encoding         : 65001

Date: 2017-11-02 22:21:40
*/


-- ----------------------------
-- Table structure for stuscore
-- ----------------------------
DROP TABLE "GAFKER2020"."stuscore";
CREATE TABLE "GAFKER2020"."stuscore" (
"ID" NUMBER(8) NOT NULL ,
"SCORE" NUMBER(8) NULL ,
"STUDENT_NAME" VARCHAR2(20 BYTE) NULL ,
"SUBJECT" VARCHAR2(20 BYTE) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "GAFKER2020"."stuscore"."SCORE" IS '分数';
COMMENT ON COLUMN "GAFKER2020"."stuscore"."STUDENT_NAME" IS '学生姓名';
COMMENT ON COLUMN "GAFKER2020"."stuscore"."SUBJECT" IS '科目';

-- ----------------------------
-- Records of stuscore
-- ----------------------------
INSERT INTO "GAFKER2020"."stuscore" VALUES ('1', '80', '熊锋', '语文');
INSERT INTO "GAFKER2020"."stuscore" VALUES ('2', '85', '熊锋', '数学');
INSERT INTO "GAFKER2020"."stuscore" VALUES ('3', '90', '熊锋', '英语');
INSERT INTO "GAFKER2020"."stuscore" VALUES ('4', '98', '熊锋', '物理');
INSERT INTO "GAFKER2020"."stuscore" VALUES ('5', '55', '熊锋', '地理');
INSERT INTO "GAFKER2020"."stuscore" VALUES ('6', '100', '熊锋', '生理');
INSERT INTO "GAFKER2020"."stuscore" VALUES ('7', '85', '熊锋', '自然');
INSERT INTO "GAFKER2020"."stuscore" VALUES ('9', '98', '陈国娟', '数学');
INSERT INTO "GAFKER2020"."stuscore" VALUES ('10', '88', '陈国娟', '地理');
INSERT INTO "GAFKER2020"."stuscore" VALUES ('11', '76', '陈国娟', '物理');
INSERT INTO "GAFKER2020"."stuscore" VALUES ('12', '89', '熊巍然', '数学');
INSERT INTO "GAFKER2020"."stuscore" VALUES ('13', '78', '熊巍然', '地理');
INSERT INTO "GAFKER2020"."stuscore" VALUES ('14', '99', '熊巍然', '英语');
INSERT INTO "GAFKER2020"."stuscore" VALUES ('15', '66', '熊巍雅', '数学');
INSERT INTO "GAFKER2020"."stuscore" VALUES ('16', '100', '熊巍雅', '地理');
INSERT INTO "GAFKER2020"."stuscore" VALUES ('17', '98', '熊巍雅', '英语');

-- ----------------------------
-- Indexes structure for table stuscore
-- ----------------------------

-- ----------------------------
-- Checks structure for table stuscore
-- ----------------------------
ALTER TABLE "GAFKER2020"."stuscore" ADD CHECK ("ID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table stuscore
-- ----------------------------
ALTER TABLE "GAFKER2020"."stuscore" ADD PRIMARY KEY ("ID");
