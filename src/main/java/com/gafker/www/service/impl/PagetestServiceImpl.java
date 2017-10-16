package com.gafker.www.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gafker.www.entity.Pagetest;
import com.gafker.www.mapper.PagetestMapper;
import com.gafker.www.service.PagetestService;

@Service
public class PagetestServiceImpl implements PagetestService {

	@Autowired
	PagetestMapper pagetestMapper;
	@Override
	public int insertSelective(Pagetest p)  throws Exception{
		int result = pagetestMapper.insertSelective(p);
		return result;
	}

	@Override
	public List<Pagetest> selectAll()  throws Exception{
		return pagetestMapper.selectByExample(null);
	}

}
