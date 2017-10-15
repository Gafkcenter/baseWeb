package com.gafker.www.logs;

import java.util.Date;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

public class TimeHandler {
	private static final Logger LOGGER =LogManager.getLogger(TimeHandler.class);
public void printTime(){
	System.out.println("执行时间:"+new Date()+":"+System.currentTimeMillis());
	LOGGER.info("执行时间！"+new Date());
}
}
