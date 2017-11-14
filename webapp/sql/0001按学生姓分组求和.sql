--1.计算每个人的总成绩并排名
SELECT
	STU_ID,
	SUM (SCORE) AS TOTAL_SCORE
FROM
	"stuscore"
GROUP BY
	STU_ID;

--2.计算每个人的总成绩并排名(当需要附加多个字段时使用)
--格式 SELECT DISTINCT t1.STUD_ID,t2.STUD_ID FROM "stuscore" AS t1,t2 WHERE t1.STUD_ID=t2.STUD_ID ORDER BY t1.STUD_ID;
--SELECT * FROM "student";
SELECT DISTINCT
	T1.STU_ID,
	t2.total_score
FROM
	"stuscore" t1,
	(
		SELECT
			STU_ID,
			SUM (SCORE) AS total_score
		FROM
			"stuscore"
		GROUP BY
			STU_ID
	) t2
WHERE
	T1.STU_ID = T2.STU_ID
ORDER BY
	T1.STU_ID;

--综合应用(基本统计)，统计信息 带上姓名，通过学生STU_ID 到学生表查询到名字
SELECT DISTINCT
	T1.STU_ID,
	(
		SELECT
			STUDENT_NAME
		FROM
			"student"
		WHERE
			"ID" = T2."STU_ID"
	) AS STUDENT_NAME,
	t2.TOTAL_SCORE,
	T2.TOTAL_COUNT,
	T2.TOTAL_AVG,
	T2.TOTAL_MAX,
	T2.TOTAL_MIN,
T2.VAR_IANCE,
T2.VAR_SAMP,
T2.var_pop,
T2.STD_SAMP,
T2.STD_POP,
T2.STD_DEV
FROM
	"stuscore" t1,
	(
		SELECT
			STU_ID,
			SUM (SCORE) AS total_score,
			COUNT (SCORE) AS total_count,
			AVG (SCORE) AS total_AVG,
			MAX (SCORE) AS total_max,
			MIN (SCORE) AS total_min,
			-- 标准差 
			STDDEV (SCORE) AS std_dev,
			--总体标准差 
			STDDEV_POP (SCORE) AS std_pop,
			--样本标准差
			STDDEV_SAMP (SCORE) AS std_samp,
			-- 总体方差 
			VAR_POP (SCORE) AS var_pop,
			-- 样本方差 
			VAR_SAMP (SCORE) AS var_samp,
			-- 方差 
			VARIANCE (SCORE) AS var_iance
		FROM
			"stuscore"
		GROUP BY
			STU_ID
	) t2
WHERE
	T1.STU_ID = T2.STU_ID
ORDER BY
	T1.STU_ID;

