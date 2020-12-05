package com.kh.bom.qna.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.common.page.PageBarFactory;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.qna.model.service.QnaService;
import com.kh.bom.qna.model.vo.Qna;

@Controller
public class QnaController {
	
	@Autowired
	private QnaService service;
	
	//qna(1:1) 목록 가져오기
	@RequestMapping("mypage/qna")
	public ModelAndView qnaList(ModelAndView mv, HttpSession session,
			@RequestParam(value="cPage", defaultValue="0") int cPage,
			@RequestParam(value="numPerpage", defaultValue="5") int numPerpage) {
		Member login= (Member) session.getAttribute("loginMember");
		String memNo=login.getMemNo();
		
		mv.addObject("list", service.selectQnaList(memNo,cPage,numPerpage));
		int totalData=service.selectCount(memNo);
		mv.addObject("loginMember", login);
		mv.addObject("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerpage, "qna"));
		mv.addObject("totalData", totalData);
		mv.setViewName("mypage/qna");
		
		return mv;
	}
	//qna 글쓰기 화면 이동
	@RequestMapping("mypage/qnaWrite")
	public String qnaWrite() {
		return "mypage/qnaWrite";
	}
	
	//qna 글작성 
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
