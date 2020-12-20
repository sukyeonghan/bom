package com.kh.bom.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.member.model.service.KakaoService;
import com.kh.bom.member.model.service.MemberService;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.point.model.vo.Point;

@Controller
public class KakaoController {
	@Autowired
	private KakaoService kakaoService;
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/oauth")
    public ModelAndView kakaoLogin(ModelAndView mv, @RequestParam(value = "code", required = false) String code, HttpSession session) throws Exception{
        System.out.println("#########" + code);
        String access_Token=kakaoService.getAccessToken(code); 
        HashMap<String,String> userInfo=kakaoService.getUserInfo(access_Token);
        Member loginMember=new Member();
        if(userInfo.get("email")!=null) {
        	loginMember.setMemEmail(userInfo.get("email"));
        	loginMember.setMemPro(userInfo.get("profile_image"));
        	loginMember.setMemNick(userInfo.get("nickname"));
        	Member m=memberService.selectOneMember(userInfo.get("email"));
        	int result=0;
        	String memNo="";
        	//해당이메일주소로 가입한 회원이 있을경우, 없을 경우 어떻게 할지 정해야할 필요 잆음.
        	//소셜로그인 회원 따로 저장? sns_mem??, 그냥 컬럼 추가?
        	if(m!=null) {
        		//해당 이메일로 가입한 회원이 있을경우
        		//기존정보 업데이트
        		memNo=m.getMemNo();
        		loginMember.setMemNo(memNo);
        		result=memberService.updateMember(loginMember);
        		if(result>0) {
        			loginMember=memberService.selectOneMember(userInfo.get("email"));
        			System.out.println("소셜로그인 세션에 올라갈 정보:"+loginMember);
        			session.setAttribute("loginMember",loginMember);
            		session.setAttribute("access_Tocken", access_Token);
            		mv.setViewName("index");
        		}else {
        			mv.addObject("msg","소셜로그인실패");
            		mv.addObject("loc","/");
            		mv.setViewName("common/msg");
        		}
        		
        	}else {
        		//해당이메일로 가입한 회원이 없을경우 , 가입
        		Point p=new Point();
            	p.setPointContent("회원가입");
            	p.setPointChange(2000);
            	loginMember.setMemPwd("0000");//비밀번호 낫널처리 해제 필요 , 마이페이지 메뉴 접근 어디까지 할지 의논필요
            	result=memberService.insertMember(loginMember, p);
            	if(result>0) {
            		Member member=memberService.selectOneMember(userInfo.get("email"));
            		loginMember.setMemNo(member.getMemNo());
            		session.setAttribute("loginMember",loginMember);
            		session.setAttribute("access_Tocken", access_Token);
            		mv.setViewName("index");
            	}else {
            		mv.addObject("msg","소셜로그인실패");
            		mv.addObject("loc","/");
            		mv.setViewName("common/msg");
            	}
        	}

        }else {
    		mv.addObject("msg","소셜로그인실패");
    		mv.addObject("loc","/");
    		mv.setViewName("common/msg");
    	}
        return mv;
        	
        
    }
}
