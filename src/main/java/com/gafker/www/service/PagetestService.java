package com.gafker.www.service;

import java.util.List;

import com.gafker.www.entity.Pagetest;

public interface PagetestService {
int insertSelective(Pagetest p) throws Exception;
List<Pagetest> selectAll() throws Exception;
}
