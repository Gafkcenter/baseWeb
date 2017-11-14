--create table xuesheng(id integer, xing_ming varchar2(25), yu_wen number, shu_xue number);

--insert into xuesheng values(1,'zhangsan',80,90);
--insert into xuesheng values(2,'lisi',85,87);
--2）有单个数据值返回的存储过程
--https://www.cnblogs.com/liliu/archive/2011/06/22/2087546.html
CREATE OR REPLACE PROCEDURE xs_proc(temp_name in varchar2,temp_num out NUMBER)IS
num_1 NUMBER;
num_2 NUMBER;
BEGIN
SELECT yu_wen,shu_xue INTO num_1,num_2 FROM xuesheng WHERE xing_ming=temp_name;
temp_num:=num_1+num_2;
END;
---SELECT * FROM XUESHENG;