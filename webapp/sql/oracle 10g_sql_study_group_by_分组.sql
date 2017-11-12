----Oracle统计分析---Oracle 10g函数大全--分析函数-study_sql
--https://www.cnblogs.com/zfc2201/p/3285010.html
--http://www.w3school.com.cn/sql/sql_functions.asp
--1）GROUP BY子句 
--A、GROUPING SETS(一次分别按多个组分类统计条件完成统计结果并显示，相当于多个union ALL)
--http://blog.itpub.net/26110315/viewspace-720291/
/*--------理解grouping sets
select a, b, c, sum( d ) from t group by grouping sets ( a, b, c )

等效于
select * from (
select a, null, null, sum( d ) from t group by a
union all
select null, b, null, sum( d ) from t group by b 
union all
select null, null, c, sum( d ) from t group by c 
)
*/
--统计表效果--按指定的分组条件依次显示分组结果
SELECT
	ID,
	AREA,
	STU_TYPE,
	--统计求和
	SUM (SCORE) AS SUM_SCORE,
	--统计计数
	COUNT (SCORE) AS COUNT_SCORE,
	--统计求平均
	AVG (SCORE) AS AVG_SCORE,
	--统计求最大
	MAX (SCORE) AS MAX_SCORE,
	--统计求最小
	MIN (SCORE) AS MIN_SCORE
FROM
	"students_oracle"
GROUP BY
	GROUPING SETS (
		--先按年级，班级和小组统计一次
		("ID", AREA, STU_TYPE),
		--再按年级，班级，统计一次
		("ID", AREA),
		--按年级统计一次
		"ID",
		--()按全部年级统计一次。依次显示出来
		()
	)
ORDER BY
	"ID",
	AREA,
	STU_TYPE;

--B、ROLLUP
--http://blog.itpub.net/519536/viewspace-610995/
/*--------理解rollup
select a, b, c, sum( d )
from t
group by rollup(a, b, c);

等效于

select * from (
select a, b, c, sum( d ) from t group by a, b, c 
union all
select a, b, null, sum( d ) from t group by a, b
union all
select a, null, null, sum( d ) from t group by a
union all
select null, null, null, sum( d ) from t
)
*/
--统计表效果-提供的所有分组参数，数量按递减顺序组合，依次显示统计结果
SELECT
	ID,
	AREA,
	STU_TYPE,
	--统计求和
	SUM (SCORE) AS SUM_SCORE
FROM
	"students_oracle"
GROUP BY
	ROLLUP --有3个分组参数会依次按最多分组参数到没分组参数进行汇总结果展示
	("ID", AREA, STU_TYPE)
ORDER BY
	"ID",
	AREA,
	STU_TYPE;

--C、CUBE
/*--------理解cube
select a, b, c, sum( d ) from t
group by cube( a, b, c)

等效于

select a, b, c, sum( d ) from t
group by grouping sets( 
( a, b, c ), 
( a, b ), ( a ), ( b, c ), 
( b ), ( a, c ), ( c ), 
() )
*/
--统计表效果-提供的所有分组参数，按序任意组合，依次显示统计结果
SELECT
	"ID",
	AREA,
	STU_TYPE,
	--统计求和
	SUM (SCORE) AS SUM_SCORE
FROM
	"students_oracle"
GROUP BY
	CUBE --有3个分组参数会依次按最多分组参数到没分组参数进行汇总结果展示
	("ID", AREA, STU_TYPE)
ORDER BY
	"ID",
	AREA,
	STU_TYPE;

--D、GROUPING
/*从上面的结果中我们很容易发现,每个统计数据所对应的行都会出现null,
如何来区分到底是根据那个字段做的汇总呢,grouping函数判断是否合计列!
grouping函数用来区分NULL值，这里NULL值有2种情况，一是原本表中的数据就为NULL，二是由rollup、cube、grouping sets生成的NULL值。
当为第一种情况中的空值时，grouping(NULL)返回0；当为第二种情况中的空值时，grouping(NULL)返回1*/
--GROUPING 应用安例一
SELECT
	DECODE (
		GROUPING ("ID"),
		1,
		'id_null',
		"ID"
	) "ID",
	DECODE (
		GROUPING (AREA),
		1,
		'area_null',
		TO_CHAR (AREA)
	) AREA,
	DECODE (
		GROUPING (STU_TYPE),
		1,
		'stu_type_null',
		STU_TYPE
	) STU_TYPE,
	SUM (SCORE) SCORE
FROM
	"students_oracle"
GROUP BY
	CUBE ("ID", AREA, STU_TYPE)
ORDER BY
	"ID",
	AREA,
	STU_TYPE;

--GROUPING 应用安例二
--https://www.cnblogs.com/fangyz/p/5813916.html
--Oracle NULL:
--NVL(Expr1,Expr2)如果Expr1为NULL，返回Expr2的值，否则返回Expr1的值
--NVL2(Expr1,Expr2,Expr3)如果Expr1为NULL，返回Expr2的值，否则返回Expr3的值
--NULLIF(Expr1,Expr2)如果Expr1和Expr2的值相等，返回NULL，否则返回Expr1的值
--Mysql:
--ISNULL ("ID",CASE WHEN GROUPING("ID")=1 THEN 'rollup-NULL' END) AS "ID"
SELECT
	DECODE (
		GROUPING ("ID"),
		1,
		'rollup-NULL',
		"ID"
	),
	--字段为number,做下decode就可以存字符类型
	--NVL("ID",'rollup-NULL') AS "ID",--这种方法会报错，因为rollup-NULL不是number型。
	NVL (AREA, 'rollup-NULL') AS AREA,
	NVL (STU_TYPE, 'rollup-NULL') AS STU_TYPE,
	SUM (SCORE) SCORE
FROM
	"students_oracle"
GROUP BY
	CUBE ("ID", AREA, STU_TYPE)
ORDER BY
	"ID",
	AREA,
	STU_TYPE;

--GROUPING_ID()
--会发现grouping_id(id,grade)和grouping_id(grade,id)的值是不同的，因为GROUPING_ID()函数可以接受一列或多列，
--返回GROUPING位向量的十进制值。GROUPING位向量的计算方法是将按照顺序对每一列调用GROUPING函数的结果组合起来，
--所以说01和10的值不一样的（二进制结果转换成10进制显示）
--原始数据：显示十进制数字级别，案例应用1
SELECT
	"ID",
	AREA,
	STU_TYPE,
	--统计求和
	GROUPING_ID ("ID", AREA) AS GROUP_LEVEL,
	--多层统计的层属性(可以用于显示不同层的过滤器)
	SUM (SCORE) AS SUM_SCORE
FROM
	"students_oracle"
GROUP BY
	CUBE --有3个分组参数会依次按最多分组参数到没分组参数进行汇总结果展示
	("ID", AREA, STU_TYPE);

--显示十进制数字级别，案例应用2 显示指定级别的统计结果
SELECT
	"ID",
	AREA,
	STU_TYPE,
	--统计求和
	GROUPING_ID ("ID", AREA) AS GROUP_LEVEL,
	--多层统计的层属性(可以用于显示不同层的过滤器)
	SUM (SCORE) AS SUM_SCORE
FROM
	"students_oracle"
GROUP BY
	CUBE --有3个分组参数会依次按最多分组参数到没分组参数进行汇总结果展示
	("ID", AREA, STU_TYPE)
HAVING
	GROUPING_ID ("ID", AREA) = 3;

--显示第三层统计结果
--显示十进制数字级别，案例应用3 显示指定级别的统计结果--显示注释提示


SELECT
	"ID",
	AREA,
	STU_TYPE,
	--统计求和
	DECODE (
		GROUPING_ID ("ID", AREA),
		'0',
		'--',
		'1',
		'小计',
		'3',
		'总计'
	) AS GROUPING_LEVEL,
	--多层统计的层属性(可以用于显示不同层的过滤器)
	SUM (SCORE) AS SUM_SCORE
FROM
	"students_oracle"
GROUP BY
	CUBE --有3个分组参数会依次按最多分组参数到没分组参数进行汇总结果展示
	("ID", AREA, STU_TYPE)
HAVING
	--显示第二层统计结果
	GROUPING_ID ("ID", AREA) >= 0;