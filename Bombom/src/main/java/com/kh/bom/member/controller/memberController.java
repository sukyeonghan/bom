package com.kh.bom.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.member.model.service.MemberService;
import com.kh.bom.member.model.vo.Member;

@Controller
@SessionAttributes("loginMember")
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
	//회원정보수정 전 비밀번호 체크화면
	@RequestMapping("/mypage/updateMember")
	public String updateMember() {
		return "mypage/updateMemberPwCk";
	}
	//회원정보수정 접근시 비밀번호 체크
	@RequestMapping("/member/updateMemberView")
	public ModelAndView updateMemberPwCk(String memPwd,String memNo,ModelAndView mv){
		
		//회원번호로 회원정보가져오기
		Member login=service.selectMemberOne(memNo);
		String msg="";
		String loc=""; 
		//회원비밀번호와 매개변수 비밀번호가 일치하면 true,일치하지 않으면  false
		if(pwEncoder.matches(login.getMemPwd(), memPwd)) {
			mv.setViewName("mypage/updateMemberView");
			
		}else {
			mv.addObject("msg","비밀번호가 일치하지 않습니다.");
			mv.addObject("loc","/mypage/updateMember");
			mv.setViewName("common/msg");
		}
		return mv;
		
	}
	//회원삭제
	@RequestMapping("/member/deleteMember")
	public ModelAndView deleteMember(String memNo,ModelAndView mv) {
		int result=service.deleteMember(memNo);
		if(result>0) {
			mv.setViewName("redirect:/");
		}else {
			mv.addObject("msg","회원탈퇴 실패");
			mv.addObject("icon","warning");
			mv.addObject("loc","/mypage/updateMember");
			mv.setViewName("common/msg");
		}
		return mv;
	}
	//닉네임 중복검사
	@RequestMapping("/member/checkDuplicateNick")
	@ResponseBody
	public boolean checkDuplicateNick(String memNick) {
		Member m=service.selectMemberNick(memNick);
		//닉네임이 있으면 false,없으면 true
		return m!=null?false:true;
	}
	
	//회원정보수정
	@RequestMapping("/member/updateMemberEnd")
	public ModelAndView updateMember(Member m,
			@RequestParam(value="upload",required=false) MultipartFile[] upFile,
			ModelAndView mv, HttpSession session) throws Exception {
		String path=session.getServletContext().getRealPath("/resources/upload/profile");
		File dir = new File(path);
		if(!dir.exists())dir.mkdirs(); //경로상에 없는 폴더 생성
		for(MultipartFile f : upFile) {
			if(!f.isEmpty()) {
				//본래 파일이름 가져오기
				String originalName=f.getOriginalFilename();
				//확장자 분리
				String ext=originalName.substring(originalName.lastIndexOf(".")+1);
				//리네임양식정하기
				SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
				int rndValue=(int)(Math.random()*1000);
				String reName="pro"+sdf.format(System.currentTimeMillis())+"_"+rndValue+"."+ext;
				try {
					f.transferTo(new File(path+"/"+reName));
				}catch(IOException e) {
					e.printStackTrace();
				}
				m.setMemPro(reName); //리네임한 파일이름 프로필로 넣기
			}
		}
		
		//비밀번호 암호화처리 - 회원가입 후에 살릴것
		String oriPw=m.getMemPwd();
		m.setMemPwd(pwEncoder.encode(oriPw));
		
		int result=service.updateMember(m);
		String msg="";
		String loc="/mypage/updateMember";
		String icon="";
		if(result>0) {
			msg="회원정보가 수정되었습니다.";
			icon="success";
		}else {
			msg="회원정보가 수정되지 않았습니다. 반복될경우 관리자에게 문의하세요.";
			icon="warning";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		return mv;
	}
	
	
	//회원가입
	@RequestMapping("/member/enrollMember")
	public String enrollMember(Member mem,
			@RequestParam(value="nick") String nick,
			@RequestParam(value="email") String email,
			@RequestParam(value="password") String password,
			Model m) {
		mem.setMemNick(nick);
		mem.setMemEmail(email);
		mem.setMemPwd(password);
		
		//패스워드 암호화처리
		String oriPw=mem.getMemPwd();
		
		mem.setMemPwd(pwEncoder.encode(oriPw));
		
		int result=service.insertMember(mem);
		m.addAttribute("msg",result>0?"다시:봄 회원이 되셨습니다.":"회원가입 실패!!!!!!");
		m.addAttribute("loc","/");
		
		
		return "common/msg";
	}
	
	//로그인
	@RequestMapping("/member/loginMember")
	public String loginMember(String email, String password, Model m) {
		
		Member login=service.selectOneMember(email);
		//암호화된 비번 비교 
		if(pwEncoder.matches(password, login.getMemPwd())) {
			m.addAttribute("loginMember",login);
		}else {
			//로그인 실패
		}
		
		
		return "redirect:/";
				
	}
	
	@RequestMapping("/member/logout")
	public String logout(SessionStatus ss) {
		//세션이 살아있으면, 
		if(!ss.isComplete()) {
			ss.setComplete();
		}
		return "redirect:/";		
	}
	
	
}
