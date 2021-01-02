package com.kh.bom.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.admin.model.service.AdminService;
import com.kh.bom.common.page.MemberPageBarFactory;
import com.kh.bom.common.page.PageBarFactory;
import com.kh.bom.member.model.service.MemberService;
import com.kh.bom.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AdminController {

	@Autowired
	private AdminService service;
	@Autowired
	private MemberService memberService;

	// 회원관리
	// 회원목록
	@RequestMapping("/admin/memberList")
	public ModelAndView memberList(ModelAndView mv,
			@RequestParam(value = "searchType", defaultValue = "all") String searchType,
			@RequestParam(value = "keyword", defaultValue = "") String keyword,
			@RequestParam(value = "cPage", defaultValue = "1") int cPage,
			@RequestParam(value = "numPerpage", defaultValue = "10") int numPerpage,
			@RequestParam(value = "filter", defaultValue = "dateDown") String filter) {
		Map<String, String> map = new HashMap();
		map.put("searchType", searchType);
		map.put("keyword", keyword);
		map.put("filter", filter);
		List<Member> list = service.selectMemberList(cPage, numPerpage, map);
		int totalData = service.selectMemberCount(map);
		mv.addObject("list", list);
		mv.addObject("cPage", cPage);
		mv.addObject("pageBar", MemberPageBarFactory.getMemberPageBar(totalData, cPage, numPerpage,
				"selectMemberSearch", searchType, keyword, filter));
		mv.setViewName("admin/member/memberList");
		return mv;
	}

	// 관리지 권한 변경
	@RequestMapping("/admin/updateManagerYn")
	@ResponseBody
	public boolean updateManagerYn(Member m,HttpSession session) {
		int result = service.updateManagerYn(m);
		return result > 0 ? true : false;
	}

	// 회원검색기능
	@RequestMapping("/admin/selectMemberSearch")
	public ModelAndView selectMemberSearch(ModelAndView mv,
			@RequestParam(value = "searchType", defaultValue = "all") String searchType,
			@RequestParam(value = "keyword", defaultValue = "") String keyword,
			@RequestParam(value = "cPage", defaultValue = "1") int cPage,
			@RequestParam(value = "numPerpage", defaultValue = "10") int numPerpage,
			@RequestParam(value = "filter", defaultValue = "dateDown") String filter) {
		Map<String, String> map = new HashMap();
		map.put("searchType", searchType);
		map.put("keyword", keyword);
		map.put("filter", filter);
		List<Member> list = service.selectMemberList(cPage, numPerpage, map);
		int totalData = service.selectMemberCount(map);
		mv.addObject("list", list);
		mv.addObject("cPage", cPage);
		mv.addObject("filter", filter);
		mv.addObject("searchType", searchType);
		mv.addObject("keyword", keyword);
		mv.addObject("pageBar", MemberPageBarFactory.getMemberPageBar(totalData, cPage, numPerpage,
				"selectMemberSearch", searchType, keyword, filter));
		mv.setViewName("admin/member/memberListAjax");
		return mv;
	}

	// 회원검색자동완성
	@RequestMapping("/admin/memberAutoComplete")
	@ResponseBody
	public List<Member> memberAutoComplete(@RequestParam(value = "type", defaultValue = "all") String type,
			@RequestParam(value = "key") String key) {
		Map<String, String> map = new HashMap();
		map.put("type", type);
		map.put("key", key);
		List<Member> list = service.memberAutoComplete(map);
		return list;
	}

	//전체 회원 이메일 가져오기
	@RequestMapping("/admin/memEmailList")
	@ResponseBody
	public String selectMemEmailList(){
		List<String> list=service.selectMemEmailList();
		String emailList= String.join(",",list); //전체 이메일 스트링으로 변환해 전달
		return emailList;
	}
	
	
	
	
	// 1:1문의
	// qna(1:1) 목록 가져오기
	@RequestMapping("/admin/qnaList")
	public ModelAndView qnaList(ModelAndView mv, @RequestParam(value = "cPage", defaultValue = "0") int cPage,
			@RequestParam(value = "numPerpage", defaultValue = "5") int numPerpage) {

		mv.addObject("list", service.selectQnaList(cPage, numPerpage));
		int totalData = service.selectQnaCount();

		mv.addObject("pageBar", PageBarFactory.getPageBar(totalData, cPage, numPerpage, "qnaList"));
		mv.addObject("totalData", totalData);
		mv.setViewName("admin/qna/qnaList");

		return mv;
	}
	
	
    
}
