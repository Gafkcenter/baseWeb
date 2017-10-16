package com.gafker.www.service;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.util.Date;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.gafker.www.base.BaseTest;
import com.gafker.www.entity.Pagetest;

public class PagetestServiceTest extends BaseTest{
	@Autowired
	PagetestService pagetestService;

	@Test
	public void testInsertSelective() throws Exception {
		Pagetest p = new Pagetest();
		p.setQrcode("xxxxx"+Math.random());
		p.setStartTime(new Date());
		int result = pagetestService.insertSelective(p);
		assertTrue(result>0);
	}

	@Test
	public void testSelectAll() {
		fail("Not yet implemented");
	}

}
