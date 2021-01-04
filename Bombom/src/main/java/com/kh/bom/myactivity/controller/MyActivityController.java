package com.kh.bom.myactivity.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.common.page.MypageAjaxPageBarFactory;
import com.kh.bom.common.page.PageBarFactory;
import com.kh.bom.community.model.vo.Community;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.myactivity.model.service.MyActivityService;
import com.kh.bom.review.model.vo.Review;

@Controller
public class MyActivityController {

	@Autowired
	private MyActivityService service;
	
	//구매평 리뷰 가져오기
//	@RequestMapping("/mypage/myActivity")
//	public ModelAndView reviewList(ModelAndView mv, HttpSession session,
//			@RequestParam(value="cPage", defaultValue="1") int cPage,
//			@RequestParam(value="numPerpage",defaultValue="5") int numPerpage) {
//		Member login=(Member) session.getAttribute("loginMember");
//		String memNo=login.getMemNo();
//		
//		//구매평 inquiry 아니고 review 로 바꿔야함
//		List<Review> review=service.selectReviewList(memNo, cPage, numPerpage);
//		int totalDataR=service.selectReviewCount(memNo);
//		
//		//커뮤니티 글 
//		List<Community> community=service.selectComList(memNo,cPage,numPerpage);
//		int totalDataC=service.selectComCount(memNo);
//		mv.addObject("community",community);
//		mv.addObject("review",review);
//		mv.addObject("loginMember",login);
//		mv.addObject("pageBarR",PageBarFactory.getPageBar(totalDataR, cPage, numPerpage, "myActivity"));
//		mv.addObject("pageBarC",PageBarFactory.getPageBar(totalDataC, cPage, numPerpage, "myActivity"));
//		mv.addObject("totalDataR", totalDataR);
//		mv.addObject("totalDataC", totalDataC);
//		
//		mv.setViewName("mypage/myActivity");
//		
//		return mv;
//	}
	
	//내활동내역으로 왔을대 첫화면 -구매평리스트
		@RequestMapping("/mypage/myActivity")
		public ModelAndView myReview(ModelAndView mv, HttpSession session, 
				@RequestParam(value="cPage", defaultValue="1") int cPage,
				@RequestParam(value="numPerpage",defaultValue="5") int numPerpage) {
			Member login=(Member) session.getAttribute("loginMember");
			String memNo=login.getMemNo();
			//구매평
			List<Review> review = service.selectReviewList(memNo,cPage, numPerpage);
			//구매평 갯수
			int totalData = service.selectReviewCount(memNo);
			
			mv.addObject("review", review);			
			mv.addObject("cPage", cPage);
			mv.addObject("pageBarR", MypageAjaxPageBarFactory.getAjaxPageBar(totalData, cPage, numPerpage, "myReviewAjax"));
			mv.addObject("memNo", memNo);
			mv.setViewName("mypage/myActivity");
			
			return mv;
		}
	//구매평 눌럿을때 
		@RequestMapping("/mypage/myReview")
		@ResponseBody
		public ModelAndView myReview2(ModelAndView mv, HttpSession session, 
				@RequestParam(value="cPage", defaultValue="1") int cPage,
				@RequestParam(value="numPerpage",defaultValue="5") int numPerpage) {
			Member login=(Member) session.getAttribute("loginMember");
			String memNo=login.getMemNo();
			//구매평
			List<Review> review = service.selectReviewList(memNo,cPage, numPerpage);
			//구매평 갯수
			int totalData = service.selectReviewCount(memNo);
			
			mv.addObject("review", review);			
			mv.addObject("cPage", cPage);
			mv.addObject("pageBarR", MypageAjaxPageBarFactory.getAjaxPageBar(totalData, cPage, numPerpage, "myReviewAjax"));
			mv.addObject("memNo", memNo);
			mv.setViewName("mypage/myReviewAjax");
			
			return mv;
		}
	//구매평페이징
		@RequestMapping("/mypage/myReviewAjax")
		@ResponseBody
		public ModelAndView productReviewAjax(ModelAndView mv, HttpSession session, 
				int cPage,
				@RequestParam(value="numPerpage",defaultValue="5") int numPerpage) {
			Member login=(Member) session.getAttribute("loginMember");
			String memNo=login.getMemNo();
			//구매평
			List<Review> review = service.selectReviewList(memNo,cPage, numPerpage);
			//구매평 갯수
			int totalData = service.selectReviewCount(memNo);
			
			mv.addObject("review", review);		
			mv.addObject("cPage", cPage);
			mv.addObject("pageBarR", MypageAjaxPageBarFactory.getAjaxPageBar(totalData, cPage, numPerpage, "myReviewAjax"));
			mv.addObject("memNo", memNo);
			mv.setViewName("mypage/myReviewAjax");
			
			return mv;
		}
		
	//내가 쓴 커뮤니티
		@RequestMapping("/mypage/myCommunity")
		@ResponseBody
		public ModelAndView myCommunity(ModelAndView mv, HttpSession session, 
				@RequestParam(value="cPage", defaultValue="1") int cPage,
				@RequestParam(value="numPerpage",defaultValue="5") int numPerpage) {
			Member login=(Member) session.getAttribute("loginMember");
			String memNo=login.getMemNo();

			//커뮤글
			List<Community> community=service.selectComList(memNo,cPage,numPerpage);
			//커뮤글 갯수 
			int totalData=service.selectComCount(memNo);
			
			mv.addObject("community", community);
			
			mv.addObject("cPage", cPage);
			mv.addObject("pageBarC", MypageAjaxPageBarFactory.getAjaxPageBar(totalData, cPage, numPerpage, "myComAjax"));
			mv.addObject("memNo", memNo);
			mv.setViewName("mypage/myComAjax");
			
			return mv;
		}	
	//커뮤니티 페이징
		@RequestMapping("/mypage/myComAjax")
		@ResponseBody
		public ModelAndView myComAjax(ModelAndView mv, HttpSession session, 
				int cPage,
				@RequestParam(value="numPerpage",defaultValue="5") int numPerpage) {
			Member login=(Member) session.getAttribute("loginMember");
			String memNo=login.getMemNo();
			//커뮤니티글
			List<Community> community=service.selectComList(memNo,cPage,numPerpage);
			//커뮤니티 갯수
			int totalData=service.selectComCount(memNo);
			
			mv.addObject("community", community);
			mv.addObject("cPage", cPage);
			mv.addObject("pageBarC", MypageAjaxPageBarFactory.getAjaxPageBar(totalData, cPage, numPerpage, "myComAjax"));
			mv.addObject("memNo", memNo);
			mv.setViewName("mypage/myComAjax");
			
			return mv;
		}
	
	
}
