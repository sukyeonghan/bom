package com.kh.bom.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.member.model.service.MemberService;
import com.kh.bom.member.model.vo.Member;

@Controller
public class memberController {
    @Autowired
    private MemberService service;
	
    @Autowired
    BCryptPasswordEncoder pwEncoder;
    
    
	@RequestMapping("/mypage/orderStatus")
	public ModelAndView order(ModelAndView mv) {
		
		//주문내역
		
		mv.setViewName("mypage/orderStatus");
		return mv;
	}
	
	@RequestMapping("/mypage/updateMember")
	public String updateMember() {
		return "mypage/updateMemberPwCk";
	}
	//회원정보수정 접근시 비밀번호 체크
	@RequestMapping("/member/updateMemberpwdCk")
	public String updateMemberPwCk(String memPwd,String memEmail,Model m){
		memEmail="abc@naver.com";
		//아이디로 회원정보가져오기
		Member mem=service.selectMemberOne(memEmail);
		String msg="";
		String loc="";
		//회원비밀번호와 매개변수 비밀번호가 일치하면 true,일치하지 않으면  false
		//if(pwEncoder.matches(memPwd, m.getMemPwd())) {
		if(mem.getMemPwd().equals(memPwd)) {
			m.addAttribute("loginMember",mem);//로그인 구현시 삭제할것
			loc="mypage/updateMemberView";
			
		}else {
			m.addAttribute("msg","비밀번호가 일치하지 않습니다.");
			m.addAttribute("loc","/mypage/updateMember");
			loc="common/msg";
		}
		return loc;
		
	}
	@RequestMapping("/member/deleteMember")
	public String deleteMember(String memNo,Model m) {
		int result=service.deleteMember(memNo);
		String loc="";
		if(result>0) {
			loc="redirect:/";
		}else {
			m.addAttribute("msg","회원탈퇴 실패");
			m.addAttribute("icon","warning");
			m.addAttribute("loc","/mypage/updateMember");
			loc="common/msg";
		}
		return loc;
	}
	
}
