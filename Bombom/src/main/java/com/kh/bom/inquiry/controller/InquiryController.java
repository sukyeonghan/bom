package com.kh.bom.inquiry.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.inquiry.model.service.InquiryService;
import com.kh.bom.inquiry.model.vo.Inquiry;
import com.kh.bom.member.model.service.MemberService;
import com.kh.bom.member.model.vo.Member;

@Controller
public class InquiryController {
	@Autowired
	private InquiryService service;
	@Autowired
	private MemberService memberservice;
	
	//상품문의 등록 
	@RequestMapping("/product/insertInquiry")
	public ModelAndView inquiry(String pdtNo, Inquiry i, ModelAndView mv, HttpSession session) {

		System.out.println("상품문의등록"+pdtNo);
		Member m = (Member)session.getAttribute("loginMember");
		int result = service.insertInquiry(i);
		String msg = "";
		String loc = "";
		String icon = "";
		
		if(result>0) {
			mv.addObject("loginMember", memberservice.selectMemberOne(m.getMemNick()));
			msg = "문의글이 등록되었습니다";
			loc = "/product/productOne?pdtNo="+pdtNo;
			icon = "success";
		}else {
			msg = "문의글을 다시 등록해주세요";
			loc = "/product/productOne?pdtNo="+pdtNo;
			icon = "warning";
		}
		
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		return mv;
		
	}
	
	//상품문의 모달창에서 답변하기
	@RequestMapping("/inquiry/insertInquiryAnswer")
	public ModelAndView inquiryAnswer(String pdtNo, Inquiry i, String pdtName, String receiver,ModelAndView mv) {
		
		int result = service.insertInquiryAnswer(i);
		System.out.println("상품문의 내용:"+i);
		String msg = "";
		String loc = "";
		String icon = "";
		String category="";
		String receiverNo="";
		String bascket="";
		
		if(result>0) {
			msg = "답변이 등록되었습니다";
			loc = "/product/productOne?pdtNo="+pdtNo;
			icon = "success";
			category="productQna";
			receiverNo=receiver;
			bascket=pdtName;
		}else {
			msg = "답변을 다시 등록해주세요";
			loc = "/product/productOne?pdtNo="+pdtNo;
			icon = "warning";
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon",icon);
		mv.addObject("category",category);
		mv.addObject("receiverNo",receiverNo);
		mv.addObject("bascket",bascket);
		mv.setViewName("common/msg");
		return mv;		
		
	}
	
	//상품문의 삭제
	@RequestMapping("/inquiry/deleteInquiry")
	public ModelAndView deleteInquiry(String pdtNo, String inqNo, ModelAndView mv) {
		
		System.out.println("문의삭제"+pdtNo);
		int result = service.deleteInquiry(inqNo);
		String msg = "";
		String loc = "";
		String icon = "";
		
		if(result>0) {
			msg = "게시글이 삭제되었습니다";
			loc = "/product/productOne?pdtNo="+pdtNo;
			icon = "success";
		}else {
			msg = "게시글을 다시 삭제해주세요";
			loc = "/product/productOne?pdtNo="+pdtNo;
			icon = "warning";
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		return mv;
	}	
	
	//상품문의 답변삭제
	@RequestMapping("/inquiry/deleteInquiryAnswer")
	public ModelAndView deleteInquiryAnswer(String pdtNo, String inqNo, ModelAndView mv) {
		
		int result = service.deleteInquiryAnswer(inqNo);
		String msg = "";
		String loc = "";
		String icon = "";
		
		if(result>0) {
			msg = "답변이 삭제되었습니다";
			loc = "/product/productOne?pdtNo="+pdtNo;
			icon = "success";
		}else {
			msg = "답변을 다시 삭제해주세요";
			loc = "/product/productOne?pdtNo="+pdtNo;
			icon = "warning";
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		return mv;
		
	}
	
	//상품문의 수정
	@RequestMapping("/inquiry/updateInquiry")
	public ModelAndView updateInquiry(String pdtNo, Inquiry i, ModelAndView mv) {
		
		int result = service.updateInquiry(i);
		String msg = "";
		String loc = "";
		String icon = "";
		
		if(result>0) {
			msg = "문의가 수정되었습니다";
			loc = "/product/productOne?pdtNo="+pdtNo;
			icon = "success";
		}else {
			msg = "문의를 다시 작성해주세요";
			loc = "/product/productOne?pdtNo="+pdtNo;
			icon = "warning";
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		return mv;
	}
	
	//상품문의 관리자답변 수정
	@RequestMapping("/inquiry/updateInquiryAnswer")
	public ModelAndView updateInquiryAnswer(String pdtNo, Inquiry i, ModelAndView mv) {
		
		int result = service.updateInquiryAnswer(i);
		String msg = "";
		String loc = "";
		String icon = "";
		
		if(result>0) {
			msg = "답변이 수정되었습니다";
			loc = "/product/productOne?pdtNo="+pdtNo;
			icon = "success";
		}else {
			msg = "답변을 다시 작성해주세요";
			loc = "/product/productOne?pdtNo="+pdtNo;
			icon = "warning";
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		return mv;	
	}
	
	
	
	
}
