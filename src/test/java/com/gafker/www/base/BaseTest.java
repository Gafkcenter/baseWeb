package com.gafker.www.base;

import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class) //用于配置spring中测试的环境 
@ContextConfiguration(locations="classpath:spring/applicationContext-aop.xml") //用于指定配置文件所在的位置
//@Transactional
public class BaseTest {
	final Logger logger = LoggerFactory.getLogger(BaseTest.class);  
/**
 * Test配置类
 */
}
