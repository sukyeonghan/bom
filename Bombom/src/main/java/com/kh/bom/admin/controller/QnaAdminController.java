package com.kh.bom.admin.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.admin.model.service.AdminService;
import com.kh.bom.common.page.PageBarFactory;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.qna.model.vo.Qna;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class QnaAdminController {

	@Autowired
	private AdminService service;
	
	@RequestMapping("/admin/qnaAnswer")
	public ModelAndView qnaAnswer(String qnaAnswer, String qnaNo, String qnaWriter,ModelAndView mv) {
		Qna q= new Qna();
		q.setQnaAnswer(qnaAnswer);
		q.setQnaNo(qnaNo);
		System.out.println(qnaAnswer+qnaNo+qnaWriter);
		int result=service.insertQnaAnswer(q);
		String msg = "";
		String loc = "";
		String icon = "";
		String category="";
		String receiverNo="";
	
		if(result>0) {
			msg = "답변이 등록되었습니다";
			loc = "/admin/qnaList";
			icon = "success";
			category="oneQna";
			receiverNo=qnaWriter;
		}else {
			msg = "답변을 다시 등록해주세요";
			loc = "/admin/qnaList";
			icon = "warning";
		}
		
		mv.addObject("category", category);
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon",icon);
		mv.addObject("receiverNo",receiverNo);
		mv.setViewName("common/msg");
		
		return mv;
	}
	
	@RequestMapping("/admin/deleteQna")
	public ModelAndView deleteQna(String qnaNo, ModelAndView mv, HttpSession session) {

		System.out.println(qnaNo);
		int result=service.deleteQna(qnaNo);
		
		String msg="";
		String loc="";
		String icon="";
		if(result>0) {
			msg="문의글을 삭제되었습니다.";
			loc="/admin/qnaList";
			icon="success";
		}else {
			msg="문의글을 다시 삭제해주세요..";
			loc="/admin/qnaList";
			icon="warning";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		
		return mv;
		
	}
	
	@RequestMapping("/admin/qnaWait")
	public ModelAndView qnaFilter(ModelAndView mv, @RequestParam(value = "cPage", defaultValue = "0") int cPage,
			@RequestParam(value = "numPerpage", defaultValue = "5") int numPerpage) {

		mv.addObject("list", service.selectQnaWaitList(cPage, numPerpage));
		int totalData = service.selectQnaCount();

		mv.addObject("pageBar", PageBarFactory.getPageBar(totalData, cPage, numPerpage, "qnaList"));
		mv.addObject("totalData", totalData);
		mv.setViewName("admin/qna/qnaList");

		return mv;
	}
	
}
