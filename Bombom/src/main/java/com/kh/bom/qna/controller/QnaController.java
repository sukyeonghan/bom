package com.kh.bom.qna.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.bom.qna.model.service.QnaService;

@Controller
public class QnaController {
	
	@Autowired
	private QnaService service;
	
	//qna 화면
	@RequestMapping("mypage/qna")
	public String qnaList() {
		return "mypage/qna";
	}
}
