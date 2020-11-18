package com.kh.bom.faq.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.faq.model.service.FaqService;
import com.kh.bom.faq.model.vo.Faq;


@Controller
public class FaqController {
	@Autowired
	private FaqService service;
	
	//faq 리스트 
	@RequestMapping("/board/faqList")
	public ModelAndView selectfaqList(ModelAndView mv) {
		mv.addObject("list",service.selectFaqList());
		mv.setViewName("board/faqList");
		return mv;
	}
	
	//faq 수정/등록 창으로 전환
	@RequestMapping("board/faq")
	public String faq() {
		return "board/faq";
	}
	
	//faq등록
	@RequestMapping("/board/insertFaq")
	public ModelAndView insertFaq(Faq f,ModelAndView mv) {
		int result=service.insertFaq(f);
		String msg="";
		String loc="";
		String icon="";
		if(result>0) {
			msg="자주묻는 질문 등록 성공";
			loc="board/faqList";
			icon="success"; //success,error,warning
		}else {
			msg="자주묻는 질문 등록 실패";
			loc="board/faq";	
			icon="warning";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		return mv;
	}
	
	//faq삭제
	@RequestMapping("board/deleteFaq")
	public ModelAndView deleteFaq(String faqNo, ModelAndView mv) {
		int result=service.deleteFaq(faqNo);
		String msg="";
		String loc="";
		String icon="";
		if(result>0) {
			msg="자주묻는 질문 삭제 성공";
			loc="board/faqList";
		}else {
			msg="자주묻는 질문 삭제 실패";
			loc="board/faq";	
			icon="warning";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		return mv;
	}
	
	//faq 수정
	@RequestMapping("board/updateFaq")
	public ModelAndView selectFaqOne(String faqNo, ModelAndView mv) {
		Faq f=service.selectFaqOne(faqNo);
		mv.addObject("faq",f);
		mv.setViewName("board/faq");
		return mv;	
	}
	
	@RequestMapping("/board/updateFaqEnd")
	public ModelAndView updateFaq(Faq f, ModelAndView mv) {
		int result=service.updateFaq(f);
		String msg="";
		String loc="";
		String icon="";
		if(result>0) {
			msg="자주묻는 질문 수정 성공";
			loc="board/faqList";
		}else {
			msg="자주묻는 질문 수정 실패";
			loc="board/updateFaq?faqNo="+f.getFaqNo();	
			icon="warning";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		return mv;
	}
}