--Oracle统计分析---Oracle 10g函数大全--分析函数
--https://www.cnblogs.com/zfc2201/p/3285010.html
--http://www.w3school.com.cn/sql/sql_functions.asp
--初始化表数据 Statistical Analysis
create table students_oracle
(id number(15,0),
area varchar2(10),
stu_type varchar2(2),
score number(20,2));
insert into "students_oracle" values(1, '111', 'g', 80 );
insert into "students_oracle" values(1, '111', 'j', 80 );
insert into "students_oracle" values(1, '222', 'g', 89 );
insert into "students_oracle" values(1, '222', 'g', 68 );
insert into "students_oracle" values(2, '111', 'g', 80 );
insert into "students_oracle" values(2, '111', 'j', 70 );
insert into "students_oracle" values(2, '222', 'g', 60 );
insert into "students_oracle" values(2, '222', 'j', 65 );
insert into "students_oracle" values(3, '111', 'g', 75 );
insert into "students_oracle" values(3, '111', 'j', 58 );
insert into "students_oracle" values(3, '222', 'g', 58 );
insert into "students_oracle" values(3, '222', 'j', 90 );
insert into "students_oracle" values(4, '111', 'g', 89 );
insert into "students_oracle" values(4, '111', 'j', 90 );
insert into "students_oracle" values(4, '222', 'g', 90 );
insert into "students_oracle" values(4, '222', 'j', 89 );
commit;
