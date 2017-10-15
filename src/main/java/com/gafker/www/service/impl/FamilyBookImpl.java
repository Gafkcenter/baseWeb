package com.gafker.www.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gafker.www.entity.User;
import com.gafker.www.service.FamilyBook;

@Service
@Transactional
public class FamilyBookImpl implements FamilyBook {
	public static ConcurrentHashMap<Integer, User> datas = new ConcurrentHashMap<Integer, User>();
	public static AtomicInteger primaryKey =new AtomicInteger();
	@Override
	public int insert(User user) {
		int result =0;
		if (user != null) {
			Integer userId = user.getId();
			user.setId(userId=userId!=null?userId:primaryKey.get());
			datas.put(user.getId(), user);
			result =1;
		}
		return result;
	}
	@Override
	public int update(User user) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public List<User> select(User user) {
		List<User> users = null;
		if(datas != null && datas.size()>0){
			users = new ArrayList<User>();
			for(Integer k:datas.keySet()){
				users.add(datas.get(k));
			}
		}
		return users;
	}
	@Override
	public User queryById(Integer id) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public int del(User user) {
		// TODO Auto-generated method stub
		return 0;
	}

}
