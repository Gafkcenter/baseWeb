#2017 ##2017.7 ###27

Game CDN 2017.7.27 费用过高待定

1.1.47M 2.费用26/月/M 3.费用过高 URL encode&decode

dfd dfdf fdfd MD5 验签 & Base64

http://blog.csdn.net/xifeijian/article/details/8209731 @熊锋(熊锋) 网页金币筹码兑换加密逻辑参考CSRF攻击原理 dfdf fdfd WorldTime 2017.7.30 done

GMT 图像审核&用户详情部时长天数 图像审核pass 完成

收不到开播提醒 2017.7.28进行中 项目内部已经发出主要是Jpush延迟导致

家族管理提现审核除0错误 完成2017.7.28 52.211.75.21

实现转换器与格式化器对日期操作与配置 （完成）下一步扩展Long to Date Converter 两种格式间互换 Formatter 字符串转换到其它格式 Spring 验证器

###31

Jpush vshowId=1949684 done

活动业务完成 （幸运大转盘,7日欢迎颂,分享直播（每日达指定数量）,设置头像（状态表中有记录任务已做）,关注主播（一次性到达指定数量））

版本迭代问题(向前兼容) ...活动迭代 ...接口迭代新版本（不同版本用不同的Controller,Service,Mapper） 命名规则：功能模块名Vxx

安全性加密（URL编码,验签,加密） 网页金币筹码兑换加密逻辑参考CSRF攻击原理 http://blog.csdn.net/xifeijian/article/details/8209731

服务器器动态切换 IOS收益与支付方式隐藏（Ios解决） 审核热切换：调用API地址,调用IM地址（解决APP中地址不能自由切换问题）

外网服务器使用 能登录了 数据库还边不上通过客户端

时区上班统计异常 1910465 ####vshowId:1745253 searchStartTime:1501430400000 searchEndTime:1501516740000 timezone:8 startTime:2017-07-31 00:00 endTime:2017-07-31 23:59

startTime GMT0+ZONE
endTime GMT0+ZONE
search GMT0-zoneP+zoneU
two Days
2017-08-01 22:21:22

1. 筹码流水 需求：
筛选条件。 vshowID、昵称、起始时间、结束时间，选择筹码流水类型（百万豪礼天天送、观看直播任务1、观看直播任务
金币兑换筹码、筹码兑换金币、游戏彩金、游戏消耗） 2．排序条件。 当前账户筹码倒序、当前账户筹码升序、 单次筹码流水升序、单次筹码流水倒序。

查询结果统计。 当在搜索条件下，先在上方显示总计结果。 显示文案如下： 查询结果：共x条记录，由y人产生，累计增加筹码m,累计减少筹码n。

列表结果字段。 Vshowid（点击可跳转）、昵称、当前账户筹码总数、时间、筹码流水（减少以-a表示，增加以b表示）、
流水类型。 相关表: 任务送筹码 ta_activity_task_record 金币兑换筹码 vmoney_to_vcoin_record 玩游戏消耗筹码 co_product_usage_record     <h3>done</h3>

2. 可做任务列表 百万好社，直播一，直播二  <h3>done</h3>

3. 近期工作 时区 ios收益隐藏 done ios第三方支付隐藏 <h3>done</h3>
4. 用户任务完成状态 强制更新 游戏推送 <h3>done</h3>


###外网测试服
1.外网测试数据库在哪？外网测试服上开通客户端连接； <h3>done</h3>
2.Redis开通客户端连接；done3.游戏数据库 有吗？  <h3>done</h3>
3.在哪，游戏不通   <h3>done</h3>
4.IM通吗？  <h3>done</h3> v00  send to ...


5.app 游戏真人压注，赢钱推送  <h3>done</h3> v3 80%
6.部署最新内容到外网测试。 v1  done
7.项目放上git v2 done 


###游戏推送
####真人推送  80%
####机器人推送 0%
####推送后台参数设置 0%
...活动连续领取  vshow_Id =24045
...支付失败状态保存不对
...游戏房间结果不一致
...秒停无效

???机器人的要推给所有房间吗？
???下注信息推到那种类型范围？
...dev测试服务器完善。
...内部测试服务器完善。
...消息推送文档完善。

+++配置Dev环境：使用之能够正常运转（数据库用21，redis用21，im用80，游戏用80）
>>>im 改成 80 ip test   <h3>done</h3>
>>>游戏改成80 ip test   <h3>done</h3>

+++内网测试环境：确认使用之正常运转（im 能够共用吗？，游戏能够共用吗） <h3>done 分开</h3>

++++推送按范围推真人推送限制完成。  <h3>done</h3>

###2017.8.14
整理运营管理后台文档: 20%
整理IM接口文档: 100%
完善真人配置缓存读取 WAIT
完善机器人推送策略  DELAY

###2017.8.15

CHIP AMMOUNT done
ACT TASK
        bug fix 5013 返回 200  done
        bug fix n+1 天问题     done
        query account          done
   ...全服推送问题。            done
   ...机器人分组推送问题        ongoing
   推送等级的顺序 更改 Type 
           FULLSEND(10000, "fullSend"),//钱最多 单局游戏彩金超过此值即选择全服消息推送形式
           ROOMSEND(10001, "roomSend"),//钱最少 单局游戏彩金超过此值即选择单房间聊天框推送形式
           ROOMVERTICALSEND(10002, "roomVerticalSend");//钱中等 单局游戏彩金超过此值即选择单房间弹屏推送形式
   
#### 2017.8.17

推送行等级对比确认
图片路径异常                      done
机器人推送异常    delay
按房间状态推送
上线准备   ***用户任务数据初始化。
Robot推送   delay


#### 2017.8.21
im上线调试     delay
out_test db link deploy  done ---repeat vshow-config in server tomcat
机器人推送异常    ongoing
  
   支付问题 delay
   加密问题 代码实行
   项目架构问题 
   UI问题 
   流程图问题 must
   异常 must
   
   
   
#### 2017.8.28
    处理历史数据问题
        1.先拿vshow_id =1949684做测试    <b>pass</b> 完成4家经济公司所有认证主播8月直播天数数据的计算完善,运营可以正常显示计算 done
            设置duration_start=end_time-start_time
            设置timezone=家族的timezone
        2. GetLives数据更新 delay
        3. 机器人显示推送不急时 SendMsg    done
        4. 上脉统计默认区间为月初到当前时间  <b>pass</b> 完成，更改完成（从默认查最近一周改到默认查当前所有月的数据）--运营后台上脉统计和家族后台上脉统计
        5. 传文件静态文件到CDN  done 完成
        6. 分享送活动    mind     22222
           活动完成没有变灰 test   deploy done
        7.webSocket delay
        8.游戏列表没有按时间排序  pass
        9.房间心跳开启停止记录  done
        
#### 2017.8.29
    1. 确认做任务是否正确 pass done
    2. 确认任务列表的兼容性，老版本会显示哪些  usepush=0展示 新版本<=数据库规定版本展示 pass done 
    3. 7日欢乐颂进行中。。。  done
    4. 1.一次性任务next_do_level>1就说明已经做；2.每日任务task_do_time=当天表示已经做；3.跨多天任务查任务开始时间到当前时间或任务最近一次的task_do_time到当前时间是否有相关的操作记录 remaind
       对于多天任务，通过next_do_level确认是否超过次数
   

    
#### 2017.9.6 
    支付问题 delay
       加密问题 代码实行
       项目架构问题 
       UI问题 
       流程图问题 must
       异常 must
       vshow_id:1960966 user_id:345675 59时:57分:51秒   工时结果不一致
       自动部署(自动化部署) must
       Junit Test must
       多线程与任务系统 must 
       代码整洁
       mysql sql  must
       
       
       已经完成3大功能：1.机器人分开发送；2.增加关闭房间记录；3.增加七日欢乐颂任务；4.增加分享任务。
#### 2017.9.11
    Intellj maven deploy
    maven 配置依赖第3rd part 包
    
#### 2017.9.13
    后台图片监控功能显示私密聊天图片   done
    WebSocket后台视频监控id不一致
    用户图片列表显示 手机端调试中
       
#### 2017.9.14
   用户图片列表功能上外网测试
   运营后台图片监控增加私密房间图片上外网测试
   Jenkis,Maven 配置
   上麦统计默认搜索条件设置
   WebSocket 视频监控bug
#### 2017.9.23
	抽奖的并发问题:http://blog.csdn.net/qq_16681169/article/details/53750704
	#### Maven 创建Java EE 项目: C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Notepad++
	Oracle操作: http://www.cnblogs.com/ycdx2001/p/3464649.html
	Eclipse插件安装： http://blog.csdn.net/dylan619/article/details/46839941
	Oracle Mybatis Generatoer 分页：http://www.360doc.com/content/13/0513/12/7471983_285096815.shtml
	
####万物和润,创业兴邦 上海市徐汇区徐虹中路20号（西岸创意产业园）2号楼5楼
----------------------------------------------------------------------------------------------------------------------------------------------------	
#润邦Start 2017.9.27
#### 项目结构
#### 项目技术
#2017.10.9项目业务
描述：
已经完成：熟悉企业商端和政府端需求;分析需求完成接口文档;规范出接口JSON格式。 
下周计划：1.将接口与对应数据库表对上;
		 2.对于业务逻辑较复杂的生成流程图;
		 3.实现具体的业务接口。
##工作任务
	1. 深入理解业务逻辑
		1.1  接口完善(字段属性设置)10.9 AM
		1.2 接口完善(与表对接,确定JSON数据)10.10
			TBDB 公共功能00 建筑信息表
			TOPR_报价项目02 项目建筑表
			TSYS_日志
			TSNS_朋友，朋友圈
			TSHP_商家，下单，购物
			TRPT_运营
			TPTH_广告
			TPOP_第3方核心业务
			TPCP_平台信息,建筑信息表
			TMEM_会员表
			TBBS_论坛
			TAIF_帐务
			GAZETTEER 地名索引，地名词典;
		1.3 接口完善 使用表与接口对应
			Junit Test 生成模拟数据
	2. 业务与表对应
	3. 业务逻辑图绘制
	---------------
##架构思维
	1. 数据结构
	2. 事务
	3. 安全机制
	4. 缓存使用
	5. 分布式开发
	
	 >>>问题解决: spring加载资源文件中classpath*与classpath的区别 
	 	http://blog.csdn.net/qq3516744991/article/details/50757650
	 	classpath:只能加载找到的第一个资源文件.(上面只匹配了com/eloan/bu/mapper/business下的mapper文件,而com/eloan/base/mapper就陪忽略了)
	 >>>国庆前申报：已经完成：熟悉企业商端和政府端需求;分析需求完成接口文档;规范出接口JSON格式。 下周计划：1.将接口与对应数据库表对上;2.对于业务逻辑较复杂的生成流程图;3.实现具体的业务接口。
	>>>工作早报：本周任务：1. 理解政府与企业版数据库结构；2.接口文档返回JSON数据填充完整;3.与前端讨论对接确认接口数量和所需要的参数。

	
	报价项目:http://180.169.233.35:8090/Maven_Project/IBG.do
	



