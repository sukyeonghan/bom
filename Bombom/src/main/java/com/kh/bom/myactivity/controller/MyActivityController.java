package com.kh.bom.myactivity.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.common.page.PageBarFactory;
import com.kh.bom.community.model.vo.Community;
import com.kh.bom.inquiry.model.vo.Inquiry;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.myactivity.model.service.MyActivityService;

@Controller
public class MyActivityController {

	@Autowired
	private MyActivityService service;
	
	//구매평 리뷰 가져오기
	@RequestMapping("/mypage/myActivity")
	public ModelAndView reviewList(ModelAndView mv, HttpSession session,
			@RequestParam(value="cPage", defaultValue="0") int cPage,
			@RequestParam(value="numPerpage",defaultValue="5") int numPerpage) {
		Member login=(Member) session.getAttribute("loginMember");
		String memNo=login.getMemNo();
		
		//구매평 inquiry 아니고 review 로 바꿔야함
		List<Inquiry> review=service.selectReviewList(memNo, cPage, numPerpage);
		int totalData=service.selectReviewCount(memNo);
		
		//커뮤니티 글 
		List<Community> community=service.selectComList(memNo,cPage,numPerpage);
		//int totalD=service.selectComCount(memNo);
		mv.addObject("community",community);
		mv.addObject("review",review);
		mv.addObject("loginMember",login);
		mv.addObject("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerpage, "myActivity"));
		mv.addObject("totalData", totalData);
		
		mv.setViewName("mypage/myActivity");
		
		return mv;
	}
	
	
	
	
}
