package com.kh.bom.member.controller;

import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.bom.member.model.service.KakaoService;
import com.kh.bom.member.model.service.MemberService;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.member.model.vo.SnsLogin;
import com.kh.bom.member.model.vo.SnsValue;
import com.kh.bom.point.model.vo.Point;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@SessionAttributes({"loginMember","access_Tocken"})
public class SnsController {
	@Autowired
    BCryptPasswordEncoder pwEncoder;
	@Autowired
	private KakaoService kakaoService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private SnsValue naverSns;
	@Autowired
	private SnsValue googleSns;
	
	@RequestMapping("/auth/kakao/callback")
    public String kakaoLogin(Model model, 
    		@RequestParam(value = "code", required = false) String code, 
    		HttpServletRequest request) throws Exception{
        System.out.println("#code#" + code);
        String oldUrl="";
       // 쿠키값 가져오기
        Cookie[] cookies = request.getCookies() ;
        if(cookies != null){
            for(int i=0; i < cookies.length; i++){
                Cookie c = cookies[i] ;
                if(cookies[i].getName().equals("oldUrl")) {
                	oldUrl=cookies[i].getValue();
                }
            }
        }
       
        System.out.println("#oldUrl#" + oldUrl);
        //access_token 받아오기
        String access_Token=kakaoService.getAccessToken(code); 
        //access_token으로 로그인정보 가져오기
        HashMap<String,Object> userInfo=kakaoService.getUserInfo(access_Token);
       
        int result=0;
        int rnd=(int)(Math.random()*10000);
    	String msg="";
    	String loc="";
    	String viewName="";
    	String kakaoEmail="";
    	String kakaoProfile="";
    	String kakaoNickName="";
    	String kakaoId="";
    	String nickYn="Y"; //닉네임 사용가능 여부
		String emailYn="Y"; //이메일 사용가능 여부
    	Member snsMem=new Member();
    	kakaoId=userInfo.get("id").toString();
    	if(userInfo.get("email")!=null) {    		
    		kakaoEmail=userInfo.get("email").toString();
    	}else {
    		kakaoEmail=null;
    	}
    	kakaoProfile=userInfo.get("profile_image").toString();
    	kakaoNickName=userInfo.get("nickname").toString();
    	
        if(userInfo.get("id")!=null) { //값 받아왔는지 확인
        	snsMem.setKakaoId(kakaoId);
        	snsMem.setMemEmail(kakaoEmail);
        	snsMem.setMemPro(kakaoProfile);
        	snsMem.setMemNick(kakaoNickName);
        	
        	Member member = memberService.selectSnsMem(snsMem);
    		if(member != null) {
    			//해당소셜로그인ID로 가입한 회원이 검색될경우 해당 아이디 회원 로그인처리
    			memberService.updateMemLastDate(member.getMemNo());//최근 접속일
    			model.addAttribute("loginMember",member);
    			return "redirect:/"+oldUrl;
        		
    		}else {
    			if(kakaoEmail==null){
    				
    				//이메일로 존재 여부 확인 불가. 신규가입으로 진행. 이메일 반드시 입력받아야 함.
    				Member memNickCk=memberService.selectMemberNick(kakaoNickName);
    	        	if(memNickCk!=null) {
    	        		//받아온 닉네임이 중복될겨웅 닉네임도 받아야함.
    	        		nickYn="N";//닉네임 중복, 사용불가
    	        		emailYn="N";//이메일없음.사용불가
    	        		
    	        	}else {
    	        		emailYn="N";
    	        	}
    	        	snsMem.setMemPwd("소셜"+pwEncoder.encode(rnd+""));//비밀번호 낫널 방지 임의값부여
    	        	model.addAttribute("insertMember",snsMem);
	        		viewName="common/duplicateNick";   
    			}else {
    				
    				//존재하지 않을경우 
        			//이메일로 기존 가입여부 확인
        			Member basicMem=memberService.selectOneMember(kakaoEmail);

        			if(basicMem!=null) {
        				//1.기존 사이트내 회원가입한 회원  - 연결필요, 로그인
        				basicMem.setKakaoId(kakaoId);
        				log.debug("기존회원 sns정보 업데이트: {}",basicMem);
        				result=memberService.updateMember(basicMem);
        				if(result>0) {
        					memberService.updateMemLastDate(basicMem.getMemNo());
                    		model.addAttribute("loginMember",basicMem);
                    		model.addAttribute("access_Tocken", access_Token);
                    		System.out.println("redirect:/"+oldUrl);
                    		return "redirect:/"+oldUrl;
        				}else {
        					msg="소셜 회원정보와 기존회원정보 연동 실패 : 반복될 경우 관리자에게 문의 바랍니다.";
                    		loc="/"+oldUrl;
                    		viewName="common/msg";
        				}

        			}else {
        				//2.처음으로 방문한 회원 신규가입  - 회원가입, 로그인
        				Point p=new Point();
        	        	p.setPointContent("회원가입");
        	        	p.setPointChange(2000);
        	        	
        	        	snsMem.setMemPwd("소셜"+pwEncoder.encode(rnd+""));//비밀번호 낫널 방지 임의값부여
        	        	//소셜닉네임으로 가입된 회원있는지 확인
        	        	Member memNickCk=memberService.selectMemberNick(kakaoNickName);
        	        	if(memNickCk!=null) {
        	        		//해당닉네임을 가진 기존회원이 있을경우, 닉네임변경페이지로 이동
        	        		model.addAttribute("insertMember",snsMem);//그 페이지에서 회원가입 메소드로 가기 때문에 point불필요
        	        		nickYn="N";//닉네임 중복, 사용불가
        	        		viewName="common/duplicateNick";    		
        	        	}else {
        	        		//닉네임을 가진 회원이 없을경우  그대로 회원가입진행
        	        		result=memberService.insertMember(snsMem, p);
        	            	if(result>0) {
        	            		//가입한 회원정보 불러와서 로그인진행
        	            		snsMem=memberService.selectOneMember(kakaoId);
        	            		model.addAttribute("loginMember",snsMem);
        	            		model.addAttribute("access_Tocken", access_Token);
        	            		return "redirect:/"+oldUrl;
        	            	}else {
        	            		msg="소셜 회원정보로 회원가입실패 -소셜로그인 실패: 반복될 경우 관리자에게 문의 바랍니다.";
        	            		loc="/"+oldUrl;
        	            		viewName="common/msg";
        	            	}
        	        	}
        			}
    				
    			}
    			
    			
    			

	        }
    		
        }else {
        	msg="카카오 정보 못불러옴 - 소셜로그인 실패";
    		loc="/"+oldUrl;
    		viewName="common/msg";
	    }
        model.addAttribute("nickYn",nickYn);
    	model.addAttribute("emailYn",emailYn);
        model.addAttribute("loc",loc);
		model.addAttribute("msg",msg);
		model.addAttribute("currentUrl",oldUrl);
        return viewName;
        	
        
    }
	
	
	
	//구글.네이버용
	@RequestMapping(value = "/auth/{snsService}/callback", method = { RequestMethod.GET, RequestMethod.POST})
	public String snsLoginCallback(@PathVariable String snsService,Model model, 
			@RequestParam String code,
			HttpServletRequest request) throws Exception {
		String oldUrl="";
       // 쿠키값 가져오기
        Cookie[] cookies = request.getCookies() ;
         
        if(cookies != null){
             
            for(int i=0; i < cookies.length; i++){
                Cookie c = cookies[i] ;
                if(cookies[i].getName().equals("oldUrl")) {
                	oldUrl=cookies[i].getValue();
                }
            }
        }
		System.out.println("#oldUrl#" + oldUrl);
		log.info("snsLoginCallback: service={}", snsService);
		SnsValue sns = null;
		if (StringUtils.equals("naver", snsService)) {
			sns = naverSns;	
		}else {
			sns = googleSns;	
		}
		
		//1.code이용해서 access_token받기
		//2.access_token을 이용해서 사용자 profile정보가져오기
		SnsLogin snsLogin =new SnsLogin(sns);
		System.out.println("snsLogin"+snsLogin);
		Member snsMem=snsLogin.getUserProfile(code); //프로필정보 담긴 snsMem
		System.out.println("Profile:"+snsMem);
		
		//3.DB snsId여부로 해당 유저가 존재하는 지 체크 (googleId, naverId 컬럼추가)
		Member member = memberService.selectSnsMem(snsMem);
		//Member member = memberService.selectOneMember(snsMem.getMemEmail());
		String snsEmail=snsMem.getMemEmail();
		String snsPro=snsMem.getMemPro();
		String snsNick=snsMem.getMemNick();
		String loc="";
		String msg="";
		String viewName="";
		String nickYn="Y"; //닉네임 사용가능 여부
		String emailYn="Y"; //이메일 사용가능 여부
		int result=0;
		int rnd=(int)(Math.random()*10000);
		if(member != null) {
			
			//해당소셜로그인ID로 가입한 회원이 검색될경우 해당 아이디 회원 로그인처리
			model.addAttribute("loginMember",member);
			return "redirect:/"+oldUrl;
    		
		}else {
			//존재하지 않을경우 
			//1.기존 사이트내 회원가입한 회원  - 연결필요, 로그인
			//2.처음으로 방문한 회원 신규가입  - 회원가입, 로그인
			//위 두가지 경우 존재
			
			//기존사이트 내 회원인지 이메일 일치여부로 검사
			Member basicMem = memberService.selectOneMember(snsEmail); //기존회원정보
			if(basicMem!=null) {
				//1.기존 사이트내 회원가입한 회원  - 연결필요, 로그인
				if(snsMem.getGoogleId()!=null) {
					basicMem.setGoogleId(snsMem.getGoogleId());
				}else if(snsMem.getNaverId()!=null) {
					basicMem.setNaverId(snsMem.getNaverId());
				}
				
				System.out.println("기존회원+sns정보 업데이트할정보"+basicMem);
				result=memberService.updateMember(basicMem);
				if(result>0) {
					memberService.updateMemLastDate(basicMem.getMemNo());//최근접속일
            		model.addAttribute("loginMember",basicMem);
            		return "redirect:/"+oldUrl;
				}else {
					msg="소셜 회원정보와 기존회원정보 연동 실패 : 반복될 경우 관리자에게 문의 바랍니다.";
            		loc="/"+oldUrl;
            		viewName="common/msg";
				}
				
				
			}else {
				//2.처음으로 방문한 회원 신규가입  - 회원가입, 로그인
				Point p=new Point();
	        	p.setPointContent("회원가입");
	        	p.setPointChange(2000);
	        	snsMem.setMemPwd("소셜"+pwEncoder.encode(rnd+""));//비밀번호 낫널 방지 임의값부여
	        	//소셜닉네임으로 가입된 회원있는지 확인
	        	Member memNickCk=memberService.selectMemberNick(snsNick);
	        	if(memNickCk!=null) {
	        		//해당닉네임을 가진 기존회원이 있을경우, 닉네임변경페이지로 이동
	        		model.addAttribute("insertMember",snsMem);//그 페이지에서 회원가입 메소드로 가기 때문에 point불필요
	        		System.out.println("닉네임 변경페이지로 넘어갈 데이터:"+snsMem);
	        		nickYn="N"; 
	        		viewName="common/duplicateNick";    		
	        	}else {
	        		//닉네임을 가진 회원이 없을경우  그대로 회원가입진행
	        		result=memberService.insertMember(snsMem, p);
	            	if(result>0) {
	            		//가입한 회원정보 불러와서 로그인진행
	            		snsMem=memberService.selectOneMember(snsEmail);
	            		model.addAttribute("loginMember",snsMem);
	            		return "redirect:/"+oldUrl;
	            	}else {
	            		msg="소셜 회원정보로 회원가입실패 -소셜로그인 실패: 반복될 경우 관리자에게 문의 바랍니다.";
	            		loc="/"+oldUrl;
	            		viewName="common/msg";
	            	}
	        	}
	        	

			}
		}
		model.addAttribute("nickYn",nickYn);
    	model.addAttribute("emailYn",emailYn);
		model.addAttribute("loc",loc);
		model.addAttribute("msg",msg);
		model.addAttribute("currentUrl",oldUrl);
		return viewName;
	}
}
