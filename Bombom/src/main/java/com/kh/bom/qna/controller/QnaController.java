package com.kh.bom.qna.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.qna.model.service.QnaService;
import com.kh.bom.qna.model.vo.Qna;

@Controller
public class QnaController {
	
	@Autowired
	private QnaService service;
	
	//qna(1:1) 목록 가져오기
	@RequestMapping("mypage/qna")
	public String qnaList() {
		return "mypage/qna";
	}
	
	@RequestMapping("mypage/qnaWrite")
	public String qnaWrite() {
		return "mypage/qnaWrite";
	}
	
	//qna 글쓰기
	@RequestMapping("mypage/insertQna")
	public ModelAndView insertQna(Qna qna, ModelAndView mv) {
		
		int result = service.insertQna(qna);
		String msg="";
		String loc="";
		String icon="";
		if(result>0) {
			msg="1:1문의 글 작성완료";
			loc="/mypage/qna";
			icon="success";
		}else {
			msg="1:1문의 글 작성 실패";
			loc="/mypage/insertQna";
			icon="warning";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		
		
		return mv;
	}
	
}
