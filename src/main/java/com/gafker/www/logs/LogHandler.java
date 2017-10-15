package com.gafker.www.logs;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

public class LogHandler {
	private static final Logger LOGGER =LogManager.getLogger(LogHandler.class);
	public void printBefore(){
		System.out.println("方法开始执行。。。");
		LOGGER.info("方法开始执行！"+System.currentTimeMillis());
	}
	public void printAfter(){
		System.out.println("方法结束执行。。。");
		LOGGER.info("方法结束执行！"+System.currentTimeMillis());
	}
}
