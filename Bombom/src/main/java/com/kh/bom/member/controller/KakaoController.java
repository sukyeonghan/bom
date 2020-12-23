package com.kh.bom.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
    public ModelAndView kakaoLogin(ModelAndView mv, 
    		@RequestParam(value = "code", required = false) String code, 
    		HttpSession session) throws Exception{
        System.out.println("#code#" + code);
        //access_token 받아오기
        String access_Token=kakaoService.getAccessToken(code); 
        //access_token으로 로그인정보 가져오기
        HashMap<String,Object> userInfo=kakaoService.getUserInfo(access_Token);
        Member loginMember=new Member();
        int result=0;
    	String memNo="";
    	String msg="";
    	String loc="";
    	String viewName="";
    	
    	String kakaoEmail="";
    	String kakaoProfile="";
    	String kakaoNickName="";
        if(userInfo.get("email")!=null) {
        	//받아온정보가 있을경우, 각 정보를 로그인회원으로 세팅
        	kakaoEmail=userInfo.get("email").toString();
        	kakaoProfile=userInfo.get("profile_image").toString();
        	kakaoNickName=userInfo.get("nickname").toString();
        
        	//받아온 이메일 정보로 가입된 회원이 있는지 여부 확인하기
        	Member m=memberService.selectOneMember(kakaoEmail);

        	//이메일정보가 있는 경우 로그인 또는 기존회원 연동필요
        	if(m!=null) {
        		//해당 이메일로 가입한 회원이 있을경우 카카오에서 가져온 정보로  기존정보 업데이트하기
        		memNo=m.getMemNo(); //해당 이메일로 가입한 회원번호 가져오기
        		loginMember.setMemNo(memNo); //회원번호 로그인한 회원객체에 추가 세팅
        		loginMember.setMemSns("카카오");
//        		Member memNickCk=memberService.selectMemberNick(kakaoNickName);
//        		if(memNickCk!=null) { //받아온 닉네임이 이미 있을경우에는 기존의 닉네임으로 두기
//        			loginMember.setMemNick(m.getMemNick()); 
//        		}else {
//        			
//        		}
        		if(m.getMemSns()==null) {
        			System.out.println("기존회원정보와 연동하기전:"+loginMember);
        			result=memberService.updateMember(loginMember); //기존회원정보와 연동
        		}
        		
        		if(result>0) {
        			//업데이트가 성공적으로 이루어졌을경우, 해당 이메일 정보로 등록된 회원정보 다시 가져오기
        			loginMember=memberService.selectOneMember(kakaoEmail); 
        			System.out.println("기존회원정보와 연동후:"+loginMember);
        			
        			//받아온정보 로그인한회원으로 세션에 올리기
        			session.setAttribute("loginMember",loginMember);
            		session.setAttribute("access_Tocken", access_Token);
            		viewName="index";
            		
        		}else {
            		msg="카카오 회원정보로 로그인 실패 - 소셜로그인 실패1";
            		loc="/";
            		viewName="common/msg";
        		}
        	
        		
       		//해당이메일로 가입한 회원이 없을경우 , 신규가입하기
        	}else {
        		loginMember.setMemEmail(kakaoEmail);
            	loginMember.setMemPro(kakaoProfile);
            	loginMember.setMemNick(kakaoNickName);
            	
        		Point p=new Point();
            	p.setPointContent("회원가입");
            	p.setPointChange(2000);
            	loginMember.setMemPwd(kakaoEmail);//비밀번호 낫널 방지 임의값부여
    
            	Member memNickCk=memberService.selectMemberNick(kakaoNickName);
            	if(memNickCk!=null) {
            		//카카오톡의 닉네임을 가진 회원이 있을경우 닉네임변경 페이지로 이동해 회원가입 진행
            		mv.addObject("access_Tocken", access_Token);
            		mv.addObject("insertMember",loginMember);
            		System.out.println("넘어갈값1:"+loginMember);
            		System.out.println("넘어갈값2:"+memNickCk.getMemNick());
            		session.setAttribute("access_Tocken", access_Token);
            		viewName="common/duplicateNick";
            		    		
            	}else {
            		//카카오톡의 닉네임을 가진 회원이 없을경우  회원가입진행
            		result=memberService.insertMember(loginMember, p);
                	if(result>0) {
                		Member member=memberService.selectOneMember(kakaoEmail);
            
                		session.setAttribute("loginMember",member);
                		session.setAttribute("access_Tocken", access_Token);
                		viewName="index";
                	}else {
                		msg="카카오 회원정보로 회원가입실패 -소셜로그인 실패";
                		loc="/";
                		viewName="common/msg";
                	}
            	}
        	}

        	
        	
        }else {
        	msg="카카오 이메일 못불러옴 - 소셜로그인 실패";
    		loc="/";
    		viewName="common/msg";
    	}
 
        mv.addObject("msg",msg );
        mv.addObject("loc",loc);
        mv.setViewName(viewName);
        System.out.println(mv);
        return mv;
        	
        
    }
}
