--1.计算每个人的总成绩并排名

select name,sum(score) as allscore from stuscore group by name order by allscore;

--2.计算每个人的总成绩并排名

select distinct t1.name,t1.stuid,t2.allscore from stuscore t1,( select stuid,sum(score) as allscore from stuscore group by stuid) t2 where t1.stuid=t2.stuid order by t2.allscore desc;

--3. 计算每个人单科的最高成绩

select t1.stuid,t1.name,t1.subject,t1.score from stuscore t1,(select stuid,max(score) as maxscore from stuscore group by stuid) t2 where t1.stuid=t2.stuid and t1.score=t2.maxscore;

--4.计算每个人的平均成绩

select distinct t1.stuid,t1.name,t2.avgscore from stuscore t1,(select stuid,avg(score) as avgscore from stuscore group by stuid) t2 where t1.stuid=t2.stuid;

5.列出各门课程成绩最好的学生 

select t1.stuid,t1.name,t1.subject,t2.maxscore from stuscore t1,(select subject,max(score) as maxscore from stuscore group by subject) t2where t1.subject=t2.subject and t1.score=t2.maxscore 
6.列出各门课程成绩最好的两位学生 

select distinct t1.* from stuscore t1 where t1.id in (select top 2 stuscore.id from stuscore where subject = t1.subject order by score desc) order by t1.subject 

7.学号 姓名 语文 数学 英语 总分 平均分 

select stuid as 学号,name as 姓名,sum(case when subject='语文' then score else 0 end) as 语文,sum(case when subject='数学' then score else 0 end) as 数学,sum(case when subject='英语' then score else 0 end) as 英语,sum(score) as 总分,(sum(score)/count(*)) as 平均分from stuscoregroup by stuid,name order by 总分desc 

8.列出各门课程的平均成绩 

select subject,avg(score) as avgscore from stuscoregroup by subject 

9.列出数学成绩的排名 

declare @tmp table(pm int,name varchar(50),score int,stuid int)insert into @tmp select null,name,score,stuid from stuscore where subject='数学' order by score descdeclare @id intset @id=0;update @tmp set @id=@id+1,pm=@idselect * from @tmp 

select DENSE_RANK () OVER(order by score desc) as row,name,subject,score,stuid from stuscore where subject='数学'order by score desc 

10. 列出数学成绩在2-3名的学生 

select t3.* from(select top 2 t2.* from (select top 3 name,subject,score,stuid from stuscore where subject='数学'order by score desc) t2 order by t2.score) t3 order by t3.score desc 

11. 求出李四的数学成绩的排名 

declare @tmp table(pm int,name varchar(50),score int,stuid int)insert into @tmp select null,name,score,stuid from stuscore where subject='数学' order by score descdeclare @id intset @id=0;update @tmp set @id=@id+1,pm=@idselect * from @tmp where name='李四' 

12. 课程 不及格（-59） 良（-80） 优（-100） 

select subject, (select count(*) from stuscore where score<60 and subject=t1.subject) as 不及格,(select count(*) from stuscore where score between 60 and 80 and subject=t1.subject) as 良,(select count(*) from stuscore where score >80 and subject=t1.subject) as 优from stuscore t1 group by subject 

13. 数学:张三(50分),李四(90分),王五(90分),赵六(76分) 

declare @s varchar(1000)set @s=''select @s =@s+','+name+'('+convert(varchar(10),score)+'分)' from stuscore where subject='数学' set @s=stuff(@s,1,1,'')print '数学:'+@s


SQL查询语句大全集锦
一、 简单查询 
简单的Transact-SQL查询只包括选择列表、FROM子句和WHERE子句。它们分别说明所查询列、查询的
表或视图、以及搜索条件等。
例如，下面的语句查询testtable表中姓名为“张三”的nickname字段和email字段。
代码:SELECT `nickname`,`email`FROM `testtable`WHERE `name`='张三'
 (一) 选择列表
选择列表(select_list)指出所查询列，它可以是一组列名列表、星号、表达式、变量(包括局部变量和全局变量)等构成。

1、选择所有列      
例如，下面语句显示testtable表中所有列的数据：
代码:SELECT * FROM testtable
 
2、选择部分列并指定它们的显示次序
查询结果集合中数据的排列顺序与选择列表中所指定的列名排列顺序相同。
例如：
代码:SELECT nickname,email FROM testtable
 
3、更改列标题
在选择列表中，可重新指定列标题。定义格式为：
列标题=列名
列名 列标题
如果指定的列标题不是标准的标识符格式时，应使用引号定界符，例如，下列语句使用汉字显示列
标题：
代码:SELECT 昵称=nickname,电子邮件=email  FROM testtable
 
4、删除重复行
SELECT语句中使用ALL或DISTINCT选项来显示表中符合条件的所有行或删除其中重复的数据行，默认
为ALL。使用DISTINCT选项时，对于所有重复的数据行在SELECT返回的结果集合中只保留一行。

5、限制返回的行数
使用TOP n [PERCENT]选项限制返回的数据行数，TOP n说明返回n行，而TOP n PERCENT时，说明n是
表示一百分数，指定返回的行数等于总行数的百分之几。
例如：
代码:SELECT TOP 2 * FROM `testtable`
代码:SELECT TOP 20 PERCENT * FROM `testtable`

(二) FROM子句
FROM子句指定SELECT语句查询及与查询相关的表或视图。在FROM子句中最多可指定256个表或视图，
它们之间用逗号分隔。
在FROM子句同时指定多个表或视图时，如果选择列表中存在同名列，这时应使用对象名限定这些列
所属的表或视图。例如在usertable和citytable表中同时存在cityid列，在查询两个表中的cityid时应
使用下面语句格式加以限定：
代码:SELECT `username`,citytable.cityid
FROM `usertable`,`citytable`
WHERE usertable.cityid=citytable.cityid在FROM子句中可用以下两种格式为表或视图指定别名：
代码:表名 as 别名
表名 别名例如上面语句可用表的别名格式表示为：
代码:SELECT `username`,b.cityid
FROM usertable a,citytable b
WHERE a.cityid=b.cityidSELECT不仅能从表或视图中检索数据，它还能够从其它查询语句所返回的结果集合中查询数据。
例如：
代码:SELECT a.au_fname+a.au_lname
FROM authors a,titleauthor ta
(SELECT `title_id`,`title`
FROM `titles`
WHERE ` ytd_sales`>10000
) AS t
WHERE a.au_id=ta.au_id
AND ta.title_id=t.title_id此例中，将SELECT返回的结果集合给予一别名t，然后再从中检索数据。

(三) 使用WHERE子句设置查询条件
WHERE子句设置查询条件，过滤掉不需要的数据行。例如下面语句查询年龄大于20的数据：
 
代码:SELECT * FROM usertable WHERE age>20 WHERE子句可包括各种条件运算符：
比较运算符(大小比较)：>、>=、=、、!>、!=10 AND age
代码:SELECT * FROM `usertable` ORDER BY `age` DESC,`userid` ASC另外，可以根据表达式进行排序。

二、 联合查询
UNION运算符可以将两个或两个以上上SELECT语句的查询结果集合合并成一个结果集合显示，即执行联
合查询。
UNION的语法格式为：
代码:select_statement
UNION [ALL] selectstatement
[UNION [ALL] selectstatement][…n]其中selectstatement为待联合的SELECT查询语句。
ALL选项表示将所有行合并到结果集合中。不指定该项时，被联合查询结果集合中的重复行将只保留一行。
联合查询时，查询结果的列标题为第一个查询语句的列标题。因此，要定义列标题必须在第一个查询语
句中定义。要对联合查询结果排序时，也必须使用第一查询语句中的列名、列标题或者列序号。
在使用UNION 运算符时，应保证每个联合查询语句的选择列表中有相同数量的表达式，并且每个查询选
择表达式应具有相同的数据类型，或是可以自动将它们转换为相同的数据类型。在自动转换时，对于数值类
型，系统将低精度的数据类型转换为高精度的数据类型。
在包括多个查询的UNION语句中，其执行顺序是自左至右，使用括号可以改变这一执行顺序。例如：
查询1 UNION (查询2 UNION 查询3)

三、连接查询
        通过连接运算符可以实现多个表查询。连接是关系数据库模型的主要特点，也是它区别于其它类型数据库管理系统的一个标志。
       在关系数据库管理系统中，表建立时各数据之间的关系不必确定，常把一个实体的所有信息存放在
一个表中。当检索数据时，通过连接操作查询出存放在多个表中的不同实体的信息。连接操作给用户带
来很大的灵活性，他们可以在任何时候增加新的数据类型。为不同实体创建新的表，尔后通过连接进行
查询。
       连接可以在SELECT 语句的FROM子句或WHERE子句中建立，似是而非在FROM子句中指出连接时有助于
将连接操作与WHERE子句中的搜索条件区分开来。所以，在Transact-SQL中推荐使用这种方法。
       SQL-92标准所定义的FROM子句的连接语法格式为： 
 
代码:FROM join_table join_type join_table [ON (join_condition)]其中join_table指出参与连接操作的表名，连接可以对同一个表操作，也可以对多表操作，对同一个表操作的连接又称做自连接。
join_type 指出连接类型，可分为三种：内连接、外连接和交叉连接。
 
       内连接(INNER JOIN)使用比较运算符进行表间某(些)列数据的比较操作，并列出这些表中与连接条件相匹配的数据行。根据所使用的比较方式不同，内连接又分为等值连接、自然连接和不等连接三种。
       外连接分为左外连接(LEFT OUTER JOIN或LEFT JOIN)、右外连接(RIGHT OUTER JOIN或RIGHT JOIN)
和全外连接(FULL OUTER JOIN或FULL JOIN)三种。与内连接不同的是，外连接不只列出与连接条件相匹配的行，而是列出左表(左外连接时)、右表(右外连接时)或两个表(全外连接时)中所有符合搜索条件的数据行。
       交叉连接(CROSS JOIN)没有WHERE 子句，它返回连接表中所有数据行的笛卡尔积，其结果集合中的数据行数等于第一个表中符合查询条件的数据行数乘以第二个表中符合查询条件的数据行数。
       连接操作中的ON (join_condition) 子句指出连接条件，它由被连接表中的列和比较运算符、逻辑运算符等构成。
        无论哪种连接都不能对text、ntext和image数据类型列进行直接连接，但可以对这三种列进行间接连接。例如：
代码:SELECT p1.pub_id,p2.pub_id,p1.pr_info
FROM pub_info AS p1 INNER JOIN pub_info AS p2
ON DATALENGTH(p1.pr_info)=DATALENGTH(p2.pr_info)(一)内连接
内连接查询操作列出与连接条件匹配的数据行，它使用比较运算符比较被连接列的列值。
 内连接分三种：
1、等值连接：在连接条件中使用等于号(=)运算符比较被连接列的列值，其查询结果中列出被连接表中的所有列，包括其中的重复列。
2、不等连接： 在连接条件使用除等于运算符以外的其它比较运算符比较被连接的列的列值。这些运算符包括>、>=、、!。
3、自然连接：在连接条件中使用等于(=)运算符比较被连接列的列值，但它使用选择列表指出查询结果集合中所包括的列，并删除连接表中的重复列。
例，下面使用等值连接列出authors和publishers表中位于同一城市的作者和出版社：
代码:SELECT *
FROM authors AS a INNER JOIN publishers AS p
ON a.city=p.city又如使用自然连接，在选择列表中删除authors 和publishers 表中重复列(city和state)：
代码:SELECT a.*,p.pub_id,p.pub_name,p.country
FROM authors AS a INNER JOIN publishers AS p
ON a.city=p.city
(二)外连接内连接时，返回查询结果集合中的仅是符合查询条件( WHERE 搜索条件或 HAVING 条件)和连接条件
的行。而采用外连接时，它返回到查询结果集合中的不仅包含符合连接条件的行，而且还包括左表(左外连接时)、右表(右外连接时)或两个边接表(全外连接)中的所有数据行。
如下面使用左外连接将论坛内容和作者信息连接起来：
代码:SELECT a.*,b.* FROM `luntan` LEFT JOIN usertable as b
ON a.username=b.username下面使用全外连接将city表中的所有作者以及user表中的所有作者，以及他们所在的城市：
代码:SELECT a.*,b.*
FROM city as a FULL OUTER JOIN user as b
ON a.username=b.username
 (三)交叉连接
交叉连接不带WHERE 子句，它返回被连接的两个表所有数据行的笛卡尔积，返回到结果集合中的数
据行数等于第一个表中符合查询条件的数据行数乘以第二个表中符合查询条件的数据行数。
例，titles表中有6类图书，而publishers表中有8家出版社，则下列交叉连接检索到的记录数将等
于6*8=48行。
代码:SELECT `type`,`pub_name`
FROM `titles` CROSS JOIN `publishers`
ORDER BY `type`
 
SQL核心语句(非常实用的几个技巧)
_ArticleContent1_lblContent>插入数据
向表中添加一个新记录，你要使用SQL INSERT 语句。这里有一个如何使用这种语句的例子：
代码:INSERT mytable (mycolumn) VALUES (‘some data’) 这个语句把字符串’some data’插入表mytable的mycolumn字段中。将要被插入数据的字段的名字在第一个括号中指定，实际的数据在第二个括号中给出。
INSERT 语句的完整句法如下：
代码:INSERT [INTO] {table_name|view_name} [(column_list)] {DEFAULT VALUES |
Values_list | select_statement} 如果一个表有多个字段，通过把字段名和字段值用逗号隔开，你可以向所有的字段中插入数据。假设表mytable有三个字段first_column,second_column,和third_column。
下面的INSERT语句添加了一条三个字段都有值的完整记录：
代码:INSERT mytable (first_column,second_column,third_column)
VALUES (‘some data’,’some more data’,’yet more data’) 注意
你可以使用INSERT语句向文本型字段中插入数据。但是，如果你需要输入很长的字符串，你应该使用WRITETEXT语句。这部分内容对本书来说太高级了，因此不加讨论。要了解更多的信息，请参考Microsoft SQL Sever 的文档。
如果你在INSERT 语句中只指定两个字段和数据会怎么样呢？换句话说，你向一个表中插入一条新记录，但有一个字段没有提供数据。在这种情况下，有下面的四种可能：
如果该字段有一个缺省值，该值会被使用。例如，假设你插入新记录时没有给字段third_column提供数据，而这个字段有一个缺省值’some value’。在这种情况下，当新记录建立时会插入值’some value’。
如果该字段可以接受空值，而且没有缺省值，则会被插入空值。
如果该字段不能接受空值，而且没有缺省值，就会出现错误。你会收到错误信息：
The column in table mytable may not be null.
最后，如果该字段是一个标识字段，那么它会自动产生一个新值。当你向一个有标识字段的表中插入新记录时，只要忽略该字段，标识字段会给自己赋一个新值。
注意
向一个有标识字段的表中插入新记录后，你可以用SQL变量@@identity来访问新记录
的标识字段的值。考虑如下的SQL语句：
 代码:INSERT mytable (first_column) VALUES(‘some value’) [code]
[code]INSERT anothertable(another_first,another_second)
VALUES(@@identity,’some value’) 如果表mytable有一个标识字段，该字段的值会被插入表anothertable的another_first字段。这是因为变量@@identity总是保存最后一次插入标识字段的值。
字段another_first应该与字段first_column有相同的数据类型。但是，字段another_first不能是应该标识字段。Another_first字段用来保存字段first_column的值。
删除记录
要从表中删除一个或多个记录，需要使用SQL DELETE语句。你可以给DELETE 语句提供WHERE 子句。WHERE子句用来选择要删除的记录。例如，下面的这个DELETE语句只删除字段first_column的值等于’Delete Me’的记录：
 代码:DELETE mytable WHERE first_column=’Deltet Me’ DELETE 语句的完整句法如下：
 
代码:DELETE [FROM] {table_name|view_name} [WHERE clause] 在SQL SELECT 语句中可以使用的任何条件都可以在DELECT 语句的WHERE子句 中使用。例如，下面的这个DELETE语句只删除那些first_column字段的值为’goodbye’或second_column字段的值为’so long’的记录：
 代码:DELETE mytable WHERE first_column=’goodby’ OR second_column=’so long’ 如果你不给DELETE 语句提供WHERE 子句，表中的所有记录都将被删除。你不应该有这种想法。如果你想删除应该表中的所有记录，应使用第十章所讲的TRUNCATE TABLE语句。
注意
为什么要用TRUNCATE TABLE 语句代替DELETE语句？当你使用TRUNCATE TABLE语句时，记录的删除是不作记录的。也就是说，这意味着TRUNCATE TABLE 要比DELETE快得多。
更新记录
要修改表中已经存在的一条或多条记录，应使用SQL UPDATE语句。同DELETE语句一样，UPDATE语句可以使用WHERE子句来选择更新特定的记录。请看这个例子：
 代码:UPDATE mytable SET first_column=’Updated!’ WHERE second_column=’Update Me!’ 这个UPDATE 语句更新所有second_column字段的值为’Update Me!’的记录。对所有被选中的记录，字段first_column的值被置为’Updated!’。
下面是UPDATE语句的完整句法：
 代码:UPDATE {table_name|view_name} SET [{table_name|view_name}]
{column_list|variable_list|variable_and_column_list}
[,{column_list2|variable_list2|variable_and_column_list2}…
[,{column_listN|variable_listN|variable_and_column_listN}]]
[WHERE clause] 注意
你可以对文本型字段使用UPDATE语句。但是，如果你需要更新很长的字符串，应使用UPDATETEXT语句。这部分内容对本书来说太高级了，因此不加讨论。要了解更多的信息，请参考Microsoft SQL Sever 的文档。
如果你不提供WHERE子句，表中的所有记录都将被更新。有时这是有用的。例如，如果你想把表titles中的所有书的价格加倍，你可以使用如下的UPDATE 语句：
你也可以同时更新多个字段。例如，下面的UPDATE语句同时更新first_column,second_column,和third_column这三个字段：
 代码:UPDATE mytable SET first_column=’Updated!’
Second_column=’Updated!’
Third_column=’Updated!’
WHERE first_column=’Update Me1’ 技巧
SQL忽略语句中多余的空格。你可以把SQL语句写成任何你最容易读的格式。
用SELECT 创建记录和表
你也许已经注意到，INSERT 语句与DELETE语句和UPDATE语句有一点不同，它一次只操作一个记录。然而，有一个方法可以使INSERT 语句一次添加多个记录。要作到这一点，你需要把INSERT 语句与SELECT 语句结合起来，象这样：
 代码:INSERT mytable (first_column,second_column)
SELECT another_first,another_second
FROM anothertable
WHERE another_first=’Copy Me!’ 这个语句从anothertable拷贝记录到mytable.只有表anothertable中字段another_first的值为’Copy Me！’的记录才被拷贝。
当为一个表中的记录建立备份时，这种形式的INSERT 语句是非常有用的。在删除一个表中的记录之前，你可以先用这种方法把它们拷贝到另一个表中。
如果你需要拷贝整个表，你可以使用SELECT INTO 语句。例如，下面的语句创建了一个名为newtable的新表，该表包含表mytable的所有数据：
 代码:SELECT * INTO newtable FROM mytable 你也可以指定只有特定的字段被用来创建这个新表。要做到这一点，只需在字段列表中指定你想要拷贝的字段。另外，你可以使用WHERE 子句来限制拷贝到新表中的记录。下面的例子只拷贝字段second_columnd的值等于’Copy Me!’的记录的first_column字段。
 代码:SELECT first_column INTO newtable
FROM mytable
WHERE second_column=’Copy Me!’ 使用SQL修改已经建立的表是很困难的。例如，如果你向一个表中添加了一个字段，没有容易的办法来去除它。另外，如果你不小心把一个字段的数据类型给错了，你将没有办法改变它。但是，使用本节中讲述的SQL语句，你可以绕过这两个问题。
例如，假设你想从一个表中删除一个字段。使用SELECT INTO 语句，你可以创建该表的一个拷贝，但不包含要删除的字段。这使你既删除了该字段，又保留了不想删除的数据。
如果你想改变一个字段的数据类型，你可以创建一个包含正确数据类型字段的新表。创建好该表后，你就可以结合使用UPDATE语句和SELECT 语句，把原来表中的所有数据拷贝到新表中。通过这种方法，你既可以修改表的结构，又能保存原有的数据。
_ArticleContent1_lblContent>插入数据
向表中添加一个新记录，你要使用SQL INSERT 语句。这里有一个如何使用这种语句的例子：
 代码:INSERT mytable (mycolumn) VALUES (‘some data’) 这个语句把字符串’some data’插入表mytable的mycolumn字段中。将要被插入数据的字段的名字在第一个括号中指定，实际的数据在第二个括号中给出。
INSERT 语句的完整句法如下：
 代码:INSERT [INTO] {table_name|view_name} [(column_list)] {DEFAULT VALUES | Values_list | select_statement} 如果一个表有多个字段，通过把字段名和字段值用逗号隔开，你可以向所有的字段中插入数据。假设表mytable有三个字段first_column,second_column,和third_column。下面的INSERT语句添加了一条三个字段都有值的完整记录：
代码:INSERT mytable (first_column,second_column,third_column) VALUES (‘some data’,’some more data’,’yet more data’)
[code]
注意
你可以使用INSERT语句向文本型字段中插入数据。但是，如果你需要输入很长的字符串，你应该使用WRITETEXT语句。这部分内容对本书来说太高级了，因此不加讨论。要了解更多的信息，请参考Microsoft SQL Sever 的文档。
如果你在INSERT 语句中只指定两个字段和数据会怎么样呢？换句话说，你向一个表中插入一条新记录，但有一个字段没有提供数据。在这种情况下，有下面的四种可能：
如果该字段有一个缺省值，该值会被使用。例如，假设你插入新记录时没有给字段third_column提供数据，而这个字段有一个缺省值’some value’。在这种情况下，当新记录建立时会插入值’some value’。
如果该字段可以接受空值，而且没有缺省值，则会被插入空值。
如果该字段不能接受空值，而且没有缺省值，就会出现错误。你会收到错误信息：
The column in table mytable may not be null.
最后，如果该字段是一个标识字段，那么它会自动产生一个新值。当你向一个有标识字段的表中插入新记录时，只要忽略该字段，标识字段会给自己赋一个新值。
注意
向一个有标识字段的表中插入新记录后，你可以用SQL变量@@identity来访问新记录
的标识字段的值。考虑如下的SQL语句：
[code]INSERT mytable (first_column) VALUES(‘some value’) 
 代码:INSERT anothertable(another_first,another_second) VALUES(@@identity,’some value’) 如果表mytable有一个标识字段，该字段的值会被插入表anothertable的another_first字段。这是因为变量@@identity总是保存最后一次插入标识字段的值。
字段another_first应该与字段first_column有相同的数据类型。但是，字段another_first不能是应该标识字段。Another_first字段用来保存字段first_column的值。
删除记录
要从表中删除一个或多个记录，需要使用SQL DELETE语句。你可以给DELETE 语句提供WHERE 子句。WHERE子句用来选择要删除的记录。例如，下面的这个DELETE语句只删除字段first_column的值等于’Delete Me’的记录：
 代码:DELETE mytable WHERE first_column=’Deltet Me’ DELETE 语句的完整句法如下：
 代码:DELETE [FROM] {table_name|view_name} [WHERE clause] 在SQL SELECT 语句中可以使用的任何条件都可以在DELECT 语句的WHERE子句 中使用。例如，下面的这个DELETE语句只删除那些first_column字段的值为’goodbye’或second_column字段的值为’so long’的记录：
 代码:DELETE mytable WHERE first_column=’goodby’ OR second_column=’so long’ 如果你不给DELETE 语句提供WHERE 子句，表中的所有记录都将被删除。你不应该有这种想法。如果你想删除应该表中的所有记录，应使用第十章所讲的TRUNCATE TABLE语句。
注意
为什么要用TRUNCATE TABLE 语句代替DELETE语句？当你使用TRUNCATE TABLE语句时，记录的删除是不作记录的。也就是说，这意味着TRUNCATE TABLE 要比DELETE快得多。
更新记录
要修改表中已经存在的一条或多条记录，应使用SQL UPDATE语句。同DELETE语句一样，UPDATE语句可以使用WHERE子句来选择更新特定的记录。请看这个例子：
 代码:UPDATE mytable SET first_column=’Updated!’ WHERE second_column=’Update Me!’ 这个UPDATE 语句更新所有second_column字段的值为’Update Me!’的记录。对所有被选中的记录，字段first_column的值被置为’Updated!’。
下面是UPDATE语句的完整句法：
 代码:UPDATE {table_name|view_name} SET [{table_name|view_name}]
{column_list|variable_list|variable_and_column_list}
[,{column_list2|variable_list2|variable_and_column_list2}…
[,{column_listN|variable_listN|variable_and_column_listN}]]
[WHERE clause] 注意
你可以对文本型字段使用UPDATE语句。但是，如果你需要更新很长的字符串，应使用UPDATETEXT语句。这部分内容对本书来说太高级了，因此不加讨论。要了解更多的信息，请参考Microsoft SQL Sever 的文档。
如果你不提供WHERE子句，表中的所有记录都将被更新。有时这是有用的。例如，如果你想把表titles中的所有书的价格加倍，你可以使用如下的UPDATE 语句：
你也可以同时更新多个字段。例如，下面的UPDATE语句同时更新first_column,second_column,和third_column这三个字段：
 代码:UPDATE mytable SET first_column=’Updated!’
Second_column=’Updated!’
Third_column=’Updated!’
WHERE first_column=’Update Me1’ 技巧
SQL忽略语句中多余的空格。你可以把SQL语句写成任何你最容易读的格式。
用SELECT 创建记录和表
你也许已经注意到，INSERT 语句与DELETE语句和UPDATE语句有一点不同，它一次只操作一个记录。然而，有一个方法可以使INSERT 语句一次添加多个记录。要作到这一点，你需要把INSERT 语句与SELECT 语句结合起来，象这样：
 代码:INSERT mytable (first_column,second_column)
SELECT another_first,another_second
FROM anothertable
WHERE another_first=’Copy Me!’ 这个语句从anothertable拷贝记录到mytable.只有表anothertable中字段another_first的值为’Copy Me！’的记录才被拷贝。
当为一个表中的记录建立备份时，这种形式的INSERT 语句是非常有用的。在删除一个表中的记录之前，你可以先用这种方法把它们拷贝到另一个表中。
如果你需要拷贝整个表，你可以使用SELECT INTO 语句。例如，下面的语句创建了一个名为newtable的新表，该表包含表mytable的所有数据：
 代码:SELECT * INTO newtable FROM mytable 你也可以指定只有特定的字段被用来创建这个新表。要做到这一点，只需在字段列表中指定你想要拷贝的字段。另外，你可以使用WHERE 子句来限制拷贝到新表中的记录。下面的例子只拷贝字段second_columnd的值等于’Copy Me!’的记录的first_column字段。
 代码:SELECT first_column INTO newtable
FROM mytable
WHERE second_column=’Copy Me!’ 使用SQL修改已经建立的表是很困难的。例如，如果你向一个表中添加了一个字段，没有容易的办法来去除它。另外，如果你不小心把一个字段的数据类型给错了，你将没有办法改变它。但是，使用本节中讲述的SQL语句，你可以绕过这两个问题。
例如，假设你想从一个表中删除一个字段。使用SELECT INTO 语句，你可以创建该表的一个拷贝，但不包含要删除的字段。这使你既删除了该字段，又保留了不想删除的数据。
如果你想改变一个字段的数据类型，你可以创建一个包含正确数据类型字段的新表。创建好该表后，你就可以结合使用UPDATE语句和SELECT 语句，把原来表中的所有数据拷贝到新表中。通过这种方法，你既可以修改表的结构，又能保存原有的数据。
 
SQL语法,SQL语句大全,SQL基础
ＳＱＬ 语法参考手册(SQL)/数据类型
2006-07-24 07:42 
《ＳＱＬ 语法参考手册(SQL)》
DB2 提供了关连式资料库的查询语言 ＳＱＬ (Structured Query Language)，是一种非常口语化、既易学又易懂的语法。此一语言几乎是每个资料库系统都必须提供的，用以表示关连式的*作，包含了资料的定义（ＤＤＬ）以及资料的处理（ＤＭＬ）。SQL原来拼成SEQUEL，这语言的原型以“系统 R“的名字在 IBM 圣荷西实验室完成，经过IBM内部及其他的许多使用性及效率测试，其结果相当令人满意，并决定在系统R 的技术基础发展出来 IBM 的产品。而且美国国家标准学会（ANSI）及国际标准化组织（ISO）在1987遵循一个几乎是以 IBM SQL 为基础的标准关连式资料语言定义。  
一、资料定义 ＤＤＬ（Data Definition Language)  
资料定语言是指对资料的格式和形态下定义的语言，他是每个资料库要建立时候时首先要面对的，举凡资料分哪些表格关系、表格内的有什麽栏位主键、表格和表格之间互相参考的关系等等，都是在开始的时候所必须规划好的。  
１、建表格：  
Create TABLE table_name(  
column1 DATATYPE [NOT NULL] [NOT NULL PRIMARY KEY],  
column2 DATATYPE [NOT NULL],  
...）  
说明：　  
DATATYPE --是资料的格式，详见表。  
NUT NULL --可不可以允许资料有空的（尚未有资料填入）。  
PRIMARY KEY --是本表的主键。  
２、更改表格　  
Alter TABLE table_name  
ADD COLUMN column_name DATATYPE  
说明：增加一个栏位（没有删除某个栏位的语法。  
Alter TABLE table_name  
ADD PRIMARY KEY (column_name)  
说明：更改表得的定义把某个栏位设为主键。  
Alter TABLE table_name  
Drop PRIMARY KEY (column_name)  
说明：把主键的定义删除。  
３、建立索引　  
Create INDEX index_name ON table_name (column_name)  
说明：对某个表格的栏位建立索引以增加查询时的速度。  
４、删除　  
Drop table_name  
Drop index_name  
二、的资料形态 DATATYPEs  
smallint  
16 位元的整数。  
interger  
32 位元的整数。  
decimal(p,s)  
p 精确值和 s 大小的十进位整数，精确值p是指全部有几个数(digits)大小值，s是指小数  
点後有几位数。如果没有特别指定，则系统会设为 p=5; s=0 。  
float  
32位元的实数。  
double  
64位元的实数。  
char(n)  
n 长度的字串，n不能超过 254。  
varchar(n)  
长度不固定且其最大长度为 n 的字串，n不能超过 4000。  
graphic(n)  
和 char(n) 一样，不过其单位是两个字元 double-bytes， n不能超过127。这个形态是为  
了支援两个字元长度的字体，例如中文字。  
vargraphic(n)  
可变长度且其最大长度为 n 的双字元字串，n不能超过 2000。  
date  
包含了 年份、月份、日期。  
time  
包含了 小时、分钟、秒。  
timestamp  
包含了 年、月、日、时、分、秒、千分之一秒。  
三、资料*作 ＤＭＬ （Data Manipulation Language)  
资料定义好之後接下来的就是资料的*作。资料的*作不外乎增加资料（insert)、查询资料（query）、更改资料（update) 、删除资料（delete）四种模式，以下分 别介绍他们的语法：  
１、增加资料：  
Insert INTO table_name (column1,column2,...)  
valueS ( value1,value2, ...)  
说明：  
1.若没有指定column 系统则会按表格内的栏位顺序填入资料。  
2.栏位的资料形态和所填入的资料必须吻合。  
3.table_name 也可以是景观 view_name。  
Insert INTO table_name (column1,column2,...)  
Select columnx,columny,... FROM another_table  
说明：也可以经过一个子查询（subquery）把别的表格的资料填入。  
２、查询资料：  
基本查询  
Select column1,columns2,...  
FROM table_name  
说明：把table_name 的特定栏位资料全部列出来  
Select *  
FROM table_name  
Where column1 = xxx  
[AND column2 〉 yyy] [OR column3 〈〉 zzz]  
说明：  
1.’*’表示全部的栏位都列出来。  
2.Where 之後是接条件式，把符合条件的资料列出来。  
Select column1,column2  
FROM table_name  
orDER BY column2 [DESC]  
说明：ORDER BY 是指定以某个栏位做排序，[DESC]是指从大到小排列，若没有指明，则是从小到大  
排列  
组合查询  
组合查询是指所查询得资料来源并不只有单一的表格，而是联合一个以上的  
表格才能够得到结果的。  
Select *  
FROM table1,table2  
Where table1.colum1=table2.column1  
说明：  
1.查询两个表格中其中 column1 值相同的资料。  
2.当然两个表格相互比较的栏位，其资料形态必须相同。  
3.一个复杂的查询其动用到的表格可能会很多个。  
整合性的查询：  
Select COUNT (*)  
FROM table_name  
Where column_name = xxx  
说明：  
查询符合条件的资料共有几笔。  
Select SUM(column1)  
FROM table_name  
说明：  
1.计算出总和，所选的栏位必须是可数的数字形态。  
2.除此以外还有 AVG() 是计算平均、MAX()、MIN()计算最大最小值的整合性查询。  
Select column1,AVG(column2)  
FROM table_name  
GROUP BY column1  
HAVING AVG(column2) 〉 xxx  
说明：  
1.GROUP BY: 以column1 为一组计算 column2 的平均值必须和 AVG、SUM等整合性查询的关键字  
一起使用。  
2.HAVING : 必须和 GROUP BY 一起使用作为整合性的限制。  
复合性的查询  
Select *  
FROM table_name1  
Where EXISTS (  
Select *  
FROM table_name2  
Where conditions )  
说明：  
1.Where 的 conditions 可以是另外一个的 query。  
2.EXISTS 在此是指存在与否。  
Select *  
FROM table_name1  
Where column1 IN (  
Select column1  
FROM table_name2  
Where conditions )  
说明：　  
1. IN 後面接的是一个集合，表示column1 存在集合里面。  
2. Select 出来的资料形态必须符合 column1。  
其他查询  
Select *  
FROM table_name1  
Where column1 LIKE ’x%’  
说明：LIKE 必须和後面的’x%’ 相呼应表示以 x为开头的字串。  
Select *  
FROM table_name1  
Where column1 IN (’xxx’,’yyy’,..)  
说明：IN 後面接的是一个集合，表示column1 存在集合里面。  
Select *  
FROM table_name1  
Where column1 BETWEEN xx AND yy  
说明：BETWEEN 表示 column1 的值介於 xx 和 yy 之间。  
３、更改资料：  
Update table_name  
SET column1=’xxx’  
Where conditoins  
说明：  
1.更改某个栏位设定其值为’xxx’。  
2.conditions 是所要符合的条件、若没有 Where 则整个 table 的那个栏位都会全部被更改。  
４、删除资料：  
Delete FROM table_name  
Where conditions  
说明：删除符合条件的资料。  
说明：关于Where条件后面如果包含有日期的比较，不同数据库有不同的表达式。具体如下：  
(1)如果是ACCESS数据库，则为：Where mydate〉#2000-01-01#  
(2)如果是ORACLE数据库，则为：Where mydate〉cast(’2000-01-01’ as date)  
或：Where mydate〉to_date(’2000-01-01’,’yyyy-mm-dd’)  
在Delphi中写成：  
thedate=’2000-01-01’;  
query1.SQL.add(’select * from abc where mydate〉cast(’+’’’’+thedate+’’’’+’ as date)’);  
如果比较日期时间型，则为：  
Where mydatetime〉to_date(’2000-01-01 10:00:01’,’yyyy-mm-dd hh24:mi:ss’)
Recordset对象一些有用的属性"/〉 引用来自 增加一个 ：Recordset对象一些有用的属性
rs.CursorType=
rs.CursorLocation=
rs.LockType =  
rs.CacheSize=
rs.Pagesize=
rs.Pagecount=
rs.RecordCount=
’’---- CursorType Values ----
Const adOpenForwardOnly = 0 仅向前
Const adOpenKeyset = 1 键集游标
Const adOpenDynamic = 2 动态游标
Const adOpenStatic = 3 静态游标
’’---- LockType Values ----
Const adLockReadOnly = 1 默认值，只读
Const adLockPessimistic = 2 保守式记录锁定  
Const adLockOptimistic = 3 开放式记录锁定，只在调用Update方法时锁定记录
Const adLockBatchOptimistic = 4 开放式批更新
’’---- CursorLocation Values ----
Const adUseServer = 2
Const adUseClient = 3  
Set rs=Server.CreateObject("ADODB.Rrecordset")  
rs.Open.sqlst,conn,1,1 ’读取  
rs.Open sqlst,conn,1,2 ’新增，修改，或删除） 
下一页 ：《SQL SERVER的数据类型》 
〉〉〉---------我想分页！--这么长的文章，在这里来个分页多好啊！哈哈----------〈〈〈 
《SQL SERVER的数据类型》
1.SQL SERVER的数据类型  
　　数据类弄是数据的一种属性，表示数据所表示信息的类型。任何一种计算机语言都定义了自己的数据类型。当然，不同的程序语言都具有不同的特点，所定义的数据类型的各类和名称都或多或少有些不同。SQLServer 提供了 25 种数据类型： 
　　·Binary [(n)] 
　　·Varbinary [(n)] 
　　·Char [(n)] 
　　·Varchar[(n)] 
　　·Nchar[(n)] 
　　·Nvarchar[(n)] 
　　·Datetime 
　　·Smalldatetime 
　　·Decimal[(p[,s])] 
　　·Numeric[(p[,s])] 
　　·Float[(n)] 
　　·Real 
　　·Int 
　　·Smallint 
　　·Tinyint 
　　·Money 
　　·Smallmoney 
　　·Bit 
　　·Cursor 
　　·Sysname 
　　·Timestamp 
　　·Uniqueidentifier 
　　·Text 
　　·Image 
　　·Ntext  
(1)二进制数据类型  
　　二进制数据包括 Binary、Varbinary 和 Image 
　　Binary 数据类型既可以是固定长度的(Binary),也可以是变长度的。 
　　Binary[(n)] 是 n 位固定的二进制数据。其中，n 的取值范围是从 1 到 8000。其存储窨的大小是 n + 4 个字节。 
　　Varbinary[(n)] 是 n 位变长度的二进制数据。其中，n 的取值范围是从 1 到 8000。其存储窨的大小是 n + 4个字节，不是n 个字节。 
　　在 Image 数据类型中存储的数据是以位字符串存储的，不是由 SQL Server 解释的，必须由应用程序来解释。例如，应用程序可以使用BMP、TIEF、GIF 和 JPEG 格式把数据存储在 Image 数据类型中。  
(2)字符数据类型  
　　字符数据的类型包括 Char，Varchar 和 Text 
　　字符数据是由任何字母、符号和数字任意组合而成的数据。 
　　Varchar 是变长字符数据，其长度不超过 8KB。Char 是定长字符数据，其长度最多为 8KB。超过 8KB 的ASCII 数据可以使用Text数据类型存储。例如，因为 Html 文档全部都是 ASCII 字符，并且在一般情况下长度超过 8KB，所以这些文档可以 Text 数据类型存储在SQL Server 中。  
(3)Unicode 数据类型  
　　Unicode 数据类型包括 Nchar,Nvarchar 和Ntext 
　　在 Microsoft SQL Server 中，传统的非 Unicode 数据类型允许使用由特定字符集定义的字符。在 SQL Server安装过程中，允许选择一种字符集。使用 Unicode 数据类型，列中可以存储任何由Unicode 标准定义的字符。在 Unicode 标准中，包括了以各种字符集定义的全部字符。使用Unicode数据类型，所战胜的窨是使用非 Unicode 数据类型所占用的窨大小的两倍。  
　　在 SQL Server 中，Unicode 数据以 Nchar、Nvarchar 和 Ntext 数据类型存储。使用这种字符类型存储的列可以存储多个字符集中的字符。当列的长度变化时，应该使用Nvarchar 字符类型，这时最多可以存储 4000 个字符。当列的长度固定不变时，应该使用 Nchar 字符类型，同样，这时最多可以存储4000 个字符。当使用 Ntext 数据类型时，该列可以存储多于 4000 个字符。  
(4)日期和时间数据类型  
　　日期和时间数据类型包括 Datetime 和 Smalldatetime两种类型 
　　日期和时间数据类型由有效的日期和时间组成。例如，有效的日期和时间数据包括“4/01/98 12:15:00:00:00 PM”和“1:28:29:15:01AM 8/17/98”。前一个数据类型是日期在前，时间在后一个数据类型是霎时间在前，日期在后。在 Microsoft SQL Server中，日期和时间数据类型包括Datetime 和 Smalldatetime 两种类型时，所存储的日期范围是从 1753 年 1 月 1 日开始，到9999 年12 月 31 日结束(每一个值要求 8 个存储字节)。使用 Smalldatetime 数据类型时，所存储的日期范围是 1900年 1 月 1日 开始，到 2079 年 12 月 31 日结束(每一个值要求 4 个存储字节)。 
　　日期的格式可以设定。设置日期格式的命令如下： 
　　Set DateFormat {format | @format _var| 
　　其中，format | @format_var 是日期的顺序。有效的参数包括 MDY、DMY、YMD、YDM、MYD 和 DYM。在默认情况下，日期格式为MDY。 
　　例如，当执行 Set DateFormat YMD 之后，日期的格式为年 月 日 形式；当执行 Set DateFormat DMY 之后，日期的格式为日 月有年 形式  
（5）数字数据类型  
　　数字数据只包含数字。数字数据类型包括正数和负数、小数（浮点数）和整数 
　　整数由正整数和负整数组成，例如 39、25、0-2 和 33967。在 Micrsoft SQL Server 中，整数存储的数据类型是 　　 Int，Smallint和 Tinyint。Int 数据类型存储数据的范围大于 Smallint 数据类型存储数据的范围，而 Smallint 据类型存储数据的范围大于Tinyint 数据类型存储数据的范围。使用 Int 数据狗昔存储数据的范围是从 -2 147 483 648 到 2 147 483 647（每一个值要求4个字节存储空间）。使用 Smallint 数据类型时，存储数据的范围从 -32 768 到 32 767（每一个值要求2个字节存储空间）。使用Tinyint 数据类型时，存储数据的范围是从0 到255（每一个值要求1个字节存储空间）。 
　　精确小娄数据在 SQL Server 中的数据类型是 Decimal 和 Numeric。这种数据所占的存储空间根据该数据的位数后的位数来确定。 
　　在SQL Server 中，近似小数数据的数据类型是 Float 和 Real。例如，三分之一这个分数记作。3333333，当使用近似数据类型时能准确表示。因此，从系统中检索到的数据可能与存储在该列中数据不完全一样。  
（6）货币数据表示正的或者负的货币数量 。  
　　在 Microsoft SQL Server 中，货币数据的数据类型是Money 和 Smallmoney  
　　Money数据类型要求 8 个存储字节，Smallmoney 数据类型要求 4 个存储字节。  
（7）特殊数据类型  
　　特殊数据类型包括前面没有提过的数据类型。特殊的数据类型有3种，即 　　 Timestamp、Bit 和 Uniqueidentifier。 
　　Timestamp 用于表示SQL Server 活动的先后顺序，以二进投影的格式表示。Timestamp 数据与插入数据或者日期和时间没有关系。 
　　Bit 由 1 或者 0 组成。当表示真或者假、ON 或者 OFF 时，使用 Bit 数据类型。例如，询问是否是每一次访问的客户机请求可以存储在这种数据类型的列中。 
　　Uniqueidentifier 由 16 字节的十六进制数字组成，表示一个全局唯一的。当表的记录行要求唯一时，GUID是非常有用。例如，在客户标识号列使用这种数据类型可以区别不同的客户。  
2.用户定义的数据类型  
　　用户定义的数据类型基于在 Microsoft SQL Server 中提供的数据类型。当几个表中必须存储同一种数据类型时，并且为保证这些列有相同的数据类型、长度和可空性时，可以使用用户定义的数据类型。例如，可定义一种称为 　　postal_code 的数据类型，它基于 Char 数据类型。 
　　当创建用户定义的数据类型时，必须提供三个数：数据类型的名称、所基于的系统数据类型和数据类型的可空性。  
（1）创建用户定义的数据类型  
　　创建用户定义的数据类型可以使用 Transact-SQL 语句。系统存储过程 sp_addtype 可以来创建用户定义的数据类型。其语法形式如下： 
　　sp_addtype {type},[,system_data_bype][,’null_type’] 
　　其中，type 是用户定义的数据类型的名称。system_data_type 是系统提供的数据类型，例如 Decimal、Int、Char 　　等等。 null_type 表示该数据类型是如何处理空值的，必须使用单引号引起来，例如’NULL’、’NOT NULL’或者’NONULL’。 
　　例子： 
　　Use cust 
　　Exec sp_addtype ssn,’Varchar(11)’,"Not Null’ 
　　创建一个用户定义的数据类型 ssn，其基于的系统数据类型是变长为11 的字符，不允许空。 
　　例子： 
　　Use cust 
　　Exec sp_addtype birthday,datetime,’Null’ 
　　创建一个用户定义的数据类型 birthday，其基于的系统数据类型是 DateTime，允许空。 
　　例子： 
　　Use master 
　　Exec sp_addtype telephone,’varchar(24),’Not Null’ 
　　Eexc sp_addtype fax,’varchar(24)’,’Null’ 
　　创建两个数据类型，即 telephone 和 fax  
（2）删除用户定义的数据类型  
　　当用户定义的数据类型不需要时，可删除。删除用户定义的数据类型的命令是 sp_droptype {’type’}。 
　　例子： 
　　Use master 
　　Exec sp_droptype ’ssn’ 
　　注意：当表中的列还正在使用用户定义的数据类型时，或者在其上面还绑定有默认或者规则时，这种用户定义的数据类型不能删除。  
　　以下为SQL SERVER7.0以上版本的字段类型说明。SQL SERVER6.5的字段类型说明请参考SQL SERVER提供的说明。 
字段类型 描述  
bit 0或1的整型数字  
int 从-2^31(-2,147,483,648)到2^31(2,147,483,647)的整型数字  
smallint 从-2^15(-32,768)到2^15(32,767)的整型数字  
tinyint 从0到255的整型数字  
decimal 从-10^38到10^38-1的定精度与有效位数的数字  
numeric decimal的同义词  
money 从-2^63(-922,337,203,685,477.5808)到2^63-1(922,337,203,685,477.5807)的货币数据，最小货币单位千分之十  
smallmoney 从-214,748.3648到214,748.3647的货币数据，最小货币单位千分之十  
float 从-1.79E+308到1.79E+308可变精度的数字  
real 从-3.04E+38到3.04E+38可变精度的数字  
datetime 从1753年1月1日到9999年12日31的日期和时间数据，最小时间单位为百分之三秒或3.33毫秒  
smalldatetime 从1900年1月1日到2079年6月6日的日期和时间数据，最小时间单位为分钟  
timestamp 时间戳，一个数据库宽度的唯一数字  
uniqueidentifier 全球唯一标识符GUID  
char 定长非Unicode的字符型数据，最大长度为8000  
varchar 变长非Unicode的字符型数据，最大长度为8000  
text 变长非Unicode的字符型数据，最大长度为2^31-1(2G)  
nchar 定长Unicode的字符型数据，最大长度为8000  
nvarchar 变长Unicode的字符型数据，最大长度为8000  
ntext 变长Unicode的字符型数据，最大长度为2^31-1(2G)  
binary 定长二进制数据，最大长度为8000  
varbinary 变长二进制数据，最大长度为8000  
image 变长二进制数据，最大长度为2^31-1(2G)  
〉〉〉---------我想分页！--这么长的文章，在这里来个分页多好啊！哈哈----------〈〈〈 
《SQL语句的基本语法》 
一.Select语句的完整语法为：
Select[ALL|DISTINCT|DISTINCTROW|TOP]
{*|talbe.*|[table.]field1[AS alias1][,[table.]field2[AS alias2][,…]]}
FROM tableexpression[,…][IN externaldatabase]
[Where…]
[GROUP BY…]
[HAVING…]
[ORDER BY…]
[WITH OWNERACCESS OPTION] 
说明： 
用中括号([])括起来的部分表示是可选的，用大括号({})括起来的部分是表示必须从中选择其中的一个。
1 FROM子句
FROM子句指定了Select语句中字段的来源。FROM子句后面是包含一个或多个的表达式(由逗号分开)，其中的表达式可为单一表名称、已保存的查询或由 INNER JOIN、LEFT JOIN 或 RIGHT JOIN 得到的复合结果。如果表或查询存储在外部数据库，在IN 子句之后指明其完整路径。 
例：下列SQL语句返回所有有定单的客户：
Select orderID,Customer.customerID
FROM orders Customers
Where orders.CustomerID=Customers.CustomeersID
2 ALL、DISTINCT、DISTINCTROW、TOP谓词
(1) ALL 返回满足SQL语句条件的所有记录。如果没有指明这个谓词，默认为ALL。 
例：Select ALL FirstName,LastName
FROM Employees
(2) DISTINCT 如果有多个记录的选择字段的数据相同，只返回一个。
(3) DISTINCTROW 如果有重复的记录，只返回一个
(4) TOP显示查询头尾若干记录。也可返回记录的百分比，这是要用 TOP N PERCENT子句（其中N 表示百分比） 
例：返回5%定货额最大的定单
Select TOP 5 PERCENT*
FROM [ order Details]
orDER BY UnitPrice*Quantity*(1-Discount) DESC
3 用 AS 子句为字段取别名 
如果想为返回的列取一个新的标题，或者，经过对字段的计算或总结之后，产生了一个新的值，希望把它放到一个新的列里显示，则用AS保留。 
例：返回FirstName字段取别名为NickName
Select FirstName AS NickName ,LastName ,City
FROM Employees 
例：返回新的一列显示库存价值
Select ProductName ,UnitPrice ,UnitsInStock ,UnitPrice*UnitsInStock AS valueInStock
FROM Products 
二 .Where 子句指定查询条件
1 比较运算符 
比较运算符 含义
= 等于 
〉 大于 
〈 小于 
〉= 大于等于 
〈= 小于等于 
〈〉 不等于
!〉 不大于
!〈 不小于 
例：返回96年1月的定单
Select orderID, CustomerID, orderDate
FROM orders
Where orderDate〉#1/1/96# AND orderDate〈#1/30/96# 
注意：
Mcirosoft JET SQL 中，日期用‘#’定界。日期也可以用Datevalue()函数来代替。在比较字符型的数据时，要加上单引号’’，尾空格在比较中被忽略。 
例：
Where orderDate〉#96-1-1# 
也可以表示为：
Where orderDate〉Datevalue(‘1/1/96’) 
使用 NOT 表达式求反。 
例：查看96年1月1日以后的定单
Where Not orderDate〈=#1/1/96#
2 范围（BETWEEN 和 NOT BETWEEN）
BETWEEN …AND…运算符指定了要搜索的一个闭区间。 
例：返回96年1月到96年2月的定单。
Where orderDate Between #1/1/96# And #2/1/96#
3 列表（IN ，NOT IN）
IN 运算符用来匹配列表中的任何一个值。IN子句可以代替用OR子句连接的一连串的条件。 
例：要找出住在 London、Paris或Berlin的所有客户
Select CustomerID, CompanyName, ContactName, City
FROM Customers
Where City In(‘London’,’ Paris’,’ Berlin’)
4 模式匹配(LIKE)
LIKE运算符检验一个包含字符串数据的字段值是否匹配一指定模式。
LIKE运算符里使用的通配符 
通配符 含义 
？ 任何一个单一的字符
* 任意长度的字符
# 0~9之间的单一数字
[字符列表] 在字符列表里的任一值
[！字符列表] 不在字符列表里的任一值
- 指定字符范围，两边的值分别为其上下限 
例：返回邮政编码在（171）555-0000到（171）555-9999之间的客户
Select CustomerID ,CompanyName,City,Phone
FROM Customers
Where Phone Like ‘(171)555-####’
LIKE运算符的一些样式及含义 
样式 含义 不符合
LIKE ‘A*’ A后跟任意长度的字符 Bc,c255
LIKE’5  
’ 5*5 555
LIKE’5?5’ 5与5之间有任意一个字符 55,5wer5
LIKE’5##5’ 5235，5005 5kd5,5346
LIKE’[a-z]’ a-z间的任意一个字符 5,%
LIKE’[!0-9]’ 非0-9间的任意一个字符 0,1
LIKE’[[]’ 1,* 
三 .用ORDER BY子句排序结果
orDER子句按一个或多个（最多16个）字段排序查询结果，可以是升序（ASC）也可以是降序（DESC），缺省是升序。ORDER子句通常放在SQL语句的最后。
orDER子句中定义了多个字段，则按照字段的先后顺序排序。 
例：
Select ProductName,UnitPrice, UnitInStock
FROM Products
orDER BY UnitInStock DESC , UnitPrice DESC, ProductName  
orDER BY 子句中可以用字段在选择列表中的位置号代替字段名，可以混合字段名和位置号。 
例：下面的语句产生与上列相同的效果。
Select ProductName,UnitPrice, UnitInStock
FROM Products
orDER BY 1 DESC , 2 DESC,3  
四 .运用连接关系实现多表查询 
例：找出同一个城市中供应商和客户的名字
Select Customers.CompanyName, Suppliers.ComPany.Name
FROM Customers, Suppliers
Where Customers.City=Suppliers.City 
例：找出产品库存量大于同一种产品的定单的数量的产品和定单
Select ProductName,OrderID, UnitInStock, Quantity
FROM Products, [Order Deails]
Where Product.productID=[Order Details].ProductID
AND UnitsInStock〉Quantity 
另一种方法是用 Microsof JET SQL 独有的 JNNER JOIN 
语法：
FROM table1 INNER JOIN table2
ON table1.field1 comparision table2.field2 
其中comparision 就是前面Where子句用到的比较运算符。
Select FirstName,lastName,OrderID,CustomerID,OrderDate
FROM Employees
INNER JOIN orders ON Employees.EmployeeID=Orders.EmployeeID 
注意：
INNER JOIN不能连接Memo OLE Object Single Double 数据类型字段。 
在一个JOIN语句中连接多个ON子句 
语法：
Select fields
FROM table1 INNER JOIN table2
ON table1.field1 compopr table2.field1 AND
ON table1.field2 compopr table2.field2 or
ON table1.field3 compopr table2.field3 
也可以
Select fields
FROM table1 INNER JOIN 
（table2 INNER JOIN [( ]table3
[INNER JOER] [( ]tablex[INNER JOIN]
ON table1.field1 compopr table2.field1  
ON table1.field2 compopr table2.field2  
ON table1.field3 compopr table2.field3 
外部连接返回更多记录，在结果中保留不匹配的记录，不管存不存在满足条件的记录都要返回另一侧的所有记录。
FROM table [LEFT|RIGHT]JOIN table2
ON table1.field1comparision table.field2 
用左连接来建立外部连接，在表达式的左边的表会显示其所有的数据 
例：不管有没有定货量，返回所有商品
Select ProductName ,OrderID
FROM Products
LEFT JOIN orders ON Products.PrductsID=Orders.ProductID 
右连接与左连接的差别在于：不管左侧表里有没有匹配的记录，它都从左侧表中返回所有记录。 
例：如果想了解客户的信息，并统计各个地区的客户分布，这时可以用一个右连接，即使某个地区没有客户，也要返回客户信息。 
空值不会相互匹配，可以通过外连接才能测试被连接的某个表的字段是否有空值。
Select *
FROM talbe1
LEFT JOIN table2 ON table1.a=table2.c
1 连接查询中使用Iif函数实现以0值显示空值
Iif表达式： Iif(IsNull(Amount,0,Amout) 
例：无论定货大于或小于￥50，都要返回一个标志。
Iif([Amount]〉50,?Big order?,?Small order?) 
五. 分组和总结查询结果 
在SQL的语法里，GROUP BY和HAVING子句用来对数据进行汇总。GROUP BY子句指明了按照哪几个字段来分组，而将记录分组后，用HAVING子句过滤这些记录。
GROUP BY 子句的语法
Select fidldlist
FROM table
Where criteria
[GROUP BY groupfieldlist [HAVING groupcriteria]] 
注：Microsoft Jet数据库 Jet 不能对备注或OLE对象字段分组。
GROUP BY字段中的Null值以备分组但是不能被省略。 
在任何SQL合计函数中不计算Null值。
GROUP BY子句后最多可以带有十个字段，排序优先级按从左到右的顺序排列。 
例：在‘WA’地区的雇员表中按头衔分组后，找出具有同等头衔的雇员数目大于1人的所有头衔。
Select Title ,Count(Title) as Total
FROM Employees
Where Region = ‘WA’
GROUP BY Title
HAVING Count(Title)〉1
JET SQL 中的聚积函数 
聚集函数 意义
SUM ( ) 求和
AVG ( ) 平均值
COUNT ( ) 表达式中记录的数目
COUNT (* ) 计算记录的数目
MAX 最大值
MIN 最小值
VAR 方差
STDEV 标准误差
FIRST 第一个值
LAST 最后一个值 
六. 用Parameters声明创建参数查询
Parameters声明的语法:
PARAMETERS name datatype[,name datatype[, …]] 
其中name 是参数的标志符,可以通过标志符引用参数.
Datatype说明参数的数据类型. 
使用时要把PARAMETERS 声明置于任何其他语句之前. 
例:
PARAMETERS[Low price] Currency,[Beginning date]datatime
Select orderID ,OrderAmount
FROM orders
Where orderAMount〉[low price]
AND orderDate〉=[Beginning date] 
七. 功能查询 
所谓功能查询,实际上是一种操作查询,它可以对数据库进行快速高效的操作.它以选择查询为目的,挑选出符合条件的数据,再对数据进行批处理.功能查询包括更新查询,删除查询,添加查询,和生成表查询.
1 更新查询
Update子句可以同时更改一个或多个表中的数据.它也可以同时更改多个字段的值. 
更新查询语法:
Update 表名
SET 新值
Where 准则 
例:英国客户的定货量增加5%,货运量增加3%
Update OEDERS
SET orderAmount = orderAmount *1.1
Freight = Freight*1.03
Where ShipCountry = ‘UK’
2 删除查询
Delete子句可以使用户删除大量的过时的或冗于的数据. 
注:删除查询的对象是整个记录.
Delete子句的语法:
Delete [表名.*]
FROM 来源表
Where 准则 
例: 要删除所有94年前的定单
Delete *
FROM orders
Where orderData〈#94-1-1#
3 追加查询  
Insert子句可以将一个或一组记录追加到一个或多个表的尾部.
INTO 子句指定接受新记录的表
valueS 关键字指定新记录所包含的数据值.
Insert 子句的语法:
INSETR INTO 目的表或查询(字段1,字段2,…)
valueS(数值1,数值2,…) 
例:增加一个客户
Insert INTO Employees(FirstName,LastName,title)
valueS(‘Harry’,’Washington’,’Trainee’)
4 生成表查询 
可以一次性地把所有满足条件的记录拷贝到一张新表中.通常制作记录的备份或副本或作为报表的基础.
Select INTO子句用来创建生成表查询语法:
Select 字段1,字段2,…
INTO 新表[IN 外部数据库]
FROM 来源数据库
Where 准则 
例:为定单制作一个存档备份
Select *
INTO ordersArchive
FROM orders 
八. 联合查询
UNION运算可以把多个查询的结果合并到一个结果集里显示.
UNION运算的一般语法:
[表]查询1 UNION [ALL]查询2 UNION … 
例:返回巴西所有供给商和客户的名字和城市
Select CompanyName,City
FROM Suppliers
Where Country = ‘Brazil’
UNION
Select CompanyName,City
FROM Customers
Where Country = ‘Brazil’ 
注: 
缺省的情况下,UNION子句不返回重复的记录.如果想显示所有记录,可以加ALL选项
UNION运算要求查询具有相同数目的字段.但是,字段数据类型不必相同. 
每一个查询参数中可以使用GROUP BY 子句 或 HAVING 子句进行分组.要想以指定的顺序来显示返回的数据,可以在最后一个查询的尾部使用OREER BY子句. 
九. 交叉查询 
交叉查询可以对数据进行总和,平均,计数或其他总和计算法的计算,这些数据通过两种信息进行分组:一个显示在表的左部,另一个显示在表的顶部.
Microsoft Jet SQL 用TRANSFROM语句创建交叉表查询语法:
TRANSFORM aggfunction
Select 语句
GROUP BY 子句
PIVOT pivotfield[IN(value1 [,value2[,…]]) ]
Aggfounction指SQL聚积函数,
Select语句选择作为标题的的字段,
GROUP BY 分组 
说明：
Pivotfield 在查询结果集中创建列标题时用的字段或表达式,用可选的IN子句限制它的取值.
value代表创建列标题的固定值. 
例:显示在1996年里每一季度每一位员工所接的定单的数目:
TRANSFORM Count(OrderID)
Select FirstName&’’&LastName AS FullName
FROM Employees INNER JOIN orders
ON Employees.EmployeeID = orders.EmployeeID
Where DatePart(“yyyy”,OrderDate)= ‘1996’
GROUP BY FirstName&’’&LastName
orDER BY FirstName&’’&LastName
POVOT DatePart(“q”,OrderDate)&’季度’ 
十 .子查询 
子查询可以理解为 套查询.子查询是一个Select语句.
1 表达式的值与子查询返回的单一值做比较 
语法:  
表达式 comparision [ANY|ALL|SOME](子查询) 
说明：
ANY和SOME谓词是同义词,与比较运算符(=,〈,〉,〈〉,〈=,〉=)一起使用.返回一个布尔值True或False.ANY的意思是,表达式与子查询返回的一系列的值逐一比较,只要其中的一次比较产生True结果,ANY测试的返回 True值(既Where子句的结果),对应于该表达式的当前记录将进入主查询的结果中.ALL测试则要求表达式与子查询返回的一系列的值的比较都产生True结果,才回返回True值. 
例:主查询返回单价比任何一个折扣大于等于25%的产品的单价要高的所有产品
Select * FROM Products
Where UnitPrice〉ANY
(Select UnitPrice FROM[Order Details] Where Discount〉0.25)
2 检查表达式的值是否匹配子查询返回的一组值的某个值 
语法:
[NOT]IN(子查询) 
例:返回库存价值大于等于1000的产品.
Select ProductName FROM Products
Where ProductID IN
(Select PrdoctID FROM [Order DEtails]
Where UnitPrice*Quantity〉= 1000)
3检测子查询是否返回任何记录 
语法:
[NOT]EXISTS (子查询) 
例:用EXISTS检索英国的客户
Select ComPanyName,ContactName
FROM orders
Where EXISTS
(Select *
FROM Customers
Where Country = ‘UK’ AND
Customers.CustomerID= orders.CustomerID) 
〉〉〉---------我想分页！--这么长的文章，在这里来个分页多好啊！哈哈----------〈〈〈
Sql Server 和 Access 操作数据库结构Sql语句 
下面是Sql Server 和 Access 操作数据库结构的常用Sql，希望对你有所帮助。 
内容由海娃整理，不正确与不完整之处还请提出，谢谢。 
新建表：
create table [表名]
(
[自动编号字段] int IDENTITY (1,1) PRIMARY KEY ,
[字段1] nVarChar(50) default ’默认值’ null ,
[字段2] ntext null ,
[字段3] datetime,
[字段4] money null ,
[字段5] int default 0,
[字段6] Decimal (12,4) default 0,
[字段7] image null ,
) 
删除表：
Drop table [表名] 
插入数据：
Insert INTO [表名] (字段1,字段2) VALUES (100,’51WINDOWS.NET’) 
删除数据：
Delete FROM [表名] Where [字段名]〉100 
更新数据：
Update [表名] SET [字段1] = 200,[字段2] = ’51WINDOWS.NET’ Where [字段三] = ’HAIWA’ 
新增字段：
Alter TABLE [表名] ADD [字段名] NVARCHAR (50) NULL 
删除字段：
Alter TABLE [表名] Drop COLUMN [字段名] 
修改字段：
Alter TABLE [表名] Alter COLUMN [字段名] NVARCHAR (50) NULL 
重命名表：(Access 重命名表，请参考文章：在Access数据库中重命名表) 
引用来自 在Access数据库中重命名表
Dim Conn,ConnStr,oCat,oTbl
ConnStr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("data.mdb")
Set oCat=Server.CreateObject("ADOX.Catalog")  
oCat.ActiveConnection = ConnStr
Set oTbl = Server.CreateObject("ADOX.Table")
Set oTbl = oCat.Tables("OldTable") ’要重命名的表名：OldTable
oTbl.Name = "NewTable" ’新表名
Set oCat = Nothing
Set oTbl = Nothing
sp_rename ’表名’, ’新表名’, ’OBJECT’ 
新建约束：
Alter TABLE [表名] ADD CONSTRAINT 约束名 CHECK ([约束字段] 〈= ’2000-1-1’) 
删除约束：
Alter TABLE [表名] Drop CONSTRAINT 约束名 
新建默认值
Alter TABLE [表名] ADD CONSTRAINT 默认值名 DEFAULT ’51WINDOWS.NET’ FOR [字段名] 
删除默认值
Alter TABLE [表名] Drop CONSTRAINT 默认值名 
删除Sql Server 中的日志，减小数据库文件大小
dump transaction 数据库名 with no_log
backup log 数据库名 with no_log
dbcc shrinkdatabase(数据库名)
exec sp_dboption ’数据库名’, ’autoshrink’, ’true’
 
 
 
SQL查询语句精华大全.txt
一、 简单查询
简单的Transact-SQL查询只包括选择列表、FROM子句和WHERE子句。它们分别说明所查询列、查询的
表或视图、以及搜索条件等。
例如，下面的语句查询testtable表中姓名为“张三”的nickname字段和email字段。
SELECT nickname,email
FROM testtable
WHERE name='张三'
 
(一) 选择列表
选择列表(select_list)指出所查询列，它可以是一组列名列表、星号、表达式、变量(包括局部变
量和全局变量)等构成。
1、选择所有列
例如，下面语句显示testtable表中所有列的数据：
SELECT *
FROM testtable
 
2、选择部分列并指定它们的显示次序
查询结果集合中数据的排列顺序与选择列表中所指定的列名排列顺序相同。
例如：
SELECT nickname,email
FROM testtable
 
3、更改列标题
在选择列表中，可重新指定列标题。定义格式为：
列标题=列名
列名 列标题
如果指定的列标题不是标准的标识符格式时，应使用引号定界符，例如，下列语句使用汉字显示列
标题：
SELECT 昵称=nickname,电子邮件=email
FROM testtable
 
4、删除重复行
SELECT语句中使用ALL或DISTINCT选项来显示表中符合条件的所有行或删除其中重复的数据行，默认
为ALL。使用DISTINCT选项时，对于所有重复的数据行在SELECT返回的结果集合中只保留一行。
 
5、限制返回的行数
使用TOP n [PERCENT]选项限制返回的数据行数，TOP n说明返回n行，而TOP n PERCENT时，说明n是
表示一百分数，指定返回的行数等于总行数的百分之几。
例如：
SELECT TOP 2 *
FROM testtable
SELECT TOP 20 PERCENT *
FROM testtable
 
(二) FROM子句
FROM子句指定SELECT语句查询及与查询相关的表或视图。在FROM子句中最多可指定256个表或视图，
它们之间用逗号分隔。
在FROM子句同时指定多个表或视图时，如果选择列表中存在同名列，这时应使用对象名限定这些列
所属的表或视图。例如在usertable和citytable表中同时存在cityid列，在查询两个表中的cityid时应
使用下面语句格式加以限定：
SELECT username,citytable.cityid
FROM usertable,citytable
WHERE usertable.cityid=citytable.cityid
在FROM子句中可用以下两种格式为表或视图指定别名：
表名 as 别名
表名 别名
例如上面语句可用表的别名格式表示为：
SELECT username,b.cityid
FROM usertable a,citytable b
WHERE a.cityid=b.cityid
SELECT不仅能从表或视图中检索数据，它还能够从其它查询语句所返回的结果集合中查询数据。
例如：
SELECT a.au_fname+a.au_lname
FROM authors a,titleauthor ta
(SELECT title_id,title
FROM titles
WHERE ytd_sales>10000
) AS t
WHERE a.au_id=ta.au_id
AND ta.title_id=t.title_id
此例中，将SELECT返回的结果集合给予一别名t，然后再从中检索数据。
 
(三) 使用WHERE子句设置查询条件
WHERE子句设置查询条件，过滤掉不需要的数据行。例如下面语句查询年龄大于20的数据：
SELECT *
FROM usertable
WHERE age>20
WHERE子句可包括各种条件运算符：
比较运算符(大小比较)：>、>=、=、<、<=、<>、!>、!<
范围运算符(表达式值是否在指定的范围)：BETWEEN…AND…
NOT BETWEEN…AND…
列表运算符(判断表达式是否为列表中的指定项)：IN (项1,项2……)
NOT IN (项1,项2……)
模式匹配符(判断值是否与指定的字符通配格式相符):LIKE、NOT LIKE
空值判断符(判断表达式是否为空)：IS NULL、NOT IS NULL
逻辑运算符(用于多条件的逻辑连接)：NOT、AND、OR
1、范围运算符例：age BETWEEN 10 AND 30相当于age>=10 AND age<=30
2、列表运算符例：country IN ('Germany','China')
3、模式匹配符例：常用于模糊查找，它判断列值是否与指定的字符串格式相匹配。可用于char、
varchar、text、ntext、datetime和smalldatetime等类型查询。
可使用以下通配字符：
百分号%：可匹配任意类型和长度的字符，如果是中文，请使用两个百分号即%%。
下划线_：匹配单个任意字符，它常用来限制表达式的字符长度。
方括号[]：指定一个字符、字符串或范围，要求所匹配对象为它们中的任一个。
[^]：其取值也[] 相同，但它要求所匹配对象为指定字符以外的任一个字符。
例如：
限制以Publishing结尾，使用LIKE '%Publishing'
限制以A开头：LIKE '[A]%'
限制以A开头外：LIKE '[^A]%'
4、空值判断符例WHERE age IS NULL
5、逻辑运算符：优先级为NOT、AND、OR
(四)查询结果排序
使用ORDER BY子句对查询返回的结果按一列或多列排序。ORDER BY子句的语法格式为：
ORDER BY {column_name [ASC|DESC]} [,…n]
其中ASC表示升序，为默认值，DESC为降序。ORDER BY不能按ntext、text和image数据类型进行排
序。
例如：
SELECT *
FROM usertable
ORDER BY age desc,userid ASC
另外，可以根据表达式进行排序。
 
二、 联合查询
UNION运算符可以将两个或两个以上上SELECT语句的查询结果集合合并成一个结果集合显示，即执行联
合查询。UNION的语法格式为：
select_statement
UNION [ALL] selectstatement
[UNION [ALL] selectstatement][…n]
其中selectstatement为待联合的SELECT查询语句。
ALL选项表示将所有行合并到结果集合中。不指定该项时，被联合查询结果集合中的重复行将只保留一
行。
联合查询时，查询结果的列标题为第一个查询语句的列标题。因此，要定义列标题必须在第一个查询语
句中定义。要对联合查询结果排序时，也必须使用第一查询语句中的列名、列标题或者列序号。
在使用UNION 运算符时，应保证每个联合查询语句的选择列表中有相同数量的表达式，并且每个查询选
择表达式应具有相同的数据类型，或是可以自动将它们转换为相同的数据类型。在自动转换时，对于数值类
型，系统将低精度的数据类型转换为高精度的数据类型。
在包括多个查询的UNION语句中，其执行顺序是自左至右，使用括号可以改变这一执行顺序。例如：
查询1 UNION (查询2 UNION 查询3)
 
三、连接查询
通过连接运算符可以实现多个表查询。连接是关系数据库模型的主要特点，也是它区别于其它类型
数据库管理系统的一个标志。
在关系数据库管理系统中，表建立时各数据之间的关系不必确定，常把一个实体的所有信息存放在
一个表中。当检索数据时，通过连接操作查询出存放在多个表中的不同实体的信息。连接操作给用户带
来很大的灵活性，他们可以在任何时候增加新的数据类型。为不同实体创建新的表，尔后通过连接进行
查询。
连接可以在SELECT 语句的FROM子句或WHERE子句中建立，似是而非在FROM子句中指出连接时有助于
将连接操作与WHERE子句中的搜索条件区分开来。所以，在Transact-SQL中推荐使用这种方法。
SQL-92标准所定义的FROM子句的连接语法格式为：
FROM join_table join_type join_table
[ON (join_condition)]
其中join_table指出参与连接操作的表名，连接可以对同一个表操作，也可以对多表操作，对同一
个表操作的连接又称做自连接。
join_type 指出连接类型，可分为三种：内连接、外连接和交叉连接。内连接(INNER JOIN)使用比
较运算符进行表间某(些)列数据的比较操作，并列出这些表中与连接条件相匹配的数据行。根据所使用
的比较方式不同，内连接又分为等值连接、自然连接和不等连接三种。
外连接分为左外连接(LEFT OUTER JOIN或LEFT JOIN)、右外连接(RIGHT OUTER JOIN或RIGHT JOIN)
和全外连接(FULL OUTER JOIN或FULL JOIN)三种。与内连接不同的是，外连接不只列出与连接条件相匹
配的行，而是列出左表(左外连接时)、右表(右外连接时)或两个表(全外连接时)中所有符合搜索条件的
数据行。
交叉连接(CROSS JOIN)没有WHERE 子句，它返回连接表中所有数据行的笛卡尔积，其结果集合中的
数据行数等于第一个表中符合查询条件的数据行数乘以第二个表中符合查询条件的数据行数。
连接操作中的ON (join_condition) 子句指出连接条件，它由被连接表中的列和比较运算符、逻辑
运算符等构成。
无论哪种连接都不能对text、ntext和image数据类型列进行直接连接，但可以对这三种列进行间接
连接。例如：
SELECT p1.pub_id,p2.pub_id,p1.pr_info
FROM pub_info AS p1 INNER JOIN pub_info AS p2
ON DATALENGTH(p1.pr_info)=DATALENGTH(p2.pr_info)
 
(一)内连接
内连接查询操作列出与连接条件匹配的数据行，它使用比较运算符比较被连接列的列值。内连接分
三种：
1、等值连接：在连接条件中使用等于号(=)运算符比较被连接列的列值，其查询结果中列出被连接
表中的所有列，包括其中的重复列。
2、不等连接： 在连接条件使用除等于运算符以外的其它比较运算符比较被连接的列的列值。这些
运算符包括>、>=、<=、<、!>、!<和<>。
3、自然连接：在连接条件中使用等于(=)运算符比较被连接列的列值，但它使用选择列表指出查询
结果集合中所包括的列，并删除连接表中的重复列。
例，下面使用等值连接列出authors和publishers表中位于同一城市的作者和出版社：
SELECT *
FROM authors AS a INNER JOIN publishers AS p
ON a.city=p.city
又如使用自然连接，在选择列表中删除authors 和publishers 表中重复列(city和state)：
SELECT a.*,p.pub_id,p.pub_name,p.country
FROM authors AS a INNER JOIN publishers AS p
ON a.city=p.city
(二)外连接
内连接时，返回查询结果集合中的仅是符合查询条件( WHERE 搜索条件或 HAVING 条件)和连接条件
的行。而采用外连接时，它返回到查询结果集合中的不仅包含符合连接条件的行，而且还包括左表(左外
连接时)、右表(右外连接时)或两个边接表(全外连接)中的所有数据行。
如下面使用左外连接将论坛内容和作者信息连接起来：
SELECT a.*,b.* FROM luntan LEFT JOIN usertable as b
ON a.username=b.username
下面使用全外连接将city表中的所有作者以及user表中的所有作者，以及他们所在的城市：
SELECT a.*,b.*
FROM city as a FULL OUTER JOIN user as b
ON a.username=b.username
 
(三)交叉连接
交叉连接不带WHERE 子句，它返回被连接的两个表所有数据行的笛卡尔积，返回到结果集合中的数
据行数等于第一个表中符合查询条件的数据行数乘以第二个表中符合查询条件的数据行数。
例，titles表中有6类图书，而publishers表中有8家出版社，则下列交叉连接检索到的记录数将等
于6*8=48行。
SELECT type,pub_name
FROM titles CROSS JOIN publishers
ORDER BY typeSQL核心语句(非常实用的几个技巧)插入数据
 
向表中添加一个新记录，你要使用SQL INSERT 语句。这里有一个如何使用这种语句的例子：
 
INSERT mytable (mycolumn) VALUES (‘some data’)
 
这个语句把字符串’some data’插入表mytable的mycolumn字段中。将要被插入数据的字段的名字在第一个括号中指定，实际的数据在第二个括号中给出。
 
INSERT 语句的完整句法如下：
 
INSERT [INTO] {table_name|view_name} [(column_list)] {DEFAULT VALUES |
 
Values_list | select_statement}
 
如果一个表有多个字段，通过把字段名和字段值用逗号隔开，你可以向所有的字段中插入数据。假设表mytable有三个字段first_column,second_column,和third_column。下面的INSERT语句添加了一条三个字段都有值的完整记录：
 
INSERT mytable (first_column,second_column,third_column)
 
VALUES (‘some data’,’some more data’,’yet more data’)
 
注意
 
你可以使用INSERT语句向文本型字段中插入数据。但是，如果你需要输入很长的字符串，你应该使用WRITETEXT语句。这部分内容对本书来说太高级了，因此不加讨论。要了解更多的信息，请参考Microsoft SQL Sever 的文档。
 
如果你在INSERT 语句中只指定两个字段和数据会怎么样呢？换句话说，你向一个表中插入一条新记录，但有一个字段没有提供数据。在这种情况下，有下面的四种可能：
 
如果该字段有一个缺省值，该值会被使用。例如，假设你插入新记录时没有给字段third_column提供数据，而这个字段有一个缺省值’some value’。在这种情况下，当新记录建立时会插入值’some value’。
如果该字段可以接受空值，而且没有缺省值，则会被插入空值。
如果该字段不能接受空值，而且没有缺省值，就会出现错误。你会收到错误信息：
The column in table mytable may not be null.
 
最后，如果该字段是一个标识字段，那么它会自动产生一个新值。当你向一个有标识字段的表中插入新记录时，只要忽略该字段，标识字段会给自己赋一个新值。
 
注意
向一个有标识字段的表中插入新记录后，你可以用SQL变量@@identity来访问新记录
的标识字段的值。考虑如下的SQL语句：
INSERT mytable (first_column) VALUES(‘some value’)
INSERT anothertable(another_first,another_second)
VALUES(@@identity,’some value’)
如果表mytable有一个标识字段，该字段的值会被插入表anothertable的another_first字段。这是因为变量@@identity总是保存最后一次插入标识字段的值。
字段another_first应该与字段first_column有相同的数据类型。但是，字段another_first不能是应该标识字段。Another_first字段用来保存字段first_column的值。
 
删除记录
要从表中删除一个或多个记录，需要使用SQL DELETE语句。你可以给DELETE 语句提供WHERE 子句。WHERE子句用来选择要删除的记录。例如，下面的这个DELETE语句只删除字段first_column的值等于’Delete Me’的记录：
DELETE mytable WHERE first_column=’Deltet Me’
DELETE 语句的完整句法如下：
DELETE [FROM] {table_name|view_name} [WHERE clause]
在SQL SELECT 语句中可以使用的任何条件都可以在DELECT 语句的WHERE子句中使用。例如，下面的这个DELETE语句只删除那些first_column字段的值为’goodbye’或second_column字段的值为’so long’的记录：
DELETE mytable WHERE first_column=’goodby’ OR second_column=’so long’
如果你不给DELETE 语句提供WHERE 子句，表中的所有记录都将被删除。你不应该有这种想法。如果你想删除应该表中的所有记录，应使用第十章所讲的TRUNCATE TABLE语句。
 
注意
为什么要用TRUNCATE TABLE 语句代替DELETE语句？当你使用TRUNCATE TABLE语句时，记录的删除是不作记录的。也就是说，这意味着TRUNCATE TABLE 要比DELETE快得多。
 
更新记录
要修改表中已经存在的一条或多条记录，应使用SQL UPDATE语句。同DELETE语句一样，UPDATE语句可以使用WHERE子句来选择更新特定的记录。请看这个例子：
UPDATE mytable SET first_column=’Updated!’ WHERE second_column=’Update Me!’
这个UPDATE 语句更新所有second_column字段的值为’Update Me!’的记录。对所有被选中的记录，字段first_column的值被置为’Updated!’。
 
下面是UPDATE语句的完整句法：
UPDATE {table_name|view_name} SET [{table_name|view_name}]
{column_list|variable_list|variable_and_column_list}
[,{column_list2|variable_list2|variable_and_column_list2}…
[,{column_listN|variable_listN|variable_and_column_listN}]]
[WHERE clause]
 
注意
你可以对文本型字段使用UPDATE语句。但是，如果你需要更新很长的字符串，应使用UPDATETEXT语句。这部分内容对本书来说太高级了，因此不加讨论。要了解更多的信息，请参考Microsoft SQL Sever 的文档。
 
如果你不提供WHERE子句，表中的所有记录都将被更新。有时这是有用的。例如，如果你想把表titles中的所有书的价格加倍，你可以使用如下的UPDATE 语句：
 
你也可以同时更新多个字段。例如，下面的UPDATE语句同时更新first_column,second_column,和third_column这三个字段：
UPDATE mytable SET first_column=’Updated!’
Second_column=’Updated!’
Third_column=’Updated!’
WHERE first_column=’Update Me1’
 
技巧
SQL忽略语句中多余的空格。你可以把SQL语句写成任何你最容易读的格式。
用SELECT 创建记录和表
 
你也许已经注意到，INSERT 语句与DELETE语句和UPDATE语句有一点不同，它一次只操作一个记录。然而，有一个方法可以使INSERT 语句一次添加多个记录。要作到这一点，你需要把INSERT 语句与SELECT 语句结合起来，象这样：
INSERT mytable (first_column,second_column)
SELECT another_first,another_second
FROM anothertable
WHERE another_first=’Copy Me!’
这个语句从anothertable拷贝记录到mytable.只有表anothertable中字段another_first的值为’Copy Me！’的记录才被拷贝。
 
当为一个表中的记录建立备份时，这种形式的INSERT 语句是非常有用的。在删除一个表中的记录之前，你可以先用这种方法把它们拷贝到另一个表中。
 
如果你需要拷贝整个表，你可以使用SELECT INTO 语句。例如，下面的语句创建了一个名为newtable的新表，该表包含表mytable的所有数据：
SELECT * INTO newtable FROM mytable
你也可以指定只有特定的字段被用来创建这个新表。要做到这一点，只需在字段列表中指定你想要拷贝的字段。另外，你可以使用WHERE 子句来限制拷贝到新表中的记录。下面的例子只拷贝字段second_columnd的值等于’Copy Me!’的记录的first_column字段。
SELECT first_column INTO newtable
FROM mytable
WHERE second_column=’Copy Me!’
 
使用SQL修改已经建立的表是很困难的。例如，如果你向一个表中添加了一个字段，没有容易的办法来去除它。另外，如果你不小心把一个字段的数据类型给错了，你将没有办法改变它。但是，使用本节中讲述的SQL语句，你可以绕过这两个问题。
 
例如，假设你想从一个表中删除一个字段。使用SELECT INTO 语句，你可以创建该表的一个拷贝，但不包含要删除的字段。这使你既删除了该字段，又保留了不想删除的数据。
 
如果你想改变一个字段的数据类型，你可以创建一个包含正确数据类型字段的新表。创建好该表后，你就可以结合使用UPDATE语句和SELECT 语句，把原来表中的所有数据拷贝到新表中。通过这种方法，你既可以修改表的结构，又能保存原有的数据。


1.create user username identified by password;//建用户名和密码oracle ,oracle
2.grant connect,resource,dba to username;//授权 grant connect,resource,dba,sysdba to username;
3.connect username/password//进入。
4.select table_name,column_name from user_tab_columns where table_name='mview_log';//查询表中的表名，字段名等等。
5. 如何执行脚本SQL文件? SQL>@PATH/filename.sql;
6.Oracle oledb 提供者在command中执行多条SQL语句与SQL SERVER有少许差别,SQL Server只需使用";"分割多条SQL语句,而Oracle需要遵守ORACLE调用规范,即除分号分割外,还需以begin /end;包围语句体.
使用C#描述应如下所示:
this.oleDbCommand1.CommandText = "begin INSERT INTO GROUP_INFO (GROUP_ID, GROUP_NAME) VALUES (1, \'2\'); INSERT INTO GROUP_INFO(GROUP_ID, GROUP_NAME) VALUES (2, \'2\'); end;";
7.查询用户下的所有表 select distinct table_name from user_tab_columns;
8.如何搜索出前N条记录？Select a.*,rownum from (select * from cardkind order by cardkind ) a where rownum<n
9.查找用户下的所有表：select * from tab;
2、显示当前连接用户
show user
--3、查看系统拥有哪些用户
select * from all_users;
--4、新建用户并授权
create user a identified by a;(默认建在SYSTEM表空间下)
grant connect,resource to a;
5、连接到新用户
conn a/a
6、查询当前用户下所有对象
select * from tab;
7、建立第一个表
create table a(a number);
8、查询表结构
desc a
9、插入新记录
insert into a values(1);
10、查询记录
select * from a;
11、更改记录
update a set a=2;
12、删除记录
delete from a;
13、回滚
roll;
rollback;
14、提交
commit;
select * from
(select t.*,dense_rank() over (order by cardkind) rank from cardkind t)
where rank = 2;
46. 如何在字符串里加回车?
select 'Welcome to visit'||chr(10)||'www.CSDN.NET' from dual ;
47. 中文是如何排序的？
Oracle9i之前，中文是按照二进制编码进行排序的。
在oracle9i中新增了按照拼音、部首、笔画排序功能。设置NLS_SORT值
SCHINESE_RADICAL_M 按照部首（第一顺序）、笔划（第二顺序）排序
SCHINESE_STROKE_M 按照笔划（第一顺序）、部首（第二顺序）排序
SCHINESE_PINYIN_M 按照拼音排序
48. Oracle8i中对象名可以用中文吗？
可以
49. 如何改变WIN中SQL*Plus启动选项？
SQL*PLUS自身的选项设置我们可以在$ORACLE_HOME/sqlplus/admin/glogin.sql中设置。
50. 怎样修改oracel数据库的默认日期?
alter session set nls_date_format='yyyymmddhh24miss';
OR
可以在init.ora中加上一行
nls_date_format='yyyymmddhh24miss'
51. 如何将小表放入keep池中?
alter table xxx storage(buffer_pool keep);
52. 如何检查是否安装了某个patch?
check that oraInventory
53. 如何使select语句使查询结果自动生成序号?
select rownum,COL from table;
54. 如何知道数据裤中某个表所在的tablespace?
select tablespace_name from user_tables where table_name='TEST';
select * from user_tables中有个字段TABLESPACE_NAME，（oracle）;
select * from dba_segments where …;
55. 怎么可以快速做一个和原表一样的备份表?
create table new_table as (select * from old_table);
55. 怎么在sqlplus下修改procedure?
select line,trim(text) t from user_source where name ='A' order by line;
56. 怎样解除PROCEDURE被意外锁定?
alter system kill session ,把那个session给杀掉，不过你要先查出她的session id
or
把该过程重新改个名字就可以了。
57. SQL Reference是个什么东西？
是一本sql的使用手册，包括语法、函数等等，oracle官方网站的文档中心有下载.
58. 如何查看数据库的状态?
unix下
ps -ef | grep ora
windows下
看服务是否起来
是否可以连上数据库
59. 请问如何修改一张表的主键?
alter table aaa
drop constraint aaa_key ;
alter table aaa
add constraint aaa_key primary key(a1,b1) ;
60. 改变数据文件的大小?
用 ALTER DATABASE .... DATAFILE .... ;
手工改变数据文件的大小，对于原来的 数据文件有没有损害。
61. 怎样查看ORACLE中有哪些程序在运行之中？
查看v$sessions表
62. 怎么可以看到数据库有多少个tablespace?
select * from dba_tablespaces;
63. 如何修改oracle数据库的用户连接数？
修改initSID.ora，将process加大，重启数据库.
64. 如何查出一条记录的最后更新时间?
可以用logminer 察看
65. 如何在PL/SQL中读写文件？
UTL_FILE包允许用户通过PL/SQL读写操作系统文件。
66. 怎样把"&"放入一条记录中？
insert into a values (translate ('at{&}t','at{}','at'));
67. EXP 如何加ＱＵＥＲＹ参数？
EXP USER/PASS FILE=A.DMP TABLES(BSEMPMS)
QUERY='"WHERE EMP_NO=\'S09394\'\" ﹔
68. 关于oracle8i支持简体和繁体的字符集问题？
ZHS16GBK可以支
69. Data Guard是什么软件？
就是Standby的换代产品
70. 如何创建SPFILE?
connect / as sysdba
select * from v$version;
create pfile from spfile;
CREATE SPFILE FROM PFILE='E:\ora9i\admin\eygle\pfile\init.ora';
文件已创建。
CREATE SPFILE='E:\ora9i\database\SPFILEEYGLE.ORA' FROM
PFILE='E:\ora9i\admin\eygle\pfile\init.ora';
文件已创建。
71. 内核参数的应用?
shmmax
含义：这个设置并不决定究竟Oracle数据库或者操作系统使用多少物理内存，只决定了
最多可以使用的内存数目。这个设置也不影响操作系统的内核资源。
设置方法：0.5*物理内存
例子：Set shmsys:shminfo_shmmax=10485760
shmmin
含义：共享内存的最小大小。
设置方法：一般都设置成为1。
例子：Set shmsys:shminfo_shmmin=1：
shmmni
含义：系统中共享内存段的最大个数。
例子：Set shmsys:shminfo_shmmni=100
shmseg
含义：每个用户进程可以使用的最多的共享内存段的数目。
例子：Set shmsys:shminfo_shmseg=20：
semmni
含义：系统中semaphore identifierer的最大个数。
设置方法：把这个变量的值设置为这个系统上的所有Oracle的实例的init.ora中的最大
的那个processes的那个值加10。
例子：Set semsys:seminfo_semmni=100
semmns
含义：系统中emaphores的最大个数。
设置方法：这个值可以通过以下方式计算得到：各个Oracle实例的initSID.ora里边的
processes的值的总和（除去最大的Processes参数）＋最大的那个Processes×2＋10×
Oracle实例的个数。
例子：Set semsys:seminfo_semmns=200
semmsl:
含义：一个set中semaphore的最大个数。
设置方法：设置成为10＋所有Oracle实例的InitSID.ora中最大的Processes的值。
例子：Set semsys:seminfo_semmsl=-200
72. 怎样查看哪些用户拥有SYSDBA、SYSOPER权限？
SQL>conn sys/change_on_install
SQL>select * from V_$PWFILE_USERS;
73. 如何单独备份一个或多个表？
exp 用户/密码 tables=(表1,…,表2)
74. 如何单独备份一个或多个用户？
exp system/manager owner=(用户1,用户2,…,用户n) file=导出文件
75. 如何对CLOB字段进行全文检索？
SELECT * FROM A WHERE dbms_lob.instr(a.a,'K',1,1)>0; 76. 如何显示当前连接用户?
SHOW USER
77. 如何查看数据文件放置的路径 ?
col file_name format a50
select tablespace_name,file_id,bytes/1024/1024,file_name from dba_data_files
order by file_id;
78. 如何查看现有回滚段及其状态 ?
col segment format a30
SELECT SEGMENT_NAME,OWNER,TABLESPACE_NAME,SEGMENT_ID,FILE _ID,STATUS FROM
DBA_ROLLBACK_SEGS
79. 如何改变一个字段初始定义的Check范围？
alter table xxx drop constraint constraint_name;
之后再创建新约束:
alter table xxx add constraint constraint_name check();
80. Oracle常用系统文件有哪些？
通过以下视图显示这些文件信息：v$database,v$datafile,v$logfile v$controlfile
v$parameter;
81. 内连接INNER JOIN?
Select a.* from bsempms a,bsdptms b where a.dpt_no=b.dpt_no;
82. 如何外连接?
Select a.* from bsempms a,bsdptms b where a.dpt_no=b.dpt_no(+);
Select a.* from bsempms a,bsdptms b wherea.dpt_no(+)=b.dpt_no;
83. 如何执行脚本SQL文件?
SQL>@$PATH/filename.sql;
84. 如何快速清空一个大表?
SQL>truncate table table_name;
85. 如何查有多少个数据库实例?
SQL>SELECT * FROM V$INSTANCE;
86. 如何查询数据库有多少表?
SQL>select * from all_tables;
87. 如何测试SQL语句执行所用的时间?
SQL>set timing on ;
SQL>select * from tablename;
88. CHR()的反函数是?
ASCII()
SELECT CHAR(65) FROM DUAL;
SELECT ASCII('A') FROM DUAL;
89. 字符串的连接
SELECT CONCAT(COL1,COL2) FROM TABLE ;
SELECT COL1||COL2 FROM TABLE ;
90. 怎么把select出来的结果导到一个文本文件中？
SQL>SPOOL C:\ABCD.TXT;
SQL>select * from table;
SQL >spool off;
91. 怎样估算SQL执行的I/O数 ?
SQL>SET AUTOTRACE ON ;
SQL>SELECT * FROM TABLE;
OR
SQL>SELECT * FROM v$filestat ;
可以查看IO数
92. 如何在sqlplus下改变字段大小?
alter table table_name modify (field_name varchar2(100));
改大行，改小不行（除非都是空的）
93. 如何查询某天的数据?
select * from table_name where trunc(日期字段)＝to_date('2003-05-02','yyyy-mm-
dd');
94. sql 语句如何插入全年日期？
create table BSYEAR (d date);
insert into BSYEAR
select to_date('20030101','yyyymmdd')+rownum-1
from all_objects
where rownum <= to_char(to_date('20031231','yyyymmdd'),'ddd');
95. 如果修改表名?
alter table old_table_name rename to new_table_name;
96. 如何取得命令的返回状态值？
sqlcode=0
97. 如何知道用户拥有的权限?
SELECT * FROM dba_sys_privs ;
98. 从网上下载的ORACLE9I与市场上卖的标准版有什么区别？
从功能上说没有区别，只不过oracle公司有明文规定；从网站上下载的oracle产品不得用于
商业用途，否则侵权。
99. 怎样判断数据库是运行在归档模式下还是运行在非归档模式下？
进入dbastudio，历程--〉数据库---〉归档查看。
100. sql>startup pfile和ifile,spfiled有什么区别？
pfile就是Oracle传统的初始化参数文件，文本格式的。
ifile类似于c语言里的include，用于把另一个文件引入
spfile是9i里新增的并且是默认的参数文件，二进制格式
startup后应该只可接pfile
101. 如何搜索出前N条记录？
SELECT * FROM empLOYEE WHERE ROWNUM < n ORDER BY empno;
102. 如何知道机器上的Oracle支持多少并发用户数?
SQL>conn internal ;
SQL>show parameter processes ;
103. db_block_size可以修改吗?
一般不可以﹐不建议这样做的。
104. 如何统计两个表的记录总数?
select (select count(id) from aa)+(select count(id) from bb) 总数 from dual;
105. 怎样用Sql语句实现查找一列中第N大值？
select * from
(select t.*,dense_rank() over (order by sal) rank from employee)
where rank = N;
106. 如何在给现有的日期加上2年？(
select add_months(sysdate,24) from dual;
107. USED_UBLK为负值表示什么意思?
It is "harmless".
108. Connect string是指什么?
应该是tnsnames.ora中的服务名后面的内容
109. 怎样扩大REDO LOG的大小？
建立一个临时的redolog组，然后切换日志，删除以前的日志，建立新的日志。
110. tablespace 是否不能大于4G?
没有限制.
111. 返回大于等于N的最小整数值?
SELECT CEIL(N) FROM DUAL;
112. 返回小于等于N的最小整数值?
SELECT FLOOR(N) FROM DUAL;
113. 返回当前月的最后一天?
SELECT LAST_DAY(SYSDATE) FROM DUAL;
114. 如何不同用户间数据导入?
IMP SYSTEM/MANAGER FILE=AA.DMP FROMUSER=USER_OLD TOUSER=USER_NEW ROWS=Y INDEXES=Y

115. 如何找数据库表的主键字段的名称?
SQL>SELECT * FROM user_constraints WHERE CONSTRAINT_TYPE='P' and
table_name='TABLE_NAME';
116. 两个结果集互加的函数?
SQL>SELECT * FROM BSEMPMS_OLD INTERSECT SELECT * FROM BSEMPMS_NEW;
SQL>SELECT * FROM BSEMPMS_OLD UNION SELECT * FROM BSEMPMS_NEW;
SQL>SELECT * FROM BSEMPMS_OLD UNION ALL SELECT * FROM BSEMPMS_NEW;
117. 两个结果集互减的函数?
SQL>SELECT * FROM BSEMPMS_OLD MINUS SELECT * FROM BSEMPMS_NEW;
118. 如何配置Sequence?
建sequence seq_custid
create sequence seq_custid start 1 incrememt by 1;
建表时:
create table cust
{ cust_id smallint not null,
...}
insert 时:
insert into table cust
values( seq_cust.nextval, ...)
日期的各部分的常用的的写法
119>.取时间点的年份的写法:
SELECT TO_CHAR(SYSDATE,'YYYY') FROM DUAL;
120>.取时间点的月份的写法:
SELECT TO_CHAR(SYSDATE,'MM') FROM DUAL;
121>.取时间点的日的写法:
SELECT TO_CHAR(SYSDATE,'DD') FROM DUAL;
122>.取时间点的时的写法:
SELECT TO_CHAR(SYSDATE,'HH24') FROM DUAL;
123>.取时间点的分的写法:
SELECT TO_CHAR(SYSDATE,'MI') FROM DUAL;
124>.取时间点的秒的写法:
SELECT TO_CHAR(SYSDATE,'SS') FROM DUAL;
125>.取时间点的日期的写法:
SELECT TRUNC(SYSDATE) FROM DUAL;
126>.取时间点的时间的写法:
SELECT TO_CHAR(SYSDATE,'HH24:MI:SS') FROM DUAL;
127>.日期,时间形态变为字符形态
SELECT TO_CHAR(SYSDATE) FROM DUAL;
128>.将字符串转换成日期或时间形态:
SELECT TO_DATE('2003/08/01') FROM DUAL; 129>.返回参数的星期几的写法:
SELECT TO_CHAR(SYSDATE,'D') FROM DUAL;
130>.返回参数一年中的第几天的写法:
SELECT TO_CHAR(SYSDATE,'DDD') FROM DUAL;
131>.返回午夜和参数中指定的时间值之间的秒数的写法:
SELECT TO_CHAR(SYSDATE,'SSSSS') FROM DUAL;
132>.返回参数中一年的第几周的写法:
SELECT TO_CHAR(SYSDATE,'WW') FROM DUAL;
虚拟字段
133. CURRVAL 和 nextval
为表创建序列
CREATE SEQUENCE EMPSEQ ... ;
SELECT empseq.currval FROM DUAL ;
自动插入序列的数值
INSERT INTO emp
VALUES (empseq.nextval, 'LEWIS', 'CLERK',
7902, SYSDATE, 1200, NULL, 20) ;
134. ROWNUM
按设定排序的行的序号
SELECT * FROM emp WHERE ROWNUM < 10 ;
135. ROWID
返回行的物理地址
SELECT ROWID, ename FROM emp WHERE deptno = 20 ;
136. 将N秒转换为时分秒格式？
set serverout on
declare
N number := 1000000;
ret varchar2(100);
begin
ret := trunc(n/3600) || '小时' || to_char(to_date(mod(n,3600),'sssss'),'fmmi"分
"ss"秒"') ;
dbms_output.put_line(ret);
end;
137. 如何查询做比较大的排序的进程？
SELECT b.tablespace, b.segfile#, b.segblk#, b.blocks, a.sid, a.serial#,
a.username, a.osuser, a.status
FROM v$session a,v$sort_usage b
WHERE a.saddr = b.session_addr
ORDER BY b.tablespace, b.segfile#, b.segblk#, b.blocks ;
138. 如何查询做比较大的排序的进程的SQL语句？
select /*+ ORDERED */ sql_text from v$sqltext a
where a.hash_value = (
select sql_hash_value from v$session b
where b.sid = &sid and b.serial# = &serial)
order by piece asc ;
139. 如何查找重复记录？
SELECT * FROM TABLE_NAME
WHERE ROWID!=(SELECT MAX(ROWID) FROM TABLE_NAME D
WHERE TABLE_NAME.COL1=D.COL1 AND TABLE_NAME.COL2=D.COL2);
140. 如何删除重复记录？
DELETE FROM TABLE_NAME
WHERE ROWID!=(SELECT MAX(ROWID) FROM TABLE_NAME D
WHERE TABLE_NAME.COL1=D.COL1 AND TABLE_NAME.COL2=D.COL2);
141. 如何快速编译所有视图？
SQL >SPOOL VIEW1.SQL
SQL >SELECT 'ALTER VIEW '||TNAME||'
COMPILE;' FROM TAB;
SQL >SPOOL OFF
然后执行VIEW1.SQL即可。
SQL >@VIEW1.SQL;
142. ORA-01555 SNAPSHOT TOO OLD的解决办法
增加MINEXTENTS的值，增加区的大小，设置一个高的OPTIMAL值。
143. 事务要求的回滚段空间不够，表现为表空间用满（ORA-01560错误），回滚段扩展到达
参数 MAXEXTENTS的值（ORA-01628）的解决办法.
向回滚段表空间添加文件或使已有的文件变大；增加MAXEXTENTS的值。
144. 如何加密ORACLE的存储过程？
下列存储过程内容放在AA.SQL文件中
create or replace procedure testCCB(i in number) as
begin
dbms_output.put_line('输入参数是'||to_char(i));
end;
SQL>wrap iname=a.sql;
PL/SQL Wrapper: Release 8.1.7.0.0 - Production on Tue Nov 27 22:26:48 2001
Copyright (c) Oracle Corporation 1993, 2000. All Rights Reserved.
Processing AA.sql to AA.plb
运行AA.plb
@AA.plb ;
145. 如何监控事例的等待？
select event,sum(decode(wait_Time,0,0,1)) "Prev",
sum(decode(wait_Time,0,1,0)) "Curr",count(*) "Tot"
from v$session_Wait
group by event order by 4;
146. 如何回滚段的争用情况？
select name, waits, gets, waits/gets "Ratio"
from v$rollstat C, v$rollname D
where C.usn = D.usn;
147. 如何监控表空间的 I/O 比例？
select B.tablespace_name name,B.file_name "file",A.phyrds pyr,
A.phyblkrd pbr,A.phywrts pyw, A.phyblkwrt pbw
from v$filestat A, dba_data_files B
where A.file# = B.file_id
order by B.tablespace_name;
148. 如何监控文件系统的 I/O 比例？
select substr(C.file#,1,2) "#", substr(C.name,1,30) "Name",
C.status, C.bytes, D.phyrds, D.phywrts
from v$datafile C, v$filestat D
where C.file# = D.file#;
149. 如何在某个用户下找所有的索引？
select user_indexes.table_name, user_indexes.index_name,uniqueness, column_name
from user_ind_columns, user_indexes
where user_ind_columns.index_name = user_indexes.index_name
and user_ind_columns.table_name = user_indexes.table_name
order by user_indexes.table_type, user_indexes.table_name,
user_indexes.index_name, column_position;
150. 如何监控 SGA 的命中率？
select a.value + b.value "logical_reads", c.value "phys_reads",
round(100 * ((a.value+b.value)-c.value) / (a.value+b.value)) "BUFFER HIT RATIO"
from v$sysstat a, v$sysstat b, v$sysstat c
where a.statistic# = 38 and b.statistic# = 39
and c.statistic# = 40;
151. 如何监控 SGA 中字典缓冲区的命中率？
select parameter, gets,Getmisses , getmisses/(gets+getmisses)*100 "miss ratio",
(1-(sum(getmisses)/ (sum(gets)+sum(getmisses))))*100 "Hit ratio"
from v$rowcache
where gets+getmisses <>0
group by parameter, gets, getmisses;
152. 如何监控 SGA 中共享缓存区的命中率，应该小于1% ？
select sum(pins) "Total Pins", sum(reloads) "Total Reloads",
sum(reloads)/sum(pins) *100 libcache
from v$librarycache;
select sum(pinhits-reloads)/sum(pins) "hit radio",sum(reloads)/sum(pins) "reload
percent"
from v$librarycache;
153. 如何显示所有数据库对象的类别和大小？
select count(name) num_instances ,type ,sum(source_size) source_size ,
sum(parsed_size) parsed_size ,sum(code_size) code_size ,sum(error_size)
error_size,
sum(source_size) +sum(parsed_size) +sum(code_size) +sum(error_size) size_required
from dba_object_size
group by type order by 2;
154. 监控 SGA 中重做日志缓存区的命中率，应该小于1%
SELECT name, gets, misses, immediate_gets, immediate_misses,
Decode(gets,0,0,misses/gets*100) ratio1,
Decode(immediate_gets+immediate_misses,0,0,
immediate_misses/(immediate_gets+immediate_misses) *100) ratio2
FROM v$latch WHERE name IN ('redo allocation', 'redo copy');
155. 监控内存和硬盘的排序比率，最好使它小于 .10，增加 sort_area_size
SELECT name, value FROM v$sysstat WHERE name IN ('sorts (memory)', 'sorts
(disk)');
156. 如何监控当前数据库谁在运行什么SQL语句？
SELECT osuser, username, sql_text from v$session a, v$sqltext b
where a.sql_address =b.address order by address, piece;
157. 如何监控字典缓冲区？
SELECT (SUM(PINS - RELOADS)) / SUM(PINS) "LIB CACHE" FROM V$LIBRARYCACHE;
SELECT (SUM(GETS - GETMISSES - USAGE - FIXED)) / SUM(GETS) "ROW CACHE" FROM
V$ROWCACHE;
SELECT SUM(PINS) "EXECUTIONS", SUM(RELOADS) "CACHE MISSES WHILE EXECUTING" FROM
V$LIBRARYCACHE;
后者除以前者,此比率小于1%,接近0%为好。
SELECT SUM(GETS) "DICTIONARY GETS",SUM(GETMISSES) "DICTIONARY CACHE GET MISSES"
FROM V$ROWCACHE
158. 监控 MTS
select busy/(busy+idle) "shared servers busy" from v$dispatcher;
此值大于0.5时，参数需加大
select sum(wait)/sum(totalq) "dispatcher waits" from v$queue where
type='dispatcher';
select count(*) from v$dispatcher;
select servers_highwater from v$mts;
servers_highwater接近mts_max_servers时，参数需加大
159. 如何知道当前用户的ID号?
SQL>SHOW USER;
OR
SQL>select user from dual;
160. 如何查看碎片程度高的表?
SELECT segment_name table_name , COUNT(*) extents
FROM dba_segments WHERE owner NOT IN ('SYS', 'SYSTEM') GROUP BY segment_name
HAVING COUNT(*) = (SELECT MAX( COUNT(*) ) FROM dba_segments GROUP BY
segment_name);
162. 如何知道表在表空间中的存储情况?
select segment_name,sum(bytes),count(*) ext_quan from dba_extents where
tablespace_name='&tablespace_name' and segment_type='TABLE' group by
tablespace_name,segment_name;
163. 如何知道索引在表空间中的存储情况?
select segment_name,count(*) from dba_extents where segment_type='INDEX' and
owner='&owner'
group by segment_name;
164、如何知道使用CPU多的用户session?
11是cpu used by this session
select a.sid,spid,status,substr(a.program,1,40)
prog,a.terminal,osuser,value/60/100 value
from v$session a,v$process b,v$sesstat c
where c.statistic#=11 and c.sid=a.sid and a.paddr=b.addr order by value desc;
165. 如何知道监听器日志文件?
以8I为例
$ORACLE_HOME/NETWORK/LOG/LISTENER.LOG
166. 如何知道监听器参数文件?
以8I为例
$ORACLE_HOME/NETWORK/ADMIN/LISTENER.ORA
167. 如何知道TNS 连接文件?
以8I为例
$ORACLE_HOME/NETWORK/ADMIN/TNSNAMES.ORA
168. 如何知道Sql*Net 环境文件?
以8I为例
$ORACLE_HOME/NETWORK/ADMIN/SQLNET.ORA
169. 如何知道警告日志文件?
以8I为例
$ORACLE_HOME/ADMIN/SID/BDUMP/SIDALRT.LOG
170. 如何知道基本结构?
以8I为例
$ORACLE_HOME/RDBMS/ADMIN/STANDARD.SQL
171. 如何知道建立数据字典视图?
以8I为例
$ORACLE_HOME/RDBMS/ADMIN/CATALOG.SQL
172. 如何知道建立审计用数据字典视图?
以8I为例
$ORACLE_HOME/RDBMS/ADMIN/CATAUDIT.SQL
173. 如何知道建立快照用数据字典视图?
以8I为例
$ORACLE_HOME/RDBMS/ADMIN/CATSNAP.SQL
本讲主要讲的是SQL语句的优化方法! 主要基于ORACLE9I的.
174. /*+ALL_ROWS*/
表明对语句块选择基于开销的优化方法,并获得最佳吞吐量,使资源消耗最小化.
例如:
SELECT /*+ALL+_ROWS*/ EMP_NO,EMP_NAM,DAT_IN FROM BSEMPMS WHERE EMP_NO='CCBZZP';
175. /*+FIRST_ROWS*/
表明对语句块选择基于开销的优化方法,并获得最佳响应时间,使资源消耗最小化.
例如:
SELECT /*+FIRST_ROWS*/ EMP_NO,EMP_NAM,DAT_IN FROM BSEMPMS WHERE EMP_NO='CCBZZP'; 176. /*+CHOOSE*/
表明如果数据字典中有访问表的统计信息,将基于开销的优化方法,并获得最佳的吞吐量;
表明如果数据字典中没有访问表的统计信息,将基于规则开销的优化方法;
例如:
SELECT /*+CHOOSE*/ EMP_NO,EMP_NAM,DAT_IN FROM BSEMPMS WHERE EMP_NO='CCBZZP';
177. /*+RULE*/
表明对语句块选择基于规则的优化方法.
例如:
SELECT /*+ RULE */ EMP_NO,EMP_NAM,DAT_IN FROM BSEMPMS WHERE EMP_NO='CCBZZP';
178. /*+FULL(TABLE)*/
表明对表选择全局扫描的方法.
例如:
SELECT /*+FULL(A)*/ EMP_NO,EMP_NAM FROM BSEMPMS A WHERE EMP_NO='CCBZZP';
179. /*+ROWID(TABLE)*/
提示明确表明对指定表根据ROWID进行访问.
例如:
SELECT /*+ROWID(BSEMPMS)*/ * FROM BSEMPMS WHERE ROWID>='AAAAAAAAAAAAAA'
AND EMP_NO='CCBZZP';
180. /*+CLUSTER(TABLE)*/
提示明确表明对指定表选择簇扫描的访问方法,它只对簇对象有效.
例如:
SELECT /*+CLUSTER */ BSEMPMS.EMP_NO,DPT_NO FROM BSEMPMS,BSDPTMS
WHERE DPT_NO='TEC304' AND BSEMPMS.DPT_NO=BSDPTMS.DPT_NO;
181. /*+INDEX(TABLE INDEX_NAME)*/
表明对表选择索引的扫描方法.
例如:
SELECT /*+INDEX(BSEMPMS SEX_INDEX) USE SEX_INDEX BECAUSE THERE ARE FEWMALE
BSEMPMS */ FROM BSEMPMS WHERE SEX='M';
182. /*+INDEX_ASC(TABLE INDEX_NAME)*/
表明对表选择索引升序的扫描方法.


1.ASCII 返回与指定的字符对应的十进制数;
select ascii('A') A,ascii('a') a,ascii('0') zero,ascii(' ') space from dual;
A         A      ZERO     SPACE
--------- --------- --------- ---------
65        97        48        32
2.CHR 给出整数,返回对应的字符;
select chr(54740) zhao,chr(65) chr65 from dual;
ZH C
-- -
赵 A
3.CONCAT 连接两个字符串;
select concat('010-','88888888')||'转23'  高乾竞电话 from dual;
高乾竞电话
----------------
010-88888888转23
4.INITCAP 返回字符串并将字符串的第一个字母变为大写;
select initcap('smith') upp from dual;
UPP
-----
Smith
5.INSTR(C1,C2,I,J) 在一个字符串中搜索指定的字符,返回发现指定的字符的位置;
C1    被搜索的字符串
C2    希望搜索的字符串
I     搜索的开始位置,默认为1
J     出现的位置,默认为1
select instr('oracle traning','ra',1,2) instring from dual;
INSTRING
---------
9
6.LENGTH 返回字符串的长度;
select name,length(name),addr,length(addr),sal,length(to_char(sal)) from .nchar_tst;
NAME   LENGTH(NAME) ADDR             LENGTH(ADDR)       SAL LENGTH(TO_CHAR(SAL))
------ ------------ ---------------- ------------ --------- --------------------
高乾竞            3 北京市海锭区                6   9999.99                    7
7.LOWER 返回字符串,并将所有的字符小写
select lower('AaBbCcDd')AaBbCcDd from dual;
AABBCCDD
--------
aabbccdd
8.UPPER 返回字符串,并将所有的字符大写
select upper('AaBbCcDd') upper from dual;
UPPER
--------
AABBCCDD
9.RPAD和LPAD(粘贴字符)
RPAD  在列的右边粘贴字符
LPAD  在列的左边粘贴字符
select lpad(rpad('gao',10,'*'),17,'*')from dual;
LPAD(RPAD('GAO',1
-----------------
*******gao*******
不够字符则用*来填满
10.LTRIM和RTRIM
LTRIM  删除左边出现的字符串
RTRIM  删除右边出现的字符串
select ltrim(rtrim('   gao qian jing   ',' '),' ') from dual;
LTRIM(RTRIM('
-------------
gao qian jing
11.SUBSTR(string,start,count)
取子字符串,从start开始,取count个
select substr('13088888888',3,8) from dual;
SUBSTR('
--------
08888888
12.REPLACE('string','s1','s2')
string   希望被替换的字符或变量
s1       被替换的字符串
s2       要替换的字符串
select replace('he love you','he','i') from dual;
REPLACE('HELOVEYOU','HE','I')
------------------------------
i love you
13.SOUNDEX 返回一个与给定的字符串读音相同的字符串
create table table1(xm varchar(8));
insert into table1 values('weather');
insert into table1 values('wether');
insert into table1 values('gao');
select xm from table1 where soundex(xm)=soundex('weather');
XM
--------
weather
wether
14.TRIM('s' from 'string')
LEADING   剪掉前面的字符
TRAILING  剪掉后面的字符
如果不指定,默认为空格符
15.ABS 返回指定值的绝对值
select abs(100),abs(-100) from dual;
ABS(100) ABS(-100)
--------- ---------
100       100
16.ACOS 给出反余弦的值
select acos(-1) from dual;
ACOS(-1)
---------
3.1415927
17.ASIN 给出反正弦的值
select asin(0.5) from dual;
ASIN(0.5)
---------
.52359878
18.ATAN 返回一个数字的反正切值
select atan(1) from dual;
ATAN(1)
---------
.78539816
19.CEIL 返回大于或等于给出数字的最小整数
select ceil(3.1415927) from dual;
CEIL(3.1415927)
---------------
4
20.COS 返回一个给定数字的余弦
select cos(-3.1415927) from dual;
COS(-3.1415927)
---------------
-1
21.COSH 返回一个数字反余弦值
select cosh(20) from dual;
COSH(20)
---------
242582598
22.EXP 返回一个数字e的n次方根
select exp(2),exp(1) from dual;
EXP(2)    EXP(1)
--------- ---------
7.3890561 2.7182818
23.FLOOR 对给定的数字取整数
select floor(2345.67) from dual;
FLOOR(2345.67)
--------------
2345
24.LN 返回一个数字的对数值
select ln(1),ln(2),ln(2.7182818) from dual;
LN(1)     LN(2) LN(2.7182818)
--------- --------- -------------
0 .69314718     .99999999
25.LOG(n1,n2) 返回一个以n1为底n2的对数
select log(2,1),log(2,4) from dual;
LOG(2,1)  LOG(2,4)
--------- ---------
0         2
26.MOD(n1,n2) 返回一个n1除以n2的余数
select mod(10,3),mod(3,3),mod(2,3) from dual;

MOD(10,3)  MOD(3,3)  MOD(2,3)
--------- --------- ---------
1         0         2
27.POWER 返回n1的n2次方根
select power(2,10),power(3,3) from dual;
POWER(2,10) POWER(3,3)
----------- ----------
1024         27
28.ROUND和TRUNC
按照指定的精度进行舍入
select round(55.5),round(-55.4),trunc(55.5),trunc(-55.5) from dual;
ROUND(55.5) ROUND(-55.4) TRUNC(55.5) TRUNC(-55.5)
----------- ------------ ----------- ------------
56          -55          55          -55
29.SIGN 取数字n的符号,大于0返回1,小于0返回-1,等于0返回0
select sign(123),sign(-100),sign(0) from dual;
SIGN(123) SIGN(-100)   SIGN(0)
--------- ---------- ---------
1         -1         0
30.SIN 返回一个数字的正弦值
select sin(1.57079) from dual;
SIN(1.57079)
------------
1
31.SIGH 返回双曲正弦的值
select sin(20),sinh(20) from dual;

SIN(20)  SINH(20)
--------- ---------
.91294525 242582598
32.SQRT 返回数字n的根
select sqrt(64),sqrt(10) from dual;
SQRT(64)  SQRT(10)
--------- ---------
8 3.1622777
33.TAN 返回数字的正切值
select tan(20),tan(10) from dual;
TAN(20)   TAN(10)
--------- ---------
2.2371609 .64836083
34.TANH
返回数字n的双曲正切值
select tanh(20),tan(20) from dual;
TANH(20)   TAN(20)
--------- ---------
1 2.2371609
35.TRUNC
按照指定的精度截取一个数
select trunc(124.1666,-2) trunc1,trunc(124.16666,2) from dual;
TRUNC1 TRUNC(124.16666,2)
--------- ------------------
100             124.16
36.ADD_MONTHS
增加或减去月份
select to_char(add_months(to_date('199912','yyyymm'),2),'yyyymm') from dual;
TO_CHA
------
200002
select to_char(add_months(to_date('199912','yyyymm'),-2),'yyyymm') from dual;
TO_CHA
------
199910
37.LAST_DAY
返回日期的最后一天
select to_char(sysdate,'yyyy.mm.dd'),to_char((sysdate)+1,'yyyy.mm.dd') from dual;
TO_CHAR(SY TO_CHAR((S
---------- ----------
2004.05.09 2004.05.10
select last_day(sysdate) from dual;
LAST_DAY(S
----------
31-5月 -04
38.MONTHS_BETWEEN(date2,date1)
给出date2-date1的月份
select months_between('19-12月-1999','19-3月-1999') mon_between from dual;
MON_BETWEEN
-----------
9
SQL>selectmonths_between(to_date('2000.05.20','yyyy.mm.dd'),to_date('2005.05.20','yyyy.dd')) mon_betw from dual;
MON_BETW
---------
-60
39.NEW_TIME(date,'this','that')
给出在this时区=other时区的日期和时间
select to_char(sysdate,'yyyy.mm.dd hh24:mi:ss') bj_time,to_char(new_time
2  (sysdate,'PDT','GMT'),'yyyy.mm.dd hh24:mi:ss') los_angles from dual;
BJ_TIME             LOS_ANGLES
------------------- -------------------
2004.05.09 11:05:32 2004.05.09 18:05:32
40.NEXT_DAY(date,'day')
给出日期date和星期x之后计算下一个星期的日期
select next_day('18-5月-2001','星期五') next_day from dual;
NEXT_DAY
----------
25-5月 -01
41.SYSDATE 用来得到系统的当前日期
select to_char(sysdate,'dd-mm-yyyy day') from dual;
TO_CHAR(SYSDATE,'
-----------------
09-05-2004 星期日
trunc(date,fmt)按照给出的要求将日期截断,如果fmt='mi'表示保留分,截断秒
select to_char(trunc(sysdate,'hh'),'yyyy.mm.dd hh24:mi:ss') hh,
2  to_char(trunc(sysdate,'mi'),'yyyy.mm.dd hh24:mi:ss') hhmm from dual;
HH                  HHMM
------------------- -------------------
2004.05.09 11:00:00 2004.05.09 11:17:00
42.CHARTOROWID 将字符数据类型转换为ROWID类型
select rowid,rowidtochar(rowid),ename from scott.emp;
ROWID              ROWIDTOCHAR(ROWID) ENAME
------------------ ------------------ ----------
AAAAfKAACAAAAEqAAA AAAAfKAACAAAAEqAAA SMITH
AAAAfKAACAAAAEqAAB AAAAfKAACAAAAEqAAB ALLEN
AAAAfKAACAAAAEqAAC AAAAfKAACAAAAEqAAC WARD
AAAAfKAACAAAAEqAAD AAAAfKAACAAAAEqAAD JONES


SQL中的单记录函数
1.ASCII
返回与指定的字符对应的十进制数;
select ascii('A') A,ascii('a') a,ascii('0') zero,ascii(' ') space from dual;
        A         A      ZERO     SPACE
--------- --------- --------- ---------
       65        97        48        32

2.CHR
给出整数,返回对应的字符;
select chr(54740) zhao,chr(65) chr65 from dual;
ZH C
-- -
赵 A
3.CONCAT
连接两个字符串;
select concat('010-','88888888')||'转23'  高乾竞电话 from dual;
高乾竞电话
----------------
010-88888888转23
4.INITCAP
返回字符串并将字符串的第一个字母变为大写;
select initcap('smith') upp from dual;
UPP
-----
Smith

5.INSTR(C1,C2,I,J)
在一个字符串中搜索指定的字符,返回发现指定的字符的位置;
C1    被搜索的字符串
C2    希望搜索的字符串
I     搜索的开始位置,默认为1
J     出现的位置,默认为1
select instr('oracle traning','ra',1,2) instring from dual;
 INSTRING
---------
        9

6.LENGTH
返回字符串的长度;
select name,length(name),addr,length(addr),sal,length(to_char(sal)) from gao.nchar_tst;
NAME   LENGTH(NAME) ADDR             LENGTH(ADDR)       SAL LENGTH(TO_CHAR(SAL))
------ ------------ ---------------- ------------ --------- --------------------
高乾竞            3 北京市海锭区                6   9999.99                    7

7.LOWER
返回字符串,并将所有的字符小写
select lower('AaBbCcDd')AaBbCcDd from dual;
AABBCCDD
--------
aabbccdd

8.UPPER
返回字符串,并将所有的字符大写
select upper('AaBbCcDd') upper from dual;
UPPER
--------
AABBCCDD

9.RPAD和LPAD(粘贴字符)
RPAD  在列的右边粘贴字符
LPAD  在列的左边粘贴字符
select lpad(rpad('gao',10,'*'),17,'*')from dual;
LPAD(RPAD('GAO',1
-----------------
*******gao*******
不够字符则用*来填满

10.LTRIM和RTRIM
LTRIM  删除左边出现的字符串
RTRIM  删除右边出现的字符串
select ltrim(rtrim('   gao qian jing   ',' '),' ') from dual;
LTRIM(RTRIM('
-------------
gao qian jing

11.SUBSTR(string,start,count)
取子字符串,从start开始,取count个
select substr('13088888888',3,8) from dual;
SUBSTR('
--------
08888888

12.REPLACE('string','s1','s2')
string   希望被替换的字符或变量
s1       被替换的字符串
s2       要替换的字符串
select replace('he love you','he','i') from dual;
REPLACE('H
----------
i love you

13.SOUNDEX
返回一个与给定的字符串读音相同的字符串
create table table1(xm varchar(8));
insert into table1 values('weather');
insert into table1 values('wether');
insert into table1 values('gao');
select xm from table1 where soundex(xm)=soundex('weather');
XM
--------
weather
wether

14.TRIM('s' from 'string')
LEADING   剪掉前面的字符
TRAILING  剪掉后面的字符
如果不指定,默认为空格符
15.ABS
返回指定值的绝对值
select abs(100),abs(-100) from dual;
 ABS(100) ABS(-100)
--------- ---------
      100       100

16.ACOS
给出反余弦的值
select acos(-1) from dual;
 ACOS(-1)
---------
3.1415927

17.ASIN
给出反正弦的值
select asin(0.5) from dual;
ASIN(0.5)
---------
.52359878

18.ATAN
返回一个数字的反正切值
select atan(1) from dual;
  ATAN(1)
---------
.78539816

19.CEIL
返回大于或等于给出数字的最小整数
select ceil(3.1415927) from dual;
CEIL(3.1415927)
---------------
              4

20.COS
返回一个给定数字的余弦
select cos(-3.1415927) from dual;
COS(-3.1415927)
---------------
             -1

21.COSH
返回一个数字反余弦值
select cosh(20) from dual;
 COSH(20)
---------
242582598

22.EXP
返回一个数字e的n次方根
select exp(2),exp(1) from dual;
   EXP(2)    EXP(1)
--------- ---------
7.3890561 2.7182818

23.FLOOR
对给定的数字取整数
select floor(2345.67) from dual;
FLOOR(2345.67)
--------------
          2345

24.LN
返回一个数字的对数值
select ln(1),ln(2),ln(2.7182818) from dual;
    LN(1)     LN(2) LN(2.7182818)
--------- --------- -------------
        0 .69314718     .99999999

25.LOG(n1,n2)
返回一个以n1为底n2的对数
select log(2,1),log(2,4) from dual;
 LOG(2,1)  LOG(2,4)
--------- ---------
        0         2

26.MOD(n1,n2)
返回一个n1除以n2的余数
select mod(10,3),mod(3,3),mod(2,3) from dual;
MOD(10,3)  MOD(3,3)  MOD(2,3)
--------- --------- ---------
        1         0         2

27.POWER
返回n1的n2次方根
select power(2,10),power(3,3) from dual;
POWER(2,10) POWER(3,3)
----------- ----------
       1024         27

28.ROUND和TRUNC
按照指定的精度进行舍入
select round(55.5),round(-55.4),trunc(55.5),trunc(-55.5) from dual;
ROUND(55.5) ROUND(-55.4) TRUNC(55.5) TRUNC(-55.5)
----------- ------------ ----------- ------------
         56          -55          55          -55

29.SIGN
取数字n的符号,大于0返回1,小于0返回-1,等于0返回0
select sign(123),sign(-100),sign(0) from dual;
SIGN(123) SIGN(-100)   SIGN(0)
--------- ---------- ---------
        1         -1         0

30.SIN
返回一个数字的正弦值
select sin(1.57079) from dual;
SIN(1.57079)
------------
           1

31.SIGH
返回双曲正弦的值
select sin(20),sinh(20) from dual;
  SIN(20)  SINH(20)
--------- ---------
.91294525 242582598

32.SQRT
返回数字n的根
select sqrt(64),sqrt(10) from dual;
 SQRT(64)  SQRT(10)
--------- ---------
        8 3.1622777

33.TAN
返回数字的正切值
select tan(20),tan(10) from dual;
  TAN(20)   TAN(10)
--------- ---------
2.2371609 .64836083

34.TANH
返回数字n的双曲正切值
select tanh(20),tan(20) from dual;
 TANH(20)   TAN(20)
--------- ---------
        1 2.2371609

35.TRUNC
按照指定的精度截取一个数
select trunc(124.1666,-2) trunc1,trunc(124.16666,2) from dual;
   TRUNC1 TRUNC(124.16666,2)
--------- ------------------
      100             124.16

36.ADD_MONTHS
增加或减去月份
select to_char(add_months(to_date('199912','yyyymm'),2),'yyyymm') from dual;
TO_CHA
------
200002
select to_char(add_months(to_date('199912','yyyymm'),-2),'yyyymm') from dual;
TO_CHA
------
199910

37.LAST_DAY
返回日期的最后一天
select to_char(sysdate,'yyyy.mm.dd'),to_char((sysdate)+1,'yyyy.mm.dd') from dual;
TO_CHAR(SY TO_CHAR((S
---------- ----------
2004.05.09 2004.05.10
select last_day(sysdate) from dual;
LAST_DAY(S
----------
31-5月 -04

38.MONTHS_BETWEEN(date2,date1)
给出date2-date1的月份
select months_between('19-12月-1999','19-3月-1999') mon_between from dual;
MON_BETWEEN
-----------
          9
SQL>selectmonths_between(to_date('2000.05.20','yyyy.mm.dd'),to_date('2005.05.20','yyyy.mm.dd')) mon_betw from dual;
 MON_BETW
---------
      -60

39.NEW_TIME(date,'this','that')
给出在this时区=other时区的日期和时间
select to_char(sysdate,'yyyy.mm.dd hh24:mi:ss') bj_time,to_char(new_time
  2  (sysdate,'PDT','GMT'),'yyyy.mm.dd hh24:mi:ss') los_angles from dual;
BJ_TIME             LOS_ANGLES
------------------- -------------------
2004.05.09 11:05:32 2004.05.09 18:05:32

40.NEXT_DAY(date,'day')
给出日期date和星期x之后计算下一个星期的日期
select next_day('18-5月-2001','星期五') next_day from dual;
NEXT_DAY
----------
25-5月 -01

41.SYSDATE
用来得到系统的当前日期
select to_char(sysdate,'dd-mm-yyyy day') from dual;
TO_CHAR(SYSDATE,'
-----------------
09-05-2004 星期日
trunc(date,fmt)按照给出的要求将日期截断,如果fmt='mi'表示保留分,截断秒
select to_char(trunc(sysdate,'hh'),'yyyy.mm.dd hh24:mi:ss') hh,
  2  to_char(trunc(sysdate,'mi'),'yyyy.mm.dd hh24:mi:ss') hhmm from dual;
HH                  HHMM
------------------- -------------------
2004.05.09 11:00:00 2004.05.09 11:17:00

42.CHARTOROWID
将字符数据类型转换为ROWID类型
select rowid,rowidtochar(rowid),ename from scott.emp;
ROWID              ROWIDTOCHAR(ROWID) ENAME
------------------ ------------------ ----------
AAAAfKAACAAAAEqAAA AAAAfKAACAAAAEqAAA SMITH
AAAAfKAACAAAAEqAAB AAAAfKAACAAAAEqAAB ALLEN
AAAAfKAACAAAAEqAAC AAAAfKAACAAAAEqAAC WARD
AAAAfKAACAAAAEqAAD AAAAfKAACAAAAEqAAD JONES

43.CONVERT(c,dset,sset)
将源字符串 sset从一个语言字符集转换到另一个目的dset字符集
select convert('strutz','we8hp','f7dec') "conversion" from dual;
conver
------
strutz

44.HEXTORAW
将一个十六进制构成的字符串转换为二进制

45.RAWTOHEXT
将一个二进制构成的字符串转换为十六进制

46.ROWIDTOCHAR
将ROWID数据类型转换为字符类型

47.TO_CHAR(date,'format')
select to_char(sysdate,'yyyy/mm/dd hh24:mi:ss') from dual;
TO_CHAR(SYSDATE,'YY
-------------------
2004/05/09 21:14:41

48.TO_DATE(string,'format')
将字符串转化为ORACLE中的一个日期

49.TO_MULTI_BYTE
将字符串中的单字节字符转化为多字节字符
 select to_multi_byte('高') from dual;
TO
--
高

50.TO_NUMBER
将给出的字符转换为数字
select to_number('1999') year from dual;
     YEAR
---------
     1999

51.BFILENAME(dir,file)
指定一个外部二进制文件
SQL>insert into file_tb1 values(bfilename('lob_dir1','image1.gif'));

52.CONVERT('x','desc','source')
将x字段或变量的源source转换为desc
select sid,serial#,username,decode(command,
  2  0,'none',
  3  2,'insert',
  4  3,
  5  'select',
  6  6,'update',
  7  7,'delete',
  8  8,'drop',
  9  'other') cmd  from v$session where type!='background';
      SID   SERIAL# USERNAME                       CMD
--------- --------- ------------------------------ ------
        1         1                                none
        2         1                                none
        3         1                                none
        4         1                                none
        5         1                                none
        6         1                                none
        7      1275                                none
        8      1275                                none
        9        20 GAO                            select
       10        40 GAO                            none

53.DUMP(s,fmt,start,length)
DUMP函数以fmt指定的内部数字格式返回一个VARCHAR2类型的值
col global_name for a30
col dump_string for a50
set lin 200
select global_name,dump(global_name,1017,8,5) dump_string from global_name;
GLOBAL_NAME                    DUMP_STRING
------------------------------ --------------------------------------------------
ORACLE.WORLD                   Typ=1 Len=12 CharacterSet=ZHS16GBK: W,O,R,L,D

54.EMPTY_BLOB()和EMPTY_CLOB()
这两个函数都是用来对大数据类型字段进行初始化操作的函数

55.GREATEST
返回一组表达式中的最大值,即比较字符的编码大小.
select greatest('AA','AB','AC') from dual;
GR
--
AC
select greatest('啊','安','天') from dual;
GR
--
天

56.LEAST
返回一组表达式中的最小值
select least('啊','安','天') from dual;
LE
--
啊

57.UID
返回标识当前用户的唯一整数
show user
USER 为"GAO"
select username,user_id from dba_users where user_id=uid;
USERNAME                         USER_ID
------------------------------ ---------
GAO                                   25

58.USER
返回当前用户的名字
select user from  dual;
USER
------------------------------
GAO

59.USEREVN
返回当前用户环境的信息,opt可以是:
ENTRYID,SESSIONID,TERMINAL,ISDBA,LABLE,LANGUAGE,CLIENT_INFO,LANG,VSIZE
ISDBA  查看当前用户是否是DBA如果是则返回true
select userenv('isdba') from dual;
USEREN
------
FALSE
select userenv('isdba') from dual;
USEREN
------
TRUE
SESSION
返回会话标志
select userenv('sessionid') from dual;
USERENV('SESSIONID')
--------------------
                 152
ENTRYID
返回会话人口标志
select userenv('entryid') from dual;
USERENV('ENTRYID')
------------------
                 0
INSTANCE
返回当前INSTANCE的标志
select userenv('instance') from dual;
USERENV('INSTANCE')
-------------------
                  1
LANGUAGE
返回当前环境变量
select userenv('language') from dual;
USERENV('LANGUAGE')
----------------------------------------------------
SIMPLIFIED CHINESE_CHINA.ZHS16GBK
LANG
返回当前环境的语言的缩写
select userenv('lang') from dual;
USERENV('LANG')
----------------------------------------------------
ZHS
TERMINAL
返回用户的终端或机器的标志
select userenv('terminal') from dual;
USERENV('TERMINA
----------------
GAO
VSIZE(X)
返回X的大小(字节)数
select vsize(user),user from dual;
VSIZE(USER) USER
----------- ------------------------------
          6 SYSTEM

60.AVG(DISTINCT|ALL)
all表示对所有的值求平均值,distinct只对不同的值求平均值
SQLWKS> create table table3(xm varchar(8),sal number(7,2));
语句已处理。
SQLWKS>  insert into table3 values('gao',1111.11);
SQLWKS>  insert into table3 values('gao',1111.11);
SQLWKS>  insert into table3 values('zhu',5555.55);
SQLWKS> commit;
select avg(distinct sal) from gao.table3;
AVG(DISTINCTSAL)
----------------
         3333.33
select avg(all sal) from gao.table3;
AVG(ALLSAL)
-----------
    2592.59

61.MAX(DISTINCT|ALL)
求最大值,ALL表示对所有的值求最大值,DISTINCT表示对不同的值求最大值,相同的只取一次
select max(distinct sal) from scott.emp;
MAX(DISTINCTSAL)
----------------
            5000

62.MIN(DISTINCT|ALL)
求最小值,ALL表示对所有的值求最小值,DISTINCT表示对不同的值求最小值,相同的只取一次
select min(all sal) from gao.table3;
MIN(ALLSAL)
-----------
    1111.11

63.STDDEV(distinct|all)
求标准差,ALL表示对所有的值求标准差,DISTINCT表示只对不同的值求标准差
select stddev(sal) from scott.emp;
STDDEV(SAL)
-----------
  1182.5032
select stddev(distinct sal) from scott.emp;
STDDEV(DISTINCTSAL)
-------------------
           1229.951

64.VARIANCE(DISTINCT|ALL)
求协方差
select variance(sal) from scott.emp;
VARIANCE(SAL)
-------------
    1398313.9

65.GROUP BY
主要用来对一组数进行统计
select deptno,count(*),sum(sal) from scott.emp group by deptno;
   DEPTNO  COUNT(*)  SUM(SAL)
--------- --------- ---------
       10         3      8750
       20         5     10875
       30         6      9400

66.HAVING
对分组统计再加限制条件
select deptno,count(*),sum(sal) from scott.emp group by deptno having count(*)>=5;
   DEPTNO  COUNT(*)  SUM(SAL)
--------- --------- ---------
       20         5     10875
       30         6      9400
select deptno,count(*),sum(sal) from scott.emp having count(*)>=5 group by deptno ;
   DEPTNO  COUNT(*)  SUM(SAL)
--------- --------- ---------
       20         5     10875
       30         6      9400

67.ORDER BY 用于对查询到的结果进行排序输出
select deptno,ename,sal from scott.emp order by deptno,sal desc;
/*   DEPTNO ENAME            SAL
--------- ---------- ---------
       10 KING            5000
       10 CLARK           2450
       10 MILLER          1300
       20 SCOTT           3000
       20 FORD            3000
       20 JONES           2975
       20 ADAMS           1100
       20 SMITH            800
       30 BLAKE           2850
       30 ALLEN           1600
       30 TURNER          1500
       30 WARD            1250
       30 MARTIN          1250
       30 JAMES            950
*/