--第一章
use db_mrsql      --使用db_mrsql数据库
/*使用select关键字查询药品销售表tb_sell03，
并且使用order by关键字按照“药品编号”的降序排列该中的相关信息*/
select * from tb_sell03 order by 药品编号 desc 	


USE db_mrsql --使用db_mrsql数据库
/*使用sp_addtype创建用来存储邮政编码信息的postalcode用户定义数据类型*/
EXEC sp_addtype mrVarChar,'varchar(20)','not null'	


use db_mrsql  --使用db_mrsql数据库
declare @class varchar(20)  --声明一个局部变量                                                            
select  @class=所在班级  
from tb_student03 
where 学生姓名='张力心' 
--使用print关键字显示局部变量的值	      
print '张力心同学所在班级为:'+@class    


use db_mrsql--使用db_mrsql数据库
--使用@@identity显示插入“学生编号”的数值情况
insert into tb_Student03 
values('齐小强','男','4104班','80')
select @@identity as '学生编号' 	


USE db_mrsql --使用db_mrsql数据库
declare @A int ,@B int,@C int  --声明3个整型变量
/*--使用select关键字为变量@A和变量@B分别赋值为“30”和“80”*/
select @A=30,@B=80         
--使用SET关键字为变量@c赋值，将变量@A对@B取余的结果赋给变量@C
set @C=@A%@B
print @C  --使用print关键字显示变量@C的信息内容


use db_mrsql --使用db_mrsql数据库
DECLARE @studentname  char(20)  --使用declare声明一个变量
--使用set关键字为@studentname变量赋值为“Jim”
SET @studentname='Jim'  
print '字符串的值为:'+@studentname


USE db_mrsql --使用db_mrsql数据库
DECLARE @studentname char(20) --使用declare声明一个变量
SELECT @studentname='Luck'  --使用select关键字为该变量赋值
print @studentname     --使用print关键字输出变量的值


use db_mrsql  --使用db_mrsql数据库
/*查询“所在班级”为“4108班”并且
“学生成绩”大于“60”分的学生的基本信息*/
select *
from tb_student03
where 所在班级='4108班' and 学生成绩>'60'	


use db_mrsql --使用db_mrsql数据库
GO
--使用declare关键字声明3个变量
declare @x varchar(20),@y varchar(20),@z varchar(20)
set @x='你好！'  --将变量@x赋值为“你好！”
set @y='世界！'  --将变量@y 赋值为“世界！” 
print '两个变量交换前：'   --使用print关键字输出一句话
print @x                 --使用print关键字将变量@x输出
print @y                 --使用print关键字将变量@y输出
begin                    --在BEGIN…END语句中完成把两个变量的值交换   
  set @z=@x            
  set @x=@y
  set @y=@z
end
print '两个变量交换后：'   --使用print关键字输出一句话
print @x                 --使用print关键字输出一个变量@x
print @y   	--使用print关键字输出一个变量@y


--第二章

use db_mrsql      --使用db_mrsql
declare @m int     --使用declare关键字声明一个整型变量“@m”
set @m=-24        --使用set关键字将该变量赋值为“-24”
if @m<0           --利用IF条件选择语句判断该变量的值是否是负数
print '@m是一个负数'--使用print关键字输出一句话


use db_mrsql--使用db_mrsql
declare  @A int   --使用declare声明一个整型变量
set @A=7        --使用set关键字将数字8赋值给变量@A
if @A % 2<>0    --如果变量@A对数字2取余不等于0
--使用print关键字输出一句话为"@A变量是一个奇数!"
 print  '@A变量是一个奇数!'  
else            --如果变量@A对数字2取余等于0
--使用print关键字输出一句话为"@A变量是一个偶数!"
 print  '@A变量是一个偶数!'    	



use db_mrsql--使用db_mrsql
declare  @m int,@n int --使用declare声明2个变量@m和@n
set @m=20           --使用set将数字20赋值给变量@m
set @n=30           --使用set将数字30赋值给变量@n
if @m<@n            --判断变量@m是否小于@n 
--如果@m比@n小，输出一句话“变量@m大于变量@n”
    print '变量@m大于变量@n' 
else 
--如果@m比@n大，输出一句话“变量@m不大于变量@n”
    print'变量@m不大于变量@n'


use db_mrsql--使用db_mrsql数据库
--使用declare关键字声明两个整型变量@A和@B
declare  @A int,@B int  
set @A=-7
set @B=-7
if @A>0    --变量@A大于0
  if @B>0  --变量@B大于0
--使用print关键字输出一句话"@A@B位于第一象限"
     print'@A@B位于第一象限'
  else     --变量@B小于0
--使用print关键字输出一句话"@A@B位于第四象限"     
     print'@A@B位于第四象限'
else       --变量@A小于0 
  if @B>0  --变量@B大于0
--使用print关键字输出一句话"@A@B位于第二象限"
     print'@A@B位于第二象限'
  else    --变量@B小于0
--使用print关键字输出一句话"@A@B位于第三象限"
     print'@A@B位于第三象限'


USE pubs --使用pubs数据库
/*使用带有简单CASE 函数的SELECT语句统计titles数据表信息情况*/
SELECT kind = 
      CASE type
         WHEN 'popular_comp' THEN 'Popular Computing'
         WHEN 'mod_cook' THEN 'Modern Cooking'
         WHEN 'business' THEN 'Business'
         WHEN 'psychology' THEN 'Psychology'
         WHEN 'trad_cook' THEN 'Traditional Cooking'
         ELSE 'Not yet categorized'
      END,
   CAST(title AS varchar(30)) AS 'Shortened Title',
   price AS Price
FROM titles
WHERE price IS NOT NULL
ORDER BY type, price
COMPUTE AVG(price) BY type  


USE pubs  --使用pubs数据库
SELECT    'Price Kind' = 
      CASE 
         WHEN price IS NULL THEN 'Not yet priced'
         WHEN price < 20 THEN 'Very Reasonable Title'
         WHEN price >= 20 and price < 20 THEN 'Coffee Table Title'
         ELSE 'Expensive book!'
      END,   
   CAST(title AS varchar(20)) AS 'Shortened Title'
FROM titles
ORDER BY price


use db_mrsql  --使用db_mrsql数据库
--使用declare关键字声明两个整型变量“@S”和变量“@sum”
declare  @S int,@sum int 
--使用set关键字为这两个变量分别赋值
set @S=1      
set @sum=0
while @S<=100
begin  
set @sum=@sum+@S
set @S=@S+1
end
print @sum --使用print关键字将变量@sum输出	

use db_mrsql  --使用db_mrsql数据库
--使用declare关键字声明两个整型变量“@A”和变量“@S”
declare @A int,@S int
--使用SET关键字将数字1赋给变量@A
set @A=1
--使用SET关键字将数字0赋给变量@S
set @S=0
while @A<15
 begin
   set @A=@A+1--使用SET关键字将变量@A与1的和赋给变量@A
  if @A%2=0 --使用IF关键字判断变量@A和2相除后的余数是否等于0
   set @S=@S+@A--使用SET关键字将变量@S与变量@A相加的和赋给变量@S
  else
    continue
----使用print关键字输出一句话"只有当@A是偶数时才输出这句话"
    print '只有当@A是偶数时才输出这句话'
 end 
print @S --使用print关键字将变量@S输出

use db_mrsql    --使用db_mrsql数据库
declare @x int   --使用DECLARE关键字声明一个变量  
set @x=3       --使用SET关键字将数字3赋给变量@x                                
if @x>0        --使用IF关键字判断变量@x是否大于0
--如果变量@x大于0,则用print关键字输出一句话"碰到return语句之前!"
 print'碰到return语句之前!'  
return
--如果变量@x大于0,则用print关键字输出一句话"碰到return语句之后!"
 print'碰到return语句之后!' 


use db_mrsql          --使用db_mrsql数据库
declare @M int        --使用DECLARE关键字声明一个整型变量@M                                      
select @M=50        --使用SELECT关键字将数字50赋给变量@M
HI:
    print @M        --使用print关键字将变量@M输出
    select @M=@M+1 --使用SRLECT关键字将变量@M与1的和赋给变量@M
while @M<=51
goto HI



--第三章


use db_mrsql     --使用db_mrsql数据库
declare  @x int  -- 使用DECLARE关键字声明一个变量@x
select @x=1001  -- 将数字1001赋给变量@x
print @x        -- 使用PRINT关键字将变量@x的值输出 

use db_mrsql  --使用db_mrsql数据库
backup DATABASE db_mrsql TO disk='backupsql.bak'

use db_mrsql  --使用db_mrsql数据库
--使用SELECT关键字查询商品信息表"tb_spreadtext03"
select 商品备注 from tb_spreadtext03
--使用DECLARE关键字声明一个变量
DECLARE @sp varbinary(20)
SELECT @sp= TEXTPTR(商品备注) 
   FROM tb_spreadtext03 
READTEXT tb_spreadtext03.商品备注 @sp  0  9  

use db_mrsql--使用db_mrsql数据库
--使用DECLARE关键字声明4个变量
declare @timesj1 varchar(30),@timesj2 varchar(30),
@timenow varchar(30)
/*使用SET关键字为变量@timesj1和变量@timesj2分别
赋值为"2008/02/18"和"2008/04/02"*/
set @timesj1='2008/02/18'
set @timesj2='2008/04/02'
--使用SET关键字将当前时间赋给变量@timenow
set @timenow=(CONVERT(varchar(30),GETDATE(),111))
--使用IF判断变量@timesj1是否等于变量@timenow
if @timesj1<>@timenow
/*如果两个变量不相等,使用PRINT关键字输出
"@timesj1和@timenow两个时间不相同！"*/
  print '@timesj1和@timenow两个时间不相同！'
else
/*如果两个变量相等,使用PRINT关键字输出
"@timesj1和@timenow两个时间相同！"*/
  print '@timesj1和@timenow两个时间相同！'
--使用IF判断变量@timesj2是否等于变量@timenow
if @timesj2<>@timenow
/*如果两个变量不相等,使用PRINT关键字输出
"@timesj1和@timenow两个时间不相同！"*/
  print '@timesj2和@timenow两个时间不相同！'
else
/*如果两个变量相等,使用PRINT关键字输出
"@timesj1和@timenow两个时间相同！"*/
  print '@timesj2和@timenow两个时间相同！'


use db_mrsql --使用db_mrsql数据库
--使用DECLARE关键字声明5个变量
declare @A varchar(10),@B varchar(10),@C varchar(10),
@D varchar(50),@E varchar(20) 
--使用SELECT关键字为这5个变量赋值                           
select @A='weihong',@B='女',@C='23',@D='吉林省长春市',
@E='weihong@XX.com'
--使用print关键字显示变量并生成字符串
print '注册信息:-)'
print '您的姓名：'+ @A
print '您的性别：'+ @B
print '您的年龄: '+ @C
print '家庭住址: '+ @D
print '邮箱：'+@E


use db_mrsql--使用db_mrsql数据库
/*使用CHECKPOINT命令检查db_mrsql数据库中被更改过的数据页或日志页，并将这些数据从数据缓冲器中强制写入硬盘*/
CHECKPOINT


use pubs  --使用pubs数据库
/*使用 OBJECT_ID 获得表 ID 和使用 sysindexes 获得索引 ID*/
DECLARE @id int, @indid int--使用DECLARE关键字声明两个变量
SET @id = OBJECT_ID('authors')--使用SET关键字为变量@id复值
SELECT @indid = indid 
FROM sysindexes
WHERE id = @id 
   AND name = 'aunmind'
--使用DBCC SHOWCONTIG命令显示指定的表的数据和索引的碎片信息
DBCC SHOWCONTIG (@id, @indid)


use db_mrsql  --使用db_mrsql数据库
--检查指定pubs数据库的磁盘空间分配结构的一致性
DBCC CHECKALLOC ('pubs')   


use db_mrsql--使用db_mrsql数据库
WAITFOR DELAY'00:00:08' --等待8分钟              
print'你好！！'--使用print关键字输出"你好！！"


use db_mrsql             --使用db_mrsql数据库
WAITFOR TIME '7:00:00'  --时间等到7点钟
PRINT '小赖虫起床了！'   --使用PRINT显示一句话"小赖虫起床了！"



use db_mrsql--使用db_mrsql数据库
--使用DECLARE关键字声明3个变量
declare  @x int,@y char(20),@z datetime
/*使用SELECT关键字为变量@x,@y,@z赋值,
分别赋值为"50","LOVING","2008/03/04" */                    
select @x=50,@y='LOVING',@z='2008/03/04'
print @x
print @y
print @z


use db_mrsql  --使用db_mrsql数据库
declare @stuname varchar(30)
declare @sex char(2)
declare @score float
declare @class varchar(20)
select @stuname=学生姓名,@score=学生成绩,@sex=学生性别,@class=所在班级
from tb_student03 where 学生编号=1001
print @stuname
print @sex
print @class
print @score  


use db_mrsql --使用db_mrsql数据库
declare @M varchar(10)  -- 使用DECLARE声明一个变量@M
set @M='你们好！！'     -- 使用SET关键字将变量@M赋值为"你们好！！"
print @M                -- 使用PRINT关键字输出变量@M的值


use db_mrsql --使用db_mrsql数据库
SHUTDOWN  
WITH NOWAIT


use master --使用MASTER数据库
GO

--第四章

create database mrgwh	--使用create database 命令创建一个名称是“mrgwh”的数据库

create database mrdz
on 
(name=mrdat,
filename='D:\Program Files\Sql server2000安装好的\MSSQL\Data\mrdz.mdf',
size=10,
maxsize=100,
filegrowth=5)
log on
(name='mingrilog',
filename='D:\Program Files\Sql server2000安装好的\MSSQL\Data\mrdz.ldf',
size=8mb,
maxsize=50mb,
filegrowth=8mb )


create database mr
on
 primary(
   name=mrdat,
   filename='D:\Program Files\Sql server2000安装好的\MSSQL\Data\mr.mdf',
   size=5,
   maxsize=80,
   filegrowth=5),
filegroup mrgroup
(
   name=mingri,
   filename='D:\Program Files\Sql server2000安装好的\MSSQL\Data\mr.ndf',
   size=10,
   maxsize=80,
   filegrowth=5
)
log on
(name='mrlog',
filename='D:\Program Files\Sql server2000安装好的\MSSQL\Data\lovingmr.ldf',
size=6mb,
maxsize=30mb,
filegrowth=6mb )


alter database db_mrsql--使用alter database 命令修改数据库
  add  file(  --添加文件“happy”
       name=happy,
       filename='D:\Program Files\Sql server2000安装好的\MSSQL\Data\happy.ndf',
       size=2mb,
       maxsize=30mb,
       filegrowth=3mb
)

alter database db_mrsql--使用alter database 命令修改数据库
  add  file(  --添加文件“joy”
       name=joy,
       filename='D:\temp\joy.ndf',
       size=2mb,
       maxsize=30mb,
       filegrowth=3mb
)

alter database db_mrsql 
modify file(
       name=joy,
       size=40mb
   )



use db_mrsql
DBCC SHRINKDATABASE (mrgwh,10,NOTRUNCATE)



alter database db_mrsql
add filegroup happy


alter database db_mrsql
remove file happy


use db_mrsql
DBCC SHRINKFILE(joy,1,NOTRUNCATE)



--第五章

use db_mrsql
exec sp_renamedb 'mr', 'mrsoft'


use db_mrsql
drop database teacher 


use db_mrsql
drop database hello,every,person


use db_mrsql  --使用db_mrsql数据库
create  table teacher --创建“teacher”信息表
(
 教师编号 int, 
 教师姓名  varchar(10), 
 教师年龄  int,
 所教课程  varchar(30) 
)  


use db_mrsql
create table shopping
(
商品编号 int primary key, --使用primary key将“商品编号”字段设置为主键列
商品类别 varchar(10),
商品数量 int,
商品备注 text 
)  


use db_mrsql   --使用db_mrsql数据库  
create table pupil   --创建tb_pupil04数据表 
(
 学生学号  varchar(8),
 学生姓名  varchar(10) unique,-- 定义了具有唯一值（unique）的“学生姓名”列
 -- 创建一个检验约束(check)检验“学生年龄”列的值是否在8到15之间
学生年龄  int check(学生年龄>=8 and 学生年龄<=15), 
 学生性别  int,
 备注 text 
)


use db_mrsql  --使用db_mrsql数据库    
create  table tb_student04   --创建学生信息表tb_student04
(
 学号  varchar(8) not null,--指定学号列不能为空
 姓名  varchar(10) unique, -- 定义了具有唯一值（unique）的“姓名”列
 -- 创建一个检验约束(check)检验“年龄”列的值是否在10到20之间
 年龄  int check(年龄>=10 and 年龄<=20),
 性别  char(2) not null--指定性别列不能为空
)


use db_mrsql                --使用db_mrsql数据库 
create table tb_member04  --创建会员信息表tb_member04
(
 会员编号 int,
 会员名称 varchar(20),
 /*为“会员性别”列指定了默认值,将默认值设置为“男”*/
 会员性别 char(2) default '男',
 会员年龄 int,
 备注 text
)


use db_mrsql--使用db_mrsql数据库
create table tb_employee04----创建员工信息表tb_employee04
(
 员工编号 int,
 员工名称 varchar(20),
 基本工资 float,
 浮动奖金 float,
 --“所得奖金”列是由“基本工资”和“浮动奖金”两个列的和计算得到的
 所得金额 as (基本工资+浮动奖金),  
 备注 text
)


use db_mrsql--使用db_mrsql数据库
create table tb_employee04----创建员工信息表tb_employee04
(
 员工编号 int,
 员工名称 varchar(20),
 基本工资 float,
 浮动奖金 float,
 --“所得奖金”列是由“基本工资”和“浮动奖金”两个列的和计算得到的
 所得金额 as (基本工资+浮动奖金),  
 备注 text
)


use db_mrsql--使用db_mrsql 数据库
create table #materia  --创建临时表“#materia”
(
 药品编号 int,
 药品名称  varchar(20),
 药品数量  int,
 备注 text
)


--第六章

use db_mrsql--使用db_mrsql数据库
create table ##car –-创建一个全局临时表“##car”
(
车辆编号 int,
车辆名称  varchar(20),
车辆数量  int
)


use db_mrsql   --使用db_mrsql数据库  
--通过系统存储过程sp_help来查看药品销售信息表“tb_sell03”中的信息
EXEC  sp_help 'tb_sell03' 


USE  db_mrsql --使用db_mrsql数据库
/*通过使用系统存储过程sp_spaceused来查看学生信息表“tb_student04”中的行数及表格所用的存储空间*/
EXEC sp_spaceused 'tb_student04'


USE  db_mrsql--使用db_mrsql数据库
--使用系统存储过程sp_depends来查看学生信息表“tb_student04”和其他表的相关性
EXEC sp_depends 'tb_student04'


USE  db_mrsql--使用db_mrsql数据库
/*给学生信息表“tb_student04”添加“学生性别”列*/
alter table tb_student04 
add  学生性别  char(2)


use db_mrsql
--创建数据表
create table tb_student04
(
  学生学号 varchar(10),
  学生姓名 varchar(20)
) 
alter table tb_student04
alter column 学生学号 varchar(20)


USE  db_mrsql --使用db_mrsql数据库
--在学生信息表“tb_student04”中，将“学生学号”字段设置为主键
alter table tb_student04 add primary key(学生学号)


use db_mrsql --使用db_mrsql数据库
--在房屋信息表“tb_home04”中，删除名称是“zhufang”的约束
alter  table  tb_home04
drop constraint zhufang 


use db_mrsql--使用db_mrsql数据库
--使用EXEC sp_rename关键字将“student”数据表名称改成“stu”
EXEC sp_rename 'student', 'stu'


use db_mrsql  --使用db_mrsql数据库 
--  将房屋信息表“tb_home04”中的“住房备注”列修改为“备注信息”    
EXEC sp_rename 'tb_home04.[住房备注]', '备注信息', 'COLUMN'


use db_mrsql      --使用db_mrsql数据库
--使用ALTER TABLE命令从现有的学生信息表“tb_student04”中，删除 “学生性别”列
alter table tb_student04
drop column 学生性别



use db_mrsql 
alter table tb_home04 
add constraint 住房编号 
check (住房编号 >=1000 and 住房编号<=9999) 


use db_mrsql--使用db_mrsql数据库
alter  table  tb_home04 
add  constraint zhufang
default '备注' for 住房备注



use db_mrsql
drop table tb_storage04


--使用db_mrsql数据库
use db_mrsql
/*“tb_storage04”、“tb_stunum04”、
“tb_booksell04”这三个数据表*/
drop table tb_storage04,tb_stunum04,tb_booksell04



--第八章
use db_mrsql   --使用db_mrsql数据库       
insert into tb_home04 -–向房屋信息表中插入一条记录
(住房编号,住房名称,住房类别,住户姓名,备注信息)
values(1001,'XX名称','一室一厅','王雪健','无')
GO
select * from tb_home04  --查看房屋信息表插入后的数据信息



use db_mrsql --使用db_mrsql数据库
GO
select * from tb_huiyuan04 --查询数据表中的信息
--向数据表中插入NULL值
insert into tb_huiyuan04 values('H-1004','王雨婷',NULL,NULL)
--查看插入后的数据表中的信息
select * from tb_huiyuan04




use db_mrsql--使用db_mrsql数据库
select * from tb_yuangong05
use db_mrsql--使用db_mrsql数据库
--向数据表中插入一条数据数据，系统将会报错
insert into tb_yuangong05
values(1005,'孙建国','230108XXXXXXXXXXXX','无')



use db_mrsql --使用db_mrsql数据库
insert into tb_shopping04  --向商品信息表“tb_shopping04”中插入一条数据
(商品编号,商品名称,商品数量,上市日期)
values(1023,'洗衣粉','200','2008-3-5')
GO
use db_mrsql --使用db_mrsql数据库
select * from  tb_shopping04  --查看插入数据后数据表中的信息



use db_mrsql  --使用db_mrsql数据库        
insert into car04 –-向车辆信息表中插入一条数据
(车辆编号,车辆名称)
values(1001,'车辆1') 


use db_mrsql--使用db_mrsql数据库
GO
--查询数据表中的信息内容
select * from tb_person04
--向数据表中插入一条数据
insert into 
tb_person04(人员编号,人员名称,人员备注) 
values(1004,'王强','他是一名勤奋的人！')
--查询插入后的数据表中的信息情况
select * from tb_person04


use db_mrsql--使用db_mrsql数据库
GO
--判断“tb_stu04”信息表是否存在，如果存在将该信息表删除
      if exists(select * from INFORMATION_SCHEMA.TABLES 
        where table_name = 'tb_stu04')
        drop table tb_stu04  --删除该信息表
GO
--创建tb_stu04数据信息表
create table tb_stu04
(
 编号 char(11) NOT NULL,
 姓名 varchar(40) NOT NULL,
 出生年月日 datetime ,--将该字段设置为日期时间类型
 备注 text
)
GO
--向该表中插入数据
insert into tb_stu04 values('M-1001','张晓波',getdate(),'无')
--查看插入数据后的信息
select * from tb_stu04


use db_mrsql--使用db_mrsql数据库
GO
/*基于员工信息表“tb_yuangong05”
创建视图“view_yuangong”*/
create view view_yuangong
as
select * from tb_yuangong05
--查看创建后的视图信息
select * from view_yuangong
insert into view_yuangong 
values(1008,'孙涛','230108888888XXXXXX','暂无')
GO
select * from tb_yuangong05





use db_mrsql --使用db_mrsql数据库
GO
--查询插入前的图书信息表“tb_booksell05”中的数据
select * from tb_booksell05
insert into 
tb_booksell05(bookname,id,bookprice,booksum)
values('XX小说',10008,20,10)
GO
--查询插入后的图书信息表中的数据
select * from tb_booksell05



use db_mrsql--使用db_mrsql数据库
--创建工人信息"tb_worker05"表
create table tb_worker05
(
  工人编号 int,
  工人姓名 varchar(20),
  工人性别 char(2),
  工人备注 varchar(50)
)
insert into tb_worker05
values('m101','小强','女','暂无')



use db_mrsql--使用db_mrsql数据库
insert into tb_pupil05
values(1001,'王月','女')



use db_mrsql –使用db_mrsql数据库
--向学生信息表“tb_stu04”中,一次插入3条数据
insert into tb_stu04
values
(1001,’jim’,’男’),
(1002,’tom’,’女’),
(1003,’marry’,’女’);



use db_mrsql--使用db_mrsql数据库
GO
--查看插入数据后的信息
select * from tb_stu04
/*使用SELECT语句批量插入数据,
把学生基本信息表“tb_stu04”中的数据批量追加*/
insert into tb_stu04 select * from tb_stu04
--查询批量插入数据后数据表中的信息
select * from tb_stu04




use db_mrsql--使用db_mrsql数据库
GO
/*查询数据表“tb_stu05”中的数据信息，把
查找搭配的“学生编号”、“学生姓名”、
“学生总成绩”字段信息插入到新创建的数据
表“tb_newstu05”中*/
select 学生编号,学生姓名,学生总成绩
into tb_newstu05
from tb_stu05
GO
--查看“tb_stu05”数据表中的数据信息
select * from tb_stu05
--查看新创建的数据表“tb_newstu05”中的数据信息
select * from tb_newstu05




use db_mrsql --使用db_mrsql数据库
GO
EXEC master..xp_cmdshell
'bcp db_mrsql.dbo.tb_car04 out F:\db_student.txt -c -q -S "MRGWH" -U "sa" -P""'



SELECT * into tb_mrgwh22
FROM OpenDataSource( 'Microsoft.Jet.OLEDB.4.0',
  'Data Source="e:\mrgwh.xls";
User ID=Admin;Password=;
Extended properties=Excel 5.0')...Sheet1$
/*动态文件名
declare @fn varchar(20),@s varchar(1000)
set @fn = 'e:\mrgwh.xls'
set @s = '"Microsoft.Jet.OLEDB.4.0","Data Source="'+@fn+'";User ID=Admin;Password=;
Extended properties=Excel 5.0"'
set @s = 'SELECT * FROM OpenDataSource ('+@s+'))...Sheet1$
exec (@s)'
*/



use db_mrsql --使用db_mrsql数据库
GO
EXEC master..xp_cmdshell 'bcp db_mrsql.dbo.tb_yuangong05 out E:\db_yuangong.xls -c -q -S "MRGWH" 
-U"sa" -P""'




insert into tb_mrfang22
 select 员工姓名,员工编号,所在部门 from openrowset
('Microsoft.Jet.OLEDB.4.0',
'E:\mrfdw.mdb';'admin';'',tb_mrMembers22)



insert into openrowset
('Microsoft.Jet.OLEDB.4.0',
'E:\mrfdw.mdb';'admin';'',tb_mrfdw22)
select * from db_sql..tb_mrgwh22



--第九章
use db_mrsql--使用db_mrsql数据库
GO
--查询修改教师信息表“tb_teacher06”前的数据表中的信息
select * from tb_teacher06
GO
/*将教师信息表“tb_teacher06”中的所有
教师备注字段中的信息修改为“对待工作认真负责！”*/
update tb_teacher06 set 
教师备注='对待工作认真负责！'
GO
--查询修改教师信息表“tb_teacher06”后的数据表中的信息
select * from tb_teacher06
GO




use db_mrsql--使用db_mrsql数据库
GO
--查看车辆数据表tb_car04中的信息情况
select * from tb_car04
GO
/*修改“车辆编号”为“1001”的信息
的“备注”的信息内容为"这是一部好车！"*/
update tb_car04 set 备注='这是一辆好车！'
where 车辆编号=1001 
GO
--查看修改后的表中的信息情况
select * from tb_car04



use db_mrsql--使用db_mrsql数据库
--查询修改前的数据表"tb_stuscore06"中的数据
select * from tb_stuscore06
--使用UPDATE语句中带有TOP子句,即修改前两条数据的信息
update top(2) tb_stuscore06 set 学生备注='是一名好学生！'
--查询修改后的数据表"tb_stuscore06"中的数据
select * from tb_stuscore06   



use db_mrsql    --使用db_mrsql数据库
GO
--判断“tb_memberCard04”信息表是否存在，如果存在将该信息表删除
      if exists(select * from INFORMATION_SCHEMA.TABLES 
        where table_name = 'tb_memberCard04')
        drop table tb_memberCard04  --删除该信息表
GO
--创建数据表 
create table tb_memberCard04
(
 会员编号 int,
 会员姓名 varchar(20),
 会员卡积分 float,
 会员卡等级 varchar(20)
)
--向tb_memberCard04数据表中的信息
insert into tb_memberCard04 values(1,'于洋',30,'银卡')
insert into tb_memberCard04 values(2,'王雪',80,'金卡')
insert into tb_memberCard04 values(3,'张波',120,'vip')
insert into tb_memberCard04 values(4,'齐春苗',140,'vip')
GO
--查询插入数据后的表中的信息的情况
select * from tb_memberCard04 
--修改数据表中的信息 
update tb_memberCard04 
set 会员卡积分=会员卡积分+
   (select 会员卡积分 
    from  tb_memberCard04
    where 会员编号='1'   
   )
where 会员卡等级='vip'
--查询修改后的数据表中的信息
select * from tb_memberCard04



use db_mrsql--使用db_mrsql数据库
GO
--修改数据表中的信息 
update tb_memberCard04 
set 会员卡积分=会员卡积分+
   (select 会员卡积分 
    from  tb_memberCard04
    where 会员卡等级='vip'   
   )
where 会员卡等级='vip'
--查询修改后的数据表中的信息的情况
select * from tb_memberCard04 



use db_mrsql --使用db_mrsql数据库
--查询会员基本信息表“tb_hy04”中的信息情况
select * from tb_hy04
--查询会员卡基本信息表“tb_hycard04”中的信息情况
select * from tb_hycard04
GO
--使用连接查询来修改会员卡基本信息表中的信息
 update tb_hycard04
 set 卡中金额=卡中金额+
 (
     select tb_hy04.会员积分 from tb_hy04 inner join 
     tb_hycard04 on tb_hy04.会员编号=tb_hycard04.会员编号   
  )
 where tb_hycard04.会员编号=1001
GO
--查询修改后的会员卡基本信息表中的信息情况
select * from tb_hycard04



use db_mrsql--使用db_mrsql数据库
GO
--查询数据表中的信息内容
select * from tb_money04
--修改“tb_money04”信息表
update tb_money04 set 基本工资=基本工资+50,浮动奖金=浮动奖金+100
where 工人编号 in 
(
select 工人编号 
from tb_work04 where 
工人编号=tb_money04.工人编号 and 职务='财会'
)
--查询修改后的数据表中的信息内容
select * from tb_money04



use db_mrsql--使用db_mrsql数据库
--查询赋值前的数据表“tb_login06”中的信息
select * from tb_login06
/*使用UPDATE为表中的所有行中的数据赋值(即：修改编号的值)*/
declare @i as int;
set @i=1000;
update tb_login06 set @i=编号=@i+1
--查询赋值后的数据表“tb_login06”中的信息
select * from tb_login06



use db_mrsql--使用db_mrsql数据库
--查询赋值前的数据表“tb_person06”中的信息
select * from tb_person06
/*使用UPDATE为表中的所有行中的数据赋值(即：修改人员备注的值)*/
declare @i as varchar(50);
set @i='暂无备注！';
update tb_person06 set 人员备注=@i 
where 人员性别='男'
--查询赋值后的数据表“tb_person06”中的信息
select * from tb_person06



use db_mrsql--使用db_mrsql数据库
select * from tb_user06
declare @A as varchar(20);
set @A='123456';
update tb_user06 set userpwd=@A
where userid=1001
select * from tb_user06


use db_mrsql--使用db_mrsql数据库
GO
--查看更新数据前工资信息表“tb_wage05”中的数据
select * from tb_wage05
--第一步
update tb_wage05 
set  工资=工资*(1-0.08)
where 工资<1800 and 工资>800
--第二步
update tb_wage05
set 工资=工资*(1-0.1)
where 工资>1800
--查看更新后的工资信息表"tb_wage05"中的数据
select * from tb_wage05


use db_mrsql--使用db_mrsql数据库
--查看修改数据前的数据表中的信息
select * from tb_employee05
--修改指定日期字段内的数据
update tb_employee05
set 员工性别='女'
where 员工生日='1988-02-16'
--查看修改数据后的数据表中的信息
select * from tb_employee05


use db_mrsql--使用db_mrsql数据库
--查看修改数据前的数据表中的信息
select * from tb_employee05
--修改指定int字段类型内的数据
update tb_employee05
set 员工姓名='王雪'
where 员工编号='1004'
--查看修改数据后的数据表中的信息
select * from tb_employee05



use db_mrsql--使用db_mrsql数据库
--查看修改数据前的数据表中的信息
select * from tb_employee05
--修改指定int字段类型内的数据
update tb_employee05
set 工资金额='1200'
where 员工姓名='王涛'
--查看修改数据后的数据表中的信息
select * from tb_employee05


use db_mrsql--使用db_mrsql数据库
--查看修改数据前的数据表中的信息
select * from tb_employee05
--修改指定int字段类型内的数据
update tb_employee05
set 员工姓名='jim'
where 工资金额='1000'
--查看修改数据后的数据表中的信息
select * from tb_employee05



use db_mrsql--使用db_mrsql数据库
GO
--判断员工信息表“tb_yuangong04”是否存在，如果存在将该信息表删除
      if exists(select * from INFORMATION_SCHEMA.TABLES 
        where table_name = 'tb_yuangong04')
          drop table tb_yuangong04  --删除员工信息表
GO
--创建员工基本信息数据表
create table tb_yuangong04
(
  员工编号 int,  
  员工姓名 varchar(20),
  家庭住址 varchar(50),
  备注 text
)
--向表中插入一条数据
insert into tb_yuangong04 values(1001,'张明慧','吉林省长春市','无')
--查询插入后的数据信息
select * from tb_yuangong04
--删除员工信息表“tb_yuangong04”中的所有数据
delete from tb_yuangong04
--查询删除数据后的信息
select * from tb_yuangong04




use db_mrsql--使用db_mrsql数据库
/*查询删除员工数据表“tb_work06”
之前数据表中的信息*/
select * from tb_work06
/*删除员工信息表“tb_work06”
中家庭住址为吉林省长春市的信息*/
delete from tb_work06 
where 家庭住址='吉林省长春市'
/*查询删除员工数据表“tb_work06”
之后数据表中的信息*/
select * from tb_work06



use db_mrsql--使用db_mrsql数据库
GO
--判断商品销售信息表“tb_sell04”是否存在，如果存在将该信息表删除
      if exists(select * from INFORMATION_SCHEMA.TABLES 
        where table_name = 'tb_sell04')
        drop table tb_sell04  --删除商品信息表
GO
--创建商品销售信息表“tb_sell04”
create table tb_sell04
( 
  商品编号 int identity(1001,1),
  商品名称 varchar(20),
  销售数量 int,
  商品说明 text
)
GO
--向该信息表中插入信息
insert into tb_sell04 values('上衣',100,'无')
insert into tb_sell04 values('毛衣',80,'新品上市！')
--查询插入前的数据的信息
select * from tb_sell04
--删除商品名称为“毛衣”的这条数据信息
delete from tb_sell04 where 商品名称='毛衣'
--查询删除后的表中的数据信息
select * from tb_sell04



use db_mrsql--使用db_mrsql数据库
--查询数据表tb_score04的数据信息
select * from tb_score04
--删除学生编号为“1002”学生姓名为“王晓佳”的重复的两条数据
delete  from tb_score04 
where 学生编号=1002 and 学生姓名='王晓佳'
--查询删除信息后的数据表中的信息
select * from tb_score04    



 use db_mrsql--使用db_mrsql数据库
GO
--判断tb_num04信息表是否存在，如果存在将该信息表删除
      if exists(select * from INFORMATION_SCHEMA.TABLES 
        where table_name = 'tb_num04')
        drop table tb_num04  --删除该信息表
GO
--创建数据表
create table tb_num04
(
  编号 int identity(1,1),
  姓名 varchar(20)
)
--向表中插入数据信息
insert into tb_num04 values('李春梅')
insert into tb_num04 values('王雪健')
insert into tb_num04 values('李春梅')
--查询插入数据信息后的数据表中的信息
select * from tb_num04
--删除tb_num04中的部分重复行
Delete from tb_num04 where 编号 not in 
(select max(编号) from tb_num04 group by 姓名)
--查询删除tb_num04中的部分重复行后的数据表中的信息
select * from tb_num04  



use db_mrsql   --使用db_mrsql数据库 
--利用TRUNCATE TABLE语句删除登录信息表“tb_login04”中的数据的信息      
truncate table tb_login04 



use db_mrsql--使用db_mrsql数据库
--查询删除信息前的数据表"tb_stuscore06"中的数据
select * from tb_stuscore06
/*删除数据表中的前条数据的信息*/
delete top(3) tb_stuscore06 
--查询删除后的数据表"tb_stuscore06"中的数据
select * from tb_stuscore06  



use db_mrsql--使用db_mrsql数据库
--查看修改数据前的数据表中的信息
select * from tb_employee05
--删除指定字段为空记录的记录的信息
delete from tb_employee05 
where 员工性别 is null and 工资金额 is null
--查看修改数据后的数据表中的信息
select * from tb_employee05 



use db_mrsql--使用db_mrsql数据库
--查询“tb_hy06”数据表中的信息
select * from tb_hy06
GO
--使用create view语句基于“tb_hy06”创建一个视图
create view view_hy06
as 
select * from tb_hy06 where 性别='女'
GO
--查看更新视图之前视图中的数据
select * from view_hy06
GO 
--查看更新视图之前数据表中的数据
Select * from tb_hy06
--通过视图更新表和视图中的数据
update view_hy06 
set 编号='1000'+编号
where 姓名='王思齐'
--查看更新视图后视图中的数据
select * from view_hy06
--查看更新视图后数据表中的数据
select * from tb_hy06




use db_mrsql--使用db_mrsql数据库
--查询更新前的表中的数据
select * from tb_hy06
/*更新表中的数据*/
delete from view_hy06 where 姓名='李强'
--查询更新后的表中的数据
select * from tb_hy06

--第十章
Use db_mrsql
Select 商品名称 From tb_commodity05



Use db_mrsql
Select 编号,商品名称,商品价格 From tb_commodity05



Use db_mrsql
Select * From tb_commodity05


Use db_mrsql
select ID as"编号",Name as "姓名",ChineseScore,
MathSocre,EnglishSocre from tb_studentScore05



use db_mrsql
select tb_studentScore05.ID as "成绩中的编号",
tb_studentInfo05.ID as "信息中的编号",tb_studentScore05.Name
from tb_studentScore05,tb_studentInfo05
where tb_studentInfo05.ID=tb_studentScore05.ID




use db_mrsql
select ID,Name,ChineseScore,MathSocre,EnglishSocre,
(ChineseScore+MathSocre+EnglishSocre) as "三科成绩总分数"
 from tb_studentScore05

 
 
 use db_mrsql
select sum(ChineseScore) as "全班语文成绩总分" ,
avg(chineseScore) as "全班语文成绩平均分" 
from tb_studentScore05


use db_mrsql
select * from tb_studentScore05
select top 2  * from tb_studentScore05



use db_mrsql
select * from tb_studentScore05
select top 60 percent * from tb_studentScore05



use db_mrsql
select * from tb_studentScore05
select top 3 * from tb_studentScore05 order by ID  desc



use db_mrsql
select Name+sex as "学生信息" from tb_studentInfo05



use db_mrsql
select 编号,商品名称,单价-进价 as 销售利润 from tb_goods05


use db_mrsql
select 编号,商品名称,销售数量*单价 as 销售额 from tb_goods05


use db_mrsql
select 编号,商品名称, (销售数量*单价-进价*销售数量)/销售数量
as 销售利润 from tb_goods05


use db_mrsql
select 编号,商品名称,销售数量,进价+50 as 进价,单价 from tb_goods05


use db_mrsql
select 编号,商品名称,convert(char(2),销售数量)+'台' as 销售数量 ,
convert(char(8),进价)+'元' as 进价 from tb_goods05



use db_mrsql
select 编号,商品名称,1+1,'字符'+'串列'from tb_goods05




use db_mrsql
select * from tb_goods05 where 编号=003



use db_mrsql
select * from tb_goods05 where 销售数量>35


use db_mrsql
select * from tb_goods05 where 销售数量<35


use db_mrsql
select * from tb_goods05 where 销售数量>=35



use db_mrsql
select * from tb_goods05 where 销售数量<=35



use db_mrsql
select * from tb_goods05 where 进价!>1500



use db_mrsql
select * from tb_goods05 where 进价!<1200


use db_mrsql
select * from tb_goods05 where 商品名称 <> '冰箱'
select * from tb_goods05 where 商品名称 != '冰箱'



use db_mrsql
select * from tb_goods05 where 进价 between 1200 and 3000



use db_mrsql
select * from tb_landing07
select * from tb_landing07 where 登录时间 between
convert(varchar(10),DATEADD(DAY,-1,GETDATE()),120) and
 convert(varchar(10),GETDATE(),120)

 
 
 use db_mrsql
select * from tb_goods05 where 进价 not between 2000 and 3000



use db_mrsql
select * from tb_commodity05
select * from tb_commodity05 where 商品名称 = '电脑' or 商品名称 = '手机'



use db_mrsql
select * from tb_goods05
select * from tb_goods05 where not 商品名称='电脑'



use db_mrsql
select * from tb_goods05
select * from tb_goods05 where 商品名称='冰箱'OR 商品名称='电脑'AND 进价=3000
select * from tb_goods05 where (商品名称='冰箱'OR 商品名称='电脑')AND 进价=3000



use db_mrsql
select * from tb_landing07
select 编号,登录名,密码,convert(nvarchar(10),登录时间,120) as 登录时间 
from tb_landing07



use db_mrsql
select * from tb_average07
select 编号,姓名,convert(decimal(10,2),平均分数) as 平均分数 from tb_average07



use db_mrsql
select * from tb_average07
select 编号,ltrim(姓名) as 姓名 ,平均分数 from tb_average07


use db_mrsql
select * from tb_commodity05
select * from tb_commodity05 where 
商品价格 < 5000 and 商品价格 > 1500


use db_mrsql
select * from tb_landing07
select * from tb_landing07 where 登录时间 
between '2013-3-15' and '2013-3-16'


use db_mrsql
select * from tb_individualInfo05
select distinct 职业  from tb_individualInfo05


--第十一章
use db_mrsql
select * from tb_individualInfo05 
select * from tb_individualInfo05 where 姓名 like'王%'



use db_mrsql
select * from tb_individualInfo05 
select * from tb_individualInfo05 where 姓名 like '王小_'



use db_mrsql
select * from tb_employee06
select * from tb_employee06 where 工号 like 'A001[0-9]2'


use db_mrsql
select * from tb_employee06
select * from tb_employee06 where 工号 like '[^A]%'



use db_mrsql
select * from tb_str05 
select * from tb_str05 where Ооич like '[s[a-z]]df' 
select * from tb_str05 where Ооич like '\[s[a-z]]df' escape '\'



use db_mrsql
select * from tb_studentInfo05
select * from tb_studentInfo05 where Name  in('苏小雨','刘小詹')


use db_mrsql
select * from tb_studentInfo05
select * from tb_studentInfo05 where Age in(13+1,15)


use db_mrsql
select * from tb_studentScore05
select * from tb_studentScore05 where 89 in(ChineseScore,MathSocre)


use db_mrsql
select * from tb_studentInfo05
select * from tb_studentInfo05 where Name not in('苏小雨','刘小詹')


use db_mrsql
select * from tb_employeePay08
select * from tb_employeePay08 where 编号 not in 
(select top 8 编号 from tb_employeePay08 )


use db_mrsql
select * from tb_employee06
select top 1 * from tb_employee06 order by newID() 
select top 1 * from tb_employee06 order by newID()


use db_mrsql
select * from tb_employee06
select 编号=(select count(姓名)from tb_employee06 as A 
where A.姓名<=B.姓名),工号,姓名,性别,职务,部门 from tb_employee06
 as B order by 1

 
 
 use db_mrsql
select * from tb_employee06
select 编号=identity(int,1,1),工号,姓名,性别,职务,部门
into #s1 from tb_employee06
go
select * from #s1
go
drop table #s1
go



use db_mrsql
select * from tb_student06
select 编号,姓名,性别,年龄 from(select row_number() over (order by 编号) 
n,编号,姓名,性别,年龄 from tb_student06 )x
where n%2=1



use db_mrsql
select * from tb_bookInfo06
select * from tb_bookInfo06 where 出版社 is null

 

--第十二章

use db_mrsql
select * from tb_str05 where Ооич like '%%' 
select * from tb_str05 where Ооич like '\%%' escape '\'



use db_mrsql
select * from tb_student06
select 编号,姓名,性别,年龄 from(select row_number() over (order by 编号) 
n,编号,姓名,性别,年龄 from tb_student06 )x
where n between 3 and 6






use db_mrsql
select * from tb_student06
select 编号,姓名,性别,年龄 from(select row_number() over (order by 编号) 
n,编号,姓名,性别,年龄 from tb_student06 )x
where n between 3 and 6




use db_mrsql
select * from tb_bookInfo06
select * from tb_bookInfo06 where 出版社 is null


use db_mrsql
select * from tb_bookInfo06
select * from tb_bookInfo06 where зїеп is not null


use db_mrsql
select * from tb_bookInfo06
select 编号,书名,作者,isnull(出版社,'无') as 出版社,价格 from tb_bookInfo06


use db_mrsql
select * from tb_bookInfo06
select 编号,书名,作者,nullif(出版社,'电月') as 出版社,价格 
 from tb_bookInfo06

 
 use db_mrsql
select * from tb_employee06
select * into tb_programmer from tb_employee06 where 职务='程序员'
select * from tb_programmer


use db_mrsql
select * from tb_employee06
select * into #DONET from tb_employee06 where 部门='.NET'
select * from #DONET


use db_mrsql
select * from tb_studentScore05
select * from (select top 3 * from tb_studentScore05) aa 
where not exists (select * from (select  top 2 * from tb_studentScore05) 
bb where aa.id=bb.id )


use db_mrsql
select * from tb_student06

create procedure PRO_student
@n int
as 
select * from (select top (@n) * from tb_student06) aa 
where not exists (select * from (select  top (@n-1) * from tb_student06)
 bb where aa.编号=bb.编号 )

exec PRO_student 2


use db_mrsql
select * from tb_chineseScore06
select a.学号,b.考试号,a.成绩 from 
(select 学号,max(成绩) as 成绩 from tb_chineseScore06 group by 学号)as a
inner join tb_chineseScore06 as b on 
a.学号=b.学号 and a.成绩=b.成绩 order by a.学号


use db_mrsql
select * from tb_employeePay08
select 工号,姓名,职务,部门,(select count(工号) from tb_employeePay08 a where 
a.部门=b.部门 )as 部门人数 from tb_employeePay08 b where 职务='经理'


use db_mrsql
select * from tb_employeePay08
select * from tb_employeePay08 a where 基本工资=
(select min(基本工资)from tb_employeePay08 b where a.部门=b.部门 and 职务!='经理' )




--第十三章

select *
FROM tb_Stu07
ORDER BY age DESC
SELECT *
FROM tb_Stu07
ORDER BY age ASC



SELECT id, name, sex, age AS 年龄, address, speciality, class
FROM tb_Stu07
ORDER BY 年龄 DESC



SELECT id, name, sex, age AS '年 龄', address, speciality, class
FROM tb_Stu07
ORDER BY '年 龄' DESC


SELECT id, name, sex, age AS 年龄, address, speciality, class, DATEADD(year, 
      - (age - 1), GETDATE()) AS 出生年月
FROM tb_Stu07
ORDER BY DATEADD(year, - (age - 1), GETDATE())


INSERT INTO tb_Stu07
      (id, name, sex, address, speciality, class)
VALUES ('xh04033332', '蒙蒙X', '女', '吉林', '英语', '04188')
SELECT *
FROM tb_Stu07


INSERT INTO tb_Stu07
      (id, name, sex, address, speciality, class)
VALUES ('xh04034432', '小花x', '女', '吉林', '计算机', '04088')
SELECT *
FROM tb_Stu07
ORDER BY age DESC



SELECT *
FROM tb_pro07
ORDER BY prod_price, prod_name



SELECT TOP 1 *
FROM tb_pro07
ORDER BY prod_price



select * from
(select prod_id,prod_price,prod_name 
from tb_pro07
order by prod_price desc) 
where rownum<=3;




select * from
(select * from tb_pro07 order by prod_price desc)
where rownum=1;




SELECT *
FROM tb_order07
ORDER BY RIGHT(xh, Len(xh)-1)



SELECT *
FROM tb_order07
ORDER BY YEAR(order_date) DESC, MONTH(order_date) DESC, DAY(order_date) DESC



SELECT *
FROM tb_test07
ORDER BY CAST(STUFF(xh, 1, 1, ' ') AS int) DESC



select t.* 
from tb_test07 t 
order by cast(substr(xh,2) as int)



SELECT *
FROM tb_lk07
WHERE (lh = 'A座')
ORDER BY CHARINDEX(LEFT(dy, 1), '一二三四五六七八九十') DESC



SELECT *
FROM tb_name07
ORDER BY LEFT(name, 1) COLLATE Chinese_PRC_Stroke_CS_AS_KS_WS DESC



SELECT TOP 3 *
FROM tb_pro07
ORDER BY prod_price DESC


SELECT *
FROM tb_name07
ORDER BY LEFT(name, 1) COLLATE Chinese_PRC_CS_AS_KS_WS DESC



SELECT *
FROM tb_Stu07
ORDER BY 4 DESC



SELECT *
FROM tb_pro07
ORDER BY 2, 3


SELECT name, job, salary, 
      CASE job WHEN '会计' THEN salary * 1.15 WHEN '秘书' THEN salary * 1.20 WHEN '程序员'
       THEN salary * 1.25 WHEN '经理' THEN salary * 1 END AS [new salary]
FROM tb_emp07
ORDER BY CASE job WHEN '会计' THEN salary * 1.15 WHEN '秘书' THEN salary * 1.20 WHEN
       '程序员' THEN salary * 1.25 WHEN '经理' THEN salary * 1 END

	   
	   
	   select name,job,salary,DECODE(job,'会计',salary*1.15,
'秘书',salary*1.20,
'程序员',salary*1.25,
'经理',salary*1) as "new salary"
from tb_emp07
order by "new salary";



SELECT *
FROM (SELECT TOP 3 *
        FROM tb_Stu07
        ORDER BY newid()) DERIVEDTBL
ORDER BY age



INSERT INTO tb_Stu07
      (id, name, sex, address, speciality, class)
VALUES ('xh04034432', '小花x', '女', '吉林', '计算机', '04088')
SELECT *
FROM tb_Stu07
ORDER BY age DESC




--第十四章
SELECT AVG(salary) AS 平均值
FROM tb_treatment08


SELECT AVG(num) 
FROM tb_EA08


SELECT AVG(salary) AS 平均工资
FROM tb_treatment08
WHERE (salary > 2500)



SELECT COUNT(*) AS 个数
FROM tb_treatment08
WHERE (salary > 2500)



SELECT COUNT(duty) AS 个数
FROM tb_treatment08


SELECT AVG(salary) AS 去掉最大值与最小值的平均值
FROM tb_treatment08
WHERE salary NOT IN
          ((SELECT MIN(salary) AS 最小值
          FROM tb_treatment08)
      UNION
      (SELECT MAX(salary) AS 最大值
      FROM tb_treatment08))

	  
	  
	  SELECT SUM(salary) AS 所有薪水加和
FROM tb_treatment08


SELECT SUM(salary + bonus) AS 实发工资的加和
FROM tb_treatment08


SELECT *
FROM tb_treatment08
WHERE (birthday BETWEEN '1980-01-01' AND '1990-01-01') AND (salary >
          (SELECT AVG(salary)
         FROM tb_treatment08))

		 
		 
		 select NVL(duty,'暂无职位'),
count(NVL(duty,'暂无职位')) 职位个数 
from tb_treatment08 
group by NVL(duty,'暂无职位');


SELECT dept, AVG(salary) AS 工资平均值, SUM(bonus) AS 奖金总和, MAX(salary) 
      AS 最高工资, MIN(salary) AS 最低工资, COUNT(*) AS 人数
FROM tb_treatment08
GROUP BY dept


SELECT dept, sex, AVG(salary) AS 工资平均值, SUM(bonus) AS 奖金总和, MAX(salary) 
      AS 最高工资, MIN(salary) AS 最低工资, COUNT(*) AS 人数
FROM tb_treatment08
GROUP BY dept, sex



SELECT name + ' 是 ' + sex + '性 ' AS 基本资料, 
      '是 ' + dept + '的' + duty AS expression2
FROM tb_treatment08
GROUP BY 基本资料, expression2



SELECT dept, name, SUM(salary) AS 工资总和
FROM tb_treatment08
GROUP BY ROLLUP (dept, name);

SELECT dept, duty, SUM(salary) AS 工资总和
FROM tb_treatment08
GROUP BY dept, duty WITH ROLLUP



SELECT dept, name, SUM(salary) AS 工资总和
FROM tb_treatment08
GROUP BY CUBE (dept, name);

SELECT dept, duty, SUM(salary) AS 工资总和
FROM tb_treatment08
GROUP BY dept, duty WITH cube



SELECT duty, COUNT(*) AS ?λ??
FROM tb_treatment08
GROUP BY duty



SELECT dept, salary, COUNT(dept) AS 人数
FROM tb_treatment08
WHERE (birthday BETWEEN '1980-01-01' AND '1990-01-01')
GROUP BY dept, salary
HAVING (salary >
          (SELECT AVG(salary)
         FROM tb_treatment08))
ORDER BY salary DESC



SELECT duty, dept
FROM tb_treatment08
GROUP BY dept, duty
HAVING (duty NOT IN ('经理'))



select * from tb_treatment08 
order by dept
compute sum(salary),min(salary),avg(salary)



select * from tb_treatment08 
order by dept
compute sum(salary),min(salary),avg(salary) by dept


SELECT dept, COUNT(dept) AS 部门个数
FROM tb_treatment08
GROUP BY dept
ORDER BY 部门个数 DESC



SELECT *
FROM tb_treatment08
WHERE (salary > ALL
          (SELECT AVG(salary)
         FROM tb_treatment08
         GROUP BY dept))

		 
		 
		 SELECT AVG(salary) AS 平均工资
FROM tb_treatment08
GROUP BY dept

--第十五章
use db_mrsql
select tb_book_author,tb_author_department,
	(select max(book_price)
		from tb_book12 
		where tb_book12.tb_book_author=tb_book_author12.tb_book_author),
	tb_book_author_id,tb_author_resume
	from tb_book_author12;

	
	use db_mrsql
select 姓名,工资,所属部门
from tb_laborage12
where 工资 in (select max(工资)
		from tb_laborage12
		group by 所属部门)
and 
      所属部门 in (select distinct 所属部门
		from tb_laborage12 
)


use db_mrsql
select * 
from tb_book_author12
where tb_book_author_id>(
	select tb_book_id
	from tb_book12
	where book_price=78
)



use db_mrsql
select 姓名,工资,所属部门
from tb_laborage12
where 工资>(
	select avg(工资)from tb_laborage12)

	
	use db_mrsql
select 姓名,工资,所属部门
from tb_laborage12
where 工资 in (
	select max(工资) 
	from tb_laborage12
	group by 所属部门)
and 所属部门<>'PHP'
and 所属部门 not like 'JSP'


use db_mrsql
select * 
from tb_book12
where book_sort not in (
	select tb_author_department 
	from tb_book_author12
)



use db_mrsql
select 姓名,工资,所属部门
from tb_laborage12
where 工资 <all (
	select avg(工资) 
	from tb_laborage12
	group by 所属部门)

	
	
	use db_mrsql
select 姓名,工资,所属部门
from tb_laborage12
where 工资 >any (
	select avg(工资) 
	from tb_laborage12
	group by 所属部门)

	
	
	use db_mrsql
select * 
from tb_book12
where exists (
	select tb_author_department 
	from tb_book_author12
	where tb_book12.book_sort=tb_book_author12.tb_author_department)
order by tb_book12.book_price



use db_mrsql
select * 
from tb_book12
where not exists(
	select tb_author_department
	from tb_book_author12
	where tb_book12.book_sort=tb_book_author12.tb_author_department )

	
	
	use db_mrsql
select * 
from tb_book12 
where book_sort in (
	select tb_author_department
	from tb_book_author12 
	where tb_book12.tb_book_id=tb_book_author12.tb_book_author_id )

	
	
	use db_mrsql
select * 
from tb_book12 
where book_sort not in (
	select tb_author_department
	from tb_book_author12 
	where tb_book12.tb_book_id=tb_book_author12.tb_book_author_id )

	
	
	use db_mrsql
select *
from tb_book12
where book_price=(
	select max(book_price) from tb_book12	
)



use db_mrsql
select *
from tb_book12
where book_sort='PHP' and book_price>(
	select avg(book_price)
	from tb_book12
	where book_sort='PHP'
)



use db_mrsql
select book_number,book_name,book_price,book_sort
from tb_book12
where book_sort='PHP'
group by book_number,book_name,book_price,book_sort
having avg(book_price)>(
	select min(book_price)
	from tb_book12
)
order by book_price



use db_mrsql
select book_number
from tb_book12 s1
where not exists (
	select * 
	from tb_book12 s2
	where s2.book_number='1001-100-102' and not exists(
		select * 
		from tb_book12 s3
		where s3.book_number=s1.book_number and s3.tb_book_author=s2.tb_book_author  
	)
)


use db_mrsql
select * 
from tb_mr_wages12 
where 工资月份=3 AND 人员姓名 IN( 
      select 负责人 
      from tb_mr_department12 
      where 负责人 IN(
           select 人员姓名 
           from tb_mr_staff12 
           where 学历='本科')) 
order by 人员编号


use db_mrsql
select * 
from tb_stu_score12 
where Math_Score < some ( 
     select Math_Score
     from tb_stu_score12 
     where name in( 
          select name
          from tb_stu_score12
          where id='2' or id='4'))

		  
		  
		  use db_mrsql
update tb_book12
set book_number='1001-101-101'
where book_sort in(
	select tb_author_department 
	from tb_book_author12
	where tb_book_author='王一'
)
select book_number from tb_book12



use db_mrsql
insert into tb_book_author12 (
    tb_book_author,tb_author_department,tb_author_resume
)(
    select tb_book_author,tb_author_department,tb_author_resume
    from tb_books_author12 )
select * from tb_book_author12



use db_mrsql
delete 
from tb_books_author12
where tb_book_author_id=(
	select tb_book_author_id 
	from tb_books_author12
	where tb_book_author_id='2'
)



use db_mrsql
select *
from tb_book_author12
intersect
select *
from tb_books_author12
order by tb_book_author_id


use db_mrsql
select *
from tb_book_author12
except
select *
from tb_books_author12
order by tb_book_author_id
select * from tb_book_author12
select * from tb_books_author12


use db_mrsql
select tb_book_author_id,tb_book_author,tb_author_department,tb_author_resume
from tb_book_author12
union
select tb_book_author_id,tb_book_author,tb_author_department,tb_author_resume 
from tb_books_author12



use db_mrsql
select tb_book_author_id,tb_book_author,tb_author_department,tb_author_resume
from tb_book_author12
union all
select tb_book_author_id,tb_book_author,tb_author_department,tb_author_resume 
from tb_books_author12



use db_mrsql
select tb_book_author as 图书作者,tb_author_department,tb_author_resume
from tb_book_author12
where tb_book_author_id=1
union all
select tb_book_author,tb_author_department,tb_author_resume 
from tb_books_author12
where tb_book_author_id=3



use db_mrsql
select tb_book_author,tb_author_department,tb_author_resume,'来自tb_book_author12表' as 数据来源
from tb_book_author12
union 
select tb_book_author,tb_author_department,tb_author_resume,'来自tb_books_author12表' 
from tb_books_author12


use db_mrsql
select *
from tb_book_author12
where tb_book_author_id=4
union all
select * 
from tb_book_author12
where tb_book_author_id!=4


use db_mrsql
with tb_book_price(book_sort,book_price)
as(
select tb_book12.book_sort,avg(tb_book12.book_price) as 平均价格
from tb_book12 
where tb_book12.book_sort='PHP'
group by book_sort
)
select max(book_price) as 平均价格 from tb_book_price


use db_mrsql
with x(部门编号,cnt,list,emps_id,length)  /*创建一个临时表x,包括5个字段*/
as(
select 部门编号,count(*) over (partition by 部门编号),
cast (员工姓名 as varchar (1000)),emps_id,1
from tb_emps12
union all	/*进行连接*/
select x.部门编号,x.cnt,cast(x.list+','+e.员工姓名 as varchar(1000)),e.emps_id,x.length+1
from tb_emps12 e,x
where e.部门编号=x.部门编号 and x.emps_id>e.emps_id )
select 部门编号,list
from x
where length=cnt
order by 1
/*为了更好的理解递归查询,这里给出了tb_emps09表的原始数据*/
select * from tb_emps12



--第十六章
use db_mrsql
select  * 
from tb_book12,tb_book_author12


use db_mrsql
select a.tb_book_id,a.book_name,a.book_number,a.book_price,b.tb_book_author,b.tb_author_department,c.tb_author_resume
from tb_book12 a,tb_book_author12 b,tb_books_author12 c
where a.tb_book_author=b.tb_book_author and b.tb_book_author=c.tb_book_author


use db_mrsql
select *
from  tb_book12 join tb_book_author12 join tb_books_author12
on tb_books_author12.tb_book_author=tb_book_author12.tb_book_author
on tb_book_author12.tb_author_department=tb_book12.book_sort


use db_mrsql
select tb_book12.* ,tb_book_author12.tb_author_resume
from tb_book12,tb_book_author12,tb_books_author12
where 
   tb_book12.book_price>75 
and
   tb_book12.tb_book_author=tb_book_author12.tb_book_author 
and 
   tb_book_author12.tb_author_department=tb_books_author12.tb_author_department

   
   
   use db_mrsql
select tb_book12.* 
from tb_book12,tb_book_author12,tb_books_author12
where tb_book12.tb_book_author=tb_book_author12.tb_book_author and tb_book_author12.tb_book_author=tb_books_author12.tb_book_author


use db_mrsql
select a.* 
from tb_book12 as a,tb_book_author12 as b,tb_books_author12 c
where a.tb_book_author=b.tb_book_author and b.tb_book_author=c.tb_book_author



use db_mrsql
select tb_book_author12.*,tb_book12.*
from tb_book_author12,tb_book12
where tb_book_author12.tb_book_author=tb_book12.tb_book_author


use db_mrsql
select tb_book12.book_name,tb_book12.book_number,tb_book12.book_price,tb_book_author12.*
from tb_book12,tb_book_author12
where tb_book_author12.tb_book_author_id>tb_book12.tb_book_id




use db_mrsql
select tb_book12.tb_book_id,tb_book12.tb_book_author,tb_book12.book_name,tb_book12.book_sort,tb_book12.book_number,tb_book_author12.tb_author_resume
from tb_book12 inner join tb_book_author12
on tb_book_author12.tb_book_author=tb_book12.tb_book_author


use db_mrsql
select fullname as 商品名称, tsum1 as 进货金额 
from (
    select a.tradecode, a.fullname,a.averageprice, b.qty1, b.tsum1 
    from tb_stock13 a inner join (
	select sum(qty) as qty1,sum(tsum) as tsum1, fullname 
        from tb_warehouse_detailed13
        group by fullname) b on a.fullname = b.fullname 
where (a.price > 0 )) tb1



use db_mrsql
select a.tb_book_id,a.book_name,a.book_number,a.book_price,b.tb_book_author,b.tb_author_department,b.tb_author_resume
from tb_book12 a left join tb_books_author12 b
on a.tb_book_author=b.tb_book_author


use db_mrsql
select a.tb_book_id,a.book_name,a.book_number,a.book_price,b.tb_book_author,b.tb_author_department,b.tb_author_resume
from tb_book12 a right join tb_books_author12 b
on a.tb_book_author=b.tb_book_author



use db_mrsql
select a.tb_book_id,a.book_name,a.book_number,a.book_price,b.tb_book_author,b.tb_author_department,b.tb_author_resume
from tb_book12 a full join tb_books_author12 b
on a.tb_book_author=b.tb_book_author



use db_mrsql
select tb_employee13.序号, tb_employee13.员工编号, 
        tb_employee13.员工姓名, tb_laborage13.薪资编号, 
        tb_laborage13.月份, tb_laborage13.基本工资, 
        tb_job13.请假天数, tb_job13.扣除金额 
from  (tb_employee13 left join tb_job13 
                      on tb_employee13.员工编号=tb_job13.员工编号) 
       left join tb_laborage13 
         on tb_employee13.员工编号=tb_laborage13.员工编号

		 
		 
		 use db_mrsql
select  a.book_name,b.book_price 
from tb_book12 a inner join tb_book12 b
on  a.tb_book_id=b.tb_book_id
where a.book_sort=b.book_sort


use db_mrsql
select  a.book_name,a.book_price,a.book_number,b.tb_author_department,b.tb_author_resume  
from tb_book12 a cross join tb_books_author12 b  





--第十七章
USE db_mrsql
GO
SELECT 库存编号,订单编号,
SUM(商品数量) OVER() AS 商品总数量,
COUNT(商品数量)OVER() AS 整个表的记录数,
AVG(商品数量)OVER() AS 平均值,
MIN(商品数量)OVER() AS 最小数量,
MAX(商品数量)OVER() AS 最大数量
FROM tb_sales09;



USE db_mrsql
GO
SELECT 订单编号, 商品编号, 订货数量
    ,SUM(订货数量) OVER(PARTITION BY 订单编号) AS '总计'
    ,AVG(订货数量) OVER(PARTITION BY 订单编号) AS '平均'
    ,COUNT(订货数量) OVER(PARTITION BY 订单编号) AS '计数'
    ,MIN(订货数量) OVER(PARTITION BY 订单编号) AS '最小'
    ,MAX(订货数量) OVER(PARTITION BY 订单编号) AS '最大'
FROM tb_MRSales09 
WHERE 订单编号 IN(1314,5257);
GO



SELECT EmployeeID,
 CAST(SUBSTRING(binstr,1,8) AS DATETIME) AS OrderDate,
 CAST(SUBSTRING(binstr,17,4) AS INT) AS OrderID,
 CAST(SUBSTRING(binstr,21,10) AS NCHAR(5)) AS CustomerID
FROM (SELECT EmployeeID,
 MAX(CAST(OrderDate AS BINARY(8))
     +CAST(OrderID AS BINARY(4))
     +CAST(CustomerID AS BINARY(10))
     ) AS binstr
FROM dbo.tb_Orders
GROUP BY EmployeeID) AS MRSOFT;


USE db_mrsql
GO  
SELECT MR.员工编号,CONVERT(VARCHAR(7),
 MR.订单月份,121)AS 订单月份,
 MR.订单数量 AS 当月数量,SUM(MRSOFT.订单数量)AS 订单总数,
CAST(AVG(1.*MRSOFT.订单数量)AS DECIMAL(12,2))AS 平均数量
FROM tb_EmpOrders09 AS MR
JOIN tb_EmpOrders09 AS MRSOFT
ON MRSOFT.员工编号=MR.员工编号 
AND MRSOFT.订单月份<=MR.订单月份
GROUP BY MR.员工编号,MR.订单月份,MR.订单数量
ORDER BY MR.员工编号,MR.订单月份;
GO



USE db_mrsql
GO
SELECT MR.员工编号,CONVERT(VARCHAR(7),MR.订单月份,121)
 AS 订单月份,
MR.订单数量 AS 当月数量,
(SELECT SUM(MRSOFT.订单数量)
FROM tb_EmpOrders09 AS MRSOFT
WHERE MR.员工编号=MRSOFT.员工编号
AND MRSOFT.订单月份<=MRSOFT.订单月份) AS 订单总数
FROM tb_EmpOrders09 AS MR
GROUP BY MR.员工编号,MR.订单月份,MR.订单数量;
GO



USE db_mrsql
GO  
SELECT MR.员工编号,CONVERT(VARCHAR(7),
 MR.订单月份,121)AS 订单月份,
 MR.订单数量 AS 当月数量,SUM(MRSOFT.订单数量)AS 订单总数,
CAST(AVG(1.*MRSOFT.订单数量)AS DECIMAL(12,2))AS 平均数量
FROM tb_EmpOrders09 AS MR
JOIN tb_EmpOrders09 AS MRSOFT
ON MRSOFT.员工编号=MR.员工编号
AND (MRSOFT.订单月份>DATEADD(month,-3,MR.订单月份)
AND MRSOFT.订单月份<=MR.订单月份)
GROUP BY MR.员工编号,MR.订单月份,MR.订单数量
ORDER BY MR.员工编号,MR.订单月份;
GO


USE db_mrsql
GO  
SELECT MR.员工编号,CONVERT(VARCHAR(7),
 MR.订单月份,121)AS 订单月份,
 MR.订单数量 AS 当月数量,SUM(MRSOFT.订单数量)AS 订单总数,
CAST(AVG(1.*MRSOFT.订单数量)AS DECIMAL(12,2))AS 平均数量
FROM tb_EmpOrders09 AS MR
JOIN tb_EmpOrders09 AS MRSOFT
ON MRSOFT.员工编号=MR.员工编号
AND (MRSOFT.订单月份>=CAST(CAST(YEAR(MR.订单月份)AS CHAR(4))
          +'0101' AS DATETIME)
AND MRSOFT.订单月份<=MR.订单月份)
GROUP BY MR.员工编号,MR.订单月份,MR.订单数量
ORDER BY MR.员工编号,MR.订单月份;
GO



use db_mrsql
select * from tb_Aeddy09			--显示原数据表
--对原数据表进行简单旋转
select max(case when 月份='一月份' then 个数 else 0 end) as '一月份',
     max(case when 月份='二月份' then 个数 else 0 end) as '二月份',
     max(case when 月份='三月份' then 个数 else 0 end) as '三月份',
     max(case when 月份='四月份' then 个数 else 0 end) as '四月份',
     max(case when 月份='五月份' then 个数 else 0 end) as '五月份',
     max(case when 月份='六月份' then 个数 else 0 end) as '六月份'  
from tb_Aeddy09



use db_mrsql
select * from tb_Aeddy09			--显示原数据表
--将数据表旋转成一行数据
select max(case when 月份='一月份' then 个数 else 0 end) as '一月份',
     max(case when 月份='二月份' then 个数 else 0 end) as '二月份',
     max(case when 月份='三月份' then 个数 else 0 end) as '三月份',
     max(case when 月份='四月份' then 个数 else 0 end) as '四月份',
     max(case when 月份='五月份' then 个数 else 0 end) as '五月份',
     max(case when 月份='六月份' then 个数 else 0 end) as '六月份' 
from tb_Aeddy09



use db_mrsql
select * from tb_distribution09			--显示原数据表
--对数据表进行旋转后求和
select sum(case when 月份='一月' then 销售个数 else 0 end) as '一月份',
     sum(case when 月份='二月' then 销售个数 else 0 end) as '二月份',
     sum(case when 月份='三月' then 销售个数 else 0 end) as '三月份',
     sum(case when 月份='四月' then 销售个数 else 0 end) as '四月份',
     sum(case when 月份='五月' then 销售个数 else 0 end) as '五月份',
     sum(case when 月份='六月' then 销售个数 else 0 end) as '六月份'
from tb_distribution09



use db_mrsql
declare @str varchar(8000)
set @str='年份,'
select @str=@str+''''+月份+''''+ '=sum(case 月份 when '+''''+月份+''''+' then 个数 else 0 end),' 
from tb_YearD09 group by 月份
set @str='select '+substring(@str,1,len(@str)-1)+',sum(个数) 总计 from tb_YearD09 group by 年份'
print(@str)	--显示@str变量中的SQL语句
exec( @str)	--执行@str变量中的SQL语句



use db_mrsql
select d.月份,
  case d.个数 
      when 一月份 then e.一月份
      when 二月份 then e.二月份
      when 三月份 then e.三月份
      when 四月份 then e.四月份
      when 五月份 then e.五月份
      when 六月份 then e.六月份
  end as 个数
from (
select max(case when 月份='一月份' then 个数 else 0 end) as '一月份',
          max(case when 月份='二月份' then 个数 else 0 end) as '二月份',
          max(case when 月份='三月份' then 个数 else 0 end) as '三月份',
          max(case when 月份='四月份' then 个数 else 0 end) as '四月份',
          max(case when 月份='五月份' then 个数 else 0 end) as '五月份',
          max(case when 月份='六月份' then 个数 else 0 end) as '六月份'  
from tb_Aeddy09) e,(select * from tb_Aeddy09) d


transform  sum(销量) as 总销量 select 语言类别 from 图书销售  group by 语言类别  pivot 销售时间


SELECT 员工姓名, SUM(CASE 所在部门 WHEN '食品部' THEN 销售业绩 ELSE NULL END) AS [食品部业绩],SUM(CASE 所在部门 WHEN '家电部' THEN 销售业绩 ELSE NULL END) AS [家电部业绩]FROM 销售 GROUP BY 员工姓名



USE db_mrsql
go
select * from tb_privot20	--显示原数据表
--用PIVOT语句实现交叉表
select 商品名称,a.[9] as [九月],a.[10] as [十月],a.[11] as [十一月],a.[12] as [十二月] 
from tb_privot20 
pivot(sum(销售数量) for 月份 
in ([9],[10],[11],[12]))as a
go



--用Sql Server 2005数据库
use db_mrsql
go
select * from tb_unpivot09	--显示自定义的旋转样式数据表
--实现数据表的反向交叉表
select 编号, 数字, Orders 
from 
   (select 编号, 数字1, 数字2, 数字3, 数字4, 数字5 
   from tb_unpivot09) p 
unpivot
   (Orders for 数字 in 
      (数字1, 数字2, 数字3, 数字4, 数字5)
)as unpvt
go



use db_mrsql
select * from tb_YearD09	--原数据表
select 年份,月份,个数 from tb_YearD09 order by 年份,月份	--为了便于观察，对数据表进行排序
--对数据表进行旋转后汇总重复字段
select 年份,  sum(case when 月份='1月' then 个数 else 0 end) as '一月份',
             sum(case when 月份='2月' then 个数 else 0 end) as '二月份',
            sum(case when 月份='3月' then 个数 else 0 end) as '三月份',
            sum(case when 月份='4月' then 个数 else 0 end) as '四月份',
            sum(case when 月份='5月' then 个数 else 0 end) as '五月份',
            sum(case when 月份='6月' then 个数 else 0 end) as '六月份'  
from tb_YearD09 group by 年份


--第十八章
use db_mrsql
go
create view 视图5
as
select distinct 
      top 100 percent dbo.tb_staff14.id as ID, dbo.tb_staff14.number as 编号, 
      dbo.tb_staff_wages14.account as 账号, dbo.tb_staff_wages14.seniority as 工龄, 
      dbo.tb_staff_wages14.wages as 工资
from dbo.tb_staff14 inner JOIN
      dbo.tb_staff_wages14 on dbo.tb_staff14.id = dbo.tb_staff_wages14.id
where (dbo.tb_staff14.number = 1026)
go
exec sp_helptext'视图5'



use db_mrsql
go
create view 视图7 
as
select name,number,duty,department,tel
from tb_staff14



use db_mrsql
go
alter view 视图4(name,number)
as
select a.name,b.number
from dbo.tb_staff14 as a inner join dbo.tb_staff_wages14 as b on a.number=b.number
where a.number>1000 and a.number<9999
go 
exec sp_helptext '视图4'



use db_mrsql
exec sp_help 视图2
go



use db_mrsql
go
drop view 视图3,视图4
go



use db_mrsql
go
----创建视图
create view 视图9 
as 
select a.name,a.number,a.duty,a.department,b.account,b.seniority
from tb_staff14 as a inner join tb_staff_wages14 as b on a.number=b.number 
go
----添加数据
insert into 视图9(name,number,duty,department)
values('孙**','1029','程序员','PHP')
go
insert into 视图9(account,seniority)
values('220322****','1')
go



use db_mrsql
update 视图1 set name='李一' where number='1026'
go 
update 视图9 set seniority='2' where number='1015'



use db_mrsql
go
create view 视图10
as
select order_number,client_name,client_tel,client_postalcode
from tb_commodity14,tb_order14,tb_client14
where tb_commodity14.number=tb_order14.number and tb_order14.order_name=tb_client14.client_name
use db_mrsql
go
select client_name,client_tel,client_postalcode
from 视图10
where order_number='1001'





use db_mrsql
go
create view 视图11 
as
select client_name,client_tel
from tb_client14
where client_tel is not null
use db_mrsql
go
select * from 视图11



use db_mrsql
go
create view 视图11 
as
select client_name,client_tel
from tb_client14
where client_tel is not null
use db_mrsql
go
select * from 视图11





use db_mrsql
go
create view 视图13(item_number,description,order_ct,sold_ct,avg_sales_price,total_cost,total_sales,profit,pct_profit)
as
select 视图12.item,description,order_ct,sold_ct,avg_sales_price,sold_ct*item_cost,sold_ct*avg_sales_price,(avg_sales_price*sold_ct)-(sold_ct*item_cost),(((avg_sales_price*sold_ct)-(sold_ct*item_cost))/(sold_ct*item_cost))*100
from tb_item14,视图12
where tb_item14.item_number=视图12.item




use db_mrsql
go
create view 视图14
as 
select * from tb_order14 
where order_name='潘一'
with check option




use db_mrsql
go
create view 视图15
with encryption
as
select a.number,a.name,b.counts
from tb_commodity14 as a inner
join tb_marketing14 as b on a.number=b.number
go
exec sp_helptext '视图15'



use db_mrsql
go
create view 视图16
as
select number,name,specification,habitat,retail,wholesale
from tb_commodity14
go
use db_mrsql
select number,name,specification,habitat,retail,wholesale
from tb_commodity14
go



use db_mrsql
go
create view 视图17
as
select * from tb_marketing14
where counts>90
go
select * from 视图17




--第十九章
USE db_mrsql
GO
CREATE PROCEDURE CRE_PRO AS
Select * from tb_tab11 where лн▒­='─л'
GO



USE db_mrsql
GO
CREATE PROCEDURE CRE_Group;1 AS
Select * from tb_tab11
GO
CREATE PROCEDURE CRE_Group;2 AS
Select * from tb_tab11 where 性别='男'
GO
CREATE PROCEDURE CRE_Group;3 AS
Select * from tb_tab11 where 性别='女'



--创建存储过程
USE db_mrsql
GO
CREATE PROCEDURE CRE_CX
AS
if EXISTS(Select * from tb_tab11 where 年龄='22')
  Print 'tb_tab11数据表中有信息。'    --表示查询结果至少有一条记录
else 
  Print 'tb_tab11数据表中无信息。'    --没有查询到任何记录
GO
--执行存储过程
EXEC CRE_CX



--创建存储过程
CREATE PROCEDURE CRE_PRI
@char char(10)
AS
if EXISTS(Select * from tb_tab11 where (姓名=@char)and(年龄<18))
  Print Rtrim(@char)+'是未成年人员'    --表示查询结果至少有一条记录
else 
  Print Rtrim(@char)+'不是未成年人员'    --没有查询到任何记录
GO
--执行存储过程
EXEC CRE_PRI'小张'



--创建存储过程
USE db_mrsql
GO
CREATE PROCEDURE CRE_RAIS
@ErrorMessage varchar(100)
AS
Set @ErrorMessage =@ErrorMessage+ '单号不存在'
Raiserror (@ErrorMessage,16,1)
GO
--执行存储过程
EXEC CRE_RAIS '1001'



--创建存储过程
USE db_mrsql
GO
CREATE PROCEDURE CRE_Raiser 
@ID int,
@姓名 int
AS
if EXISTS(SELECT * FROM tb_tab11 WHERE 编号 = @ID)
begin
  UPDATE tb_tab11
  SET 姓名 = 姓名 + @姓名
  WHERE 编号 = @ID
end
else
begin
  RAISERROR ('存储过程提示: 数据库更新数据失败, 请确认[编号]为%d的信息是否存在',
 16, 1, @ID)
  Return
end
GO
--执行存储过程
EXEC CRE_Raiser 5,30



--创建带返回值的存储过程
USE db_mrsql
GO
CREATE PROCEDURE CRE_CONV
@SEX Varchar(2)='男',
@IntOut Int OUTPUT
AS
Select * 
from tb_tables11 
where 性别='男'
Set @IntOut=@@Error
GO
DECLARE @IntOut_Return int
EXEC CRE_CONV @SEX='女',@IntOut=@IntOut_Return OutPut
PRINT '返回结果为:'+convert(varchar(6),@IntOut_Return)+'.'



--创建存储过程
USE db_mrsql
GO
CREATE PROCEDURE CRE_RET
@ID int=0,
@Int int OutPut
AS
if @ID=0
begin
  Print '错误：必须入@ID参数'
  Return 1
end
else
begin
  if (select count(*) from tb_table11 where UserID=@id)=0
  begin
    Print '错误：@ID参数无效'  
    Return 2
  end
end
select * from tb_table11 where UserID=@id
if @@ERROR=0
  Return 0
else
  Return 3
GO
--执行存储过程
Declare @cost int,@Out int
EXEC @cost=CRE_RET @id=3,@int=@Out OutPut    --在tb_table11表中只有两条记录
if @cost=0
  Print '查询成功'
if @cost=1
  Print '参数不能为0'
if @cost=2
  Print '参数不能超出范围'
if @cost=3
  Print '查询时发生错误'

  
  
  Create Procedure CTE_SW
as
declare @UserID int
set nocount on
begin tran AddUser
insert into tb_table11 (UserName,PassWord,Tel) values ('mr','123','123455')
if @@Error <> 0 or @@rowcount = 0 goto ErrMsg
set @UserID = @@identity
set nocount off
commit tran AddUser
return 1 --添加成功
ErrMsg:
   set nocount off
   rollback tran AddUser
   return -1   --添加失败并回滚
GO




--创建存储过程
USE db_mrsql
GO
CREATE PROCEDURE CRE_Return 
@ID int,
@Pice int
AS
SELECT * FROM tb_table11 WHERE UserID = @ID
Return @@Error
GO
--执行存储过程
DECLARE @Int int
EXEC @Int=CRE_Return 1,30    --将返回值赋给@Int变量
Select @Int as '返回值'    --显示返回信息



USE db_mrsql
EXEC CRE_PRO



use master
exec sp_procoption 'loving','startup','true'



--创建带返回值的存储过程
CREATE PROCEDURE CRE_OUP
  @ave int OUTPUT    --设置带返回值的参数
AS
select @ave =avg(年龄) from tb_tab11
GO
--执行存储过程
DECLARE @average int    --自定义变量
EXEC CRE_OUP @average output    --调用存储过程
if @average>=25    --利用存储过程的返回值进行判断
  PRINT '人员的平均年龄为'+cast(@average as char(2))+'，属于年龄偏高'
if @average>=18
  PRINT '人员的平均年龄为'+cast(@average as char(2))+'，属于年龄居中'
if @average<18
  PRINT '人员的平均年龄为'+cast(@average as char(2))+'，属于年龄偏低'

  
  
  USE db_mrsql
GO
EXEC sp_helptext CRE_PRO
EXEC sp_depends CRE_PRO
EXEC sp_help CRE_PRO
GO



ALTER PROCEDURE CRE_PRO
AS
SELECT 姓名,性别,年龄
FROM tb_tab11
WHERE 性别='女'
GO
EXEC CRE_PRO
GO



USE db_mrsql
GO
CREATE PROCEDURE CRE_anew 
WITH RECOMPILE
AS
Select * from tb_tab11
GO



create or replace procedure proc
as
  age number;
begin
  select count(age) into age from tb_ta15;
end;
/



CREATE PROCEDURE proc (OUT param1 INT)
BEGIN
  SELECT COUNT(*) INTO param1 FROM tb_t15;
END;
//


--第二十章
CREATE FUNCTION NUMTOSTR
(@NUM INT)
RETURNS NVARCHAR(3)
AS
BEGIN
	DECLARE @STR NVARCHAR(3)
	IF @NUM>=85
		SET @STR='优'
	ELSE
	IF @NUM>=75
		SET @STR='良'
	ELSE
	IF @NUM>=60
		SET @STR='及格'
	ELSE
	IF @NUM<60
		SET @STR='不及格'
	RETURN @STR
END




create function find(@x float)
returns table 
as 
return(select * from tb_course12 where 课程成绩>@x)



create function dbo.info()
returns @xsry table(学号 int primary key,
姓名 varchar(10),
课程代码 int)
as
begin
declare @ordernum
table(学号 int,课程代码 int)
insert @ordernum select 学号,课程代码 from tb_course12
insert @xsry select a.学号,a.姓名,b.课程代码 
from db_studets12 as a left join @ordernum as b on a.学号=b.课程代码
return
end




select 课程成绩,dbo.numtostr(课程成绩) as 成绩等级  from tb_course12



USE db_mrsql
GO
EXEC sp_helptext find
EXEC sp_depends find
EXEC sp_help find
GO



alter function find(@x float)
returns table
as
return(select * from tb_course12 where 课程成绩<@x)
use db_mrsql
select * from find (60)





--第二十一章
use db_mrsql
go
 create trigger tri_emp on tb_employee13
 for insert 
 as
   declare @id int,@name varchar(8)
   select @id = 编号,@name = 姓名 from inserted
   insert into tb_laborage13(编号,姓名,基本工资,奖金) values(@id,@name,0,0)
go   	



use db_mrsql
   go
   /*创建触发器*/
   create trigger del_student on tb_student13
    for delete as
      print '学生信息已经删除'
   /*执行删除操作*/ 
  go 
   delete from tb_student13 where 编号 = 3	

   
   
   use db_mrsql
 go
  create trigger tri_update_emp on tb_employee13
  for update 
  as
   declare @id int,@name varchar(8)
   select @id = 编号 from deleted
   select @name = 姓名 from inserted
   update tb_laborage13 set 姓名 = @name where 编号 = @id   
  go

  
  
  use db_mrsql
 go
   create trigger c_student
     on tb_student13  for update as 
   begin
     /*将DELETE表中存放的记录存入tb_studentinfo13表中*/ 
     insert into tb_studentinfo13(类型,时间,编号,姓名,性别,年龄,班级)
     select '修改前',getdate(),del.编号,del.姓名,del.性别,del.年龄,del.班级
     from deleted as del
     /*将INSERT表中存放的记录存入tb_studentinfo13表中*/
     insert into tb_studentinfo13(类型,时间,编号,姓名,性别,年龄,班级)
     select '修改后',getdate(),ins.编号,ins.姓名,ins.性别,ins.年龄,ins.班级
     from inserted as ins
   end

   
   
   use db_mrsql
go
 create trigger t_laborage 
   on tb_laborage13
   for delete ,insert as
 declare @id int ,@name varchar(8)
 select @id = 编号 ,@name = 姓名 from deleted
   if(@id in(select 编号 from tb_employee13 where 姓名 = @name))
      begin
        rollback transaction
        print '员工信息在员工表中存在，不允许删除'
      end
  declare @sid int,@sname varchar(8)
  select @sid = 编号,@sname = 姓名 from inserted
    if(@sid not in(select 编号 from tb_employee13)) 
    begin 
     rollback transaction
     print '此职工在员工表中不存在，请审核后再输入'
    end

	
	
	use db_mrsql
  go
 create trigger t_employee
 on tb_employee13
  for update as
   if(columns_updated()&3>0)  /*第一列或第二列被更新，掩码“11”用十进制表示即为“3”*/ 
      begin 
        print '编号列与姓名列不允许被更改'
        rollback transaction
      end

	  
	  
	  use db_mrsql
 go
/*为tb_stu13表创建DELETE 触发器stu_delete*/
 create trigger stu_delete
 on tb_stu13
 for delete as
  declare @rowcount int
  select @rowcount = @@rowcount /*记录删除所涉及的行数*/
    if @rowcount > 1
      begin 
        print '一次只能删除一条记录'
        rollback transaction   /*回滚操作*/
      end
    else
      declare @id varchar(10)          /*从tb_score13表中删除对应的记录*/
      select @id = 学号 from deleted
      delete from tb_score13 where 学号=@id
go
/*为tb_score表创建DELETE触发器*/
create trigger lab_delete on tb_score13                                            
 for delete as                                                                  
  declare @score varchar(10) 
  select @score = 语文  from deleted                             
  if(@score  > 90)             /*判断工资是否大于1000*/
   begin 
     rollback transaction     /*回滚操作*/
     print '不允许删除该记录'
   end
  else                                                                    
    print '记录已删除'

	
	
	use db_mrsql
go
  create trigger delete_employee
   on tb_emp13
    after delete as
       declare @rowcount int
       select @rowcount = @@rowcount
  if @rowcount>1
       begin
          rollback transaction
       print('当前删除的记录条数大于一条，一次只允许删除一条')
       end
  if @rowcount=1
      begin
          declare @所属部门 varchar(10) 
          select @所属部门 = 所属部门 from deleted
      delete from tb_emp13 where 所属部门 = @所属部门                                                 
      end
     print '不允许删除该记录'

	 
	 
	 
	 use db_mrsql
  go
 create trigger tri_book
   on v_book
 instead of insert as
   begin 
     declare @编号 varchar(10)
     select @编号 = substring(编号,1,1) from inserted
     if @编号 = 'j'		/*如果编号是以"j"开头，则将信息插入tb_javabook13表中*/
       begin
         insert into tb_javabook13 select 编号,书名,定价 from inserted
         return
       end
     if @编号 = 's'		/*如果编号是以"s"开头，则将信息插入tb_sqlbook13表中*/
        begin
         insert into tb_sqlbook13 select 编号,书名,定价 from inserted
         return
       end
      if @编号 = 'a'	/*如果编号是以"a"开头，则将信息插入tb_aspbook13表中*/
        begin
         insert into tb_aspbook13 select 编号,书名,定价 from inserted
         return                                                                                          
        end
      else
        begin                                                                                  
         rollback transaction
         print '请确认编号后再输入！'
        end
     end

	 
	 
	 use db_mrsql
go
/*创建tb_mr_emp13表*/
create table tb_mr_emp13
  ( data datetime,
    mr_id varchar(8),
    state varchar(20),
    mr_name varchar(30)
   )
go
/*为tb_emp13表创建触发器tri_emp_jl*/
 create trigger tri_emp_jl on tb_emp13
  for insert,update
 as
  declare @id varchar(4)
  select @id = 编号 from inserted
  if update(姓名)     /*判断修改的列是否为“姓名”列*/
   insert into tb_mr_emp13 values(getdate(),@id,'修改员工姓名',user_name())

   
   
   
   use db_mrsql
exec sp_helptrigger tb_emp13
exec sp_depends tb_emp13



use db_mrsql
/*创建触发器*/
  go
  create trigger tri_emp
  on tb_emp13
   for insert 
  as
   select * from tb_emp13
/*修改触发器*/
  go
  alter trigger tri_emp on tb_emp13
    for insert ,update ,delete
    as
      select * from tb_emp13

	  
	  
	  use db_mrsql
  go
  alter table tb_emp13
  disable trigger t_emp  

  
  
  use db_mrsql
  go
  create trigger insert_courses
   on tb_teacher13 for insert
  as
   /*定义变量@c_name、@t_name*/
   declare @c_name varchar(10),@t_name varchar(10)
   /*将变量赋值*/
   select @c_name = 所授课程 ,@t_name = 姓名 from inserted
  insert into tb_courses13(课程名称,教师)values (@c_name,@t_name)

  
  
  use db_mrsql
  go
    create trigger upda_stu
    on tb_stu13 for update as
    declare @id varchar(10)
    select @id = 学号 from deleted
   begin  
    if update(姓名)
    delete from tb_score13 where 学号 = @id
    print 'tb_score13表中没有对应的数据，请录入'
    print @id
   end        

   
   use db_mrsql
  go
    create trigger tri_delete_laborage
    on tb_employee13 for delete
    as
     declare @id int,@name varchar(8)
     select @id = 编号,@name = 姓名 from deleted
     delete tb_laborage13 where 编号 = @id and 姓名 = @name
  go

  
  
  
  create or replace trigger tr_emp						/*创建触发器*/
  before update or insert on tb_emp					/*设置触发事件*/
 for each row									/*指明每次更新一行都将激活触发器*/
   begin
     if inserting then								/*判断触发事件*/
         dbms_output.put_line('信息添加成功');		/*输出的提示信息*/
     end if;
     if updating then	
         dbms_output.put_line('信息修改成功');
     end if;
   end;

   
   
   create trigger tri_login					/*创建触发器*/
   after create on schema					/*指定触发动作*/
   begin
    insert into tb_login values(user,'创建表');
   end;

   
   
   create trigger tr_stu
before insert on tb_stu
for each row
set new.name = ‘mrsoft’

  
--第二十三章

use db_mrsql
  go
  declare cur_employee cursor for
  select * from tb_employee13
  go

  
  
  use db_mrsql
  go
  declare mycursor cursor for		/*声明游标*/
  select 编号,姓名,性别 from tb_employee13
  open mycursor			/*打开游标*/
  go

  
  use db_mrsql
 go
  declare cursor_emp cursor for		  /*声明游标*/
   select 编号,姓名,性别,所属部门,入司时间 from tb_employee13
   where 入司时间 >'2013-01-01' 	/*定义游标结果集*/
  open cursor_emp             	/*打开游标*/ 
  fetch next from cursor_emp   		/*执行取数操作*/
while @@fetch_status = 0      	  /*判断是否还可以继续取数*/
   begin
     fetch next from cursor_emp
   end
     close cursor_emp           	/*关闭游标*/
     deallocate cursor_emp      		/*释放游标*/   

	 
	 
	 use db_mrsql
  go
  select 商品编号,商品名称 from tb_ware14
  where 数量 > 30
  go
  /*定义游标*/
   declare cur_ware scroll cursor for
    select 商品编号,商品名称 from tb_ware14
    where 数量 > 30
  open cur_ware			/*打开游标*/
    fetch last from cur_ware	/*读取游标最后一行*/
    fetch prior from cur_ware	/*读取游标中紧邻当前行前面的一行*/      
  close cur_ware			/*关闭游标*/
  deallocate cur_ware		/*释放游标*/

  
  
  use db_mrsql
  go
  declare @name varchar(10)			/*声明变量*/
  declare cur_lab cursor for			/*声明游标*/
    select 姓名 from tb_laborage13 where 编号 =1 /*定义游标结果集*/
  open cur_lab						/*打开游标*/
    fetch next from cur_lab into @name	/*将变量赋值*/
    while ( @@fetch_status=0 )  
begin
    declare @day varchar(10)			/*声明变量*/
    declare cur_lab_2 cursor for			/*声明游标*/
    select 请假天数 from tb_job13 where 姓名 = @name	/*定义结果集*/
    open cur_lab_2					/*打开游标*/
    fetch next from cur_lab_2 into @day	/*使用游标将变量赋值*/
    while ( @@fetch_status=0)  
    begin
          print '编号为1的员工的请假天数为' +@day +'天' 	/*输出编号为1的请假天数*/
          return 
    end
    close cur_lab_2					/*关闭游标*/
    deallocate cur_lab_2				/*释放游标*/ 
end   
    close cur_lab 
    deallocate cur_lab

	
	
	use db_mrsql
 go
 declare emp_cur cursor  		/*声明游标*/
 for
  select * from tb_emp13  	/*定义游标结果集*/ 
 open emp_cur           	/*打开游标*/
  fetch next from emp_cur  	/*执行取数操作*/
 while @@fetch_status = 0		/*判断是否可以继续取数*/
 begin
   fetch next from emp_cur
 end
 close emp_cur          	/*关闭游标*/
 deallocate emp_cur     		/*释放游标*/

 
 
 DECLARE @dept AS VARCHAR(20)							/*定义参数*/
SET @dept='Java开发部'									/*为参数赋值*/
DECLARE cur_eaf CURSOR								/*声明游标*/
  FOR (SELECT * FROM tb_eaf14 WHERE dept=@dept)		/*定义游标结果集*/
  OPEN cur_eaf										/*打开游标*/
    FETCH NEXT FROM cur_eaf							/*向下移动游标指针*/
    WHILE @@FETCH_STATUS = 0						/*判断是否存在下一条记录*/
      BEGIN
        FETCH NEXT FROM cur_eaf						/*向下移动游标指针*/
      END
  CLOSE cur_eaf										/*关闭游标*/
DEALLOCATE cur_eaf									/*释放游标*/




declare cursor dept_cursor(e_dept varchar2) is
select * from tb_emp
where department = e_dept;
r_department  tb_emp%rowtype;
  begin
     open dept_cursor('销售部');
  loop
     fetch dept_cursor into r_department;
  exit when  dept_cursor%notfound;
     dbms_output.put_line('编号: '||r_department.id ||' 姓名: '||r_department.name||
     ' 性别: '||r_department.sex ||' 所属部门: '||r_department.department);
   end loop;
  close dept_cursor;
end;



USE db_mrsql
DECLARE cur_eaf CURSOR					/*声明游标*/
  FOR (SELECT * FROM tb_eaf14)				/*定义游标结果集*/
  OPEN cur_eaf							/*打开游标*/
    PRINT CURSOR_STATUS('global','cur_eaf')	/*输出状态值*/
  CLOSE cur_eaf							/*关闭游标*/
DEALLOCATE cur_eaf						/*释放游标*/



USE db_mrsql
DECLARE cur_eaf SCROLL CURSOR
  FOR(SELECT * FROM tb_eaf14)
  OPEN cur_eaf
    PRINT @@CURSOR_ROWS
  CLOSE cur_eaf
DEALLOCATE cur_eaf



DECLARE cur_eca CURSOR
  FOR(SELECT * FROM tb_eca14)
  OPEN cur_eca
    FETCH NEXT FROM cur_eca
    UPDATE tb_eca14 SET date=getdate() WHERE CURRENT OF cur_eca
  CLOSE cur_eca
DEALLOCATE cur_eca



use db_mrsql
  select * from tb_laborage13
  go
  declare update_lab cursor 
   for select * from tb_laborage13 where 编号 = '2'
   for update of 基本工资,奖金
  open update_lab
   fetch next from update_lab
   go
    update tb_laborage13 set 基本工资 = 1560 where current of update_lab
   go
   close update_lab
   deallocate update_lab
  go

  
  
  
  DECLARE cur_ecb CURSOR
  FOR(SELECT * FROM tb_ecb14)
  OPEN cur_ecb
    FETCH NEXT FROM cur_ecb
    DELETE FROM tb_ecb14 WHERE CURRENT OF cur_ecb
  CLOSE cur_ecb
DEALLOCATE cur_ecb



use db_mrsql
  go
  declare @name varchar(8)
  declare delecursor cursor
    for select 姓名 from tb_laborage13
        where 姓名 not in (select 姓名 from tb_employee13)
    open delecursor
  fetch next from delecursor into @name
  while @@fetch_status = 0
    begin
     delete tb_laborage13
     where current of delecursor
     print '删除的员工为' + @name 
     return 
   end
    close delecursor  
    deallocate delecursor

	
	use db_mrsql
 go
  declare cur_ware cursor
    for select 商品编号,商品名称,(单价-进价)*数量 as 商品利润
    from tb_ware14
  open cur_ware
  fetch next from cur_ware
  while @@fetch_status = 0
    begin 
      fetch next from cur_ware
    end
  close cur_ware                                                       
  deallocate cur_ware

  
  
  use db_mrsql
  go
  declare mycursor cursor
  for select a.编号,a.姓名,性别,所属部门,入司时间,基本工资,奖金
  from tb_employee13 a,tb_laborage13 b
  where a.编号 = b.编号
  order by a.编号 desc
    open mycursor 
    fetch next from mycursor
    while @@fetch_status = 0
      fetch next from mycursor  
  close mycursor
  deallocate mycursor

  
  
  USE db_mrsql
DECLARE cur_eca CURSOR SCROLL  	--定义游标名称
  FOR 
    SELECT * FROM tb_eca14  		--定义游标结果集
DECLARE @cur_eca CURSOR  		--定义游标变量名
  SET @cur_eca = cur_eca  			--将游标赋值给游标变量
OPEN @cur_eca  					--打开游标变量
FETCH NEXT FROM @cur_eca
WHILE(@@FETCH_STATUS = 0)
  BEGIN
    FETCH NEXT FROM @cur_eca
  END
CLOSE @cur_eca  					--关闭游标变量
DEALLOCATE cur_eca




use db_mrsql
 go
 create procedure emp_cursor		/*创建存储过程*/
 @d_name varchar(10),			/*定义变量*/
 @dept cursor varying output		/*声明游标变量*/
 as
   set @dept = cursor  for		/*将游标变量赋值*/
   select * from tb_emp13
   where 所属部门 = @d_name
 open @dept					/*打开游标*/

go
declare @mycursor cursor			/*定义游标变量，用于接受存储过程的输出参数*/
 exec emp_cursor '销售部',  @dept = @mycursor  output
 fetch next from @mycursor		/*定位到游标的第一行*/
 while (@@fetch_status = 0)		/*判断FETCH是否成功执行*/
  begin
    fetch next from @mycursor		/*游标向后移动一行*/
  end
 deallocate @mycursor			/*释放游标变量*/ 

 
 
 use db_mrsql
  go
  declare k_eaf cursor keyset for		/*创建游标*/
    select name,dept from tb_EAF14 
    where duty = '程序员'			/*定义游标结果集*/
  open k_eaf					/*打开游标*/
  declare @eaf cursor			/*创建游标变量*/
  exec sp_cursor_list @cursor_return = @eaf output,
       @cursor_scope = 2		/*获取游标特征*/
  fetch next from @eaf			/*游标指针下移一行*/
  while(@@fetch_status<>-1) 		/*判断FETCH语句是否执行成功*/
    begin
      fetch next from @eaf 
    end
    close @eaf					/*关闭游标变量*/
    deallocate @eaf				/*释放游标变量*/
    close k_eaf  				/*关闭游标*/
    deallocate k_eaf 			/*释放游标*/  

	
	
	use db_mrsql
go
declare k_stu cursor keyset for 			--创建游标
select * from tb_stu13
open k_stu 						--打开游标
declare @Report cursor 				--创建游标变量
--使用sp_describe_cursor过程查看游标的属性信息
exec sp_describe_cursor @cursor_return = @Report output,
        @cursor_source = N'global', @cursor_identity = N'k_stu'   
fetch next from @Report				--游标指针下移一行
while(@@FETCH_STATUS <> -1)		--如果FETCH语句执行成功
begin
    fetch next from @Report			--游标继续向下移动
end
close @Report						--关闭游标变量
deallocate @Report					--释放游标变量 
go
close k_stu						--关闭游标
deallocate k_stu						--释放游标
go   



use db_mrsql
go
declare cur_stu cursor keyset for			--创建游标
select 学号,姓名 from tb_stu13
open cur_stu						--打开游标
declare @Report cursor				--创建游标变量
--使用sp_describe_cursor_columns过程报告游标所使用的列
EXEC  sp_describe_cursor_columns
      @cursor_return = @Report OUTPUT,
      @cursor_source = N'global', @cursor_identity = N'cur_stu'
fetch next from @Report				--游标指针下移一行
while(@@FETCH_STATUS <> -1)		--如果FETCH语句执行成功
begin
    fetch next from @Report			--游标继续向下移动
end
close @Report						--关闭游标变量
deallocate @Report					--释放游标变量 
go
close cur_stu						--关闭游标 
deallocate cur_stu					--释放游标
go                                   



use db_mrsql
go
declare k_ware cursor keyset for				--创建游标
select 商品编号,商品名称 from tb_ware14
open k_ware							--打开游标
declare @Report cursor					--创建游标变量
--使用sp_describe_cursor_tables报告游标所引用的表                                
EXEC  sp_describe_cursor_tables                                        
      @cursor_return = @Report OUTPUT,
      @cursor_source = N'global', @cursor_identity = N'k_ware'
fetch next from @Report						--游标指针下移一行
while(@@FETCH_STATUS <> -1)				--如果FETCH语句执行成功
begin
    fetch next from @Report					--游标继续向下移动
end
close @Report								--关闭游标变量
deallocate @Report							--释放游标变量
go
close k_ware								--关闭游标 
deallocate k_ware							--释放游标
go



declare cursor cur_emp is
    select name,sex,department from tb_emp where id = &id;
    v_name tb_emp.name%type;
    v_sex  tb_emp.sex%type;
    v_department tb_emp.department%type;
      begin
        open cur_emp;
       loop
         fetch cur_emp into v_name,v_sex,v_department;
         exit when cur_emp%notfound;
         dbms_output.put_line('姓名: '||v_name||',性别: '||v_sex||
         ',所属部门: '||v_department);
       end loop;
       close cur_emp;
      end;

	  
	  
	  begin
  delete from tb_emp where department = '策划部' and name = '李丽';
if SQL%ROWCOUNT = 1 then
  insert into tb_emp(id,name,sex,department)
  values('5','李丽','女','宣传部');
end if;
end;

第二十四
/*启动隐性事务模式*/
SET IMPLICIT_TRANSACTIONS ON
GO
INSERT INTO tb_mrMember15 VALUES(1,'小贯红')
GO
INSERT INTO tb_mrMember15 VALUES(2,'大房伟')
GO
COMMIT TRANSACTION --提交事务
GO
/*下面的INSERT语句将开始第二个事务*/
INSERT INTO tb_mrMember15 VALUES(3,'小苏宇')
GO
SELECT * FROM tb_mrMember15
GO
COMMIT TRANSACTION --结束事务
GO 
/*关闭隐性事务模式*/
SET IMPLICIT_TRANSACTIONS OFF
GO



USE db_mrsql  --使用db_mrsql数据库
--查询数据表中的数据
SELECT * FROM tb_Stock15
GO
BEGIN TRANSACTION UPDATE_DATA
  UPDATE tb_Stock15 SET 库存数量 = 3000
  WHERE 商品编号 = '2008001'
  DELETE tb_Stock15 WHERE 商品名称 = '花生饮料'
COMMIT TRANSACTION UPDATE_DATA
GO
--查询修改和删除数据后的数据表中的数据
SELECT * FROM tb_Stock15



USE db_mrsql
GO
INSERT INTO tb_ShoppingSale15
(订单编号,图书名称) VALUES(1,'SQL参考大全')
INSERT INTO tb_ShoppingSale15
(订单编号,图书名称) VALUES(2,'SQL范例大典')
INSERT INTO tb_ShoppingSale15
(订单编号,图书名称) VALUES(2,'ASP.NET自学手册')
GO
SELECT * FROM tb_ShoppingSale15



USE db_mrsql
GO
SELECT * FROM tb_Operator15
BEGIN TRANSACTION INSERT_DATA --开始事务
  INSERT INTO tb_Operator15
  VALUES('2008008','夜枫冷','男')
COMMIT TRANSACTION INSERT_DATA --提交事务
GO
IF @@ERROR = 0 
  PRINT '数据添加成功！'
GO



USE db_mrsql
/*开始事务*/
BEGIN TRANSACTION
/*设置事务保存点*/
SAVE TRANSACTION SavePoint
INSERT INTO tb_BookSell15 VALUES(1001,'明日图书')
/*回滚到事务保存点*/
ROLLBACK TRANSACTION SavePoint



USE db_mrsql
/*开始事务*/
BEGIN TRAN Update_data
UPDATE tb_Customers03 SET 图书名称='ASP范例宝典'--修改操作
WHERE 图书编号='2008003'--条件
/*回滚事务*/
ROLLBACK TRAN Update_data --回滚事务
SELECT * FROM tb_Customers03




/*开始事务*/
BEGIN TRAN 
/*定义变量*/
DECLARE @now_time VARCHAR(8)
/*对表tb_mrBook15实行HOLKLOCK进行表级锁定*/
SELECT * FROM tb_mrBook15 WITH (HOLDLOCK)
SELECT @now_time = CONVERT(VARCHAR,GETDATE(),8)
/*显示加锁时间*/
PRINT '用户mr锁定的时间为:'+ @now_time
/*等待10秒*/
WAITFOR DELAY '00:00:10'
SELECT @now_time = CONVERT(VARCHAR,GETDATE(),8)
/*显示解锁时间*/
PRINT '用户mr解锁的时间为:'+ @now_time
/*提交事务，解除锁定*/
COMMIT TRAN

/*开始事务*/
BEGIN TRAN 
/*定义变量*/
DECLARE @now_time VARCHAR(8)
SELECT @now_time = CONVERT(VARCHAR,GETDATE(),8)
/*显示事务开始时间*/
PRINT '用户mrsoft开始事务的时间:'+ @now_time
SELECT * FROM tb_mrBook15
WHERE 图书编号=2
SELECT @now_time = CONVERT(VARCHAR,GETDATE(),8)
/*显示SELECT语句执行时间*/
PRINT '用户mrsoft执行SELECT语句的时间:'+ @now_time
UPDATE tb_mrBook15 SET 图书名称='SQL范例宝典'
WHERE 图书编号=2
SELECT @now_time = CONVERT(VARCHAR,GETDATE(),8)
/*显示UPDATE语句执行时间*/
PRINT '用户mrsoft执行UPDATE语句的时间:'+ @now_time
/*回滚事务*/
ROLLBACK




/*设置事务READ UNCOMMITTED（未提交读）
隔离级别*/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
/*开始事务*/
BEGIN TRAN mrdata
/*更新操作*/
UPDATE tb_Register15 SET 家庭住址='哈尔滨市'
WHERE 会员编号=1
PRINT '事务结前表中的数据'
SELECT * FROM tb_Register15
/*等待10秒*/
WAITFOR DELAY '00:00:10'
/*回滚结束事务*/
ROLLBACK TRANSACTION mrdata
PRINT '事务结束后表中的数据'
SELECT * FROM tb_Register15

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
PRINT '读取了“脏数据",即用户mr修改中间的数据'
SELECT * FROM tb_Register15
/*查询的结果不为空*/
IF @@ROWCOUNT>0
BEGIN 
/*等待10秒，用户mr的操作已完成*/
  WAITFOR DELAY '00:00:10'
  PRINT '不重复读，即两次SELECT语句结果不同'
  SELECT * FROM tb_Register15
END



Set xact_Abort on
/*显示启动分布式事务*/
Begin DISTRIBUTED TRANSACTION
Update Employees set Firstname='Nancy' 
where Lastname='Davolio'
Update [MRLFL].[Northwind].[dbo].[Employees] 
set FirstName='Nancy'
where LastName='Davolio'
/*结束分布式事务*/
COMMIT TRANSACTION




USE db_mrsql
GO
/*查看创建的索引*/
IF EXISTS (SELECT name FROM sysindexes 
   WHERE name = 'StuName_Index')
/*删除索引*/
  DROP INDEX tb_Student16.StuName_Index
GO
CREATE INDEX StuName_Index 
ON tb_Student16(学生姓名)
SELECT 学生姓名 FROM tb_Student16
GO





USE db_mrsql
GO
/*强制使用非簇索引查询学生信息表中信息*/
SELECT * 
FROM tb_Student16
WITH (INDEX(StuName_Index))
GO




USE db_mrsql
GO
/*查看是否创建了MRName_Index索引*/
IF EXISTS(SELECT name from sysindexes
   WHERE name = 'MRName_Index')
/*删除名为MRName_Index的索引*/
   DROP INDEX tb_StudentInfo16.MRName_Index
GO
CREATE INDEX MRName_Index
    ON tb_StudentInfo16(性别,学生姓名)
GO
/*强制使用非簇索引查询tb_StudentInfo16表中信息*/
SELECT * FROM tb_StudentInfo16 
WITH (INDEX(MRName_Index)) 







USE db_mrsql
GO
/*查看是否创建了MRBooks_Index索引*/
IF EXISTS(SELECT name from sysindexes
   WHERE name = 'MRBooks_Index')
/*删除名为MRBooks_Index的索引*/
   DROP INDEX tb_mrBook16.MRBooks_Index
GO
/*创建唯一索引，且指定降序排列*/
CREATE UNIQUE INDEX MRBooks_Index
    ON tb_mrBook16(图书编号 DESC)
GO
/*强制使用MRBooks_Index索引，查询tb_mrBook16表中
所有记录*/
SELECT * FROM tb_mrBook16 
WITH (INDEX(MRBooks_Index))
GO







USE db_mrsql
GO
/*查看是否创建了Memmbers_Index索引*/
IF EXISTS(SELECT name from sysindexes
   WHERE name = 'Memmbers_Index')
/*删除名为MRBooks_Index的索引*/
   DROP INDEX tb_MRMemmbers16.Memmbers_Index
GO
/*创建簇索引，且指定降序排列*/
CREATE CLUSTERED INDEX Memmbers_Index
    ON tb_MRMemmbers16(员工编号 DESC)
GO
/*使用SELECT语句查询tb_MRMemmbers16表中
所有记录*/
SELECT * FROM tb_MRMemmbers16 
GO


USE db_mrsql
GO
/*查看是否创建了Emp_Index索引*/
IF EXISTS(SELECT name from sysindexes
   WHERE name = 'Emp_Index')
/*删除名为Emp_Index的索引*/
   DROP INDEX tb_mrEmployee16.Emp_Index
GO
/*创建多字段簇索引*/
CREATE CLUSTERED INDEX Emp_Index
    ON tb_mrEmployee16(性别,地址)
GO
/*使用SELECT语句查询tb_mrEmployee16表中所有记录*/
SELECT * FROM tb_mrEmployee16 
GO







/*创建员工信息表,并创建"本月应发工资"虚拟列*/
CREATE TABLE tb_mrEmp16(员工编号 int,当月工资 money,扣罚金额 money,本月应发工资 AS (当月工资-扣罚金额))
GO
/*创建索引列索引*/
CREATE INDEX Emp_Index ON tb_mrEmp16(本月应发工资)
GO





USE db_mrsql
GO
/*创建员工信息表,并创建表中"工龄"虚拟列*/
CREATE TABLE tb_fdwEmp16
(员工编号 int identity(1001,1),
雇佣日期 datetime,
工龄 AS DATEDIFF(YEAR,雇佣日期,GETDATE()))
GO
/*创建索引列索引*/
CREATE INDEX Emp_Index ON tb_fdwEmp16(工龄)
GO



create index score_index16
on tb_score16
(score1+score2)
/



USE db_mrsql
GO
/*变量声明*/
DECLARE @table_id int
SET @table_id = object_id('tb_mrBook15')
/*查看tb_mrBook15表的索引信息*/
DBCC SHOWCONTIG(@table_id)
GO



USE db_mrsql
GO
DBCC DBREINDEX('db_mrsql.dbo.tb_mrHY16',HY_Index, 80)
GO

USE db_mrsql
GO
DBCC DBREINDEX('db_mrsql.dbo.tb_mrHY16', '' , 100)
GO



DBCC INDEXDEFRAG(db_mrsql,tb_Student16,Stu_Index)
GO



USE db_mrsql
GO
/*查看是否创建了Mer_Index索引*/
IF EXISTS(SELECT name from sysindexes
   WHERE name = 'Mer_Index')
/*删除名为Mer_Index的索引*/
   DROP INDEX tb_mrMerchan16.Mer_Index
GO






SELECT SUM(总分) AS 总分和 FROM tb_st17;


SELECT 班级,SUM(总分) AS 总分和 FROM tb_st17 GROUP BY 班级;

select sum(总分) 总分和 from mrsql.tb_st17;

select 班级,sum(总分) 总分和 from mrsql.tb_st17 group by 班级;

select class,sum(allpoint) as point from tb_st17 group by class;

select max(总分) as 总分最小值 from tb_st17;

select sum(allpoint) from tb_st17;

select * from tb_st17 where О▄ио=(select max(О▄ио)  from tb_st17);

select max(总分) 总分和 from mrsql.tb_st17;

Select * from mrsql.tb_st17 where О▄ио=(select max(О▄ио) from mrsql.tb_st17);

select max(allpoint) point from tb_st17;

select * from tb_st17 where allpoint=(select max(allpoint) from tb_st17);

select min(总分) as 总分最小值 from tb_st17;

select * from tb_st17 where О▄ио=(select min(О▄ио)  from tb_st17);

select min(总分) 总分和 from mrsql.tb_st17;

Select * from mrsql.tb_st17 where О▄ио=(select min(О▄ио) from mrsql.tb_st17);

select MIN(allpoint) point from tb_st17;

select * from tb_st17 where О▄ио > (select avg(О▄ио)  from tb_st17);

select * from tb_st17 where allpoint=(select min(allpoint) from tb_st17);

select avg(总分) as 总分平均值 from tb_st17;

select avg(总分) 总分平均值 from mrsql.tb_st17;

select * from mrsql.tb_st17 where О▄ио>(select avg(О▄ио) from mrsql.tb_st17);

select avg(allpoint) point from tb_st17;

select * from tb_st17 where allpoint>(select avg(allpoint) from tb_st17);

select stdev(总分) as 样本的标准偏差 from tb_st17;

select stdevp(总分) as 总体的标准偏差 from tb_st17;

select stddev(总分) 标准偏差 from mrsql.tb_st17;

select stddev_pop(О▄ио) from mrsql.tb_st17;

select stddev(allpoint) warp from tb_st17;

select stddev_samp(allpoint) warp from tb_st17;

select var(总分) as 总分样本方差 from tb_st17;

select varp(总分) as 总分样本方差 from tb_st17;

select variance (О▄ио) from mrsql.tb_st17;

select Var_pop(О▄ио) from mrsql.tb_st17;

select Var_samp(allpoint) warp from tb_st17;

select Variance(allpoint) warp from tb_st17;

select 班级,count(*) as 学生数量 from tb_st17 group by 班级;

select 班级,count(*) 学生数量 from mrsql.tb_st17 group by 班级;

select class,count(*) number from tb_st17 group by class;

select 学生编号,学生姓名,学生性别,greatest(期中总成绩,期末总成绩) from mrsql.tb_student17;

select number,name,sex,least(midsemester,final) from tb_student17;

select 学生编号,学生姓名,学生性别,least(期中总成绩,期末总成绩) from mrsql.tb_student17;

select number,name,sex,least(midsemester,final) from tb_student17;


select abs(2.0) as '2.0的绝对值',
abs(0.0) as '0.0的绝对值',
abs(-2.0) as '-2.0的绝对值';


select abs(2.0),abs(0.0),abs(-2.0) from dual;

select abs(2.0),abs(0.0),abs(-2.0);


select sign(2.0) as '2.0的符号',sign(0.0) as '0.0的符号',sign(-2.0) as '-2.0的符号';

select sign(2.0),sign(0.0),sign(-2.0) from dual;


select sign(2.0),sign(0.0),sign(-2.0);

select round(1222.1994,3) as '取小数点后3位',round(1222.1995,3) as '取小数点后3位';

select round(1222.1994,3),round(1222.1995,3) from dual;

select round(1222.1994,3),round(1222.1995,3);

select ceiling(123.50) as '123.50取整',
ceiling(1000.00) as '1000.00取整',
ceiling(13.45) as '13.45取整';


select ceil (123.50), ceil (1000.00), ceil (13.45) from dual;

select Floor(123.50) as '123.50取整',
Floor(1000.00) as '1000.00取整',
Floor(13.45) as '13.45取整';

select Floor(123.50),Floor(1000.00),Floor(13.45);


select sin(30*pi()/180) as '30度的正弦值',
sin(60*pi()/180) as '90度的正弦值',
sin(90*pi()/180) as '90度的正弦值';


select Floor(123.50),Floor(1000.00),Floor(13.45) from dual;



select Sinh(30*3.1415926/180),Sinh(60*3.1415926/180),Sinh(90*3.1415926/180) from dual;

select sin(30*pi()/180),sin(60*pi()/180),sin(90*pi()/180);

select Asin(0.5) as '0.5的反正弦值',
Asin(0) as '0的反正弦值',
Asin(1) as '1的反正弦值';

select sin(0.5),sin(0),sin(1) from dual;

select Asin(0.5),Asin(0),Asin(1);

select Cos (30*pi()/180) as '30度的余弦值',
Cos (60*pi()/180) as '90度的余弦值',
Cos (90*pi()/180) as '90度的余弦值';


select Cos (30*3.1415926/180), Cos (60*3.1415926/180), Cos (90*3.1415926/180) from dual;

select Cosh (30*3.1415926/180), Cosh (60*3.1415926/180), Cosh (90*3.1415926/180) from dual;

select Cos(30*pi()/180), Cos(60*pi()/180), Cos(90*pi()/180);

select tan(45*pi()/180) as '45度的正切值',tan(0*pi()/180) as '0度的正切值';

select tan(45*3.1415926/180),tan(0*3.1415926/180) from dual;

select tanh(45*3.1415926/180),tanh(0*3.1415926/180) from dual;



select tan(45*pi()/180) as '45度的正切值',tan(0*pi()/180) as '0度的正切值';


select Atan (45*pi()/180) as '45度的反正切值', Atan (0*pi()/180) as '0度的反正切值';


select Sqrt(4) as '4的平方根', Sqrt(16) as '16的平方根', Sqrt(36) as '36的平方根';

select Atan (45*3.1415926/180), Atan (0*3.1415926/180) from dual;

select tan(45*pi()/180),tan(0*pi()/180);

select Cot(45*pi()/180) as '45度的余切值', Cot(90*pi()/180) as '90度的余切值';

select Cot (45*pi()/180), Cot (90*pi()/180);

select degrees(0.5) as '0.5的角度值';


select Radians (0.6) as '0.6的弧度值';

select degrees(0.5) as '0.5的角度值';


select Radians(0.6) as '0.6的弧度值';


select Exp(2) as 'e的2次方',Exp(4) as 'e的4次方',Exp(6) as 'e的6次方';

SELECT Power(2,2)AS "2的乘方结果",
Power(3,3)AS "3的乘方结果",
Power(4,4) AS "4的乘方结果";

select Square(2) as 'e的2平方', Square(4) as 'e的4平方', Square(6) as 'e的6平方';

select Exp(2),Exp(4),Exp(6) from dual;


SELECT Power(2,2),Power(3,3),Power(4,4) from dual;

select Sqrt(4),Sqrt(16),Sqrt(36) from dual;


select Exp(2),Exp(4),Exp(6) from dual;


SELECT Power(2,2),Power(3,3),Power(4,4) from dual;



select Sqrt(4),Sqrt(16),Sqrt(36) from dual;


select Log(10) as '10的自然对数';

select Log10(10) as '以10底10的对数',Log10(100) as '以10底100的对数',Log10(1000) as '以10底1000的对数';


select Ln(10) from dual;

select log(10,10),log(10,100),log(10,1000) from dual;

select ln(10);

select log(10,10),log(10,100),log(10,1000);

select Log10(10) as '以10底10的对数',Log10(100) as '以10底100的对数',Log10(1000) as '以10底1000的对数';



select Hextoraw(‘AB’),Hextoraw(‘3C’),Hextoraw(‘45’) from dual;


select rawtohex(0001),rawtohex(0010),rawtohex(0011) from dual;

select cast(floor(rand()*100) as int) as '0到99之间的随机数', cast(ceiling(rand()*100) as int) as '1到100之间的随机数';


select floor(rand()*100) as '获取0到99之间的随机数', ceiling(rand()*100)
as '获取1到100之间的随机数';



select upper('mr') as 'mr转换为大写字母',
      upper('book') as 'book转换为大写字母',
      upper('Mingri') as 'Mingri转换为大写字母'
	  
	  select upper('mr'),upper('book'),upper('Mingri') from dual
	  
	  select Initcap('mr'), Initcap('book'), Initcap('Mingri') from dual
	  
	  select upper('mr'),upper('book'),upper('Mingri')
	  
	  select Lower('MR') as 'MR转换为小写字母', Lower('BOOK') as 'BOOK转换为小写字母',
Lower('MingRi') as 'MingRi转换为小写字母'


select Lower('MR'),Lower('BOOK'),Lower('MingRi') from dual



select Lower('MR'),Lower('BOOK'),Lower('MingRi')


select Ltrim('  MR') as '去掉左空格', Ltrim('  BOOK') as '去掉左空格'


select Ltrim('  MR'), Ltrim('  BOOK') from dual


select Ltrim('  MR') , Ltrim('  BOOK')

select Ltrim('MR  ') as '去掉右空格', Ltrim('BOOK  ') as '去掉右空格'

select Rtrim('MR  '), Rtrim('BOOK  ') from dual

select Rtrim('MR  ') , Rtrim('BOOK  ')

select concat(‘mingri’,’software’) 连接结果,concat(111111,222222) 连接结果 from dual

select concat('mingri','software'), concat(111111,222222)

select Left('MRBOOK',2) as '从左截取'

select Right('MRBOOK',4) as '从右截取'

select Ltrim('MRBOOK',’MR’) from dual

select Rtrim('MRBOOK',’BOOK’) from dual

select Left('mingri',4)


select Right ('mingri',2)


select CharIndex('明日','吉林省明日科技有限公司') as 查找出现的位置


select SUBSTRING('吉林省明日科技有限公司', 4, 4) as 返回新表达式

select LEN ('吉林省明日科技有限公司') as 字符数

select PATINDEX ('%明日%','吉林省明日科技有限公司') as 字节内容

select instr(‘This is a example,is not it’,’is’,4,2) from dual

select length('吉林省明日科技有限公司') from dual

select SubStr('吉林省明日科技有限公司',4,4) from dual

select subString('mingrisoft',5,2)

select Instr(‘mingrisoft’,’ri’)

select Length(‘mingrisoft’)

select Locate('ri','mingrisoft')

select Field('ej', 'Hej', 'ej', 'Heja', 'hej', 'foo')

select Elt(1,'ej','Heja','hej','foo'),Elt(4,'ej','Heja','hej','foo')

select Replace('明日软件','软件','科技') as Replace函数的应用

select Stuff('吉林省有限公司',4,0,'明日科技') as Stuff函数的应用

Select Replace('明日软件','软件','科技') Replace函数的替换功能,
Replace('明日科技有限公司','有限公司') Replace函数的删除功能
From dual


select Translate('明日图书',’图书’,'软件') from dual

Select Replace('明日软件','软件','科技')

select Format(12332.123456,4),Format(12332.1,4), Format(12332.2,0)

select ascII('loving') as 转型1,ascII(123456) as 转型2

SELECT CHAR(65) + CHAR(97) + CHAR(67) + CHAR(36) + CHAR(98) + CHAR(38) 类型转换

SELECT STR(123.45, 6, 1) 类型转换1,STR(123.45, 2, 2) 类型转换2

select AscII('loving') 转型1,AscII(123456) 转型2 from dual

Select chr(65),chr(97) from dual

select ascII('loving') as 转型1,ascII(123456) as 转型2

Select chr(65),chr(97)

Select Hex(225), Hex(200)

select  replicate('loving',3) as 连续输出重复数据

select Reverse('技科日明') as 反转输出

SELECT '明日科技'+','+SPACE(10)+'生日快乐！'


SELECT QUOTENAME('abc[]def')

select lpad(‘Very Good’,21,’mingrisoft  ’) from dual

select Rpad (‘Very Good’,21,’  mingrisoft’) from dual

Select lpad(‘lpad’,10,’*’);

Select Rpad(‘mrsoft’,10,’*’);

Select insert('HELLO mrsoft',7,12,'MRSOFT')

Select length(space(5));

Select repeat(‘hello’,3);

Select quote(‘’你好：’’mrsoft’);

Select reverse(‘abcdefg’);

select soundex('kate') as 'kate',soundex('kite') as 'kite'

SELECT SOUNDEX('Blotchet-Halls') as 'Blotchet-Halls',
  SOUNDEX('Greene') as 'Greene',
  DIFFERENCE('Blotchet-Halls', 'Greene')as '发音相差'

  
  select soundex('meet'),soundex('meat')from dual
  
  select StrCmp(‘y’,’w’), StrCmp(‘a’,BINARY’A’)
  
  select soundEX(‘see’),soundEX(‘sea’)
  
  

USE pubs
GO
CREATE TABLE employees
(emp_id char(1) NOT NULL,
emp_lname varchar(40) NOT NULL,
emp_fname varchar(20) NOT NULL,
emp_hire_date datetime DEFAULT GETDATE(),
emp_mgr varchar(30),
)
GO
SELECT GETDATE() AS 当前时间
GO

SELECT MONTH(GETDATE()) AS 当前月份

SELECT DATENAME(month, getdate()) AS 'Month Name'

select to_char(sysdate,'dd-mon-yyyy day') from dual;

alter session set nls_date_format = 'mm-dd-yyyy' ;
select current_date from dual;


select to_char(sysdate,'yyyy.mm.dd')sdate,to_char(last_day(sysdate),'yyyy.mm.dd')lastday from dual;

SELECT sysdate,next_day(sysdate,'星期五') Friday FROM dual;

select dbtimezone from dual;

SELECT NOW();

SELECT CURDATE(), CURDATE()+0;

SELECT
 DAY(0) AS MY_DAY1,DAY('06/24/2013')AS MY_DAY2
GO

SELECT YEAR(-1) AS MY_YEAR1,YEAR(3) AS MY_YEAR2,YEAR('06/20/2013') AS MY_YEAR3

SELECT months_between(SYSDATE,date'2013-6-14') FROM dual;

SELECT DATE('2013-3-10 10:17:00');

SELECT LAST_DAY('2013-03-12');

SELECT MONTH('2013-03-10'),MONTH('20130310');

SELECT DAYOFMONTH('2013-03-11');



SELECT DAYOFYEAR('2012-12-01'), DAYOFYEAR('2012-12-31');

SELECT YEAR ('2013-3-10');

SELECT TO_DAYS('2013-3-10'),FROM_DAYS(735302);

SELECT PERIOD_ADD(201303,12), PERIOD_ADD(1303,-3);

SELECT TO_DAYS('2013-3-10'),FROM_DAYS(735302 + 3);

SELECT TIME('2013-03-11 01:02:03');

SELECT HOUR('2013-3-15 10:17:00');

SELECT CURTIME(),CURTIME()+0;      


SELECT SECOND('10:05:03');

SELECT MICROSECOND('12:00:00.123456');


SELECT MINUTE(’10:17:59’);

select QUARTER('2013-03-01');

SELECT DAYNAME('2013-3-10');


SELECT MONTHNAME('2013-03-11'),MONTHNAME('20130311');

SELECT DAYOFWEEK('2013-3-15'),DAYNAME('2013-3-15');

SELECT WEEK('2013-03-10'); 
SELECT WEEK('2013-03-10,0'); 
SELECT WEEK('2013-03-10,1'); 


SELECT WEEKDAY('2013-3-9'),DAYNAME('2013-3-9'),WEEKDAY('2013-3-15'),DAYNAME('2013-3-15');

SELECT WEEKOFYEAR('2013-03-12');

SELECT ADDDATE('2013-04-01',12);

SELECT DATE_SUB("2013-04-01 00:00:00", INTERVAL "1 1:1:1" DAY_SECOND);

USE db_mrsql  --使用db_mrsql数据库
GO
SELECT 食品名称,食品生产日期,
DATEADD(day, 30, 食品生产日期) AS 食品有效期
FROM tb_foodstuff24
GO


select add_months(sysdate,12) "Next Year",
add_months(sysdate,-12) "Last Year" from dual;


SELECT YEARWEEK('2013-01-01'), YEARWEEK('2013-01-01',0), YEARWEEK('2013-01-01',1);


SELECT MAKEDATE(2013,31), MAKEDATE(2013,32);

select ADDTIME('2013-4-24 5:28:10', '00:00:30');

SELECT SUBTIME('2013-08-08 23:59:59.999999','1 1:1:1.000001');

select SEC_TO_TIME(1234);

SELECT MAKETIME(12,15,30);

select Time_TO_Sec (’00:00:21’);

use db_mrsql--使用db_mrsql数据库
GO
--在员工基本信息表"tb_yuangong24"中“出生日期”的值
select 出生日期 from tb_yuangong24
GO
--使用DATEDIFF函数返回跨两个指定日期的日期和时间边界数
SELECT DATEDIFF(day, 出生日期, getdate()) AS 出生日期
FROM tb_yuangong24
GO


SELECT DATEDIFF('2013-08-08 23:59:59','2013-08-07

SELECT PERIOD_DIFF(1308,201207);

select TIMEDIFF('2013-5-1 12:00:00', '2013-5-1 10:00:00');

select Time_FORMAT(‘2008-7-6 10:10:10’,’%h%i%s’);



use db_mrsql--使用db_mrsql数据库
GO
--使用datepart函数获取当前月份的数值
select datepart(month,Getdate()) 
AS '获取当前月份（单位：月）'
GO


select extract(month from sysdate) "This Month" from dual;

SELECT EXTRACT(YEAR FROM'2013-06-08');

select DATE_FORMAT('2013-5-5 12:22:23','%W%M%Y');

SELECT DATE_FORMAT('2013-06-08',GET_FORMAT(DATE,'EUR'));

select Time_FORMAT('2013-7-6 10:10:10','%h%i%s');

set serveroutput on
declare  curdate date;
begin
curdate := round(sysdate,'month');
dbms_output.put_line(sysdate||'四舍五入后:'||curdate);
end;


select to_char(trunc(sysdate,'yyyy'),'yyyy')from dual;



                                                                     
