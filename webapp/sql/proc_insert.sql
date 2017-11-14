--create table xuesheng(id integer, xing_ming varchar2(25), yu_wen number, shu_xue number);

--insert into xuesheng values(1,'zhangsan',80,90);
--insert into xuesheng values(2,'lisi',85,87);
--1）无返回值的存储过程
--https://www.cnblogs.com/liliu/archive/2011/06/22/2087546.html
CREATE OR REPLACE PROCEDURE xs_proc_no IS
BEGIN
INSERT INTO XUESHENG VALUES(9,'wangwu',90,95);
INSERT INTO XUESHENG VALUES(10,'wangwu',91,96);
INSERT INTO XUESHENG VALUES(11,'wangwu',92,97);
INSERT INTO XUESHENG VALUES(12,'wangwu',93,98);
INSERT INTO XUESHENG VALUES(13,'wangwu',94,99);
commit;
END xs_proc_no;
---SELECT * FROM XUESHENG;