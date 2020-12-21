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

//@Controller
//public class KakaoController {
//	@Autowired
//	private KakaoService kakaoService;
//	@Autowired
//	private MemberService memberService;
//	
//	@RequestMapping("/oauth")
//    public ModelAndView kakaoLogin(ModelAndView mv, @RequestParam(value = "code", required = false) String code, HttpSession session) throws Exception{
//        System.out.println("#code#" + code);
//        //access_token 받아오기
//        String access_Token=kakaoService.getAccessToken(code); 
//        //access_token으로 로그인정보 가져오기
//        HashMap<String,Object> userInfo=kakaoService.getUserInfo(access_Token);
//        Member loginMember=new Member();
//        int result=0;
//    	String memNo="";
//    	
//        if(userInfo.get("email")!=null) {
//        	//받아온정보가 있을경우, 각 정보를 로그인회원으로 세팅
//        	loginMember.setMemEmail(userInfo.get("email").toString());
//        	loginMember.setMemPro(userInfo.get("profile_image").toString());
//        	loginMember.setMemNick(userInfo.get("nickname").toString());
//        	
//        	//받아온 이메일 정보로 가입된 회원이 있는지 여부 확인하기
//        	Member m=memberService.selectOneMember(userInfo.get("email").toString());
//
//        	//해당이메일주소로 가입한 회원이 있을경우, 없을 경우 어떻게 할지 정해야할 필요 잆음.
//        	//소셜로그인 회원 따로 저장? sns_mem테이블에 ???, 그냥 컬럼 추가?
//        	if(m!=null) {
//        		//해당 이메일로 가입한 회원이 있을경우 기존정보 업데이트하기
//        		memNo=m.getMemNo(); //해당 이메일로 가입한 회원번호 가져오기
//        		loginMember.setMemNo(memNo); //회원번호 로그인한 회원객체에 추가 세팅
//        		result=memberService.updateMember(loginMember); //받아온 정보로 업데이트
//        		if(result>0) {
//        			//업데이트가 성공적으로 이루어졌을경우, 해당 이메일 정보로 등록된 회원정보 다시 가져오기
//        			loginMember=memberService.selectOneMember(userInfo.get("email").toString()); 
//        			System.out.println("소셜로그인 세션에 올라갈 정보:"+loginMember);
//        			//받아온정보 로그인한회원으로 세션에 올리기
//        			session.setAttribute("loginMember",loginMember);
//            		session.setAttribute("access_Tocken", access_Token);
//            		mv.setViewName("index");
//            		
//        		}else {
//        			mv.addObject("msg","소셜로그인실패");
//            		mv.addObject("loc","/");
//            		mv.setViewName("common/msg");
//        		}
//        		
//       		//해당이메일로 가입한 회원이 없을경우 , 가입하기
//        	}else {
//        		Point p=new Point();
//            	p.setPointContent("회원가입");
//            	p.setPointChange(2000);
//            	loginMember.setMemPwd("0000");//비밀번호 낫널처리 해제 필요 , 마이페이지 메뉴 접근 어디까지 할지 의논필요
//            	Member mem=memberService.selectMemberNick(userInfo.get("nickname").toString());
//            	//카카오톡의 닉네임을 가진 회원이 있을경우
//            	if(mem!=null) {
//            		System.out.println("넘어오냐?"+mem);
//            		mv.addObject("nick",mem.getMemNick());
//            		mv.addObject("insertMember",loginMember);
//            		System.out.println("넘어갈값1:"+loginMember);
//            		System.out.println("넘어갈값2:"+mem.getMemNick());
//            		
//            		mv.setViewName("common/duplicateNick");
//            		
//            		
//            	}else {
//            		result=memberService.insertMember(loginMember, p);
//                	if(result>0) {
//                		Member member=memberService.selectOneMember(userInfo.get("email").toString());
//                		loginMember.setMemNo(member.getMemNo());
//                		session.setAttribute("loginMember",loginMember);
//                		session.setAttribute("access_Tocken", access_Token);
//                		mv.setViewName("index");
//                	}else {
//                		mv.addObject("msg","소셜로그인실패");
//                		mv.addObject("loc","/");
//                		mv.setViewName("common/msg");
//                	}
//            	}
//            	
//            	
//        	}
//
//        	
//        }else {
//    		mv.addObject("msg","소셜로그인실패");
//    		mv.addObject("loc","/");
//    		mv.setViewName("common/msg");
//    		
//    	}
//        
// 
//        return mv;
//        	
//        
//    }
//}

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
        if(userInfo.get("email")!=null) {
        	//받아온정보가 있을경우, 각 정보를 로그인회원으로 세팅
        	loginMember.setMemEmail(userInfo.get("email").toString());
        	loginMember.setMemPro(userInfo.get("profile_image").toString());
        	loginMember.setMemNick(userInfo.get("nickname").toString());
        	
        	//받아온 이메일 정보로 가입된 회원이 있는지 여부 확인하기
        	Member m=memberService.selectOneMember(userInfo.get("email").toString());

        	//해당이메일주소로 가입한 회원이 있을경우, 없을 경우 어떻게 할지 정해야할 필요 잆음.
        	//소셜로그인 회원 따로 저장? sns_mem테이블에 ???, 그냥 컬럼 추가?
        	if(m!=null) {
        		//해당 이메일로 가입한 회원이 있을경우 기존정보 업데이트하기
        		memNo=m.getMemNo(); //해당 이메일로 가입한 회원번호 가져오기
        		loginMember.setMemNo(memNo); //회원번호 로그인한 회원객체에 추가 세팅
        		result=memberService.updateMember(loginMember); //받아온 정보로 업데이트
        		if(result>0) {
        			//업데이트가 성공적으로 이루어졌을경우, 해당 이메일 정보로 등록된 회원정보 다시 가져오기
        			loginMember=memberService.selectOneMember(userInfo.get("email").toString()); 
        			System.out.println("소셜로그인 세션에 올라갈 정보:"+loginMember);
        			//받아온정보 로그인한회원으로 세션에 올리기
        			session.setAttribute("loginMember",loginMember);
            		session.setAttribute("access_Tocken", access_Token);
            		viewName="index";
            		
        		}else {
            		msg="소셜로그인 실패";
            		loc="/";
            		viewName="common/msg";
        		}
        		
       		//해당이메일로 가입한 회원이 없을경우 , 가입하기
        	}else {
        		Point p=new Point();
            	p.setPointContent("회원가입");
            	p.setPointChange(2000);
            	loginMember.setMemPwd("0000");//비밀번호 낫널처리 해제 필요 , 마이페이지 메뉴 접근 어디까지 할지 의논필요
            	Member mem=memberService.selectMemberNick(userInfo.get("nickname").toString());
            	//카카오톡의 닉네임을 가진 회원이 있을경우
            	if(mem!=null) {
            		System.out.println("중복닉네임회원:"+mem);
            		mv.addObject("nick",mem.getMemNick());
            		mv.addObject("insertMember",loginMember);
            		System.out.println("넘어갈값1:"+loginMember);
            		System.out.println("넘어갈값2:"+mem.getMemNick());
            		
            		viewName="common/duplicateNick";
            		    		
            	}else {
            		result=memberService.insertMember(loginMember, p);
                	if(result>0) {
                		Member member=memberService.selectOneMember(userInfo.get("email").toString());
                		loginMember.setMemNo(member.getMemNo());
                		session.setAttribute("loginMember",loginMember);
                		session.setAttribute("access_Tocken", access_Token);
                		mv.setViewName("index");
                	}else {
                		msg="소셜로그인 실패";
                		loc="/";
                		viewName="common/msg";
                	}
            	}
        	}

        }else {
        	msg="소셜로그인 실패";
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
