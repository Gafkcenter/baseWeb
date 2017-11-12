----Oracle统计分析---Oracle 10g函数大全--分析函数-study_sql_statistics
--https://www.cnblogs.com/zfc2201/p/3285010.html
--http://www.w3school.com.cn/sql/sql_functions.asp
--OVER()函数的使用
--1.统计名次——DENSE_RANK()-密集排名,ROW_NUMBER()-行编号
--1)允许并列名次且名次不间断，如：122344456.....
--将score按ID分组排名：dense_rank() over(partition by id order by score desc)
--将score不分组排名：dense_rank() over(order by score desc)
----SCORE按ID分组排名：
SELECT
	"ID",
	AREA,
	SCORE,
	DENSE_RANK () OVER (
		PARTITION BY ID
		ORDER BY
			SCORE DESC
	) AS dense_rank_order
FROM
	"students_oracle";

----SCORE不分组排名：
SELECT
	"ID",
	AREA,
	SCORE,
	DENSE_RANK () OVER (ORDER BY SCORE DESC) AS dense_rank_order
FROM
	"students_oracle";

----综合语句（分组，不分组同时用）
SELECT
	"ID",
	AREA,
	SCORE,
	DENSE_RANK () OVER (
		PARTITION BY ID
		ORDER BY
			SCORE DESC
	) AS DR_O_GROUP,
	DENSE_RANK () OVER (ORDER BY SCORE DESC) AS DR_UNO_GROUP
FROM
	"students_oracle"
ORDER BY
	"ID",
	AREA;

--2)不允许并列名次、相同值名次不重复，ROW_NUMBER()，结果如123456……
--将score按ID分组排名：row_number() over(partition by id order by score desc)
--将score不分组排名：row_number() over(order by score desc)
----SCORE按ID分组排名：
SELECT
	"ID",
	AREA,
	SCORE,
	ROW_NUMBER () OVER (
		PARTITION BY ID
		ORDER BY
			SCORE DESC
	) AS ROW_NUMBER_order
FROM
	"students_oracle";

----SCORE不分组排名：
SELECT
	"ID",
	AREA,
	SCORE,
	ROW_NUMBER () OVER (ORDER BY SCORE DESC) AS ROW_NUMBER_order
FROM
	"students_oracle";

----综合语句（分组，不分组同时用）
SELECT
	"ID",
	AREA,
	SCORE,
	ROW_NUMBER () OVER (
		PARTITION BY ID
		ORDER BY
			SCORE DESC
	) AS RN_O_GROUP,
	ROW_NUMBER () OVER (ORDER BY SCORE DESC) AS RN_UNO_GROUP
FROM
	"students_oracle"
ORDER BY
	"ID",
	AREA;

--3)允许并列名次、同名次复制名次自动填充空缺，rank()，结果如12245558……
--将score按ID分组排名：rank() over(partition by id order by score desc)
--将score不分组排名：rank() over(order by score desc)
SELECT
	"ID",
	AREA,
	SCORE,
	RANK () OVER (
		PARTITION BY ID
		ORDER BY
			SCORE DESC
	) AS RANK_order
FROM
	"students_oracle";

----SCORE不分组排名：
SELECT
	"ID",
	AREA,
	SCORE,
	RANK () OVER (ORDER BY SCORE DESC) AS RANK_order
FROM
	"students_oracle";

----综合语句（分组，不分组同时用）
SELECT
	"ID",
	AREA,
	SCORE,
	RANK () OVER (
		PARTITION BY ID
		ORDER BY
			SCORE DESC
	) AS RANK_O_GROUP,
	RANK () OVER (ORDER BY SCORE DESC) AS RANK_UNO_GROUP
FROM
	"students_oracle"
ORDER BY
	"ID",
	AREA;

--4)  cume_dist() 名次分析(相对位置)，cume_dist()——-最大排名/总个数 
--语法：cume_dist() over([partition_clause] order_by_clause)
--计算结果为相对位置/总行数。返回值(0,1]。
--例如在一个5行的组中，返回的累计分布值为0.2,0.4,0.6,0.8,1.0;
--注意对于重复行，计算时取重复行中的最后一行的位置。
----http://www.linuxidc.com/Linux/2012-08/67673.htm
--select ename, sal, deptno,cume_dist() over(partition by deptno order by sal) cume_dist from emp;  
--函数：cume_dist() over(order by id)
SELECT
	"ID",
	AREA,
	SCORE,
	CUME_DIST () OVER (
		PARTITION BY ID
		ORDER BY
			SCORE DESC
	) AS CUME_DIST_order
FROM
	"students_oracle";

----SCORE不分组排名：
SELECT
	"ID",
	AREA,
	SCORE,
	CUME_DIST () OVER (ORDER BY SCORE DESC) AS CUME_DIST_order
FROM
	"students_oracle";

----综合语句（分组，不分组同时用）
SELECT
	"ID",
	AREA,
	SCORE,
	CUME_DIST () OVER (
		PARTITION BY ID
		ORDER BY
			SCORE DESC
	) AS CD_O_GROUP,
	CUME_DIST () OVER (ORDER BY SCORE DESC) AS CD_UNO_GROUP
FROM
	"students_oracle"
ORDER BY
	"ID",
	AREA;

SELECT
	"ID",
	area,
	score,
	SUM (1) OVER () AS 总数,
	SUM (1) OVER (PARTITION BY ID) AS 分组个数,
	(
		CUME_DIST () OVER (
			PARTITION BY ID
			ORDER BY
				score DESC
		)
	) * (SUM(1) OVER(PARTITION BY ID)) AS 分组id排序,
	(
		CUME_DIST () OVER (ORDER BY score DESC)
	) * (SUM(1) OVER()) 不分组排序
FROM
	"students_oracle"
ORDER BY
	ID,
	area;

----a)作为聚合函数的用法--数据构造一条假定的数据并插入到现存行中
--语法：cume_dist(expr) with group (order by exp)
--cume_dist()用参数中的指定的数据构造一条假定的数据并插入到现存行中，
--然后计算这条假定数据在所有行中的相对位置。
--例如下面的查询中,emp中总共有14行数据，
--假定的数据(deptno=20,sal=4000)会插入到第9行，
--因此相对位置 9/(14+1)=0.6。
--select cume_dist(20,4000) within group (order by deptno, sal) cume_dist from emp;
SELECT CUME_DIST(20,4000) within group (order by AREA, ID) CUME_DIST from "students_oracle";


--5)利用cume_dist()，允许并列名次、复制名次自动空缺，取并列后较大名次，结果如22355778……
--将score按ID分组排名：cume_dist() over(partition by id order by score desc)*sum(1) over(partition by id)
--将score不分组排名：cume_dist() over(order by score desc)*sum(1) over()

select id,area,score,
sum(1) over() as 总数,
sum(1) over(partition by id) as 分组个数,
(cume_dist() over(partition by id order by score desc))*(sum(1) over(partition by id)) 分组id排序,
(cume_dist() over(order by score desc))*(sum(1) over()) 不分组排序
from "students_oracle" order by id,area

--二.分组统计－－sum(),max(),avg(),RATIO_TO_REPORT()
--1.统计汇总：
SELECT "ID",area,sum(1) over() as 总记录数,sum(1) over(partition by "ID") as 分组记录数,
sum(score) over() as 总计,sum(score) over(partition by "ID") as 分组求和,
sum(score) over(order by "ID") as  分组连续求和,sum(score) over(partition by "ID",area) as 分组ID和area求和,
sum(score) over(partition by "ID" order by area) as 分组ID并连续按area求和,
max(score) over() as 最大值,max(score) over(partition by "ID") as 分组最大值,
max(score) over(order by "ID") as 分组连续最大值,max(score) over(partition by "ID",area) as 分组ID和area最大值,
max(score) over(partition by "ID" order by area) as 分组ID连续按area最大值,
avg(score) over() as 所有平均,avg(score) over(partition by "ID") as 分组平均,
avg(score) over(order by "ID") as 分组连续平均,avg(score) over(partition by id,area) as 分组ID和area平均,
avg(score) over(partition by "ID" order by area) as 分组ID连续按area平均,
RATIO_TO_REPORT(score) over() as "占所有%",RATIO_TO_REPORT(score) over(partition by "ID") as "占分组%",
score FROM "students_oracle";

--2.前n,后n条：
--LAG(COL,n,default)、LEAD(OL,n,default) --取前后边N条数据
--取前面记录的值：lag(score,n,x) over(order by id)
--取后面记录的值：lead(score,n,x) over(order by id) 
--参数：n表示移动N条记录，X表示不存在时填充值，iD表示排序列
select id,AREA,SCORE,lag(score,10,0) over(order by id) AS lg from "students_oracle";
select id,AREA,SCORE,lead(score,10,0) over(order by id) AS lg from "students_oracle";

--4、FIRST_VALUE()、LAST_VALUE()
--取第起始1行值：first_value(score,n) over(order by id)
--取第最后1行值：LAST_value(score,n) over(order by id)
select id,first_value(score) over(order by id) fv,score from "students_oracle";
select id,last_value(score) over(order by id) fv,score from "students_oracle";

