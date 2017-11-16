--1.准备表：id自增表
-- CREATE TABLE auto_incr_trigger (
-- 	ID NUMBER (6) NOT NULL,
-- 	name_str VARCHAR2 (30) NOT NULL PRIMARY KEY
-- );
--2.创建SEQUENCE
-- CREATE SEQUENCE autoIncrTrigger_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 MAXVALUE 9999999999999 NOCACHE ORDER;
--3.创建一个基于该表的before insert 触发器，在触发器中使用刚创建的SEQUENCE
-- CREATE
-- OR REPLACE TRIGGER autoIncrTrigger_trigger BEFORE INSERT ON auto_incr_trigger FOR EACH ROW
-- BEGIN
-- 	SELECT
-- 		autoIncrTrigger_seq.nextval INTO:NEW.ID --冒号和点必须没有空格
-- 	FROM
-- 		SYS.dual ;
-- 	END ;
INSERT INTO "auto_incr_trigger" ("NAME_STR") VALUES('KKKKxCCCCCyz');
INSERT INTO "auto_incr_trigger" ("NAME_STR") VALUES ('IUIUOIXXJLKHJHJK');
