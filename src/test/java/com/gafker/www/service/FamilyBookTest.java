package com.gafker.www.service;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.gafker.www.base.BaseTest;
import com.gafker.www.entity.User;

public class FamilyBookTest extends BaseTest{
	
	@Autowired
	FamilyBook familyBook;

	@Test
	public void testInsert() {
		User user=new User();
		user.setUserName("Gafker"+Math.random());
		Integer result = familyBook.insert(user);
		assertTrue(result>0);
	}

	@Test
	public void testUpdate() {
		fail("Not yet implemented");
	}

	@Test
	public void testSelect() {
		User user = null;
		List<User> users = familyBook.select(user);
		assertTrue(users.size()>0);
	}

	@Test
	public void testQueryById() {
		fail("Not yet implemented");
	}

	@Test
	public void testDel() {
		fail("Not yet implemented");
	}

}
