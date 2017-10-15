package com.gafker.www.service;

import java.util.List;

import com.gafker.www.entity.User;

public interface FamilyBook {
	int insert(User user);
	int update(User user);
	List<User>  select(User user);
	User queryById(Integer id);
	int del(User user);

}
