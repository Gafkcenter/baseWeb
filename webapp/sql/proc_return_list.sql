--create table xuesheng(id integer, xing_ming varchar2(25), yu_wen number, shu_xue number);

--insert into xuesheng values(1,'zhangsan',80,90);
--insert into xuesheng values(2,'lisi',85,87);
--3）有返回值的存储过程(列表返回)

--首先，建立我们自己的包。并定义包中的一个自定义ref cursor
--https://www.cnblogs.com/liliu/archive/2011/06/22/2087546.html
create or replace package mypackage as
  type my_cursor is ref cursor;
end mypackage;
--在定义了ref cursor后，可以书写我们的程序代码

create or replace procedure xs_proc_list(shuxue   in number,
                                         p_cursor out mypackage.my_cursor) is
begin
  open p_cursor for
    select * from xuesheng where shu_xue > shuxue;
end xs_proc_list;
---SELECT * FROM XUESHENG;