##书店
https://livebook.manning.com/
##密码技术
Java加密与解密技术：http://www.hzbook.com/Books/7452.html

##Java技术
Spring in Action:https://www.manning.com/books/spring-in-action-fourth-edition




##Oracle主键自增
<selectKey resultType="int" order="BEFORE" keyProperty="userId"> 
	SELECT SEQ_ORG_ID.nextval FROM dual 
</selectKey>

##Oracle Md5
CREATE OR REPLACE FUNCTION MD5(
passwd IN VARCHAR2)
RETURN VARCHAR2
IS
retval varchar2(32);
BEGIN
retval := utl_raw.cast_to_raw(DBMS_OBFUSCATION_TOOLKIT.MD5(INPUT_STRING => passwd)) ;
RETURN retval;
END;


##Json 四种提缴方式

http://blog.csdn.net/tycoon1988/article/details/40080691
Linux Git配置
http://www.cnblogs.com/dee0912/p/5815267.html
