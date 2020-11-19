package com.kh.bom.notice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.notice.model.service.NoticeService;
import com.kh.bom.notice.model.vo.Notice;


@Controller
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
	//게시글 상세보기
	@RequestMapping("/notice/noticeView.do")
	public ModelAndView noticeView(String noticeNo,ModelAndView mv) {
		mv.addObject("notice",service.selectNoticeOne(noticeNo));
		mv.setViewName("notice/noticeView");
		
		return mv;
	}
	
	//notice 수정/등록 창으로 전환
		@RequestMapping("notice/noticeForm")
		public String notice() {
			return "notice/noticeForm";
		}
	
		//notice등록
	@RequestMapping("/notice/insertNotice")
	public ModelAndView insertNotice(Notice notice, ModelAndView mv) {
		int result=service.insertNotice(notice);
		String msg="";
		String loc="";
		String icon="";
		if(result>0) {
			msg="공지사항 등록 성공";
			loc="notice/noticeList";
			icon="success"; 
		}else {
			msg="게시글 등록 실패";
			loc="notice/noticeForm";	
			icon="warning";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		return mv;
	}

	
	//notice삭제
	@RequestMapping("notice/deleteNotice")
	public ModelAndView deleteNotice(String noticeNo,ModelAndView mv) {
	int result = service.deleteNotice(noticeNo);
	String msg="";
	String loc="";
	String icon="";
	if(result>0) {
		msg="공지글 삭제 성공";
		loc="notice/noticeList";
	}else {
		msg="공지글 삭제 실패";
		loc="notice/noticeList";	
		icon="warning";
	}
	mv.addObject("msg",msg);
	mv.addObject("loc",loc);
	mv.addObject("icon",icon);
	mv.setViewName("common/msg");
	return mv;
}
//notice 수정
	@RequestMapping("notice/updateNotice")
	public ModelAndView selectNoticeOne(String noticeNo, ModelAndView mv) {
		Notice notice =service.selectNoticeOne(noticeNo);
		mv.addObject("notice",notice);
		mv.setViewName("notice/noticeForm");
		return mv;	
	}
	
	@RequestMapping("/notice/updateNoticeEnd")
	public ModelAndView updateNotice(Notice notice, ModelAndView mv) {
		int result=service.updateNotice(notice);
		String msg="";
		String loc="";
		String icon="";
		if(result>0) {
			msg="게시글 수정 성공";
			loc="notice/noticeList";
		}else {
			msg="게시글 수정 실패";
			loc="notice/updateNotice?noticeNo="+notice.getNoticeNo();	
			icon="warning";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		return mv;
	}
		
	}
	
