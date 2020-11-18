package com.kh.bom.notice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.notice.model.service.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class NoticeController {
	
	@Autowired
	private NoticeService service;
	
	//NoticeList 
	@RequestMapping("/notice/noticeList")
	public ModelAndView selectnoticeList(ModelAndView mv) {
		mv.addObject("list",service.selectNoticeList());
		mv.setViewName("notice/noticeList");
		return mv;
	}
	
	@RequestMapping("/notice/noticeView.do")
	public ModelAndView noticeView(String noticeNo,ModelAndView mv) {
		mv.addObject("notice",service.selectNoticeOne(noticeNo));
		mv.setViewName("notice/noticeView");
		
		return mv;
	}
	

}
