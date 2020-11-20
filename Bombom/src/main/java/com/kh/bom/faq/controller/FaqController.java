package com.kh.bom.faq.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.common.page.FaqAjaxPageBarFactory;
import com.kh.bom.common.page.PageBarFactory;
import com.kh.bom.faq.model.service.FaqService;
import com.kh.bom.faq.model.vo.Faq;


@Controller
public class FaqController {
	@Autowired
	private FaqService service;
	
	//faq 자주묻는 질문 처음 갈때 
	@RequestMapping("/faq/faqList")
	public ModelAndView selectFaqList(ModelAndView mv,
			@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerpage",defaultValue="5") int numPerpage,
			@RequestParam(value="category",defaultValue="전체")String category) {
		
		mv.addObject("list",service.selectFaqList(cPage,numPerpage,category));
		int totalData=service.selectFaqCount(category);
		mv.addObject("cPage",cPage);
		mv.addObject("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerpage, "faqList"));
		mv.setViewName("faq/faqList");
		
		return mv;
	}
	
	//카테고리를 눌렀을떄.
	@RequestMapping("/faq/faqListAjax")
	@ResponseBody
	public ModelAndView faqListAjax(ModelAndView mv,int cPage,
			@RequestParam(value="numPerpage",defaultValue="5") int numPerpage,
			@RequestParam(value="category",defaultValue="전체")String category) {
		
		mv.addObject("list",service.selectFaqList(cPage,numPerpage,category));
		int totalData=service.selectFaqCount(category);
		mv.addObject("cPage",cPage);
		mv.addObject("category",category);
		mv.addObject("pageBar",FaqAjaxPageBarFactory.getAjaxPageBar(totalData, cPage, numPerpage, "faqListAjax",category));
		mv.setViewName("faq/faqListAjax");
			
		return mv;
	}

	
	//faq 수정/등록 창으로 전환
	@RequestMapping("/faq/faq")
	public String faq() {
		return "faq/faq";
	}
	
	//faq등록
	@RequestMapping("/faq/insertFaq")
	public ModelAndView insertFaq(Faq f,ModelAndView mv) {
		int result=service.insertFaq(f);
		String msg="";
		String loc="";
		String icon="";
		if(result>0) {
			msg="자주묻는 질문 등록 성공";
			loc="/faq/faqList";
			icon="success"; //icon 종류 : success,error,warning
		}else {
			msg="자주묻는 질문 등록 실패";
			loc="/faq/faq";	
			icon="warning";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		return mv;
	}
	
	//faq삭제
	@RequestMapping("/faq/deleteFaq")
	public ModelAndView deleteFaq(String faqNo, ModelAndView mv) {
		int result=service.deleteFaq(faqNo);
		String msg="";
		String loc="";
		String icon="";
		if(result>0) {
			msg="자주묻는 질문 삭제 성공";
			loc="/faq/faqList";
		}else {
			msg="자주묻는 질문 삭제 실패";
			loc="/faq/faq";	
			icon="warning";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		return mv;
	}
	
	//faq 수정
	@RequestMapping("/faq/updateFaq")
	public ModelAndView selectFaqOne(String faqNo, ModelAndView mv) {
		Faq f=service.selectFaqOne(faqNo);
		mv.addObject("faq",f);
		mv.setViewName("faq/faq");
		return mv;	
	}
	
	@RequestMapping("/faq/updateFaqEnd")
	public ModelAndView updateFaq(Faq f, ModelAndView mv) {
		int result=service.updateFaq(f);
		String msg="";
		String loc="";
		String icon="";
		if(result>0) {
			msg="자주묻는 질문 수정 성공";
			loc="/faq/faqList";
		}else {
			msg="자주묻는 질문 수정 실패";
			loc="/faq/updateFaq?faqNo="+f.getFaqNo();	
			icon="warning";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		return mv;
	}
}