package com.gafker.www.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gafker.www.service.PagetestService;

@Controller
@RequestMapping("test")
public class PagetestController {
@Autowired
	PagetestService pagetestService;
}
