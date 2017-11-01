--1.����ÿ���˵��ܳɼ�������

select name,sum(score) as allscore from stuscore group by name order by allscore;

--2.����ÿ���˵��ܳɼ�������

select distinct t1.name,t1.stuid,t2.allscore from stuscore t1,( select stuid,sum(score) as allscore from stuscore group by stuid) t2 where t1.stuid=t2.stuid order by t2.allscore desc;

--3. ����ÿ���˵��Ƶ���߳ɼ�

select t1.stuid,t1.name,t1.subject,t1.score from stuscore t1,(select stuid,max(score) as maxscore from stuscore group by stuid) t2 where t1.stuid=t2.stuid and t1.score=t2.maxscore;


--4.����ÿ���˵�ƽ���ɼ�

select distinct t1.stuid,t1.name,t2.avgscore from stuscore t1,(select stuid,avg(score) as avgscore from stuscore group by stuid) t2 where t1.stuid=t2.stuid;

5.�г����ſγ̳ɼ���õ�ѧ�� 

select t1.stuid,t1.name,t1.subject,t2.maxscore from stuscore t1,(select subject,max(score) as maxscore from stuscore group by subject) t2where t1.subject=t2.subject and t1.score=t2.maxscore 
6.�г����ſγ̳ɼ���õ���λѧ�� 

select distinct t1.* from stuscore t1 where t1.id in (select top 2 stuscore.id from stuscore where subject = t1.subject order by score desc) order by t1.subject 

7.ѧ�� ���� ���� ��ѧ Ӣ�� �ܷ� ƽ���� 

select stuid as ѧ��,name as ����,sum(case when subject='����' then score else 0 end) as ����,sum(case when subject='��ѧ' then score else 0 end) as ��ѧ,sum(case when subject='Ӣ��' then score else 0 end) as Ӣ��,sum(score) as �ܷ�,(sum(score)/count(*)) as ƽ����from stuscoregroup by stuid,name order by �ܷ�desc 

8.�г����ſγ̵�ƽ���ɼ� 

select subject,avg(score) as avgscore from stuscoregroup by subject 

9.�г���ѧ�ɼ������� 

declare @tmp table(pm int,name varchar(50),score int,stuid int)insert into @tmp select null,name,score,stuid from stuscore where subject='��ѧ' order by score descdeclare @id intset @id=0;update @tmp set @id=@id+1,pm=@idselect * from @tmp 

select DENSE_RANK () OVER(order by score desc) as row,name,subject,score,stuid from stuscore where subject='��ѧ'order by score desc 

10. �г���ѧ�ɼ���2-3����ѧ�� 

select t3.* from(select top 2 t2.* from (select top 3 name,subject,score,stuid from stuscore where subject='��ѧ'order by score desc) t2 order by t2.score) t3 order by t3.score desc 

11. ������ĵ���ѧ�ɼ������� 

declare @tmp table(pm int,name varchar(50),score int,stuid int)insert into @tmp select null,name,score,stuid from stuscore where subject='��ѧ' order by score descdeclare @id intset @id=0;update @tmp set @id=@id+1,pm=@idselect * from @tmp where name='����' 

12. �γ� ������-59�� ����-80�� �ţ�-100�� 

select subject, (select count(*) from stuscore where score<60 and subject=t1.subject) as ������,(select count(*) from stuscore where score between 60 and 80 and subject=t1.subject) as ��,(select count(*) from stuscore where score >80 and subject=t1.subject) as ��from stuscore t1 group by subject 

13. ��ѧ:����(50��),����(90��),����(90��),����(76��) 

declare @s varchar(1000)set @s=''select @s =@s+','+name+'('+convert(varchar(10),score)+'��)' from stuscore where subject='��ѧ' set @s=stuff(@s,1,1,'')print '��ѧ:'+@s


SQL��ѯ����ȫ����
һ�� �򵥲�ѯ 
�򵥵�Transact-SQL��ѯֻ����ѡ���б�FROM�Ӿ��WHERE�Ӿ䡣���Ƿֱ�˵������ѯ�С���ѯ��
�����ͼ���Լ����������ȡ�
���磬���������ѯtesttable��������Ϊ����������nickname�ֶκ�email�ֶΡ�
����:SELECT `nickname`,`email`FROM `testtable`WHERE `name`='����'
 (һ) ѡ���б�
ѡ���б�(select_list)ָ������ѯ�У���������һ�������б��Ǻš����ʽ������(�����ֲ�������ȫ�ֱ���)�ȹ��ɡ�

1��ѡ��������      
���磬���������ʾtesttable���������е����ݣ�
����:SELECT * FROM testtable
 
2��ѡ�񲿷��в�ָ�����ǵ���ʾ����
��ѯ������������ݵ�����˳����ѡ���б�����ָ������������˳����ͬ��
���磺
����:SELECT nickname,email FROM testtable
 
3�������б���
��ѡ���б��У�������ָ���б��⡣�����ʽΪ��
�б���=����
���� �б���
���ָ�����б��ⲻ�Ǳ�׼�ı�ʶ����ʽʱ��Ӧʹ�����Ŷ���������磬�������ʹ�ú�����ʾ��
���⣺
����:SELECT �ǳ�=nickname,�����ʼ�=email  FROM testtable
 
4��ɾ���ظ���
SELECT�����ʹ��ALL��DISTINCTѡ������ʾ���з��������������л�ɾ�������ظ��������У�Ĭ��
ΪALL��ʹ��DISTINCTѡ��ʱ�����������ظ�����������SELECT���صĽ��������ֻ����һ�С�

5�����Ʒ��ص�����
ʹ��TOP n [PERCENT]ѡ�����Ʒ��ص�����������TOP n˵������n�У���TOP n PERCENTʱ��˵��n��
��ʾһ�ٷ�����ָ�����ص����������������İٷ�֮����
���磺
����:SELECT TOP 2 * FROM `testtable`
����:SELECT TOP 20 PERCENT * FROM `testtable`

(��) FROM�Ӿ�
FROM�Ӿ�ָ��SELECT����ѯ�����ѯ��صı����ͼ����FROM�Ӿ�������ָ��256�������ͼ��
����֮���ö��ŷָ���
��FROM�Ӿ�ͬʱָ����������ͼʱ�����ѡ���б��д���ͬ���У���ʱӦʹ�ö������޶���Щ��
�����ı����ͼ��������usertable��citytable����ͬʱ����cityid�У��ڲ�ѯ�������е�cityidʱӦ
ʹ����������ʽ�����޶���
����:SELECT `username`,citytable.cityid
FROM `usertable`,`citytable`
WHERE usertable.cityid=citytable.cityid��FROM�Ӿ��п����������ָ�ʽΪ�����ͼָ��������
����:���� as ����
���� �����������������ñ�ı�����ʽ��ʾΪ��
����:SELECT `username`,b.cityid
FROM usertable a,citytable b
WHERE a.cityid=b.cityidSELECT�����ܴӱ����ͼ�м������ݣ������ܹ���������ѯ��������صĽ�������в�ѯ���ݡ�
���磺
����:SELECT a.au_fname+a.au_lname
FROM authors a,titleauthor ta
(SELECT `title_id`,`title`
FROM `titles`
WHERE ` ytd_sales`>10000
) AS t
WHERE a.au_id=ta.au_id
AND ta.title_id=t.title_id�����У���SELECT���صĽ�����ϸ���һ����t��Ȼ���ٴ��м������ݡ�

(��) ʹ��WHERE�Ӿ����ò�ѯ����
WHERE�Ӿ����ò�ѯ���������˵�����Ҫ�������С�������������ѯ�������20�����ݣ�
 
����:SELECT * FROM usertable WHERE age>20 WHERE�Ӿ�ɰ������������������
�Ƚ������(��С�Ƚ�)��>��>=��=����!>��!=10 AND age
����:SELECT * FROM `usertable` ORDER BY `age` DESC,`userid` ASC���⣬���Ը��ݱ��ʽ��������

���� ���ϲ�ѯ
UNION��������Խ�����������������SELECT���Ĳ�ѯ������Ϻϲ���һ�����������ʾ����ִ����
�ϲ�ѯ��
UNION���﷨��ʽΪ��
����:select_statement
UNION [ALL] selectstatement
[UNION [ALL] selectstatement][��n]����selectstatementΪ�����ϵ�SELECT��ѯ��䡣
ALLѡ���ʾ�������кϲ�����������С���ָ������ʱ�������ϲ�ѯ��������е��ظ��н�ֻ����һ�С�
���ϲ�ѯʱ����ѯ������б���Ϊ��һ����ѯ�����б��⡣��ˣ�Ҫ�����б�������ڵ�һ����ѯ��
���ж��塣Ҫ�����ϲ�ѯ�������ʱ��Ҳ����ʹ�õ�һ��ѯ����е��������б����������š�
��ʹ��UNION �����ʱ��Ӧ��֤ÿ�����ϲ�ѯ����ѡ���б�������ͬ�����ı��ʽ������ÿ����ѯѡ
����ʽӦ������ͬ���������ͣ����ǿ����Զ�������ת��Ϊ��ͬ���������͡����Զ�ת��ʱ��������ֵ��
�ͣ�ϵͳ���;��ȵ���������ת��Ϊ�߾��ȵ��������͡�
�ڰ��������ѯ��UNION����У���ִ��˳�����������ң�ʹ�����ſ��Ըı���һִ��˳�����磺
��ѯ1 UNION (��ѯ2 UNION ��ѯ3)

�������Ӳ�ѯ
        ͨ���������������ʵ�ֶ�����ѯ�������ǹ�ϵ���ݿ�ģ�͵���Ҫ�ص㣬Ҳ���������������������ݿ����ϵͳ��һ����־��
       �ڹ�ϵ���ݿ����ϵͳ�У�����ʱ������֮��Ĺ�ϵ����ȷ��������һ��ʵ���������Ϣ�����
һ�����С�����������ʱ��ͨ�����Ӳ�����ѯ������ڶ�����еĲ�ͬʵ�����Ϣ�����Ӳ������û���
���ܴ������ԣ����ǿ������κ�ʱ�������µ��������͡�Ϊ��ͬʵ�崴���µı�����ͨ�����ӽ���
��ѯ��
       ���ӿ�����SELECT ����FROM�Ӿ��WHERE�Ӿ��н��������Ƕ�����FROM�Ӿ���ָ������ʱ������
�����Ӳ�����WHERE�Ӿ��е������������ֿ��������ԣ���Transact-SQL���Ƽ�ʹ�����ַ�����
       SQL-92��׼�������FROM�Ӿ�������﷨��ʽΪ�� 
 
����:FROM join_table join_type join_table [ON (join_condition)]����join_tableָ���������Ӳ����ı��������ӿ��Զ�ͬһ���������Ҳ���ԶԶ���������ͬһ��������������ֳ��������ӡ�
join_type ָ���������ͣ��ɷ�Ϊ���֣������ӡ������Ӻͽ������ӡ�
 
       ������(INNER JOIN)ʹ�ñȽ���������б��ĳ(Щ)�����ݵıȽϲ��������г���Щ����������������ƥ��������С�������ʹ�õıȽϷ�ʽ��ͬ���������ַ�Ϊ��ֵ���ӡ���Ȼ���ӺͲ����������֡�
       �����ӷ�Ϊ��������(LEFT OUTER JOIN��LEFT JOIN)����������(RIGHT OUTER JOIN��RIGHT JOIN)
��ȫ������(FULL OUTER JOIN��FULL JOIN)���֡��������Ӳ�ͬ���ǣ������Ӳ�ֻ�г�������������ƥ����У������г����(��������ʱ)���ұ�(��������ʱ)��������(ȫ������ʱ)�����з������������������С�
       ��������(CROSS JOIN)û��WHERE �Ӿ䣬���������ӱ������������еĵѿ����������������е������������ڵ�һ�����з��ϲ�ѯ�����������������Եڶ������з��ϲ�ѯ����������������
       ���Ӳ����е�ON (join_condition) �Ӿ�ָ���������������ɱ����ӱ��е��кͱȽ���������߼�������ȹ��ɡ�
        �����������Ӷ����ܶ�text��ntext��image���������н���ֱ�����ӣ������Զ��������н��м�����ӡ����磺
����:SELECT p1.pub_id,p2.pub_id,p1.pr_info
FROM pub_info AS p1 INNER JOIN pub_info AS p2
ON DATALENGTH(p1.pr_info)=DATALENGTH(p2.pr_info)(һ)������
�����Ӳ�ѯ�����г�����������ƥ��������У���ʹ�ñȽ�������Ƚϱ������е���ֵ��
 �����ӷ����֣�
1����ֵ���ӣ�������������ʹ�õ��ں�(=)������Ƚϱ������е���ֵ�����ѯ������г������ӱ��е������У��������е��ظ��С�
2���������ӣ� ����������ʹ�ó��������������������Ƚ�������Ƚϱ����ӵ��е���ֵ����Щ���������>��>=����!��
3����Ȼ���ӣ�������������ʹ�õ���(=)������Ƚϱ������е���ֵ������ʹ��ѡ���б�ָ����ѯ������������������У���ɾ�����ӱ��е��ظ��С�
��������ʹ�õ�ֵ�����г�authors��publishers����λ��ͬһ���е����ߺͳ����磺
����:SELECT *
FROM authors AS a INNER JOIN publishers AS p
ON a.city=p.city����ʹ����Ȼ���ӣ���ѡ���б���ɾ��authors ��publishers �����ظ���(city��state)��
����:SELECT a.*,p.pub_id,p.pub_name,p.country
FROM authors AS a INNER JOIN publishers AS p
ON a.city=p.city
(��)������������ʱ�����ز�ѯ��������еĽ��Ƿ��ϲ�ѯ����( WHERE ���������� HAVING ����)����������
���С�������������ʱ�������ص���ѯ��������еĲ����������������������У����һ��������(��������ʱ)���ұ�(��������ʱ)�������߽ӱ�(ȫ������)�е����������С�
������ʹ���������ӽ���̳���ݺ�������Ϣ����������
����:SELECT a.*,b.* FROM `luntan` LEFT JOIN usertable as b
ON a.username=b.username����ʹ��ȫ�����ӽ�city���е����������Լ�user���е��������ߣ��Լ��������ڵĳ��У�
����:SELECT a.*,b.*
FROM city as a FULL OUTER JOIN user as b
ON a.username=b.username
 (��)��������
�������Ӳ���WHERE �Ӿ䣬�����ر����ӵ����������������еĵѿ����������ص���������е���
���������ڵ�һ�����з��ϲ�ѯ�����������������Եڶ������з��ϲ�ѯ����������������
����titles������6��ͼ�飬��publishers������8�ҳ����磬�����н������Ӽ������ļ�¼������
��6*8=48�С�
����:SELECT `type`,`pub_name`
FROM `titles` CROSS JOIN `publishers`
ORDER BY `type`
 
SQL�������(�ǳ�ʵ�õļ�������)
_ArticleContent1_lblContent>��������
��������һ���¼�¼����Ҫʹ��SQL INSERT ��䡣������һ�����ʹ�������������ӣ�
����:INSERT mytable (mycolumn) VALUES (��some data��) ��������ַ�����some data�������mytable��mycolumn�ֶ��С���Ҫ���������ݵ��ֶε������ڵ�һ��������ָ����ʵ�ʵ������ڵڶ��������и�����
INSERT ���������䷨���£�
����:INSERT [INTO] {table_name|view_name} [(column_list)] {DEFAULT VALUES |
Values_list | select_statement} ���һ�����ж���ֶΣ�ͨ�����ֶ������ֶ�ֵ�ö��Ÿ���������������е��ֶ��в������ݡ������mytable�������ֶ�first_column,second_column,��third_column��
�����INSERT��������һ�������ֶζ���ֵ��������¼��
����:INSERT mytable (first_column,second_column,third_column)
VALUES (��some data��,��some more data��,��yet more data��) ע��
�����ʹ��INSERT������ı����ֶ��в������ݡ����ǣ��������Ҫ����ܳ����ַ�������Ӧ��ʹ��WRITETEXT��䡣�ⲿ�����ݶԱ�����˵̫�߼��ˣ���˲������ۡ�Ҫ�˽�������Ϣ����ο�Microsoft SQL Sever ���ĵ���
�������INSERT �����ָֻ�������ֶκ����ݻ���ô���أ����仰˵������һ�����в���һ���¼�¼������һ���ֶ�û���ṩ���ݡ�����������£�����������ֿ��ܣ�
������ֶ���һ��ȱʡֵ����ֵ�ᱻʹ�á����磬����������¼�¼ʱû�и��ֶ�third_column�ṩ���ݣ�������ֶ���һ��ȱʡֵ��some value��������������£����¼�¼����ʱ�����ֵ��some value����
������ֶο��Խ��ܿ�ֵ������û��ȱʡֵ����ᱻ�����ֵ��
������ֶβ��ܽ��ܿ�ֵ������û��ȱʡֵ���ͻ���ִ�������յ�������Ϣ��
The column in table mytable may not be null.
���������ֶ���һ����ʶ�ֶΣ���ô�����Զ�����һ����ֵ��������һ���б�ʶ�ֶεı��в����¼�¼ʱ��ֻҪ���Ը��ֶΣ���ʶ�ֶλ���Լ���һ����ֵ��
ע��
��һ���б�ʶ�ֶεı��в����¼�¼���������SQL����@@identity�������¼�¼
�ı�ʶ�ֶε�ֵ���������µ�SQL��䣺
 ����:INSERT mytable (first_column) VALUES(��some value��) [code]
[code]INSERT anothertable(another_first,another_second)
VALUES(@@identity,��some value��) �����mytable��һ����ʶ�ֶΣ����ֶε�ֵ�ᱻ�����anothertable��another_first�ֶΡ�������Ϊ����@@identity���Ǳ������һ�β����ʶ�ֶε�ֵ��
�ֶ�another_firstӦ�����ֶ�first_column����ͬ���������͡����ǣ��ֶ�another_first������Ӧ�ñ�ʶ�ֶΡ�Another_first�ֶ����������ֶ�first_column��ֵ��
ɾ����¼
Ҫ�ӱ���ɾ��һ��������¼����Ҫʹ��SQL DELETE��䡣����Ը�DELETE ����ṩWHERE �Ӿ䡣WHERE�Ӿ�����ѡ��Ҫɾ���ļ�¼�����磬��������DELETE���ֻɾ���ֶ�first_column��ֵ���ڡ�Delete Me���ļ�¼��
 ����:DELETE mytable WHERE first_column=��Deltet Me�� DELETE ���������䷨���£�
 
����:DELETE [FROM] {table_name|view_name} [WHERE clause] ��SQL SELECT ����п���ʹ�õ��κ�������������DELECT ����WHERE�Ӿ� ��ʹ�á����磬��������DELETE���ֻɾ����Щfirst_column�ֶε�ֵΪ��goodbye����second_column�ֶε�ֵΪ��so long���ļ�¼��
 ����:DELETE mytable WHERE first_column=��goodby�� OR second_column=��so long�� ����㲻��DELETE ����ṩWHERE �Ӿ䣬���е����м�¼������ɾ�����㲻Ӧ���������뷨���������ɾ��Ӧ�ñ��е����м�¼��Ӧʹ�õ�ʮ��������TRUNCATE TABLE��䡣
ע��
ΪʲôҪ��TRUNCATE TABLE ������DELETE��䣿����ʹ��TRUNCATE TABLE���ʱ����¼��ɾ���ǲ�����¼�ġ�Ҳ����˵������ζ��TRUNCATE TABLE Ҫ��DELETE��öࡣ
���¼�¼
Ҫ�޸ı����Ѿ����ڵ�һ���������¼��Ӧʹ��SQL UPDATE��䡣ͬDELETE���һ����UPDATE������ʹ��WHERE�Ӿ���ѡ������ض��ļ�¼���뿴������ӣ�
 ����:UPDATE mytable SET first_column=��Updated!�� WHERE second_column=��Update Me!�� ���UPDATE ����������second_column�ֶε�ֵΪ��Update Me!���ļ�¼�������б�ѡ�еļ�¼���ֶ�first_column��ֵ����Ϊ��Updated!����
������UPDATE���������䷨��
 ����:UPDATE {table_name|view_name} SET [{table_name|view_name}]
{column_list|variable_list|variable_and_column_list}
[,{column_list2|variable_list2|variable_and_column_list2}��
[,{column_listN|variable_listN|variable_and_column_listN}]]
[WHERE clause] ע��
����Զ��ı����ֶ�ʹ��UPDATE��䡣���ǣ��������Ҫ���ºܳ����ַ�����Ӧʹ��UPDATETEXT��䡣�ⲿ�����ݶԱ�����˵̫�߼��ˣ���˲������ۡ�Ҫ�˽�������Ϣ����ο�Microsoft SQL Sever ���ĵ���
����㲻�ṩWHERE�Ӿ䣬���е����м�¼���������¡���ʱ�������õġ����磬�������ѱ�titles�е�������ļ۸�ӱ��������ʹ�����µ�UPDATE ��䣺
��Ҳ����ͬʱ���¶���ֶΡ����磬�����UPDATE���ͬʱ����first_column,second_column,��third_column�������ֶΣ�
 ����:UPDATE mytable SET first_column=��Updated!��
Second_column=��Updated!��
Third_column=��Updated!��
WHERE first_column=��Update Me1�� ����
SQL��������ж���Ŀո�����԰�SQL���д���κ��������׶��ĸ�ʽ��
��SELECT ������¼�ͱ�
��Ҳ���Ѿ�ע�⵽��INSERT �����DELETE����UPDATE�����һ�㲻ͬ����һ��ֻ����һ����¼��Ȼ������һ����������ʹINSERT ���һ����Ӷ����¼��Ҫ������һ�㣬����Ҫ��INSERT �����SELECT �������������������
 ����:INSERT mytable (first_column,second_column)
SELECT another_first,another_second
FROM anothertable
WHERE another_first=��Copy Me!�� �������anothertable������¼��mytable.ֻ�б�anothertable���ֶ�another_first��ֵΪ��Copy Me�����ļ�¼�ű�������
��Ϊһ�����еļ�¼��������ʱ��������ʽ��INSERT ����Ƿǳ����õġ���ɾ��һ�����еļ�¼֮ǰ��������������ַ��������ǿ�������һ�����С�
�������Ҫ���������������ʹ��SELECT INTO ��䡣���磬�������䴴����һ����Ϊnewtable���±��ñ������mytable���������ݣ�
 ����:SELECT * INTO newtable FROM mytable ��Ҳ����ָ��ֻ���ض����ֶα�������������±�Ҫ������һ�㣬ֻ�����ֶ��б���ָ������Ҫ�������ֶΡ����⣬�����ʹ��WHERE �Ӿ������ƿ������±��еļ�¼�����������ֻ�����ֶ�second_columnd��ֵ���ڡ�Copy Me!���ļ�¼��first_column�ֶΡ�
 ����:SELECT first_column INTO newtable
FROM mytable
WHERE second_column=��Copy Me!�� ʹ��SQL�޸��Ѿ������ı��Ǻ����ѵġ����磬�������һ�����������һ���ֶΣ�û�����׵İ취��ȥ���������⣬����㲻С�İ�һ���ֶε��������͸����ˣ��㽫û�а취�ı��������ǣ�ʹ�ñ����н�����SQL��䣬������ƹ����������⡣
���磬���������һ������ɾ��һ���ֶΡ�ʹ��SELECT INTO ��䣬����Դ����ñ��һ����������������Ҫɾ�����ֶΡ���ʹ���ɾ���˸��ֶΣ��ֱ����˲���ɾ�������ݡ�
�������ı�һ���ֶε��������ͣ�����Դ���һ��������ȷ���������ֶε��±������øñ����Ϳ��Խ��ʹ��UPDATE����SELECT ��䣬��ԭ�����е��������ݿ������±��С�ͨ�����ַ�������ȿ����޸ı�Ľṹ�����ܱ���ԭ�е����ݡ�
_ArticleContent1_lblContent>��������
��������һ���¼�¼����Ҫʹ��SQL INSERT ��䡣������һ�����ʹ�������������ӣ�
 ����:INSERT mytable (mycolumn) VALUES (��some data��) ��������ַ�����some data�������mytable��mycolumn�ֶ��С���Ҫ���������ݵ��ֶε������ڵ�һ��������ָ����ʵ�ʵ������ڵڶ��������и�����
INSERT ���������䷨���£�
 ����:INSERT [INTO] {table_name|view_name} [(column_list)] {DEFAULT VALUES | Values_list | select_statement} ���һ�����ж���ֶΣ�ͨ�����ֶ������ֶ�ֵ�ö��Ÿ���������������е��ֶ��в������ݡ������mytable�������ֶ�first_column,second_column,��third_column�������INSERT��������һ�������ֶζ���ֵ��������¼��
����:INSERT mytable (first_column,second_column,third_column) VALUES (��some data��,��some more data��,��yet more data��)
[code]
ע��
�����ʹ��INSERT������ı����ֶ��в������ݡ����ǣ��������Ҫ����ܳ����ַ�������Ӧ��ʹ��WRITETEXT��䡣�ⲿ�����ݶԱ�����˵̫�߼��ˣ���˲������ۡ�Ҫ�˽�������Ϣ����ο�Microsoft SQL Sever ���ĵ���
�������INSERT �����ָֻ�������ֶκ����ݻ���ô���أ����仰˵������һ�����в���һ���¼�¼������һ���ֶ�û���ṩ���ݡ�����������£�����������ֿ��ܣ�
������ֶ���һ��ȱʡֵ����ֵ�ᱻʹ�á����磬����������¼�¼ʱû�и��ֶ�third_column�ṩ���ݣ�������ֶ���һ��ȱʡֵ��some value��������������£����¼�¼����ʱ�����ֵ��some value����
������ֶο��Խ��ܿ�ֵ������û��ȱʡֵ����ᱻ�����ֵ��
������ֶβ��ܽ��ܿ�ֵ������û��ȱʡֵ���ͻ���ִ�������յ�������Ϣ��
The column in table mytable may not be null.
���������ֶ���һ����ʶ�ֶΣ���ô�����Զ�����һ����ֵ��������һ���б�ʶ�ֶεı��в����¼�¼ʱ��ֻҪ���Ը��ֶΣ���ʶ�ֶλ���Լ���һ����ֵ��
ע��
��һ���б�ʶ�ֶεı��в����¼�¼���������SQL����@@identity�������¼�¼
�ı�ʶ�ֶε�ֵ���������µ�SQL��䣺
[code]INSERT mytable (first_column) VALUES(��some value��) 
 ����:INSERT anothertable(another_first,another_second) VALUES(@@identity,��some value��) �����mytable��һ����ʶ�ֶΣ����ֶε�ֵ�ᱻ�����anothertable��another_first�ֶΡ�������Ϊ����@@identity���Ǳ������һ�β����ʶ�ֶε�ֵ��
�ֶ�another_firstӦ�����ֶ�first_column����ͬ���������͡����ǣ��ֶ�another_first������Ӧ�ñ�ʶ�ֶΡ�Another_first�ֶ����������ֶ�first_column��ֵ��
ɾ����¼
Ҫ�ӱ���ɾ��һ��������¼����Ҫʹ��SQL DELETE��䡣����Ը�DELETE ����ṩWHERE �Ӿ䡣WHERE�Ӿ�����ѡ��Ҫɾ���ļ�¼�����磬��������DELETE���ֻɾ���ֶ�first_column��ֵ���ڡ�Delete Me���ļ�¼��
 ����:DELETE mytable WHERE first_column=��Deltet Me�� DELETE ���������䷨���£�
 ����:DELETE [FROM] {table_name|view_name} [WHERE clause] ��SQL SELECT ����п���ʹ�õ��κ�������������DELECT ����WHERE�Ӿ� ��ʹ�á����磬��������DELETE���ֻɾ����Щfirst_column�ֶε�ֵΪ��goodbye����second_column�ֶε�ֵΪ��so long���ļ�¼��
 ����:DELETE mytable WHERE first_column=��goodby�� OR second_column=��so long�� ����㲻��DELETE ����ṩWHERE �Ӿ䣬���е����м�¼������ɾ�����㲻Ӧ���������뷨���������ɾ��Ӧ�ñ��е����м�¼��Ӧʹ�õ�ʮ��������TRUNCATE TABLE��䡣
ע��
ΪʲôҪ��TRUNCATE TABLE ������DELETE��䣿����ʹ��TRUNCATE TABLE���ʱ����¼��ɾ���ǲ�����¼�ġ�Ҳ����˵������ζ��TRUNCATE TABLE Ҫ��DELETE��öࡣ
���¼�¼
Ҫ�޸ı����Ѿ����ڵ�һ���������¼��Ӧʹ��SQL UPDATE��䡣ͬDELETE���һ����UPDATE������ʹ��WHERE�Ӿ���ѡ������ض��ļ�¼���뿴������ӣ�
 ����:UPDATE mytable SET first_column=��Updated!�� WHERE second_column=��Update Me!�� ���UPDATE ����������second_column�ֶε�ֵΪ��Update Me!���ļ�¼�������б�ѡ�еļ�¼���ֶ�first_column��ֵ����Ϊ��Updated!����
������UPDATE���������䷨��
 ����:UPDATE {table_name|view_name} SET [{table_name|view_name}]
{column_list|variable_list|variable_and_column_list}
[,{column_list2|variable_list2|variable_and_column_list2}��
[,{column_listN|variable_listN|variable_and_column_listN}]]
[WHERE clause] ע��
����Զ��ı����ֶ�ʹ��UPDATE��䡣���ǣ��������Ҫ���ºܳ����ַ�����Ӧʹ��UPDATETEXT��䡣�ⲿ�����ݶԱ�����˵̫�߼��ˣ���˲������ۡ�Ҫ�˽�������Ϣ����ο�Microsoft SQL Sever ���ĵ���
����㲻�ṩWHERE�Ӿ䣬���е����м�¼���������¡���ʱ�������õġ����磬�������ѱ�titles�е�������ļ۸�ӱ��������ʹ�����µ�UPDATE ��䣺
��Ҳ����ͬʱ���¶���ֶΡ����磬�����UPDATE���ͬʱ����first_column,second_column,��third_column�������ֶΣ�
 ����:UPDATE mytable SET first_column=��Updated!��
Second_column=��Updated!��
Third_column=��Updated!��
WHERE first_column=��Update Me1�� ����
SQL��������ж���Ŀո�����԰�SQL���д���κ��������׶��ĸ�ʽ��
��SELECT ������¼�ͱ�
��Ҳ���Ѿ�ע�⵽��INSERT �����DELETE����UPDATE�����һ�㲻ͬ����һ��ֻ����һ����¼��Ȼ������һ����������ʹINSERT ���һ����Ӷ����¼��Ҫ������һ�㣬����Ҫ��INSERT �����SELECT �������������������
 ����:INSERT mytable (first_column,second_column)
SELECT another_first,another_second
FROM anothertable
WHERE another_first=��Copy Me!�� �������anothertable������¼��mytable.ֻ�б�anothertable���ֶ�another_first��ֵΪ��Copy Me�����ļ�¼�ű�������
��Ϊһ�����еļ�¼��������ʱ��������ʽ��INSERT ����Ƿǳ����õġ���ɾ��һ�����еļ�¼֮ǰ��������������ַ��������ǿ�������һ�����С�
�������Ҫ���������������ʹ��SELECT INTO ��䡣���磬�������䴴����һ����Ϊnewtable���±��ñ������mytable���������ݣ�
 ����:SELECT * INTO newtable FROM mytable ��Ҳ����ָ��ֻ���ض����ֶα�������������±�Ҫ������һ�㣬ֻ�����ֶ��б���ָ������Ҫ�������ֶΡ����⣬�����ʹ��WHERE �Ӿ������ƿ������±��еļ�¼�����������ֻ�����ֶ�second_columnd��ֵ���ڡ�Copy Me!���ļ�¼��first_column�ֶΡ�
 ����:SELECT first_column INTO newtable
FROM mytable
WHERE second_column=��Copy Me!�� ʹ��SQL�޸��Ѿ������ı��Ǻ����ѵġ����磬�������һ�����������һ���ֶΣ�û�����׵İ취��ȥ���������⣬����㲻С�İ�һ���ֶε��������͸����ˣ��㽫û�а취�ı��������ǣ�ʹ�ñ����н�����SQL��䣬������ƹ����������⡣
���磬���������һ������ɾ��һ���ֶΡ�ʹ��SELECT INTO ��䣬����Դ����ñ��һ����������������Ҫɾ�����ֶΡ���ʹ���ɾ���˸��ֶΣ��ֱ����˲���ɾ�������ݡ�
�������ı�һ���ֶε��������ͣ�����Դ���һ��������ȷ���������ֶε��±������øñ����Ϳ��Խ��ʹ��UPDATE����SELECT ��䣬��ԭ�����е��������ݿ������±��С�ͨ�����ַ�������ȿ����޸ı�Ľṹ�����ܱ���ԭ�е����ݡ�
 
SQL�﷨,SQL����ȫ,SQL����
�ӣѣ� �﷨�ο��ֲ�(SQL)/��������
2006-07-24 07:42 
���ӣѣ� �﷨�ο��ֲ�(SQL)��
DB2 �ṩ�˹���ʽ���Ͽ�Ĳ�ѯ���� �ӣѣ� (Structured Query Language)����һ�ַǳ����ﻯ������ѧ���׶����﷨����һ���Լ�����ÿ�����Ͽ�ϵͳ�������ṩ�ģ����Ա�ʾ����ʽ��*�������������ϵĶ��壨�ģģ̣��Լ����ϵĴ����ģ̣ͣ���SQLԭ��ƴ��SEQUEL�������Ե�ԭ���ԡ�ϵͳ R���������� IBM ʥ����ʵ������ɣ�����IBM�ڲ������������ʹ���Լ�Ч�ʲ��ԣ������൱�������⣬��������ϵͳR �ļ���������չ���� IBM �Ĳ�Ʒ�������������ұ�׼ѧ�ᣨANSI�������ʱ�׼����֯��ISO����1987��ѭһ���������� IBM SQL Ϊ�����ı�׼����ʽ�������Զ��塣  
һ�����϶��� �ģģ̣�Data Definition Language)  
���϶�������ָ�����ϵĸ�ʽ����̬�¶�������ԣ�����ÿ�����Ͽ�Ҫ����ʱ��ʱ����Ҫ��Եģ��ٷ����Ϸ���Щ����ϵ������ڵ���ʲ����λ���������ͱ��֮�以��ο��Ĺ�ϵ�ȵȣ������ڿ�ʼ��ʱ��������滮�õġ�  
���������  
Create TABLE table_name(  
column1 DATATYPE [NOT NULL] [NOT NULL PRIMARY KEY],  
column2 DATATYPE [NOT NULL],  
...��  
˵������  
DATATYPE --�����ϵĸ�ʽ�������  
NUT NULL --�ɲ��������������пյģ���δ���������룩��  
PRIMARY KEY --�Ǳ����������  
�������ı��  
Alter TABLE table_name  
ADD COLUMN column_name DATATYPE  
˵��������һ����λ��û��ɾ��ĳ����λ���﷨��  
Alter TABLE table_name  
ADD PRIMARY KEY (column_name)  
˵�������ı�õĶ����ĳ����λ��Ϊ������  
Alter TABLE table_name  
Drop PRIMARY KEY (column_name)  
˵�����������Ķ���ɾ����  
��������������  
Create INDEX index_name ON table_name (column_name)  
˵������ĳ��������λ�������������Ӳ�ѯʱ���ٶȡ�  
����ɾ����  
Drop table_name  
Drop index_name  
������������̬ DATATYPEs  
smallint  
16 λԪ��������  
interger  
32 λԪ��������  
decimal(p,s)  
p ��ȷֵ�� s ��С��ʮ��λ��������ȷֵp��ָȫ���м�����(digits)��Сֵ��s��ָС��  
�����м�λ�������û���ر�ָ������ϵͳ����Ϊ p=5; s=0 ��  
float  
32λԪ��ʵ����  
double  
64λԪ��ʵ����  
char(n)  
n ���ȵ��ִ���n���ܳ��� 254��  
varchar(n)  
���Ȳ��̶�������󳤶�Ϊ n ���ִ���n���ܳ��� 4000��  
graphic(n)  
�� char(n) һ���������䵥λ��������Ԫ double-bytes�� n���ܳ���127�������̬��Ϊ  
��֧Ԯ������Ԫ���ȵ����壬���������֡�  
vargraphic(n)  
�ɱ䳤��������󳤶�Ϊ n ��˫��Ԫ�ִ���n���ܳ��� 2000��  
date  
������ ��ݡ��·ݡ����ڡ�  
time  
������ Сʱ�����ӡ��롣  
timestamp  
������ �ꡢ�¡��ա�ʱ���֡��롢ǧ��֮һ�롣  
��������*�� �ģͣ� ��Data Manipulation Language)  
���϶����֮��������ľ������ϵ�*�������ϵ�*��������������ϣ�insert)����ѯ���ϣ�query�����������ϣ�update) ��ɾ�����ϣ�delete������ģʽ�����·� ��������ǵ��﷨��  
�����������ϣ�  
Insert INTO table_name (column1,column2,...)  
valueS ( value1,value2, ...)  
˵����  
1.��û��ָ��column ϵͳ��ᰴ����ڵ���λ˳���������ϡ�  
2.��λ��������̬������������ϱ����Ǻϡ�  
3.table_name Ҳ�����Ǿ��� view_name��  
Insert INTO table_name (column1,column2,...)  
Select columnx,columny,... FROM another_table  
˵����Ҳ���Ծ���һ���Ӳ�ѯ��subquery���ѱ�ı����������롣  
������ѯ���ϣ�  
������ѯ  
Select column1,columns2,...  
FROM table_name  
˵������table_name ���ض���λ����ȫ���г���  
Select *  
FROM table_name  
Where column1 = xxx  
[AND column2 �� yyy] [OR column3 ���� zzz]  
˵����  
1.��*����ʾȫ������λ���г�����  
2.Where ֮���ǽ�����ʽ���ѷ��������������г�����  
Select column1,column2  
FROM table_name  
orDER BY column2 [DESC]  
˵����ORDER BY ��ָ����ĳ����λ������[DESC]��ָ�Ӵ�С���У���û��ָ�������Ǵ�С����  
����  
��ϲ�ѯ  
��ϲ�ѯ��ָ����ѯ��������Դ����ֻ�е�һ�ı�񣬶�������һ�����ϵ�  
�����ܹ��õ�����ġ�  
Select *  
FROM table1,table2  
Where table1.colum1=table2.column1  
˵����  
1.��ѯ������������� column1 ֵ��ͬ�����ϡ�  
2.��Ȼ��������໥�Ƚϵ���λ����������̬������ͬ��  
3.һ�����ӵĲ�ѯ�䶯�õ��ı����ܻ�ܶ����  
�����ԵĲ�ѯ��  
Select COUNT (*)  
FROM table_name  
Where column_name = xxx  
˵����  
��ѯ�������������Ϲ��м��ʡ�  
Select SUM(column1)  
FROM table_name  
˵����  
1.������ܺͣ���ѡ����λ�����ǿ�����������̬��  
2.�������⻹�� AVG() �Ǽ���ƽ����MAX()��MIN()���������Сֵ�������Բ�ѯ��  
Select column1,AVG(column2)  
FROM table_name  
GROUP BY column1  
HAVING AVG(column2) �� xxx  
˵����  
1.GROUP BY: ��column1 Ϊһ����� column2 ��ƽ��ֵ����� AVG��SUM�������Բ�ѯ�Ĺؼ���  
һ��ʹ�á�  
2.HAVING : ����� GROUP BY һ��ʹ����Ϊ�����Ե����ơ�  
�����ԵĲ�ѯ  
Select *  
FROM table_name1  
Where EXISTS (  
Select *  
FROM table_name2  
Where conditions )  
˵����  
1.Where �� conditions ����������һ���� query��  
2.EXISTS �ڴ���ָ�������  
Select *  
FROM table_name1  
Where column1 IN (  
Select column1  
FROM table_name2  
Where conditions )  
˵������  
1. IN ����ӵ���һ�����ϣ���ʾcolumn1 ���ڼ������档  
2. Select ������������̬������� column1��  
������ѯ  
Select *  
FROM table_name1  
Where column1 LIKE ��x%��  
˵����LIKE ���������ġ�x%�� ���Ӧ��ʾ�� xΪ��ͷ���ִ���  
Select *  
FROM table_name1  
Where column1 IN (��xxx��,��yyy��,..)  
˵����IN ����ӵ���һ�����ϣ���ʾcolumn1 ���ڼ������档  
Select *  
FROM table_name1  
Where column1 BETWEEN xx AND yy  
˵����BETWEEN ��ʾ column1 ��ֵ��� xx �� yy ֮�䡣  
�����������ϣ�  
Update table_name  
SET column1=��xxx��  
Where conditoins  
˵����  
1.����ĳ����λ�趨��ֵΪ��xxx����  
2.conditions ����Ҫ���ϵ���������û�� Where ������ table ���Ǹ���λ����ȫ�������ġ�  
����ɾ�����ϣ�  
Delete FROM table_name  
Where conditions  
˵����ɾ���������������ϡ�  
˵��������Where��������������������ڵıȽϣ���ͬ���ݿ��в�ͬ�ı��ʽ���������£�  
(1)�����ACCESS���ݿ⣬��Ϊ��Where mydate��#2000-01-01#  
(2)�����ORACLE���ݿ⣬��Ϊ��Where mydate��cast(��2000-01-01�� as date)  
��Where mydate��to_date(��2000-01-01��,��yyyy-mm-dd��)  
��Delphi��д�ɣ�  
thedate=��2000-01-01��;  
query1.SQL.add(��select * from abc where mydate��cast(��+��������+thedate+��������+�� as date)��);  
����Ƚ�����ʱ���ͣ���Ϊ��  
Where mydatetime��to_date(��2000-01-01 10:00:01��,��yyyy-mm-dd hh24:mi:ss��)
Recordset����һЩ���õ�����"/�� �������� ����һ�� ��Recordset����һЩ���õ�����
rs.CursorType=
rs.CursorLocation=
rs.LockType =  
rs.CacheSize=
rs.Pagesize=
rs.Pagecount=
rs.RecordCount=
����---- CursorType Values ----
Const adOpenForwardOnly = 0 ����ǰ
Const adOpenKeyset = 1 �����α�
Const adOpenDynamic = 2 ��̬�α�
Const adOpenStatic = 3 ��̬�α�
����---- LockType Values ----
Const adLockReadOnly = 1 Ĭ��ֵ��ֻ��
Const adLockPessimistic = 2 ����ʽ��¼����  
Const adLockOptimistic = 3 ����ʽ��¼������ֻ�ڵ���Update����ʱ������¼
Const adLockBatchOptimistic = 4 ����ʽ������
����---- CursorLocation Values ----
Const adUseServer = 2
Const adUseClient = 3  
Set rs=Server.CreateObject("ADODB.Rrecordset")  
rs.Open.sqlst,conn,1,1 ����ȡ  
rs.Open sqlst,conn,1,2 ���������޸ģ���ɾ���� 
��һҳ ����SQL SERVER���������͡� 
������---------�����ҳ��--��ô�������£�������������ҳ��ð�������----------������ 
��SQL SERVER���������͡�
1.SQL SERVER����������  
����������Ū�����ݵ�һ�����ԣ���ʾ��������ʾ��Ϣ�����͡��κ�һ�ּ�������Զ��������Լ����������͡���Ȼ����ͬ�ĳ������Զ����в�ͬ���ص㣬��������������͵ĸ�������ƶ���������Щ��ͬ��SQLServer �ṩ�� 25 ���������ͣ� 
������Binary [(n)] 
������Varbinary [(n)] 
������Char [(n)] 
������Varchar[(n)] 
������Nchar[(n)] 
������Nvarchar[(n)] 
������Datetime 
������Smalldatetime 
������Decimal[(p[,s])] 
������Numeric[(p[,s])] 
������Float[(n)] 
������Real 
������Int 
������Smallint 
������Tinyint 
������Money 
������Smallmoney 
������Bit 
������Cursor 
������Sysname 
������Timestamp 
������Uniqueidentifier 
������Text 
������Image 
������Ntext  
(1)��������������  
�������������ݰ��� Binary��Varbinary �� Image 
����Binary �������ͼȿ����ǹ̶����ȵ�(Binary),Ҳ�����Ǳ䳤�ȵġ� 
����Binary[(n)] �� n λ�̶��Ķ��������ݡ����У�n ��ȡֵ��Χ�Ǵ� 1 �� 8000����洢�Ĵ�С�� n + 4 ���ֽڡ� 
����Varbinary[(n)] �� n λ�䳤�ȵĶ��������ݡ����У�n ��ȡֵ��Χ�Ǵ� 1 �� 8000����洢�Ĵ�С�� n + 4���ֽڣ�����n ���ֽڡ� 
������ Image ���������д洢����������λ�ַ����洢�ģ������� SQL Server ���͵ģ�������Ӧ�ó��������͡����磬Ӧ�ó������ʹ��BMP��TIEF��GIF �� JPEG ��ʽ�����ݴ洢�� Image ���������С�  
(2)�ַ���������  
�����ַ����ݵ����Ͱ��� Char��Varchar �� Text 
�����ַ����������κ���ĸ�����ź�����������϶��ɵ����ݡ� 
����Varchar �Ǳ䳤�ַ����ݣ��䳤�Ȳ����� 8KB��Char �Ƕ����ַ����ݣ��䳤�����Ϊ 8KB������ 8KB ��ASCII ���ݿ���ʹ��Text�������ʹ洢�����磬��Ϊ Html �ĵ�ȫ������ ASCII �ַ���������һ������³��ȳ��� 8KB��������Щ�ĵ����� Text �������ʹ洢��SQL Server �С�  
(3)Unicode ��������  
����Unicode �������Ͱ��� Nchar,Nvarchar ��Ntext 
������ Microsoft SQL Server �У���ͳ�ķ� Unicode ������������ʹ�����ض��ַ���������ַ����� SQL Server��װ�����У�����ѡ��һ���ַ�����ʹ�� Unicode �������ͣ����п��Դ洢�κ���Unicode ��׼������ַ����� Unicode ��׼�У��������Ը����ַ��������ȫ���ַ���ʹ��Unicode�������ͣ���սʤ�����ʹ�÷� Unicode ����������ռ�õ���С��������  
������ SQL Server �У�Unicode ������ Nchar��Nvarchar �� Ntext �������ʹ洢��ʹ�������ַ����ʹ洢���п��Դ洢����ַ����е��ַ������еĳ��ȱ仯ʱ��Ӧ��ʹ��Nvarchar �ַ����ͣ���ʱ�����Դ洢 4000 ���ַ������еĳ��ȹ̶�����ʱ��Ӧ��ʹ�� Nchar �ַ����ͣ�ͬ������ʱ�����Դ洢4000 ���ַ�����ʹ�� Ntext ��������ʱ�����п��Դ洢���� 4000 ���ַ���  
(4)���ں�ʱ����������  
�������ں�ʱ���������Ͱ��� Datetime �� Smalldatetime�������� 
�������ں�ʱ��������������Ч�����ں�ʱ����ɡ����磬��Ч�����ں�ʱ�����ݰ�����4/01/98 12:15:00:00:00 PM���͡�1:28:29:15:01AM 8/17/98����ǰһ������������������ǰ��ʱ���ں�һ��������������ʱ����ǰ�������ں��� Microsoft SQL Server�У����ں�ʱ���������Ͱ���Datetime �� Smalldatetime ��������ʱ�����洢�����ڷ�Χ�Ǵ� 1753 �� 1 �� 1 �տ�ʼ����9999 ��12 �� 31 �ս���(ÿһ��ֵҪ�� 8 ���洢�ֽ�)��ʹ�� Smalldatetime ��������ʱ�����洢�����ڷ�Χ�� 1900�� 1 �� 1�� ��ʼ���� 2079 �� 12 �� 31 �ս���(ÿһ��ֵҪ�� 4 ���洢�ֽ�)�� 
�������ڵĸ�ʽ�����趨���������ڸ�ʽ���������£� 
����Set DateFormat {format | @format _var| 
�������У�format | @format_var �����ڵ�˳����Ч�Ĳ������� MDY��DMY��YMD��YDM��MYD �� DYM����Ĭ������£����ڸ�ʽΪMDY�� 
�������磬��ִ�� Set DateFormat YMD ֮�����ڵĸ�ʽΪ�� �� �� ��ʽ����ִ�� Set DateFormat DMY ֮�����ڵĸ�ʽΪ�� ������ ��ʽ  
��5��������������  
������������ֻ�������֡������������Ͱ��������͸�����С������������������ 
�����������������͸�������ɣ����� 39��25��0-2 �� 33967���� Micrsoft SQL Server �У������洢������������ ���� Int��Smallint�� Tinyint��Int �������ʹ洢���ݵķ�Χ���� Smallint �������ʹ洢���ݵķ�Χ���� Smallint �����ʹ洢���ݵķ�Χ����Tinyint �������ʹ洢���ݵķ�Χ��ʹ�� Int ���ݹ����洢���ݵķ�Χ�Ǵ� -2 147 483 648 �� 2 147 483 647��ÿһ��ֵҪ��4���ֽڴ洢�ռ䣩��ʹ�� Smallint ��������ʱ���洢���ݵķ�Χ�� -32 768 �� 32 767��ÿһ��ֵҪ��2���ֽڴ洢�ռ䣩��ʹ��Tinyint ��������ʱ���洢���ݵķ�Χ�Ǵ�0 ��255��ÿһ��ֵҪ��1���ֽڴ洢�ռ䣩�� 
������ȷС¦������ SQL Server �е����������� Decimal �� Numeric������������ռ�Ĵ洢�ռ���ݸ����ݵ�λ�����λ����ȷ���� 
������SQL Server �У�����С�����ݵ����������� Float �� Real�����磬����֮һ�������������3333333����ʹ�ý�����������ʱ��׼ȷ��ʾ����ˣ���ϵͳ�м����������ݿ�����洢�ڸ��������ݲ���ȫһ����  
��6���������ݱ�ʾ���Ļ��߸��Ļ������� ��  
������ Microsoft SQL Server �У��������ݵ�����������Money �� Smallmoney  
����Money��������Ҫ�� 8 ���洢�ֽڣ�Smallmoney ��������Ҫ�� 4 ���洢�ֽڡ�  
��7��������������  
���������������Ͱ���ǰ��û��������������͡����������������3�֣��� ���� Timestamp��Bit �� Uniqueidentifier�� 
����Timestamp ���ڱ�ʾSQL Server ����Ⱥ�˳���Զ���ͶӰ�ĸ�ʽ��ʾ��Timestamp ������������ݻ������ں�ʱ��û�й�ϵ�� 
����Bit �� 1 ���� 0 ��ɡ�����ʾ����߼١�ON ���� OFF ʱ��ʹ�� Bit �������͡����磬ѯ���Ƿ���ÿһ�η��ʵĿͻ���������Դ洢�������������͵����С� 
����Uniqueidentifier �� 16 �ֽڵ�ʮ������������ɣ���ʾһ��ȫ��Ψһ�ġ�����ļ�¼��Ҫ��Ψһʱ��GUID�Ƿǳ����á����磬�ڿͻ���ʶ����ʹ�������������Ϳ�������ͬ�Ŀͻ���  
2.�û��������������  
�����û�������������ͻ����� Microsoft SQL Server ���ṩ���������͡����������б���洢ͬһ����������ʱ������Ϊ��֤��Щ������ͬ���������͡����ȺͿɿ���ʱ������ʹ���û�������������͡����磬�ɶ���һ�ֳ�Ϊ ����postal_code ���������ͣ������� Char �������͡� 
�����������û��������������ʱ�������ṩ���������������͵����ơ������ڵ�ϵͳ�������ͺ��������͵Ŀɿ��ԡ�  
��1�������û��������������  
���������û�������������Ϳ���ʹ�� Transact-SQL ��䡣ϵͳ�洢���� sp_addtype �����������û�������������͡����﷨��ʽ���£� 
����sp_addtype {type},[,system_data_bype][,��null_type��] 
�������У�type ���û�������������͵����ơ�system_data_type ��ϵͳ�ṩ���������ͣ����� Decimal��Int��Char �����ȵȡ� null_type ��ʾ��������������δ����ֵ�ģ�����ʹ�õ����������������硯NULL������NOT NULL�����ߡ�NONULL���� 
�������ӣ� 
����Use cust 
����Exec sp_addtype ssn,��Varchar(11)��,"Not Null�� 
��������һ���û�������������� ssn������ڵ�ϵͳ���������Ǳ䳤Ϊ11 ���ַ���������ա� 
�������ӣ� 
����Use cust 
����Exec sp_addtype birthday,datetime,��Null�� 
��������һ���û�������������� birthday������ڵ�ϵͳ���������� DateTime������ա� 
�������ӣ� 
����Use master 
����Exec sp_addtype telephone,��varchar(24),��Not Null�� 
����Eexc sp_addtype fax,��varchar(24)��,��Null�� 
�������������������ͣ��� telephone �� fax  
��2��ɾ���û��������������  
�������û�������������Ͳ���Ҫʱ����ɾ����ɾ���û�������������͵������� sp_droptype {��type��}�� 
�������ӣ� 
����Use master 
����Exec sp_droptype ��ssn�� 
����ע�⣺�����е��л�����ʹ���û��������������ʱ�������������滹����Ĭ�ϻ��߹���ʱ�������û�������������Ͳ���ɾ����  
��������ΪSQL SERVER7.0���ϰ汾���ֶ�����˵����SQL SERVER6.5���ֶ�����˵����ο�SQL SERVER�ṩ��˵���� 
�ֶ����� ����  
bit 0��1����������  
int ��-2^31(-2,147,483,648)��2^31(2,147,483,647)����������  
smallint ��-2^15(-32,768)��2^15(32,767)����������  
tinyint ��0��255����������  
decimal ��-10^38��10^38-1�Ķ���������Чλ��������  
numeric decimal��ͬ���  
money ��-2^63(-922,337,203,685,477.5808)��2^63-1(922,337,203,685,477.5807)�Ļ������ݣ���С���ҵ�λǧ��֮ʮ  
smallmoney ��-214,748.3648��214,748.3647�Ļ������ݣ���С���ҵ�λǧ��֮ʮ  
float ��-1.79E+308��1.79E+308�ɱ侫�ȵ�����  
real ��-3.04E+38��3.04E+38�ɱ侫�ȵ�����  
datetime ��1753��1��1�յ�9999��12��31�����ں�ʱ�����ݣ���Сʱ�䵥λΪ�ٷ�֮�����3.33����  
smalldatetime ��1900��1��1�յ�2079��6��6�յ����ں�ʱ�����ݣ���Сʱ�䵥λΪ����  
timestamp ʱ�����һ�����ݿ��ȵ�Ψһ����  
uniqueidentifier ȫ��Ψһ��ʶ��GUID  
char ������Unicode���ַ������ݣ���󳤶�Ϊ8000  
varchar �䳤��Unicode���ַ������ݣ���󳤶�Ϊ8000  
text �䳤��Unicode���ַ������ݣ���󳤶�Ϊ2^31-1(2G)  
nchar ����Unicode���ַ������ݣ���󳤶�Ϊ8000  
nvarchar �䳤Unicode���ַ������ݣ���󳤶�Ϊ8000  
ntext �䳤Unicode���ַ������ݣ���󳤶�Ϊ2^31-1(2G)  
binary �������������ݣ���󳤶�Ϊ8000  
varbinary �䳤���������ݣ���󳤶�Ϊ8000  
image �䳤���������ݣ���󳤶�Ϊ2^31-1(2G)  
������---------�����ҳ��--��ô�������£�������������ҳ��ð�������----------������ 
��SQL���Ļ����﷨�� 
һ.Select���������﷨Ϊ��
Select[ALL|DISTINCT|DISTINCTROW|TOP]
{*|talbe.*|[table.]field1[AS alias1][,[table.]field2[AS alias2][,��]]}
FROM tableexpression[,��][IN externaldatabase]
[Where��]
[GROUP BY��]
[HAVING��]
[ORDER BY��]
[WITH OWNERACCESS OPTION] 
˵���� 
��������([])�������Ĳ��ֱ�ʾ�ǿ�ѡ�ģ��ô�����({})�������Ĳ����Ǳ�ʾ�������ѡ�����е�һ����
1 FROM�Ӿ�
FROM�Ӿ�ָ����Select������ֶε���Դ��FROM�Ӿ�����ǰ���һ�������ı��ʽ(�ɶ��ŷֿ�)�����еı��ʽ��Ϊ��һ�����ơ��ѱ���Ĳ�ѯ���� INNER JOIN��LEFT JOIN �� RIGHT JOIN �õ��ĸ��Ͻ�����������ѯ�洢���ⲿ���ݿ⣬��IN �Ӿ�֮��ָ��������·���� 
��������SQL��䷵�������ж����Ŀͻ���
Select orderID,Customer.customerID
FROM orders Customers
Where orders.CustomerID=Customers.CustomeersID
2 ALL��DISTINCT��DISTINCTROW��TOPν��
(1) ALL ��������SQL������������м�¼�����û��ָ�����ν�ʣ�Ĭ��ΪALL�� 
����Select ALL FirstName,LastName
FROM Employees
(2) DISTINCT ����ж����¼��ѡ���ֶε�������ͬ��ֻ����һ����
(3) DISTINCTROW ������ظ��ļ�¼��ֻ����һ��
(4) TOP��ʾ��ѯͷβ���ɼ�¼��Ҳ�ɷ��ؼ�¼�İٷֱȣ�����Ҫ�� TOP N PERCENT�Ӿ䣨����N ��ʾ�ٷֱȣ� 
��������5%���������Ķ���
Select TOP 5 PERCENT*
FROM [ order Details]
orDER BY UnitPrice*Quantity*(1-Discount) DESC
3 �� AS �Ӿ�Ϊ�ֶ�ȡ���� 
�����Ϊ���ص���ȡһ���µı��⣬���ߣ��������ֶεļ�����ܽ�֮�󣬲�����һ���µ�ֵ��ϣ�������ŵ�һ���µ�������ʾ������AS������ 
��������FirstName�ֶ�ȡ����ΪNickName
Select FirstName AS NickName ,LastName ,City
FROM Employees 
���������µ�һ����ʾ����ֵ
Select ProductName ,UnitPrice ,UnitsInStock ,UnitPrice*UnitsInStock AS valueInStock
FROM Products 
�� .Where �Ӿ�ָ����ѯ����
1 �Ƚ������ 
�Ƚ������ ����
= ���� 
�� ���� 
�� С�� 
��= ���ڵ��� 
��= С�ڵ��� 
���� ������
!�� ������
!�� ��С�� 
��������96��1�µĶ���
Select orderID, CustomerID, orderDate
FROM orders
Where orderDate��#1/1/96# AND orderDate��#1/30/96# 
ע�⣺
Mcirosoft JET SQL �У������á�#�����硣����Ҳ������Datevalue()���������档�ڱȽ��ַ��͵�����ʱ��Ҫ���ϵ����š�����β�ո��ڱȽ��б����ԡ� 
����
Where orderDate��#96-1-1# 
Ҳ���Ա�ʾΪ��
Where orderDate��Datevalue(��1/1/96��) 
ʹ�� NOT ���ʽ�󷴡� 
�����鿴96��1��1���Ժ�Ķ���
Where Not orderDate��=#1/1/96#
2 ��Χ��BETWEEN �� NOT BETWEEN��
BETWEEN ��AND�������ָ����Ҫ������һ�������䡣 
��������96��1�µ�96��2�µĶ�����
Where orderDate Between #1/1/96# And #2/1/96#
3 �б�IN ��NOT IN��
IN ���������ƥ���б��е��κ�һ��ֵ��IN�Ӿ���Դ�����OR�Ӿ����ӵ�һ������������ 
����Ҫ�ҳ�ס�� London��Paris��Berlin�����пͻ�
Select CustomerID, CompanyName, ContactName, City
FROM Customers
Where City In(��London��,�� Paris��,�� Berlin��)
4 ģʽƥ��(LIKE)
LIKE���������һ�������ַ������ݵ��ֶ�ֵ�Ƿ�ƥ��һָ��ģʽ��
LIKE�������ʹ�õ�ͨ��� 
ͨ��� ���� 
�� �κ�һ����һ���ַ�
* ���ⳤ�ȵ��ַ�
# 0~9֮��ĵ�һ����
[�ַ��б�] ���ַ��б������һֵ
[���ַ��б�] �����ַ��б������һֵ
- ָ���ַ���Χ�����ߵ�ֵ�ֱ�Ϊ�������� 
�����������������ڣ�171��555-0000����171��555-9999֮��Ŀͻ�
Select CustomerID ,CompanyName,City,Phone
FROM Customers
Where Phone Like ��(171)555-####��
LIKE�������һЩ��ʽ������ 
��ʽ ���� ������
LIKE ��A*�� A������ⳤ�ȵ��ַ� Bc,c255
LIKE��5  
�� 5*5 555
LIKE��5?5�� 5��5֮��������һ���ַ� 55,5wer5
LIKE��5##5�� 5235��5005 5kd5,5346
LIKE��[a-z]�� a-z�������һ���ַ� 5,%
LIKE��[!0-9]�� ��0-9�������һ���ַ� 0,1
LIKE��[[]�� 1,* 
�� .��ORDER BY�Ӿ�������
orDER�Ӿ䰴һ�����������16�����ֶ������ѯ���������������ASC��Ҳ�����ǽ���DESC����ȱʡ������ORDER�Ӿ�ͨ������SQL�������
orDER�Ӿ��ж����˶���ֶΣ������ֶε��Ⱥ�˳������ 
����
Select ProductName,UnitPrice, UnitInStock
FROM Products
orDER BY UnitInStock DESC , UnitPrice DESC, ProductName  
orDER BY �Ӿ��п������ֶ���ѡ���б��е�λ�úŴ����ֶ��������Ի���ֶ�����λ�úš� 
�����������������������ͬ��Ч����
Select ProductName,UnitPrice, UnitInStock
FROM Products
orDER BY 1 DESC , 2 DESC,3  
�� .�������ӹ�ϵʵ�ֶ���ѯ 
�����ҳ�ͬһ�������й�Ӧ�̺Ϳͻ�������
Select Customers.CompanyName, Suppliers.ComPany.Name
FROM Customers, Suppliers
Where Customers.City=Suppliers.City 
�����ҳ���Ʒ���������ͬһ�ֲ�Ʒ�Ķ����������Ĳ�Ʒ�Ͷ���
Select ProductName,OrderID, UnitInStock, Quantity
FROM Products, [Order Deails]
Where Product.productID=[Order Details].ProductID
AND UnitsInStock��Quantity 
��һ�ַ������� Microsof JET SQL ���е� JNNER JOIN 
�﷨��
FROM table1 INNER JOIN table2
ON table1.field1 comparision table2.field2 
����comparision ����ǰ��Where�Ӿ��õ��ıȽ��������
Select FirstName,lastName,OrderID,CustomerID,OrderDate
FROM Employees
INNER JOIN orders ON Employees.EmployeeID=Orders.EmployeeID 
ע�⣺
INNER JOIN��������Memo OLE Object Single Double ���������ֶΡ� 
��һ��JOIN��������Ӷ��ON�Ӿ� 
�﷨��
Select fields
FROM table1 INNER JOIN table2
ON table1.field1 compopr table2.field1 AND
ON table1.field2 compopr table2.field2 or
ON table1.field3 compopr table2.field3 
Ҳ����
Select fields
FROM table1 INNER JOIN 
��table2 INNER JOIN [( ]table3
[INNER JOER] [( ]tablex[INNER JOIN]
ON table1.field1 compopr table2.field1  
ON table1.field2 compopr table2.field2  
ON table1.field3 compopr table2.field3 
�ⲿ���ӷ��ظ����¼���ڽ���б�����ƥ��ļ�¼�����ܴ治�������������ļ�¼��Ҫ������һ������м�¼��
FROM table [LEFT|RIGHT]JOIN table2
ON table1.field1comparision table.field2 
���������������ⲿ���ӣ��ڱ��ʽ����ߵı����ʾ�����е����� 
����������û�ж�����������������Ʒ
Select ProductName ,OrderID
FROM Products
LEFT JOIN orders ON Products.PrductsID=Orders.ProductID 
�������������ӵĲ�����ڣ�������������û��ƥ��ļ�¼�������������з������м�¼�� 
����������˽�ͻ�����Ϣ����ͳ�Ƹ��������Ŀͻ��ֲ�����ʱ������һ�������ӣ���ʹĳ������û�пͻ���ҲҪ���ؿͻ���Ϣ�� 
��ֵ�����໥ƥ�䣬����ͨ�������Ӳ��ܲ��Ա����ӵ�ĳ������ֶ��Ƿ��п�ֵ��
Select *
FROM talbe1
LEFT JOIN table2 ON table1.a=table2.c
1 ���Ӳ�ѯ��ʹ��Iif����ʵ����0ֵ��ʾ��ֵ
Iif���ʽ�� Iif(IsNull(Amount,0,Amout) 
�������۶������ڻ�С�ڣ�50����Ҫ����һ����־��
Iif([Amount]��50,?Big order?,?Small order?) 
��. ������ܽ��ѯ��� 
��SQL���﷨�GROUP BY��HAVING�Ӿ����������ݽ��л��ܡ�GROUP BY�Ӿ�ָ���˰����ļ����ֶ������飬������¼�������HAVING�Ӿ������Щ��¼��
GROUP BY �Ӿ���﷨
Select fidldlist
FROM table
Where criteria
[GROUP BY groupfieldlist [HAVING groupcriteria]] 
ע��Microsoft Jet���ݿ� Jet ���ܶԱ�ע��OLE�����ֶη��顣
GROUP BY�ֶ��е�Nullֵ�Ա����鵫�ǲ��ܱ�ʡ�ԡ� 
���κ�SQL�ϼƺ����в�����Nullֵ��
GROUP BY�Ӿ�������Դ���ʮ���ֶΣ��������ȼ��������ҵ�˳�����С� 
�����ڡ�WA�������Ĺ�Ա���а�ͷ�η�����ҳ�����ͬ��ͷ�εĹ�Ա��Ŀ����1�˵�����ͷ�Ρ�
Select Title ,Count(Title) as Total
FROM Employees
Where Region = ��WA��
GROUP BY Title
HAVING Count(Title)��1
JET SQL �еľۻ����� 
�ۼ����� ����
SUM ( ) ���
AVG ( ) ƽ��ֵ
COUNT ( ) ���ʽ�м�¼����Ŀ
COUNT (* ) �����¼����Ŀ
MAX ���ֵ
MIN ��Сֵ
VAR ����
STDEV ��׼���
FIRST ��һ��ֵ
LAST ���һ��ֵ 
��. ��Parameters��������������ѯ
Parameters�������﷨:
PARAMETERS name datatype[,name datatype[, ��]] 
����name �ǲ����ı�־��,����ͨ����־�����ò���.
Datatype˵����������������. 
ʹ��ʱҪ��PARAMETERS ���������κ��������֮ǰ. 
��:
PARAMETERS[Low price] Currency,[Beginning date]datatime
Select orderID ,OrderAmount
FROM orders
Where orderAMount��[low price]
AND orderDate��=[Beginning date] 
��. ���ܲ�ѯ 
��ν���ܲ�ѯ,ʵ������һ�ֲ�����ѯ,�����Զ����ݿ���п��ٸ�Ч�Ĳ���.����ѡ���ѯΪĿ��,��ѡ����������������,�ٶ����ݽ���������.���ܲ�ѯ�������²�ѯ,ɾ����ѯ,��Ӳ�ѯ,�����ɱ��ѯ.
1 ���²�ѯ
Update�Ӿ����ͬʱ����һ���������е�����.��Ҳ����ͬʱ���Ķ���ֶε�ֵ. 
���²�ѯ�﷨:
Update ����
SET ��ֵ
Where ׼�� 
��:Ӣ���ͻ��Ķ���������5%,����������3%
Update OEDERS
SET orderAmount = orderAmount *1.1
Freight = Freight*1.03
Where ShipCountry = ��UK��
2 ɾ����ѯ
Delete�Ӿ����ʹ�û�ɾ�������Ĺ�ʱ�Ļ����ڵ�����. 
ע:ɾ����ѯ�Ķ�����������¼.
Delete�Ӿ���﷨:
Delete [����.*]
FROM ��Դ��
Where ׼�� 
��: Ҫɾ������94��ǰ�Ķ���
Delete *
FROM orders
Where orderData��#94-1-1#
3 ׷�Ӳ�ѯ  
Insert�Ӿ���Խ�һ����һ���¼׷�ӵ�һ���������β��.
INTO �Ӿ�ָ�������¼�¼�ı�
valueS �ؼ���ָ���¼�¼������������ֵ.
Insert �Ӿ���﷨:
INSETR INTO Ŀ�ı���ѯ(�ֶ�1,�ֶ�2,��)
valueS(��ֵ1,��ֵ2,��) 
��:����һ���ͻ�
Insert INTO Employees(FirstName,LastName,title)
valueS(��Harry��,��Washington��,��Trainee��)
4 ���ɱ��ѯ 
����һ���Եذ��������������ļ�¼������һ���±���.ͨ��������¼�ı��ݻ򸱱�����Ϊ����Ļ���.
Select INTO�Ӿ������������ɱ��ѯ�﷨:
Select �ֶ�1,�ֶ�2,��
INTO �±�[IN �ⲿ���ݿ�]
FROM ��Դ���ݿ�
Where ׼�� 
��:Ϊ��������һ���浵����
Select *
INTO ordersArchive
FROM orders 
��. ���ϲ�ѯ
UNION������԰Ѷ����ѯ�Ľ���ϲ���һ�����������ʾ.
UNION�����һ���﷨:
[��]��ѯ1 UNION [ALL]��ѯ2 UNION �� 
��:���ذ������й����̺Ϳͻ������ֺͳ���
Select CompanyName,City
FROM Suppliers
Where Country = ��Brazil��
UNION
Select CompanyName,City
FROM Customers
Where Country = ��Brazil�� 
ע: 
ȱʡ�������,UNION�Ӿ䲻�����ظ��ļ�¼.�������ʾ���м�¼,���Լ�ALLѡ��
UNION����Ҫ���ѯ������ͬ��Ŀ���ֶ�.����,�ֶ��������Ͳ�����ͬ. 
ÿһ����ѯ�����п���ʹ��GROUP BY �Ӿ� �� HAVING �Ӿ���з���.Ҫ����ָ����˳������ʾ���ص�����,���������һ����ѯ��β��ʹ��OREER BY�Ӿ�. 
��. �����ѯ 
�����ѯ���Զ����ݽ����ܺ�,ƽ��,�����������ܺͼ��㷨�ļ���,��Щ����ͨ��������Ϣ���з���:һ����ʾ�ڱ����,��һ����ʾ�ڱ�Ķ���.
Microsoft Jet SQL ��TRANSFROM��䴴��������ѯ�﷨:
TRANSFORM aggfunction
Select ���
GROUP BY �Ӿ�
PIVOT pivotfield[IN(value1 [,value2[,��]]) ]
AggfounctionָSQL�ۻ�����,
Select���ѡ����Ϊ����ĵ��ֶ�,
GROUP BY ���� 
˵����
Pivotfield �ڲ�ѯ������д����б���ʱ�õ��ֶλ���ʽ,�ÿ�ѡ��IN�Ӿ���������ȡֵ.
value�������б���Ĺ̶�ֵ. 
��:��ʾ��1996����ÿһ����ÿһλԱ�����ӵĶ�������Ŀ:
TRANSFORM Count(OrderID)
Select FirstName&����&LastName AS FullName
FROM Employees INNER JOIN orders
ON Employees.EmployeeID = orders.EmployeeID
Where DatePart(��yyyy��,OrderDate)= ��1996��
GROUP BY FirstName&����&LastName
orDER BY FirstName&����&LastName
POVOT DatePart(��q��,OrderDate)&�����ȡ� 
ʮ .�Ӳ�ѯ 
�Ӳ�ѯ�������Ϊ �ײ�ѯ.�Ӳ�ѯ��һ��Select���.
1 ���ʽ��ֵ���Ӳ�ѯ���صĵ�һֵ���Ƚ� 
�﷨:  
���ʽ comparision [ANY|ALL|SOME](�Ӳ�ѯ) 
˵����
ANY��SOMEν����ͬ���,��Ƚ������(=,��,��,����,��=,��=)һ��ʹ��.����һ������ֵTrue��False.ANY����˼��,���ʽ���Ӳ�ѯ���ص�һϵ�е�ֵ��һ�Ƚ�,ֻҪ���е�һ�αȽϲ���True���,ANY���Եķ��� Trueֵ(��Where�Ӿ�Ľ��),��Ӧ�ڸñ��ʽ�ĵ�ǰ��¼����������ѯ�Ľ����.ALL������Ҫ����ʽ���Ӳ�ѯ���ص�һϵ�е�ֵ�ıȽ϶�����True���,�Żط���Trueֵ. 
��:����ѯ���ص��۱��κ�һ���ۿ۴��ڵ���25%�Ĳ�Ʒ�ĵ���Ҫ�ߵ����в�Ʒ
Select * FROM Products
Where UnitPrice��ANY
(Select UnitPrice FROM[Order Details] Where Discount��0.25)
2 �����ʽ��ֵ�Ƿ�ƥ���Ӳ�ѯ���ص�һ��ֵ��ĳ��ֵ 
�﷨:
[NOT]IN(�Ӳ�ѯ) 
��:���ؿ���ֵ���ڵ���1000�Ĳ�Ʒ.
Select ProductName FROM Products
Where ProductID IN
(Select PrdoctID FROM [Order DEtails]
Where UnitPrice*Quantity��= 1000)
3����Ӳ�ѯ�Ƿ񷵻��κμ�¼ 
�﷨:
[NOT]EXISTS (�Ӳ�ѯ) 
��:��EXISTS����Ӣ���Ŀͻ�
Select ComPanyName,ContactName
FROM orders
Where EXISTS
(Select *
FROM Customers
Where Country = ��UK�� AND
Customers.CustomerID= orders.CustomerID) 
������---------�����ҳ��--��ô�������£�������������ҳ��ð�������----------������
Sql Server �� Access �������ݿ�ṹSql��� 
������Sql Server �� Access �������ݿ�ṹ�ĳ���Sql��ϣ���������������� 
�����ɺ�����������ȷ�벻����֮�����������лл�� 
�½���
create table [����]
(
[�Զ�����ֶ�] int IDENTITY (1,1) PRIMARY KEY ,
[�ֶ�1] nVarChar(50) default ��Ĭ��ֵ�� null ,
[�ֶ�2] ntext null ,
[�ֶ�3] datetime,
[�ֶ�4] money null ,
[�ֶ�5] int default 0,
[�ֶ�6] Decimal (12,4) default 0,
[�ֶ�7] image null ,
) 
ɾ����
Drop table [����] 
�������ݣ�
Insert INTO [����] (�ֶ�1,�ֶ�2) VALUES (100,��51WINDOWS.NET��) 
ɾ�����ݣ�
Delete FROM [����] Where [�ֶ���]��100 
�������ݣ�
Update [����] SET [�ֶ�1] = 200,[�ֶ�2] = ��51WINDOWS.NET�� Where [�ֶ���] = ��HAIWA�� 
�����ֶΣ�
Alter TABLE [����] ADD [�ֶ���] NVARCHAR (50) NULL 
ɾ���ֶΣ�
Alter TABLE [����] Drop COLUMN [�ֶ���] 
�޸��ֶΣ�
Alter TABLE [����] Alter COLUMN [�ֶ���] NVARCHAR (50) NULL 
��������(Access ����������ο����£���Access���ݿ�����������) 
�������� ��Access���ݿ�����������
Dim Conn,ConnStr,oCat,oTbl
ConnStr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("data.mdb")
Set oCat=Server.CreateObject("ADOX.Catalog")  
oCat.ActiveConnection = ConnStr
Set oTbl = Server.CreateObject("ADOX.Table")
Set oTbl = oCat.Tables("OldTable") ��Ҫ�������ı�����OldTable
oTbl.Name = "NewTable" ���±���
Set oCat = Nothing
Set oTbl = Nothing
sp_rename ��������, ���±�����, ��OBJECT�� 
�½�Լ����
Alter TABLE [����] ADD CONSTRAINT Լ���� CHECK ([Լ���ֶ�] ��= ��2000-1-1��) 
ɾ��Լ����
Alter TABLE [����] Drop CONSTRAINT Լ���� 
�½�Ĭ��ֵ
Alter TABLE [����] ADD CONSTRAINT Ĭ��ֵ�� DEFAULT ��51WINDOWS.NET�� FOR [�ֶ���] 
ɾ��Ĭ��ֵ
Alter TABLE [����] Drop CONSTRAINT Ĭ��ֵ�� 
ɾ��Sql Server �е���־����С���ݿ��ļ���С
dump transaction ���ݿ��� with no_log
backup log ���ݿ��� with no_log
dbcc shrinkdatabase(���ݿ���)
exec sp_dboption �����ݿ�����, ��autoshrink��, ��true��
 
 
 
SQL��ѯ��侫����ȫ.txt
һ�� �򵥲�ѯ
�򵥵�Transact-SQL��ѯֻ����ѡ���б�FROM�Ӿ��WHERE�Ӿ䡣���Ƿֱ�˵������ѯ�С���ѯ��
�����ͼ���Լ����������ȡ�
���磬���������ѯtesttable��������Ϊ����������nickname�ֶκ�email�ֶΡ�
SELECT nickname,email
FROM testtable
WHERE name='����'
 
(һ) ѡ���б�
ѡ���б�(select_list)ָ������ѯ�У���������һ�������б��Ǻš����ʽ������(�����ֲ���
����ȫ�ֱ���)�ȹ��ɡ�
1��ѡ��������
���磬���������ʾtesttable���������е����ݣ�
SELECT *
FROM testtable
 
2��ѡ�񲿷��в�ָ�����ǵ���ʾ����
��ѯ������������ݵ�����˳����ѡ���б�����ָ������������˳����ͬ��
���磺
SELECT nickname,email
FROM testtable
 
3�������б���
��ѡ���б��У�������ָ���б��⡣�����ʽΪ��
�б���=����
���� �б���
���ָ�����б��ⲻ�Ǳ�׼�ı�ʶ����ʽʱ��Ӧʹ�����Ŷ���������磬�������ʹ�ú�����ʾ��
���⣺
SELECT �ǳ�=nickname,�����ʼ�=email
FROM testtable
 
4��ɾ���ظ���
SELECT�����ʹ��ALL��DISTINCTѡ������ʾ���з��������������л�ɾ�������ظ��������У�Ĭ��
ΪALL��ʹ��DISTINCTѡ��ʱ�����������ظ�����������SELECT���صĽ��������ֻ����һ�С�
 
5�����Ʒ��ص�����
ʹ��TOP n [PERCENT]ѡ�����Ʒ��ص�����������TOP n˵������n�У���TOP n PERCENTʱ��˵��n��
��ʾһ�ٷ�����ָ�����ص����������������İٷ�֮����
���磺
SELECT TOP 2 *
FROM testtable
SELECT TOP 20 PERCENT *
FROM testtable
 
(��) FROM�Ӿ�
FROM�Ӿ�ָ��SELECT����ѯ�����ѯ��صı����ͼ����FROM�Ӿ�������ָ��256�������ͼ��
����֮���ö��ŷָ���
��FROM�Ӿ�ͬʱָ����������ͼʱ�����ѡ���б��д���ͬ���У���ʱӦʹ�ö������޶���Щ��
�����ı����ͼ��������usertable��citytable����ͬʱ����cityid�У��ڲ�ѯ�������е�cityidʱӦ
ʹ����������ʽ�����޶���
SELECT username,citytable.cityid
FROM usertable,citytable
WHERE usertable.cityid=citytable.cityid
��FROM�Ӿ��п����������ָ�ʽΪ�����ͼָ��������
���� as ����
���� ����
�������������ñ�ı�����ʽ��ʾΪ��
SELECT username,b.cityid
FROM usertable a,citytable b
WHERE a.cityid=b.cityid
SELECT�����ܴӱ����ͼ�м������ݣ������ܹ���������ѯ��������صĽ�������в�ѯ���ݡ�
���磺
SELECT a.au_fname+a.au_lname
FROM authors a,titleauthor ta
(SELECT title_id,title
FROM titles
WHERE ytd_sales>10000
) AS t
WHERE a.au_id=ta.au_id
AND ta.title_id=t.title_id
�����У���SELECT���صĽ�����ϸ���һ����t��Ȼ���ٴ��м������ݡ�
 
(��) ʹ��WHERE�Ӿ����ò�ѯ����
WHERE�Ӿ����ò�ѯ���������˵�����Ҫ�������С�������������ѯ�������20�����ݣ�
SELECT *
FROM usertable
WHERE age>20
WHERE�Ӿ�ɰ������������������
�Ƚ������(��С�Ƚ�)��>��>=��=��<��<=��<>��!>��!<
��Χ�����(���ʽֵ�Ƿ���ָ���ķ�Χ)��BETWEEN��AND��
NOT BETWEEN��AND��
�б������(�жϱ��ʽ�Ƿ�Ϊ�б��е�ָ����)��IN (��1,��2����)
NOT IN (��1,��2����)
ģʽƥ���(�ж�ֵ�Ƿ���ָ�����ַ�ͨ���ʽ���):LIKE��NOT LIKE
��ֵ�жϷ�(�жϱ��ʽ�Ƿ�Ϊ��)��IS NULL��NOT IS NULL
�߼������(���ڶ��������߼�����)��NOT��AND��OR
1����Χ���������age BETWEEN 10 AND 30�൱��age>=10 AND age<=30
2���б����������country IN ('Germany','China')
3��ģʽƥ�������������ģ�����ң����ж���ֵ�Ƿ���ָ�����ַ�����ʽ��ƥ�䡣������char��
varchar��text��ntext��datetime��smalldatetime�����Ͳ�ѯ��
��ʹ������ͨ���ַ���
�ٷֺ�%����ƥ���������ͺͳ��ȵ��ַ�����������ģ���ʹ�������ٷֺż�%%��
�»���_��ƥ�䵥�������ַ��������������Ʊ��ʽ���ַ����ȡ�
������[]��ָ��һ���ַ����ַ�����Χ��Ҫ����ƥ�����Ϊ�����е���һ����
[^]����ȡֵҲ[] ��ͬ������Ҫ����ƥ�����Ϊָ���ַ��������һ���ַ���
���磺
������Publishing��β��ʹ��LIKE '%Publishing'
������A��ͷ��LIKE '[A]%'
������A��ͷ�⣺LIKE '[^A]%'
4����ֵ�жϷ���WHERE age IS NULL
5���߼�����������ȼ�ΪNOT��AND��OR
(��)��ѯ�������
ʹ��ORDER BY�Ӿ�Բ�ѯ���صĽ����һ�л��������ORDER BY�Ӿ���﷨��ʽΪ��
ORDER BY {column_name [ASC|DESC]} [,��n]
����ASC��ʾ����ΪĬ��ֵ��DESCΪ����ORDER BY���ܰ�ntext��text��image�������ͽ�����
��
���磺
SELECT *
FROM usertable
ORDER BY age desc,userid ASC
���⣬���Ը��ݱ��ʽ��������
 
���� ���ϲ�ѯ
UNION��������Խ�����������������SELECT���Ĳ�ѯ������Ϻϲ���һ�����������ʾ����ִ����
�ϲ�ѯ��UNION���﷨��ʽΪ��
select_statement
UNION [ALL] selectstatement
[UNION [ALL] selectstatement][��n]
����selectstatementΪ�����ϵ�SELECT��ѯ��䡣
ALLѡ���ʾ�������кϲ�����������С���ָ������ʱ�������ϲ�ѯ��������е��ظ��н�ֻ����һ
�С�
���ϲ�ѯʱ����ѯ������б���Ϊ��һ����ѯ�����б��⡣��ˣ�Ҫ�����б�������ڵ�һ����ѯ��
���ж��塣Ҫ�����ϲ�ѯ�������ʱ��Ҳ����ʹ�õ�һ��ѯ����е��������б����������š�
��ʹ��UNION �����ʱ��Ӧ��֤ÿ�����ϲ�ѯ����ѡ���б�������ͬ�����ı��ʽ������ÿ����ѯѡ
����ʽӦ������ͬ���������ͣ����ǿ����Զ�������ת��Ϊ��ͬ���������͡����Զ�ת��ʱ��������ֵ��
�ͣ�ϵͳ���;��ȵ���������ת��Ϊ�߾��ȵ��������͡�
�ڰ��������ѯ��UNION����У���ִ��˳�����������ң�ʹ�����ſ��Ըı���һִ��˳�����磺
��ѯ1 UNION (��ѯ2 UNION ��ѯ3)
 
�������Ӳ�ѯ
ͨ���������������ʵ�ֶ�����ѯ�������ǹ�ϵ���ݿ�ģ�͵���Ҫ�ص㣬Ҳ������������������
���ݿ����ϵͳ��һ����־��
�ڹ�ϵ���ݿ����ϵͳ�У�����ʱ������֮��Ĺ�ϵ����ȷ��������һ��ʵ���������Ϣ�����
һ�����С�����������ʱ��ͨ�����Ӳ�����ѯ������ڶ�����еĲ�ͬʵ�����Ϣ�����Ӳ������û���
���ܴ������ԣ����ǿ������κ�ʱ�������µ��������͡�Ϊ��ͬʵ�崴���µı�����ͨ�����ӽ���
��ѯ��
���ӿ�����SELECT ����FROM�Ӿ��WHERE�Ӿ��н��������Ƕ�����FROM�Ӿ���ָ������ʱ������
�����Ӳ�����WHERE�Ӿ��е������������ֿ��������ԣ���Transact-SQL���Ƽ�ʹ�����ַ�����
SQL-92��׼�������FROM�Ӿ�������﷨��ʽΪ��
FROM join_table join_type join_table
[ON (join_condition)]
����join_tableָ���������Ӳ����ı��������ӿ��Զ�ͬһ���������Ҳ���ԶԶ���������ͬһ
��������������ֳ��������ӡ�
join_type ָ���������ͣ��ɷ�Ϊ���֣������ӡ������Ӻͽ������ӡ�������(INNER JOIN)ʹ�ñ�
����������б��ĳ(Щ)�����ݵıȽϲ��������г���Щ����������������ƥ��������С�������ʹ��
�ıȽϷ�ʽ��ͬ���������ַ�Ϊ��ֵ���ӡ���Ȼ���ӺͲ����������֡�
�����ӷ�Ϊ��������(LEFT OUTER JOIN��LEFT JOIN)����������(RIGHT OUTER JOIN��RIGHT JOIN)
��ȫ������(FULL OUTER JOIN��FULL JOIN)���֡��������Ӳ�ͬ���ǣ������Ӳ�ֻ�г�������������ƥ
����У������г����(��������ʱ)���ұ�(��������ʱ)��������(ȫ������ʱ)�����з�������������
�����С�
��������(CROSS JOIN)û��WHERE �Ӿ䣬���������ӱ������������еĵѿ����������������е�
�����������ڵ�һ�����з��ϲ�ѯ�����������������Եڶ������з��ϲ�ѯ����������������
���Ӳ����е�ON (join_condition) �Ӿ�ָ���������������ɱ����ӱ��е��кͱȽ���������߼�
������ȹ��ɡ�
�����������Ӷ����ܶ�text��ntext��image���������н���ֱ�����ӣ������Զ��������н��м��
���ӡ����磺
SELECT p1.pub_id,p2.pub_id,p1.pr_info
FROM pub_info AS p1 INNER JOIN pub_info AS p2
ON DATALENGTH(p1.pr_info)=DATALENGTH(p2.pr_info)
 
(һ)������
�����Ӳ�ѯ�����г�����������ƥ��������У���ʹ�ñȽ�������Ƚϱ������е���ֵ�������ӷ�
���֣�
1����ֵ���ӣ�������������ʹ�õ��ں�(=)������Ƚϱ������е���ֵ�����ѯ������г�������
���е������У��������е��ظ��С�
2���������ӣ� ����������ʹ�ó��������������������Ƚ�������Ƚϱ����ӵ��е���ֵ����Щ
���������>��>=��<=��<��!>��!<��<>��
3����Ȼ���ӣ�������������ʹ�õ���(=)������Ƚϱ������е���ֵ������ʹ��ѡ���б�ָ����ѯ
������������������У���ɾ�����ӱ��е��ظ��С�
��������ʹ�õ�ֵ�����г�authors��publishers����λ��ͬһ���е����ߺͳ����磺
SELECT *
FROM authors AS a INNER JOIN publishers AS p
ON a.city=p.city
����ʹ����Ȼ���ӣ���ѡ���б���ɾ��authors ��publishers �����ظ���(city��state)��
SELECT a.*,p.pub_id,p.pub_name,p.country
FROM authors AS a INNER JOIN publishers AS p
ON a.city=p.city
(��)������
������ʱ�����ز�ѯ��������еĽ��Ƿ��ϲ�ѯ����( WHERE ���������� HAVING ����)����������
���С�������������ʱ�������ص���ѯ��������еĲ����������������������У����һ��������(����
����ʱ)���ұ�(��������ʱ)�������߽ӱ�(ȫ������)�е����������С�
������ʹ���������ӽ���̳���ݺ�������Ϣ����������
SELECT a.*,b.* FROM luntan LEFT JOIN usertable as b
ON a.username=b.username
����ʹ��ȫ�����ӽ�city���е����������Լ�user���е��������ߣ��Լ��������ڵĳ��У�
SELECT a.*,b.*
FROM city as a FULL OUTER JOIN user as b
ON a.username=b.username
 
(��)��������
�������Ӳ���WHERE �Ӿ䣬�����ر����ӵ����������������еĵѿ����������ص���������е���
���������ڵ�һ�����з��ϲ�ѯ�����������������Եڶ������з��ϲ�ѯ����������������
����titles������6��ͼ�飬��publishers������8�ҳ����磬�����н������Ӽ������ļ�¼������
��6*8=48�С�
SELECT type,pub_name
FROM titles CROSS JOIN publishers
ORDER BY typeSQL�������(�ǳ�ʵ�õļ�������)��������
 
��������һ���¼�¼����Ҫʹ��SQL INSERT ��䡣������һ�����ʹ�������������ӣ�
 
INSERT mytable (mycolumn) VALUES (��some data��)
 
��������ַ�����some data�������mytable��mycolumn�ֶ��С���Ҫ���������ݵ��ֶε������ڵ�һ��������ָ����ʵ�ʵ������ڵڶ��������и�����
 
INSERT ���������䷨���£�
 
INSERT [INTO] {table_name|view_name} [(column_list)] {DEFAULT VALUES |
 
Values_list | select_statement}
 
���һ�����ж���ֶΣ�ͨ�����ֶ������ֶ�ֵ�ö��Ÿ���������������е��ֶ��в������ݡ������mytable�������ֶ�first_column,second_column,��third_column�������INSERT��������һ�������ֶζ���ֵ��������¼��
 
INSERT mytable (first_column,second_column,third_column)
 
VALUES (��some data��,��some more data��,��yet more data��)
 
ע��
 
�����ʹ��INSERT������ı����ֶ��в������ݡ����ǣ��������Ҫ����ܳ����ַ�������Ӧ��ʹ��WRITETEXT��䡣�ⲿ�����ݶԱ�����˵̫�߼��ˣ���˲������ۡ�Ҫ�˽�������Ϣ����ο�Microsoft SQL Sever ���ĵ���
 
�������INSERT �����ָֻ�������ֶκ����ݻ���ô���أ����仰˵������һ�����в���һ���¼�¼������һ���ֶ�û���ṩ���ݡ�����������£�����������ֿ��ܣ�
 
������ֶ���һ��ȱʡֵ����ֵ�ᱻʹ�á����磬����������¼�¼ʱû�и��ֶ�third_column�ṩ���ݣ�������ֶ���һ��ȱʡֵ��some value��������������£����¼�¼����ʱ�����ֵ��some value����
������ֶο��Խ��ܿ�ֵ������û��ȱʡֵ����ᱻ�����ֵ��
������ֶβ��ܽ��ܿ�ֵ������û��ȱʡֵ���ͻ���ִ�������յ�������Ϣ��
The column in table mytable may not be null.
 
���������ֶ���һ����ʶ�ֶΣ���ô�����Զ�����һ����ֵ��������һ���б�ʶ�ֶεı��в����¼�¼ʱ��ֻҪ���Ը��ֶΣ���ʶ�ֶλ���Լ���һ����ֵ��
 
ע��
��һ���б�ʶ�ֶεı��в����¼�¼���������SQL����@@identity�������¼�¼
�ı�ʶ�ֶε�ֵ���������µ�SQL��䣺
INSERT mytable (first_column) VALUES(��some value��)
INSERT anothertable(another_first,another_second)
VALUES(@@identity,��some value��)
�����mytable��һ����ʶ�ֶΣ����ֶε�ֵ�ᱻ�����anothertable��another_first�ֶΡ�������Ϊ����@@identity���Ǳ������һ�β����ʶ�ֶε�ֵ��
�ֶ�another_firstӦ�����ֶ�first_column����ͬ���������͡����ǣ��ֶ�another_first������Ӧ�ñ�ʶ�ֶΡ�Another_first�ֶ����������ֶ�first_column��ֵ��
 
ɾ����¼
Ҫ�ӱ���ɾ��һ��������¼����Ҫʹ��SQL DELETE��䡣����Ը�DELETE ����ṩWHERE �Ӿ䡣WHERE�Ӿ�����ѡ��Ҫɾ���ļ�¼�����磬��������DELETE���ֻɾ���ֶ�first_column��ֵ���ڡ�Delete Me���ļ�¼��
DELETE mytable WHERE first_column=��Deltet Me��
DELETE ���������䷨���£�
DELETE [FROM] {table_name|view_name} [WHERE clause]
��SQL SELECT ����п���ʹ�õ��κ�������������DELECT ����WHERE�Ӿ���ʹ�á����磬��������DELETE���ֻɾ����Щfirst_column�ֶε�ֵΪ��goodbye����second_column�ֶε�ֵΪ��so long���ļ�¼��
DELETE mytable WHERE first_column=��goodby�� OR second_column=��so long��
����㲻��DELETE ����ṩWHERE �Ӿ䣬���е����м�¼������ɾ�����㲻Ӧ���������뷨���������ɾ��Ӧ�ñ��е����м�¼��Ӧʹ�õ�ʮ��������TRUNCATE TABLE��䡣
 
ע��
ΪʲôҪ��TRUNCATE TABLE ������DELETE��䣿����ʹ��TRUNCATE TABLE���ʱ����¼��ɾ���ǲ�����¼�ġ�Ҳ����˵������ζ��TRUNCATE TABLE Ҫ��DELETE��öࡣ
 
���¼�¼
Ҫ�޸ı����Ѿ����ڵ�һ���������¼��Ӧʹ��SQL UPDATE��䡣ͬDELETE���һ����UPDATE������ʹ��WHERE�Ӿ���ѡ������ض��ļ�¼���뿴������ӣ�
UPDATE mytable SET first_column=��Updated!�� WHERE second_column=��Update Me!��
���UPDATE ����������second_column�ֶε�ֵΪ��Update Me!���ļ�¼�������б�ѡ�еļ�¼���ֶ�first_column��ֵ����Ϊ��Updated!����
 
������UPDATE���������䷨��
UPDATE {table_name|view_name} SET [{table_name|view_name}]
{column_list|variable_list|variable_and_column_list}
[,{column_list2|variable_list2|variable_and_column_list2}��
[,{column_listN|variable_listN|variable_and_column_listN}]]
[WHERE clause]
 
ע��
����Զ��ı����ֶ�ʹ��UPDATE��䡣���ǣ��������Ҫ���ºܳ����ַ�����Ӧʹ��UPDATETEXT��䡣�ⲿ�����ݶԱ�����˵̫�߼��ˣ���˲������ۡ�Ҫ�˽�������Ϣ����ο�Microsoft SQL Sever ���ĵ���
 
����㲻�ṩWHERE�Ӿ䣬���е����м�¼���������¡���ʱ�������õġ����磬�������ѱ�titles�е�������ļ۸�ӱ��������ʹ�����µ�UPDATE ��䣺
 
��Ҳ����ͬʱ���¶���ֶΡ����磬�����UPDATE���ͬʱ����first_column,second_column,��third_column�������ֶΣ�
UPDATE mytable SET first_column=��Updated!��
Second_column=��Updated!��
Third_column=��Updated!��
WHERE first_column=��Update Me1��
 
����
SQL��������ж���Ŀո�����԰�SQL���д���κ��������׶��ĸ�ʽ��
��SELECT ������¼�ͱ�
 
��Ҳ���Ѿ�ע�⵽��INSERT �����DELETE����UPDATE�����һ�㲻ͬ����һ��ֻ����һ����¼��Ȼ������һ����������ʹINSERT ���һ����Ӷ����¼��Ҫ������һ�㣬����Ҫ��INSERT �����SELECT �������������������
INSERT mytable (first_column,second_column)
SELECT another_first,another_second
FROM anothertable
WHERE another_first=��Copy Me!��
�������anothertable������¼��mytable.ֻ�б�anothertable���ֶ�another_first��ֵΪ��Copy Me�����ļ�¼�ű�������
 
��Ϊһ�����еļ�¼��������ʱ��������ʽ��INSERT ����Ƿǳ����õġ���ɾ��һ�����еļ�¼֮ǰ��������������ַ��������ǿ�������һ�����С�
 
�������Ҫ���������������ʹ��SELECT INTO ��䡣���磬�������䴴����һ����Ϊnewtable���±��ñ������mytable���������ݣ�
SELECT * INTO newtable FROM mytable
��Ҳ����ָ��ֻ���ض����ֶα�������������±�Ҫ������һ�㣬ֻ�����ֶ��б���ָ������Ҫ�������ֶΡ����⣬�����ʹ��WHERE �Ӿ������ƿ������±��еļ�¼�����������ֻ�����ֶ�second_columnd��ֵ���ڡ�Copy Me!���ļ�¼��first_column�ֶΡ�
SELECT first_column INTO newtable
FROM mytable
WHERE second_column=��Copy Me!��
 
ʹ��SQL�޸��Ѿ������ı��Ǻ����ѵġ����磬�������һ�����������һ���ֶΣ�û�����׵İ취��ȥ���������⣬����㲻С�İ�һ���ֶε��������͸����ˣ��㽫û�а취�ı��������ǣ�ʹ�ñ����н�����SQL��䣬������ƹ����������⡣
 
���磬���������һ������ɾ��һ���ֶΡ�ʹ��SELECT INTO ��䣬����Դ����ñ��һ����������������Ҫɾ�����ֶΡ���ʹ���ɾ���˸��ֶΣ��ֱ����˲���ɾ�������ݡ�
 
�������ı�һ���ֶε��������ͣ�����Դ���һ��������ȷ���������ֶε��±������øñ����Ϳ��Խ��ʹ��UPDATE����SELECT ��䣬��ԭ�����е��������ݿ������±��С�ͨ�����ַ�������ȿ����޸ı�Ľṹ�����ܱ���ԭ�е����ݡ�


1.create user username identified by password;//���û���������oracle ,oracle
2.grant connect,resource,dba to username;//��Ȩ grant connect,resource,dba,sysdba to username;
3.connect username/password//���롣
4.select table_name,column_name from user_tab_columns where table_name='mview_log';//��ѯ���еı������ֶ����ȵȡ�
5. ���ִ�нű�SQL�ļ�? SQL>@PATH/filename.sql;
6.Oracle oledb �ṩ����command��ִ�ж���SQL�����SQL SERVER��������,SQL Serverֻ��ʹ��";"�ָ����SQL���,��Oracle��Ҫ����ORACLE���ù淶,�����ֺŷָ���,������begin /end;��Χ�����.
ʹ��C#����Ӧ������ʾ:
this.oleDbCommand1.CommandText = "begin INSERT INTO GROUP_INFO (GROUP_ID, GROUP_NAME) VALUES (1, \'2\'); INSERT INTO GROUP_INFO(GROUP_ID, GROUP_NAME) VALUES (2, \'2\'); end;";
7.��ѯ�û��µ����б� select distinct table_name from user_tab_columns;
8.���������ǰN����¼��Select a.*,rownum from (select * from cardkind order by cardkind ) a where rownum<n
9.�����û��µ����б�select * from tab;
2����ʾ��ǰ�����û�
show user
--3���鿴ϵͳӵ����Щ�û�
select * from all_users;
--4���½��û�����Ȩ
create user a identified by a;(Ĭ�Ͻ���SYSTEM��ռ���)
grant connect,resource to a;
5�����ӵ����û�
conn a/a
6����ѯ��ǰ�û������ж���
select * from tab;
7��������һ����
create table a(a number);
8����ѯ��ṹ
desc a
9�������¼�¼
insert into a values(1);
10����ѯ��¼
select * from a;
11�����ļ�¼
update a set a=2;
12��ɾ����¼
delete from a;
13���ع�
roll;
rollback;
14���ύ
commit;
select * from
(select t.*,dense_rank() over (order by cardkind) rank from cardkind t)
where rank = 2;
46. ������ַ�����ӻس�?
select 'Welcome to visit'||chr(10)||'www.CSDN.NET' from dual ;
47. �������������ģ�
Oracle9i֮ǰ�������ǰ��ն����Ʊ����������ġ�
��oracle9i�������˰���ƴ�������ס��ʻ������ܡ�����NLS_SORTֵ
SCHINESE_RADICAL_M ���ղ��ף���һ˳�򣩡��ʻ����ڶ�˳������
SCHINESE_STROKE_M ���ձʻ�����һ˳�򣩡����ף��ڶ�˳������
SCHINESE_PINYIN_M ����ƴ������
48. Oracle8i�ж�����������������
����
49. ��θı�WIN��SQL*Plus����ѡ�
SQL*PLUS�����ѡ���������ǿ�����$ORACLE_HOME/sqlplus/admin/glogin.sql�����á�
50. �����޸�oracel���ݿ��Ĭ������?
alter session set nls_date_format='yyyymmddhh24miss';
OR
������init.ora�м���һ��
nls_date_format='yyyymmddhh24miss'
51. ��ν�С�����keep����?
alter table xxx storage(buffer_pool keep);
52. ��μ���Ƿ�װ��ĳ��patch?
check that oraInventory
53. ���ʹselect���ʹ��ѯ����Զ��������?
select rownum,COL from table;
54. ���֪�����ݿ���ĳ�������ڵ�tablespace?
select tablespace_name from user_tables where table_name='TEST';
select * from user_tables���и��ֶ�TABLESPACE_NAME����oracle��;
select * from dba_segments where ��;
55. ��ô���Կ�����һ����ԭ��һ���ı��ݱ�?
create table new_table as (select * from old_table);
55. ��ô��sqlplus���޸�procedure?
select line,trim(text) t from user_source where name ='A' order by line;
56. �������PROCEDURE����������?
alter system kill session ,���Ǹ�session��ɱ����������Ҫ�Ȳ������session id
or
�Ѹù������¸ĸ����־Ϳ����ˡ�
57. SQL Reference�Ǹ�ʲô������
��һ��sql��ʹ���ֲᣬ�����﷨�������ȵȣ�oracle�ٷ���վ���ĵ�����������.
58. ��β鿴���ݿ��״̬?
unix��
ps -ef | grep ora
windows��
�������Ƿ�����
�Ƿ�����������ݿ�
59. ��������޸�һ�ű������?
alter table aaa
drop constraint aaa_key ;
alter table aaa
add constraint aaa_key primary key(a1,b1) ;
60. �ı������ļ��Ĵ�С?
�� ALTER DATABASE .... DATAFILE .... ;
�ֹ��ı������ļ��Ĵ�С������ԭ���� �����ļ���û���𺦡�
61. �����鿴ORACLE������Щ����������֮�У�
�鿴v$sessions��
62. ��ô���Կ������ݿ��ж��ٸ�tablespace?
select * from dba_tablespaces;
63. ����޸�oracle���ݿ���û���������
�޸�initSID.ora����process�Ӵ��������ݿ�.
64. ��β��һ����¼��������ʱ��?
������logminer �쿴
65. �����PL/SQL�ж�д�ļ���
UTL_FILE�������û�ͨ��PL/SQL��д����ϵͳ�ļ���
66. ������"&"����һ����¼�У�
insert into a values (translate ('at{&}t','at{}','at'));
67. EXP ��μӣѣգţңٲ�����
EXP USER/PASS FILE=A.DMP TABLES(BSEMPMS)
QUERY='"WHERE EMP_NO=\'S09394\'\" �r
68. ����oracle8i֧�ּ���ͷ�����ַ������⣿
ZHS16GBK����֧
69. Data Guard��ʲô�����
����Standby�Ļ�����Ʒ
70. ��δ���SPFILE?
connect / as sysdba
select * from v$version;
create pfile from spfile;
CREATE SPFILE FROM PFILE='E:\ora9i\admin\eygle\pfile\init.ora';
�ļ��Ѵ�����
CREATE SPFILE='E:\ora9i\database\SPFILEEYGLE.ORA' FROM
PFILE='E:\ora9i\admin\eygle\pfile\init.ora';
�ļ��Ѵ�����
71. �ں˲�����Ӧ��?
shmmax
���壺������ò�����������Oracle���ݿ���߲���ϵͳʹ�ö��������ڴ棬ֻ������
������ʹ�õ��ڴ���Ŀ���������Ҳ��Ӱ�����ϵͳ���ں���Դ��
���÷�����0.5*�����ڴ�
���ӣ�Set shmsys:shminfo_shmmax=10485760
shmmin
���壺�����ڴ����С��С��
���÷�����һ�㶼���ó�Ϊ1��
���ӣ�Set shmsys:shminfo_shmmin=1��
shmmni
���壺ϵͳ�й����ڴ�ε���������
���ӣ�Set shmsys:shminfo_shmmni=100
shmseg
���壺ÿ���û����̿���ʹ�õ����Ĺ����ڴ�ε���Ŀ��
���ӣ�Set shmsys:shminfo_shmseg=20��
semmni
���壺ϵͳ��semaphore identifierer����������
���÷����������������ֵ����Ϊ���ϵͳ�ϵ�����Oracle��ʵ����init.ora�е����
���Ǹ�processes���Ǹ�ֵ��10��
���ӣ�Set semsys:seminfo_semmni=100
semmns
���壺ϵͳ��emaphores����������
���÷��������ֵ����ͨ�����·�ʽ����õ�������Oracleʵ����initSID.ora��ߵ�
processes��ֵ���ܺͣ���ȥ����Processes�������������Ǹ�Processes��2��10��
Oracleʵ���ĸ�����
���ӣ�Set semsys:seminfo_semmns=200
semmsl:
���壺һ��set��semaphore����������
���÷��������ó�Ϊ10������Oracleʵ����InitSID.ora������Processes��ֵ��
���ӣ�Set semsys:seminfo_semmsl=-200
72. �����鿴��Щ�û�ӵ��SYSDBA��SYSOPERȨ�ޣ�
SQL>conn sys/change_on_install
SQL>select * from V_$PWFILE_USERS;
73. ��ε�������һ��������
exp �û�/���� tables=(��1,��,��2)
74. ��ε�������һ�������û���
exp system/manager owner=(�û�1,�û�2,��,�û�n) file=�����ļ�
75. ��ζ�CLOB�ֶν���ȫ�ļ�����
SELECT * FROM A WHERE dbms_lob.instr(a.a,'K',1,1)>0; 76. �����ʾ��ǰ�����û�?
SHOW USER
77. ��β鿴�����ļ����õ�·�� ?
col file_name format a50
select tablespace_name,file_id,bytes/1024/1024,file_name from dba_data_files
order by file_id;
78. ��β鿴���лع��μ���״̬ ?
col segment format a30
SELECT SEGMENT_NAME,OWNER,TABLESPACE_NAME,SEGMENT_ID,FILE _ID,STATUS FROM
DBA_ROLLBACK_SEGS
79. ��θı�һ���ֶγ�ʼ�����Check��Χ��
alter table xxx drop constraint constraint_name;
֮���ٴ�����Լ��:
alter table xxx add constraint constraint_name check();
80. Oracle����ϵͳ�ļ�����Щ��
ͨ��������ͼ��ʾ��Щ�ļ���Ϣ��v$database,v$datafile,v$logfile v$controlfile
v$parameter;
81. ������INNER JOIN?
Select a.* from bsempms a,bsdptms b where a.dpt_no=b.dpt_no;
82. ���������?
Select a.* from bsempms a,bsdptms b where a.dpt_no=b.dpt_no(+);
Select a.* from bsempms a,bsdptms b wherea.dpt_no(+)=b.dpt_no;
83. ���ִ�нű�SQL�ļ�?
SQL>@$PATH/filename.sql;
84. ��ο������һ�����?
SQL>truncate table table_name;
85. ��β��ж��ٸ����ݿ�ʵ��?
SQL>SELECT * FROM V$INSTANCE;
86. ��β�ѯ���ݿ��ж��ٱ�?
SQL>select * from all_tables;
87. ��β���SQL���ִ�����õ�ʱ��?
SQL>set timing on ;
SQL>select * from tablename;
88. CHR()�ķ�������?
ASCII()
SELECT CHAR(65) FROM DUAL;
SELECT ASCII('A') FROM DUAL;
89. �ַ���������
SELECT CONCAT(COL1,COL2) FROM TABLE ;
SELECT COL1||COL2 FROM TABLE ;
90. ��ô��select�����Ľ������һ���ı��ļ��У�
SQL>SPOOL C:\ABCD.TXT;
SQL>select * from table;
SQL >spool off;
91. ��������SQLִ�е�I/O�� ?
SQL>SET AUTOTRACE ON ;
SQL>SELECT * FROM TABLE;
OR
SQL>SELECT * FROM v$filestat ;
���Բ鿴IO��
92. �����sqlplus�¸ı��ֶδ�С?
alter table table_name modify (field_name varchar2(100));
�Ĵ��У���С���У����Ƕ��ǿյģ�
93. ��β�ѯĳ�������?
select * from table_name where trunc(�����ֶ�)��to_date('2003-05-02','yyyy-mm-
dd');
94. sql �����β���ȫ�����ڣ�
create table BSYEAR (d date);
insert into BSYEAR
select to_date('20030101','yyyymmdd')+rownum-1
from all_objects
where rownum <= to_char(to_date('20031231','yyyymmdd'),'ddd');
95. ����޸ı���?
alter table old_table_name rename to new_table_name;
96. ���ȡ������ķ���״ֵ̬��
sqlcode=0
97. ���֪���û�ӵ�е�Ȩ��?
SELECT * FROM dba_sys_privs ;
98. ���������ص�ORACLE9I���г������ı�׼����ʲô����
�ӹ�����˵û������ֻ����oracle��˾�����Ĺ涨������վ�����ص�oracle��Ʒ��������
��ҵ��;��������Ȩ��
99. �����ж����ݿ��������ڹ鵵ģʽ�»��������ڷǹ鵵ģʽ�£�
����dbastudio������--�����ݿ�---���鵵�鿴��
100. sql>startup pfile��ifile,spfiled��ʲô����
pfile����Oracle��ͳ�ĳ�ʼ�������ļ����ı���ʽ�ġ�
ifile������c�������include�����ڰ���һ���ļ�����
spfile��9i�������Ĳ�����Ĭ�ϵĲ����ļ��������Ƹ�ʽ
startup��Ӧ��ֻ�ɽ�pfile
101. ���������ǰN����¼��
SELECT * FROM empLOYEE WHERE ROWNUM < n ORDER BY empno;
102. ���֪�������ϵ�Oracle֧�ֶ��ٲ����û���?
SQL>conn internal ;
SQL>show parameter processes ;
103. db_block_size�����޸���?
һ�㲻���ԩo�������������ġ�
104. ���ͳ��������ļ�¼����?
select (select count(id) from aa)+(select count(id) from bb) ���� from dual;
105. ������Sql���ʵ�ֲ���һ���е�N��ֵ��
select * from
(select t.*,dense_rank() over (order by sal) rank from employee)
where rank = N;
106. ����ڸ����е����ڼ���2�ꣿ(
select add_months(sysdate,24) from dual;
107. USED_UBLKΪ��ֵ��ʾʲô��˼?
It is "harmless".
108. Connect string��ָʲô?
Ӧ����tnsnames.ora�еķ��������������
109. ��������REDO LOG�Ĵ�С��
����һ����ʱ��redolog�飬Ȼ���л���־��ɾ����ǰ����־�������µ���־��
110. tablespace �Ƿ��ܴ���4G?
û������.
111. ���ش��ڵ���N����С����ֵ?
SELECT CEIL(N) FROM DUAL;
112. ����С�ڵ���N����С����ֵ?
SELECT FLOOR(N) FROM DUAL;
113. ���ص�ǰ�µ����һ��?
SELECT LAST_DAY(SYSDATE) FROM DUAL;
114. ��β�ͬ�û������ݵ���?
IMP SYSTEM/MANAGER FILE=AA.DMP FROMUSER=USER_OLD TOUSER=USER_NEW ROWS=Y INDEXES=Y

115. ��������ݿ��������ֶε�����?
SQL>SELECT * FROM user_constraints WHERE CONSTRAINT_TYPE='P' and
table_name='TABLE_NAME';
116. ������������ӵĺ���?
SQL>SELECT * FROM BSEMPMS_OLD INTERSECT SELECT * FROM BSEMPMS_NEW;
SQL>SELECT * FROM BSEMPMS_OLD UNION SELECT * FROM BSEMPMS_NEW;
SQL>SELECT * FROM BSEMPMS_OLD UNION ALL SELECT * FROM BSEMPMS_NEW;
117. ��������������ĺ���?
SQL>SELECT * FROM BSEMPMS_OLD MINUS SELECT * FROM BSEMPMS_NEW;
118. �������Sequence?
��sequence seq_custid
create sequence seq_custid start 1 incrememt by 1;
����ʱ:
create table cust
{ cust_id smallint not null,
...}
insert ʱ:
insert into table cust
values( seq_cust.nextval, ...)
���ڵĸ����ֵĳ��õĵ�д��
119>.ȡʱ������ݵ�д��:
SELECT TO_CHAR(SYSDATE,'YYYY') FROM DUAL;
120>.ȡʱ�����·ݵ�д��:
SELECT TO_CHAR(SYSDATE,'MM') FROM DUAL;
121>.ȡʱ�����յ�д��:
SELECT TO_CHAR(SYSDATE,'DD') FROM DUAL;
122>.ȡʱ����ʱ��д��:
SELECT TO_CHAR(SYSDATE,'HH24') FROM DUAL;
123>.ȡʱ���ķֵ�д��:
SELECT TO_CHAR(SYSDATE,'MI') FROM DUAL;
124>.ȡʱ�������д��:
SELECT TO_CHAR(SYSDATE,'SS') FROM DUAL;
125>.ȡʱ�������ڵ�д��:
SELECT TRUNC(SYSDATE) FROM DUAL;
126>.ȡʱ����ʱ���д��:
SELECT TO_CHAR(SYSDATE,'HH24:MI:SS') FROM DUAL;
127>.����,ʱ����̬��Ϊ�ַ���̬
SELECT TO_CHAR(SYSDATE) FROM DUAL;
128>.���ַ���ת�������ڻ�ʱ����̬:
SELECT TO_DATE('2003/08/01') FROM DUAL; 129>.���ز��������ڼ���д��:
SELECT TO_CHAR(SYSDATE,'D') FROM DUAL;
130>.���ز���һ���еĵڼ����д��:
SELECT TO_CHAR(SYSDATE,'DDD') FROM DUAL;
131>.������ҹ�Ͳ�����ָ����ʱ��ֵ֮���������д��:
SELECT TO_CHAR(SYSDATE,'SSSSS') FROM DUAL;
132>.���ز�����һ��ĵڼ��ܵ�д��:
SELECT TO_CHAR(SYSDATE,'WW') FROM DUAL;
�����ֶ�
133. CURRVAL �� nextval
Ϊ��������
CREATE SEQUENCE EMPSEQ ... ;
SELECT empseq.currval FROM DUAL ;
�Զ��������е���ֵ
INSERT INTO emp
VALUES (empseq.nextval, 'LEWIS', 'CLERK',
7902, SYSDATE, 1200, NULL, 20) ;
134. ROWNUM
���趨������е����
SELECT * FROM emp WHERE ROWNUM < 10 ;
135. ROWID
�����е������ַ
SELECT ROWID, ename FROM emp WHERE deptno = 20 ;
136. ��N��ת��Ϊʱ�����ʽ��
set serverout on
declare
N number := 1000000;
ret varchar2(100);
begin
ret := trunc(n/3600) || 'Сʱ' || to_char(to_date(mod(n,3600),'sssss'),'fmmi"��
"ss"��"') ;
dbms_output.put_line(ret);
end;
137. ��β�ѯ���Ƚϴ������Ľ��̣�
SELECT b.tablespace, b.segfile#, b.segblk#, b.blocks, a.sid, a.serial#,
a.username, a.osuser, a.status
FROM v$session a,v$sort_usage b
WHERE a.saddr = b.session_addr
ORDER BY b.tablespace, b.segfile#, b.segblk#, b.blocks ;
138. ��β�ѯ���Ƚϴ������Ľ��̵�SQL��䣿
select /*+ ORDERED */ sql_text from v$sqltext a
where a.hash_value = (
select sql_hash_value from v$session b
where b.sid = &sid and b.serial# = &serial)
order by piece asc ;
139. ��β����ظ���¼��
SELECT * FROM TABLE_NAME
WHERE ROWID!=(SELECT MAX(ROWID) FROM TABLE_NAME D
WHERE TABLE_NAME.COL1=D.COL1 AND TABLE_NAME.COL2=D.COL2);
140. ���ɾ���ظ���¼��
DELETE FROM TABLE_NAME
WHERE ROWID!=(SELECT MAX(ROWID) FROM TABLE_NAME D
WHERE TABLE_NAME.COL1=D.COL1 AND TABLE_NAME.COL2=D.COL2);
141. ��ο��ٱ���������ͼ��
SQL >SPOOL VIEW1.SQL
SQL >SELECT 'ALTER VIEW '||TNAME||'
COMPILE;' FROM TAB;
SQL >SPOOL OFF
Ȼ��ִ��VIEW1.SQL���ɡ�
SQL >@VIEW1.SQL;
142. ORA-01555 SNAPSHOT TOO OLD�Ľ���취
����MINEXTENTS��ֵ���������Ĵ�С������һ���ߵ�OPTIMALֵ��
143. ����Ҫ��Ļع��οռ䲻��������Ϊ��ռ�������ORA-01560���󣩣��ع�����չ����
���� MAXEXTENTS��ֵ��ORA-01628���Ľ���취.
��ع��α�ռ�����ļ���ʹ���е��ļ��������MAXEXTENTS��ֵ��
144. ��μ���ORACLE�Ĵ洢���̣�
���д洢�������ݷ���AA.SQL�ļ���
create or replace procedure testCCB(i in number) as
begin
dbms_output.put_line('���������'||to_char(i));
end;
SQL>wrap iname=a.sql;
PL/SQL Wrapper: Release 8.1.7.0.0 - Production on Tue Nov 27 22:26:48 2001
Copyright (c) Oracle Corporation 1993, 2000. All Rights Reserved.
Processing AA.sql to AA.plb
����AA.plb
@AA.plb ;
145. ��μ�������ĵȴ���
select event,sum(decode(wait_Time,0,0,1)) "Prev",
sum(decode(wait_Time,0,1,0)) "Curr",count(*) "Tot"
from v$session_Wait
group by event order by 4;
146. ��λع��ε����������
select name, waits, gets, waits/gets "Ratio"
from v$rollstat C, v$rollname D
where C.usn = D.usn;
147. ��μ�ر�ռ�� I/O ������
select B.tablespace_name name,B.file_name "file",A.phyrds pyr,
A.phyblkrd pbr,A.phywrts pyw, A.phyblkwrt pbw
from v$filestat A, dba_data_files B
where A.file# = B.file_id
order by B.tablespace_name;
148. ��μ���ļ�ϵͳ�� I/O ������
select substr(C.file#,1,2) "#", substr(C.name,1,30) "Name",
C.status, C.bytes, D.phyrds, D.phywrts
from v$datafile C, v$filestat D
where C.file# = D.file#;
149. �����ĳ���û��������е�������
select user_indexes.table_name, user_indexes.index_name,uniqueness, column_name
from user_ind_columns, user_indexes
where user_ind_columns.index_name = user_indexes.index_name
and user_ind_columns.table_name = user_indexes.table_name
order by user_indexes.table_type, user_indexes.table_name,
user_indexes.index_name, column_position;
150. ��μ�� SGA �������ʣ�
select a.value + b.value "logical_reads", c.value "phys_reads",
round(100 * ((a.value+b.value)-c.value) / (a.value+b.value)) "BUFFER HIT RATIO"
from v$sysstat a, v$sysstat b, v$sysstat c
where a.statistic# = 38 and b.statistic# = 39
and c.statistic# = 40;
151. ��μ�� SGA ���ֵ仺�����������ʣ�
select parameter, gets,Getmisses , getmisses/(gets+getmisses)*100 "miss ratio",
(1-(sum(getmisses)/ (sum(gets)+sum(getmisses))))*100 "Hit ratio"
from v$rowcache
where gets+getmisses <>0
group by parameter, gets, getmisses;
152. ��μ�� SGA �й��������������ʣ�Ӧ��С��1% ��
select sum(pins) "Total Pins", sum(reloads) "Total Reloads",
sum(reloads)/sum(pins) *100 libcache
from v$librarycache;
select sum(pinhits-reloads)/sum(pins) "hit radio",sum(reloads)/sum(pins) "reload
percent"
from v$librarycache;
153. �����ʾ�������ݿ��������ʹ�С��
select count(name) num_instances ,type ,sum(source_size) source_size ,
sum(parsed_size) parsed_size ,sum(code_size) code_size ,sum(error_size)
error_size,
sum(source_size) +sum(parsed_size) +sum(code_size) +sum(error_size) size_required
from dba_object_size
group by type order by 2;
154. ��� SGA ��������־�������������ʣ�Ӧ��С��1%
SELECT name, gets, misses, immediate_gets, immediate_misses,
Decode(gets,0,0,misses/gets*100) ratio1,
Decode(immediate_gets+immediate_misses,0,0,
immediate_misses/(immediate_gets+immediate_misses) *100) ratio2
FROM v$latch WHERE name IN ('redo allocation', 'redo copy');
155. ����ڴ��Ӳ�̵�������ʣ����ʹ��С�� .10������ sort_area_size
SELECT name, value FROM v$sysstat WHERE name IN ('sorts (memory)', 'sorts
(disk)');
156. ��μ�ص�ǰ���ݿ�˭������ʲôSQL��䣿
SELECT osuser, username, sql_text from v$session a, v$sqltext b
where a.sql_address =b.address order by address, piece;
157. ��μ���ֵ仺������
SELECT (SUM(PINS - RELOADS)) / SUM(PINS) "LIB CACHE" FROM V$LIBRARYCACHE;
SELECT (SUM(GETS - GETMISSES - USAGE - FIXED)) / SUM(GETS) "ROW CACHE" FROM
V$ROWCACHE;
SELECT SUM(PINS) "EXECUTIONS", SUM(RELOADS) "CACHE MISSES WHILE EXECUTING" FROM
V$LIBRARYCACHE;
���߳���ǰ��,�˱���С��1%,�ӽ�0%Ϊ�á�
SELECT SUM(GETS) "DICTIONARY GETS",SUM(GETMISSES) "DICTIONARY CACHE GET MISSES"
FROM V$ROWCACHE
158. ��� MTS
select busy/(busy+idle) "shared servers busy" from v$dispatcher;
��ֵ����0.5ʱ��������Ӵ�
select sum(wait)/sum(totalq) "dispatcher waits" from v$queue where
type='dispatcher';
select count(*) from v$dispatcher;
select servers_highwater from v$mts;
servers_highwater�ӽ�mts_max_serversʱ��������Ӵ�
159. ���֪����ǰ�û���ID��?
SQL>SHOW USER;
OR
SQL>select user from dual;
160. ��β鿴��Ƭ�̶ȸߵı�?
SELECT segment_name table_name , COUNT(*) extents
FROM dba_segments WHERE owner NOT IN ('SYS', 'SYSTEM') GROUP BY segment_name
HAVING COUNT(*) = (SELECT MAX( COUNT(*) ) FROM dba_segments GROUP BY
segment_name);
162. ���֪�����ڱ�ռ��еĴ洢���?
select segment_name,sum(bytes),count(*) ext_quan from dba_extents where
tablespace_name='&tablespace_name' and segment_type='TABLE' group by
tablespace_name,segment_name;
163. ���֪�������ڱ�ռ��еĴ洢���?
select segment_name,count(*) from dba_extents where segment_type='INDEX' and
owner='&owner'
group by segment_name;
164�����֪��ʹ��CPU����û�session?
11��cpu used by this session
select a.sid,spid,status,substr(a.program,1,40)
prog,a.terminal,osuser,value/60/100 value
from v$session a,v$process b,v$sesstat c
where c.statistic#=11 and c.sid=a.sid and a.paddr=b.addr order by value desc;
165. ���֪����������־�ļ�?
��8IΪ��
$ORACLE_HOME/NETWORK/LOG/LISTENER.LOG
166. ���֪�������������ļ�?
��8IΪ��
$ORACLE_HOME/NETWORK/ADMIN/LISTENER.ORA
167. ���֪��TNS �����ļ�?
��8IΪ��
$ORACLE_HOME/NETWORK/ADMIN/TNSNAMES.ORA
168. ���֪��Sql*Net �����ļ�?
��8IΪ��
$ORACLE_HOME/NETWORK/ADMIN/SQLNET.ORA
169. ���֪��������־�ļ�?
��8IΪ��
$ORACLE_HOME/ADMIN/SID/BDUMP/SIDALRT.LOG
170. ���֪�������ṹ?
��8IΪ��
$ORACLE_HOME/RDBMS/ADMIN/STANDARD.SQL
171. ���֪�����������ֵ���ͼ?
��8IΪ��
$ORACLE_HOME/RDBMS/ADMIN/CATALOG.SQL
172. ���֪����������������ֵ���ͼ?
��8IΪ��
$ORACLE_HOME/RDBMS/ADMIN/CATAUDIT.SQL
173. ���֪�����������������ֵ���ͼ?
��8IΪ��
$ORACLE_HOME/RDBMS/ADMIN/CATSNAP.SQL
������Ҫ������SQL�����Ż�����! ��Ҫ����ORACLE9I��.
174. /*+ALL_ROWS*/
����������ѡ����ڿ������Ż�����,��������������,ʹ��Դ������С��.
����:
SELECT /*+ALL+_ROWS*/ EMP_NO,EMP_NAM,DAT_IN FROM BSEMPMS WHERE EMP_NO='CCBZZP';
175. /*+FIRST_ROWS*/
����������ѡ����ڿ������Ż�����,����������Ӧʱ��,ʹ��Դ������С��.
����:
SELECT /*+FIRST_ROWS*/ EMP_NO,EMP_NAM,DAT_IN FROM BSEMPMS WHERE EMP_NO='CCBZZP'; 176. /*+CHOOSE*/
������������ֵ����з��ʱ��ͳ����Ϣ,�����ڿ������Ż�����,�������ѵ�������;
������������ֵ���û�з��ʱ��ͳ����Ϣ,�����ڹ��������Ż�����;
����:
SELECT /*+CHOOSE*/ EMP_NO,EMP_NAM,DAT_IN FROM BSEMPMS WHERE EMP_NO='CCBZZP';
177. /*+RULE*/
����������ѡ����ڹ�����Ż�����.
����:
SELECT /*+ RULE */ EMP_NO,EMP_NAM,DAT_IN FROM BSEMPMS WHERE EMP_NO='CCBZZP';
178. /*+FULL(TABLE)*/
�����Ա�ѡ��ȫ��ɨ��ķ���.
����:
SELECT /*+FULL(A)*/ EMP_NO,EMP_NAM FROM BSEMPMS A WHERE EMP_NO='CCBZZP';
179. /*+ROWID(TABLE)*/
��ʾ��ȷ������ָ�������ROWID���з���.
����:
SELECT /*+ROWID(BSEMPMS)*/ * FROM BSEMPMS WHERE ROWID>='AAAAAAAAAAAAAA'
AND EMP_NO='CCBZZP';
180. /*+CLUSTER(TABLE)*/
��ʾ��ȷ������ָ����ѡ���ɨ��ķ��ʷ���,��ֻ�Դض�����Ч.
����:
SELECT /*+CLUSTER */ BSEMPMS.EMP_NO,DPT_NO FROM BSEMPMS,BSDPTMS
WHERE DPT_NO='TEC304' AND BSEMPMS.DPT_NO=BSDPTMS.DPT_NO;
181. /*+INDEX(TABLE INDEX_NAME)*/
�����Ա�ѡ��������ɨ�跽��.
����:
SELECT /*+INDEX(BSEMPMS SEX_INDEX) USE SEX_INDEX BECAUSE THERE ARE FEWMALE
BSEMPMS */ FROM BSEMPMS WHERE SEX='M';
182. /*+INDEX_ASC(TABLE INDEX_NAME)*/
�����Ա�ѡ�����������ɨ�跽��.


1.ASCII ������ָ�����ַ���Ӧ��ʮ������;
select ascii('A') A,ascii('a') a,ascii('0') zero,ascii(' ') space from dual;
A         A      ZERO     SPACE
--------- --------- --------- ---------
65        97        48        32
2.CHR ��������,���ض�Ӧ���ַ�;
select chr(54740) zhao,chr(65) chr65 from dual;
ZH C
-- -
�� A
3.CONCAT ���������ַ���;
select concat('010-','88888888')||'ת23'  ��Ǭ���绰 from dual;
��Ǭ���绰
----------------
010-88888888ת23
4.INITCAP �����ַ��������ַ����ĵ�һ����ĸ��Ϊ��д;
select initcap('smith') upp from dual;
UPP
-----
Smith
5.INSTR(C1,C2,I,J) ��һ���ַ���������ָ�����ַ�,���ط���ָ�����ַ���λ��;
C1    ���������ַ���
C2    ϣ���������ַ���
I     �����Ŀ�ʼλ��,Ĭ��Ϊ1
J     ���ֵ�λ��,Ĭ��Ϊ1
select instr('oracle traning','ra',1,2) instring from dual;
INSTRING
---------
9
6.LENGTH �����ַ����ĳ���;
select name,length(name),addr,length(addr),sal,length(to_char(sal)) from .nchar_tst;
NAME   LENGTH(NAME) ADDR             LENGTH(ADDR)       SAL LENGTH(TO_CHAR(SAL))
------ ------------ ---------------- ------------ --------- --------------------
��Ǭ��            3 �����к�����                6   9999.99                    7
7.LOWER �����ַ���,�������е��ַ�Сд
select lower('AaBbCcDd')AaBbCcDd from dual;
AABBCCDD
--------
aabbccdd
8.UPPER �����ַ���,�������е��ַ���д
select upper('AaBbCcDd') upper from dual;
UPPER
--------
AABBCCDD
9.RPAD��LPAD(ճ���ַ�)
RPAD  ���е��ұ�ճ���ַ�
LPAD  ���е����ճ���ַ�
select lpad(rpad('gao',10,'*'),17,'*')from dual;
LPAD(RPAD('GAO',1
-----------------
*******gao*******
�����ַ�����*������
10.LTRIM��RTRIM
LTRIM  ɾ����߳��ֵ��ַ���
RTRIM  ɾ���ұ߳��ֵ��ַ���
select ltrim(rtrim('   gao qian jing   ',' '),' ') from dual;
LTRIM(RTRIM('
-------------
gao qian jing
11.SUBSTR(string,start,count)
ȡ���ַ���,��start��ʼ,ȡcount��
select substr('13088888888',3,8) from dual;
SUBSTR('
--------
08888888
12.REPLACE('string','s1','s2')
string   ϣ�����滻���ַ������
s1       ���滻���ַ���
s2       Ҫ�滻���ַ���
select replace('he love you','he','i') from dual;
REPLACE('HELOVEYOU','HE','I')
------------------------------
i love you
13.SOUNDEX ����һ����������ַ���������ͬ���ַ���
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
LEADING   ����ǰ����ַ�
TRAILING  ����������ַ�
�����ָ��,Ĭ��Ϊ�ո��
15.ABS ����ָ��ֵ�ľ���ֵ
select abs(100),abs(-100) from dual;
ABS(100) ABS(-100)
--------- ---------
100       100
16.ACOS ���������ҵ�ֵ
select acos(-1) from dual;
ACOS(-1)
---------
3.1415927
17.ASIN ���������ҵ�ֵ
select asin(0.5) from dual;
ASIN(0.5)
---------
.52359878
18.ATAN ����һ�����ֵķ�����ֵ
select atan(1) from dual;
ATAN(1)
---------
.78539816
19.CEIL ���ش��ڻ���ڸ������ֵ���С����
select ceil(3.1415927) from dual;
CEIL(3.1415927)
---------------
4
20.COS ����һ���������ֵ�����
select cos(-3.1415927) from dual;
COS(-3.1415927)
---------------
-1
21.COSH ����һ�����ַ�����ֵ
select cosh(20) from dual;
COSH(20)
---------
242582598
22.EXP ����һ������e��n�η���
select exp(2),exp(1) from dual;
EXP(2)    EXP(1)
--------- ---------
7.3890561 2.7182818
23.FLOOR �Ը���������ȡ����
select floor(2345.67) from dual;
FLOOR(2345.67)
--------------
2345
24.LN ����һ�����ֵĶ���ֵ
select ln(1),ln(2),ln(2.7182818) from dual;
LN(1)     LN(2) LN(2.7182818)
--------- --------- -------------
0 .69314718     .99999999
25.LOG(n1,n2) ����һ����n1Ϊ��n2�Ķ���
select log(2,1),log(2,4) from dual;
LOG(2,1)  LOG(2,4)
--------- ---------
0         2
26.MOD(n1,n2) ����һ��n1����n2������
select mod(10,3),mod(3,3),mod(2,3) from dual;

MOD(10,3)  MOD(3,3)  MOD(2,3)
--------- --------- ---------
1         0         2
27.POWER ����n1��n2�η���
select power(2,10),power(3,3) from dual;
POWER(2,10) POWER(3,3)
----------- ----------
1024         27
28.ROUND��TRUNC
����ָ���ľ��Ƚ�������
select round(55.5),round(-55.4),trunc(55.5),trunc(-55.5) from dual;
ROUND(55.5) ROUND(-55.4) TRUNC(55.5) TRUNC(-55.5)
----------- ------------ ----------- ------------
56          -55          55          -55
29.SIGN ȡ����n�ķ���,����0����1,С��0����-1,����0����0
select sign(123),sign(-100),sign(0) from dual;
SIGN(123) SIGN(-100)   SIGN(0)
--------- ---------- ---------
1         -1         0
30.SIN ����һ�����ֵ�����ֵ
select sin(1.57079) from dual;
SIN(1.57079)
------------
1
31.SIGH ����˫�����ҵ�ֵ
select sin(20),sinh(20) from dual;

SIN(20)  SINH(20)
--------- ---------
.91294525 242582598
32.SQRT ��������n�ĸ�
select sqrt(64),sqrt(10) from dual;
SQRT(64)  SQRT(10)
--------- ---------
8 3.1622777
33.TAN �������ֵ�����ֵ
select tan(20),tan(10) from dual;
TAN(20)   TAN(10)
--------- ---------
2.2371609 .64836083
34.TANH
��������n��˫������ֵ
select tanh(20),tan(20) from dual;
TANH(20)   TAN(20)
--------- ---------
1 2.2371609
35.TRUNC
����ָ���ľ��Ƚ�ȡһ����
select trunc(124.1666,-2) trunc1,trunc(124.16666,2) from dual;
TRUNC1 TRUNC(124.16666,2)
--------- ------------------
100             124.16
36.ADD_MONTHS
���ӻ��ȥ�·�
select to_char(add_months(to_date('199912','yyyymm'),2),'yyyymm') from dual;
TO_CHA
------
200002
select to_char(add_months(to_date('199912','yyyymm'),-2),'yyyymm') from dual;
TO_CHA
------
199910
37.LAST_DAY
�������ڵ����һ��
select to_char(sysdate,'yyyy.mm.dd'),to_char((sysdate)+1,'yyyy.mm.dd') from dual;
TO_CHAR(SY TO_CHAR((S
---------- ----------
2004.05.09 2004.05.10
select last_day(sysdate) from dual;
LAST_DAY(S
----------
31-5�� -04
38.MONTHS_BETWEEN(date2,date1)
����date2-date1���·�
select months_between('19-12��-1999','19-3��-1999') mon_between from dual;
MON_BETWEEN
-----------
9
SQL>selectmonths_between(to_date('2000.05.20','yyyy.mm.dd'),to_date('2005.05.20','yyyy.dd')) mon_betw from dual;
MON_BETW
---------
-60
39.NEW_TIME(date,'this','that')
������thisʱ��=otherʱ�������ں�ʱ��
select to_char(sysdate,'yyyy.mm.dd hh24:mi:ss') bj_time,to_char(new_time
2  (sysdate,'PDT','GMT'),'yyyy.mm.dd hh24:mi:ss') los_angles from dual;
BJ_TIME             LOS_ANGLES
------------------- -------------------
2004.05.09 11:05:32 2004.05.09 18:05:32
40.NEXT_DAY(date,'day')
��������date������x֮�������һ�����ڵ�����
select next_day('18-5��-2001','������') next_day from dual;
NEXT_DAY
----------
25-5�� -01
41.SYSDATE �����õ�ϵͳ�ĵ�ǰ����
select to_char(sysdate,'dd-mm-yyyy day') from dual;
TO_CHAR(SYSDATE,'
-----------------
09-05-2004 ������
trunc(date,fmt)���ո�����Ҫ�����ڽض�,���fmt='mi'��ʾ������,�ض���
select to_char(trunc(sysdate,'hh'),'yyyy.mm.dd hh24:mi:ss') hh,
2  to_char(trunc(sysdate,'mi'),'yyyy.mm.dd hh24:mi:ss') hhmm from dual;
HH                  HHMM
------------------- -------------------
2004.05.09 11:00:00 2004.05.09 11:17:00
42.CHARTOROWID ���ַ���������ת��ΪROWID����
select rowid,rowidtochar(rowid),ename from scott.emp;
ROWID              ROWIDTOCHAR(ROWID) ENAME
------------------ ------------------ ----------
AAAAfKAACAAAAEqAAA AAAAfKAACAAAAEqAAA SMITH
AAAAfKAACAAAAEqAAB AAAAfKAACAAAAEqAAB ALLEN
AAAAfKAACAAAAEqAAC AAAAfKAACAAAAEqAAC WARD
AAAAfKAACAAAAEqAAD AAAAfKAACAAAAEqAAD JONES


SQL�еĵ���¼����
1.ASCII
������ָ�����ַ���Ӧ��ʮ������;
select ascii('A') A,ascii('a') a,ascii('0') zero,ascii(' ') space from dual;
        A         A      ZERO     SPACE
--------- --------- --------- ---------
       65        97        48        32

2.CHR
��������,���ض�Ӧ���ַ�;
select chr(54740) zhao,chr(65) chr65 from dual;
ZH C
-- -
�� A
3.CONCAT
���������ַ���;
select concat('010-','88888888')||'ת23'  ��Ǭ���绰 from dual;
��Ǭ���绰
----------------
010-88888888ת23
4.INITCAP
�����ַ��������ַ����ĵ�һ����ĸ��Ϊ��д;
select initcap('smith') upp from dual;
UPP
-----
Smith

5.INSTR(C1,C2,I,J)
��һ���ַ���������ָ�����ַ�,���ط���ָ�����ַ���λ��;
C1    ���������ַ���
C2    ϣ���������ַ���
I     �����Ŀ�ʼλ��,Ĭ��Ϊ1
J     ���ֵ�λ��,Ĭ��Ϊ1
select instr('oracle traning','ra',1,2) instring from dual;
 INSTRING
---------
        9

6.LENGTH
�����ַ����ĳ���;
select name,length(name),addr,length(addr),sal,length(to_char(sal)) from gao.nchar_tst;
NAME   LENGTH(NAME) ADDR             LENGTH(ADDR)       SAL LENGTH(TO_CHAR(SAL))
------ ------------ ---------------- ------------ --------- --------------------
��Ǭ��            3 �����к�����                6   9999.99                    7

7.LOWER
�����ַ���,�������е��ַ�Сд
select lower('AaBbCcDd')AaBbCcDd from dual;
AABBCCDD
--------
aabbccdd

8.UPPER
�����ַ���,�������е��ַ���д
select upper('AaBbCcDd') upper from dual;
UPPER
--------
AABBCCDD

9.RPAD��LPAD(ճ���ַ�)
RPAD  ���е��ұ�ճ���ַ�
LPAD  ���е����ճ���ַ�
select lpad(rpad('gao',10,'*'),17,'*')from dual;
LPAD(RPAD('GAO',1
-----------------
*******gao*******
�����ַ�����*������

10.LTRIM��RTRIM
LTRIM  ɾ����߳��ֵ��ַ���
RTRIM  ɾ���ұ߳��ֵ��ַ���
select ltrim(rtrim('   gao qian jing   ',' '),' ') from dual;
LTRIM(RTRIM('
-------------
gao qian jing

11.SUBSTR(string,start,count)
ȡ���ַ���,��start��ʼ,ȡcount��
select substr('13088888888',3,8) from dual;
SUBSTR('
--------
08888888

12.REPLACE('string','s1','s2')
string   ϣ�����滻���ַ������
s1       ���滻���ַ���
s2       Ҫ�滻���ַ���
select replace('he love you','he','i') from dual;
REPLACE('H
----------
i love you

13.SOUNDEX
����һ����������ַ���������ͬ���ַ���
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
LEADING   ����ǰ����ַ�
TRAILING  ����������ַ�
�����ָ��,Ĭ��Ϊ�ո��
15.ABS
����ָ��ֵ�ľ���ֵ
select abs(100),abs(-100) from dual;
 ABS(100) ABS(-100)
--------- ---------
      100       100

16.ACOS
���������ҵ�ֵ
select acos(-1) from dual;
 ACOS(-1)
---------
3.1415927

17.ASIN
���������ҵ�ֵ
select asin(0.5) from dual;
ASIN(0.5)
---------
.52359878

18.ATAN
����һ�����ֵķ�����ֵ
select atan(1) from dual;
  ATAN(1)
---------
.78539816

19.CEIL
���ش��ڻ���ڸ������ֵ���С����
select ceil(3.1415927) from dual;
CEIL(3.1415927)
---------------
              4

20.COS
����һ���������ֵ�����
select cos(-3.1415927) from dual;
COS(-3.1415927)
---------------
             -1

21.COSH
����һ�����ַ�����ֵ
select cosh(20) from dual;
 COSH(20)
---------
242582598

22.EXP
����һ������e��n�η���
select exp(2),exp(1) from dual;
   EXP(2)    EXP(1)
--------- ---------
7.3890561 2.7182818

23.FLOOR
�Ը���������ȡ����
select floor(2345.67) from dual;
FLOOR(2345.67)
--------------
          2345

24.LN
����һ�����ֵĶ���ֵ
select ln(1),ln(2),ln(2.7182818) from dual;
    LN(1)     LN(2) LN(2.7182818)
--------- --------- -------------
        0 .69314718     .99999999

25.LOG(n1,n2)
����һ����n1Ϊ��n2�Ķ���
select log(2,1),log(2,4) from dual;
 LOG(2,1)  LOG(2,4)
--------- ---------
        0         2

26.MOD(n1,n2)
����һ��n1����n2������
select mod(10,3),mod(3,3),mod(2,3) from dual;
MOD(10,3)  MOD(3,3)  MOD(2,3)
--------- --------- ---------
        1         0         2

27.POWER
����n1��n2�η���
select power(2,10),power(3,3) from dual;
POWER(2,10) POWER(3,3)
----------- ----------
       1024         27

28.ROUND��TRUNC
����ָ���ľ��Ƚ�������
select round(55.5),round(-55.4),trunc(55.5),trunc(-55.5) from dual;
ROUND(55.5) ROUND(-55.4) TRUNC(55.5) TRUNC(-55.5)
----------- ------------ ----------- ------------
         56          -55          55          -55

29.SIGN
ȡ����n�ķ���,����0����1,С��0����-1,����0����0
select sign(123),sign(-100),sign(0) from dual;
SIGN(123) SIGN(-100)   SIGN(0)
--------- ---------- ---------
        1         -1         0

30.SIN
����һ�����ֵ�����ֵ
select sin(1.57079) from dual;
SIN(1.57079)
------------
           1

31.SIGH
����˫�����ҵ�ֵ
select sin(20),sinh(20) from dual;
  SIN(20)  SINH(20)
--------- ---------
.91294525 242582598

32.SQRT
��������n�ĸ�
select sqrt(64),sqrt(10) from dual;
 SQRT(64)  SQRT(10)
--------- ---------
        8 3.1622777

33.TAN
�������ֵ�����ֵ
select tan(20),tan(10) from dual;
  TAN(20)   TAN(10)
--------- ---------
2.2371609 .64836083

34.TANH
��������n��˫������ֵ
select tanh(20),tan(20) from dual;
 TANH(20)   TAN(20)
--------- ---------
        1 2.2371609

35.TRUNC
����ָ���ľ��Ƚ�ȡһ����
select trunc(124.1666,-2) trunc1,trunc(124.16666,2) from dual;
   TRUNC1 TRUNC(124.16666,2)
--------- ------------------
      100             124.16

36.ADD_MONTHS
���ӻ��ȥ�·�
select to_char(add_months(to_date('199912','yyyymm'),2),'yyyymm') from dual;
TO_CHA
------
200002
select to_char(add_months(to_date('199912','yyyymm'),-2),'yyyymm') from dual;
TO_CHA
------
199910

37.LAST_DAY
�������ڵ����һ��
select to_char(sysdate,'yyyy.mm.dd'),to_char((sysdate)+1,'yyyy.mm.dd') from dual;
TO_CHAR(SY TO_CHAR((S
---------- ----------
2004.05.09 2004.05.10
select last_day(sysdate) from dual;
LAST_DAY(S
----------
31-5�� -04

38.MONTHS_BETWEEN(date2,date1)
����date2-date1���·�
select months_between('19-12��-1999','19-3��-1999') mon_between from dual;
MON_BETWEEN
-----------
          9
SQL>selectmonths_between(to_date('2000.05.20','yyyy.mm.dd'),to_date('2005.05.20','yyyy.mm.dd')) mon_betw from dual;
 MON_BETW
---------
      -60

39.NEW_TIME(date,'this','that')
������thisʱ��=otherʱ�������ں�ʱ��
select to_char(sysdate,'yyyy.mm.dd hh24:mi:ss') bj_time,to_char(new_time
  2  (sysdate,'PDT','GMT'),'yyyy.mm.dd hh24:mi:ss') los_angles from dual;
BJ_TIME             LOS_ANGLES
------------------- -------------------
2004.05.09 11:05:32 2004.05.09 18:05:32

40.NEXT_DAY(date,'day')
��������date������x֮�������һ�����ڵ�����
select next_day('18-5��-2001','������') next_day from dual;
NEXT_DAY
----------
25-5�� -01

41.SYSDATE
�����õ�ϵͳ�ĵ�ǰ����
select to_char(sysdate,'dd-mm-yyyy day') from dual;
TO_CHAR(SYSDATE,'
-----------------
09-05-2004 ������
trunc(date,fmt)���ո�����Ҫ�����ڽض�,���fmt='mi'��ʾ������,�ض���
select to_char(trunc(sysdate,'hh'),'yyyy.mm.dd hh24:mi:ss') hh,
  2  to_char(trunc(sysdate,'mi'),'yyyy.mm.dd hh24:mi:ss') hhmm from dual;
HH                  HHMM
------------------- -------------------
2004.05.09 11:00:00 2004.05.09 11:17:00

42.CHARTOROWID
���ַ���������ת��ΪROWID����
select rowid,rowidtochar(rowid),ename from scott.emp;
ROWID              ROWIDTOCHAR(ROWID) ENAME
------------------ ------------------ ----------
AAAAfKAACAAAAEqAAA AAAAfKAACAAAAEqAAA SMITH
AAAAfKAACAAAAEqAAB AAAAfKAACAAAAEqAAB ALLEN
AAAAfKAACAAAAEqAAC AAAAfKAACAAAAEqAAC WARD
AAAAfKAACAAAAEqAAD AAAAfKAACAAAAEqAAD JONES

43.CONVERT(c,dset,sset)
��Դ�ַ��� sset��һ�������ַ���ת������һ��Ŀ��dset�ַ���
select convert('strutz','we8hp','f7dec') "conversion" from dual;
conver
------
strutz

44.HEXTORAW
��һ��ʮ�����ƹ��ɵ��ַ���ת��Ϊ������

45.RAWTOHEXT
��һ�������ƹ��ɵ��ַ���ת��Ϊʮ������

46.ROWIDTOCHAR
��ROWID��������ת��Ϊ�ַ�����

47.TO_CHAR(date,'format')
select to_char(sysdate,'yyyy/mm/dd hh24:mi:ss') from dual;
TO_CHAR(SYSDATE,'YY
-------------------
2004/05/09 21:14:41

48.TO_DATE(string,'format')
���ַ���ת��ΪORACLE�е�һ������

49.TO_MULTI_BYTE
���ַ����еĵ��ֽ��ַ�ת��Ϊ���ֽ��ַ�
 select to_multi_byte('��') from dual;
TO
--
��

50.TO_NUMBER
���������ַ�ת��Ϊ����
select to_number('1999') year from dual;
     YEAR
---------
     1999

51.BFILENAME(dir,file)
ָ��һ���ⲿ�������ļ�
SQL>insert into file_tb1 values(bfilename('lob_dir1','image1.gif'));

52.CONVERT('x','desc','source')
��x�ֶλ������Դsourceת��Ϊdesc
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
DUMP������fmtָ�����ڲ����ָ�ʽ����һ��VARCHAR2���͵�ֵ
col global_name for a30
col dump_string for a50
set lin 200
select global_name,dump(global_name,1017,8,5) dump_string from global_name;
GLOBAL_NAME                    DUMP_STRING
------------------------------ --------------------------------------------------
ORACLE.WORLD                   Typ=1 Len=12 CharacterSet=ZHS16GBK: W,O,R,L,D

54.EMPTY_BLOB()��EMPTY_CLOB()
�������������������Դ����������ֶν��г�ʼ�������ĺ���

55.GREATEST
����һ����ʽ�е����ֵ,���Ƚ��ַ��ı����С.
select greatest('AA','AB','AC') from dual;
GR
--
AC
select greatest('��','��','��') from dual;
GR
--
��

56.LEAST
����һ����ʽ�е���Сֵ
select least('��','��','��') from dual;
LE
--
��

57.UID
���ر�ʶ��ǰ�û���Ψһ����
show user
USER Ϊ"GAO"
select username,user_id from dba_users where user_id=uid;
USERNAME                         USER_ID
------------------------------ ---------
GAO                                   25

58.USER
���ص�ǰ�û�������
select user from  dual;
USER
------------------------------
GAO

59.USEREVN
���ص�ǰ�û���������Ϣ,opt������:
ENTRYID,SESSIONID,TERMINAL,ISDBA,LABLE,LANGUAGE,CLIENT_INFO,LANG,VSIZE
ISDBA  �鿴��ǰ�û��Ƿ���DBA������򷵻�true
select userenv('isdba') from dual;
USEREN
------
FALSE
select userenv('isdba') from dual;
USEREN
------
TRUE
SESSION
���ػỰ��־
select userenv('sessionid') from dual;
USERENV('SESSIONID')
--------------------
                 152
ENTRYID
���ػỰ�˿ڱ�־
select userenv('entryid') from dual;
USERENV('ENTRYID')
------------------
                 0
INSTANCE
���ص�ǰINSTANCE�ı�־
select userenv('instance') from dual;
USERENV('INSTANCE')
-------------------
                  1
LANGUAGE
���ص�ǰ��������
select userenv('language') from dual;
USERENV('LANGUAGE')
----------------------------------------------------
SIMPLIFIED CHINESE_CHINA.ZHS16GBK
LANG
���ص�ǰ���������Ե���д
select userenv('lang') from dual;
USERENV('LANG')
----------------------------------------------------
ZHS
TERMINAL
�����û����ն˻�����ı�־
select userenv('terminal') from dual;
USERENV('TERMINA
----------------
GAO
VSIZE(X)
����X�Ĵ�С(�ֽ�)��
select vsize(user),user from dual;
VSIZE(USER) USER
----------- ------------------------------
          6 SYSTEM

60.AVG(DISTINCT|ALL)
all��ʾ�����е�ֵ��ƽ��ֵ,distinctֻ�Բ�ͬ��ֵ��ƽ��ֵ
SQLWKS> create table table3(xm varchar(8),sal number(7,2));
����Ѵ���
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
�����ֵ,ALL��ʾ�����е�ֵ�����ֵ,DISTINCT��ʾ�Բ�ͬ��ֵ�����ֵ,��ͬ��ֻȡһ��
select max(distinct sal) from scott.emp;
MAX(DISTINCTSAL)
----------------
            5000

62.MIN(DISTINCT|ALL)
����Сֵ,ALL��ʾ�����е�ֵ����Сֵ,DISTINCT��ʾ�Բ�ͬ��ֵ����Сֵ,��ͬ��ֻȡһ��
select min(all sal) from gao.table3;
MIN(ALLSAL)
-----------
    1111.11

63.STDDEV(distinct|all)
���׼��,ALL��ʾ�����е�ֵ���׼��,DISTINCT��ʾֻ�Բ�ͬ��ֵ���׼��
select stddev(sal) from scott.emp;
STDDEV(SAL)
-----------
  1182.5032
select stddev(distinct sal) from scott.emp;
STDDEV(DISTINCTSAL)
-------------------
           1229.951

64.VARIANCE(DISTINCT|ALL)
��Э����
select variance(sal) from scott.emp;
VARIANCE(SAL)
-------------
    1398313.9

65.GROUP BY
��Ҫ������һ��������ͳ��
select deptno,count(*),sum(sal) from scott.emp group by deptno;
   DEPTNO  COUNT(*)  SUM(SAL)
--------- --------- ---------
       10         3      8750
       20         5     10875
       30         6      9400

66.HAVING
�Է���ͳ���ټ���������
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

67.ORDER BY ���ڶԲ�ѯ���Ľ�������������
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