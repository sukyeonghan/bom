package com.kh.bom.member.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

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
	private KakaoService kakaoService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private SnsValue naverSns;
	@Autowired
	private SnsValue googleSns;
	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;
	
	@RequestMapping("/auth/kakao/callback")
    public String kakaoLogin(Model model, 
    		@RequestParam(value = "code", required = false) String code, 
    		HttpSession session) throws Exception{
        System.out.println("#code#" + code);
        //access_token 받아오기
        String access_Token=kakaoService.getAccessToken(code); 
        //access_token으로 로그인정보 가져오기
        HashMap<String,Object> userInfo=kakaoService.getUserInfo(access_Token);
       
        int result=0;
    	String msg="";
    	String loc="";
    	String viewName="";
    	String kakaoEmail="";
    	String kakaoProfile="";
    	String kakaoNickName="";
    	String kakaoId;
    	
    	Member snsMem=new Member();
    	kakaoId=userInfo.get("id").toString();
    	kakaoEmail=userInfo.get("email").toString();
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
    			model.addAttribute("loginMember",member);
        		viewName="redirect:/";
        		
    		}else {
    			//존재하지 않을경우 
    			//이메일로 기존 가입여부 확인
    			Member basicMem=memberService.selectOneMember(kakaoEmail);

    			if(basicMem!=null) {
    				//1.기존 사이트내 회원가입한 회원  - 연결필요, 로그인
    				basicMem.setKakaoId(kakaoId);
    				System.out.println("기존회원+sns정보 업데이트할정보"+basicMem);
    				result=memberService.updateMember(basicMem);
    				if(result>0) {
                		model.addAttribute("loginMember",basicMem);
                		model.addAttribute("access_Tocken", access_Token);
                		viewName="redirect:/";
    				}else {
    					msg="소셜 회원정보와 기존회원정보 연동 실패 : 반복될 경우 관리자에게 문의 바랍니다.";
                		loc="/";
                		viewName="common/msg";
    				}

    			}else {
    				//2.처음으로 방문한 회원 신규가입  - 회원가입, 로그인
    				Point p=new Point();
    	        	p.setPointContent("회원가입");
    	        	p.setPointChange(2000);
    	        	snsMem.setMemPwd("소셜로그인회원");//비밀번호 낫널 방지 임의값부여
    	        	//소셜닉네임으로 가입된 회원있는지 확인
    	        	Member memNickCk=memberService.selectMemberNick(kakaoNickName);
    	        	if(memNickCk!=null) {
    	        		//해당닉네임을 가진 기존회원이 있을경우, 닉네임변경페이지로 이동
    	        		model.addAttribute("insertMember",snsMem);//그 페이지에서 회원가입 메소드로 가기 때문에 point불필요
    	        		System.out.println("닉네임 변경페이지로 넘어갈 데이터:"+snsMem);
    	        		viewName="common/duplicateNick";    		
    	        	}else {
    	        		//닉네임을 가진 회원이 없을경우  그대로 회원가입진행
    	        		result=memberService.insertMember(snsMem, p);
    	            	if(result>0) {
    	            		//가입한 회원정보 불러와서 로그인진행
    	            		snsMem=memberService.selectOneMember(kakaoId);
    	            		model.addAttribute("loginMember",snsMem);
    	            		model.addAttribute("access_Tocken", access_Token);
    	            		viewName="redirect:/";
    	            	}else {
    	            		msg="소셜 회원정보로 회원가입실패 -소셜로그인 실패: 반복될 경우 관리자에게 문의 바랍니다.";
    	            		loc="/";
    	            		viewName="common/msg";
    	            	}
    	        	}
    			}
    			

	        }
    		
        }else {
        	msg="카카오 정보 못불러옴 - 소셜로그인 실패";
    		loc="/";
    		viewName="common/msg";
	    }
        model.addAttribute("loc",loc);
		model.addAttribute("msg",msg);
        return viewName;
        	
        
    }
	
	//구글.네이버용
	@RequestMapping(value = "/auth/{snsService}/callback", method = { RequestMethod.GET, RequestMethod.POST})
	public String snsLoginCallback(@PathVariable String snsService,
			Model model, @RequestParam String code, HttpSession session) throws Exception {
		
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
		
		Member snsMem=snsLogin.getUserProfile(code);
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
		int result=0;
		if(member != null) {
			
			//해당소셜로그인ID로 가입한 회원이 검색될경우 해당 아이디 회원 로그인처리
			model.addAttribute("loginMember",member);
    		viewName="redirect:/";
    		
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
				}else if(snsMem.getKakaoId()!=null) {
					basicMem.setKakaoId(snsMem.getKakaoId());
				}
				System.out.println("기존회원+sns정보 업데이트할정보"+basicMem);
				result=memberService.updateMember(basicMem);
				if(result>0) {
            		model.addAttribute("loginMember",basicMem);
            		viewName="redirect:/";
				}else {
					msg="소셜 회원정보와 기존회원정보 연동 실패 : 반복될 경우 관리자에게 문의 바랍니다.";
            		loc="/";
            		viewName="common/msg";
				}
				
				
			}else {
				//2.처음으로 방문한 회원 신규가입  - 회원가입, 로그인
				Point p=new Point();
	        	p.setPointContent("회원가입");
	        	p.setPointChange(2000);
	        	snsMem.setMemPwd("소셜로그인회원");//비밀번호 낫널 방지 임의값부여
	        	//소셜닉네임으로 가입된 회원있는지 확인
	        	Member memNickCk=memberService.selectMemberNick(snsNick);
	        	if(memNickCk!=null) {
	        		//해당닉네임을 가진 기존회원이 있을경우, 닉네임변경페이지로 이동
	        		model.addAttribute("insertMember",snsMem);//그 페이지에서 회원가입 메소드로 가기 때문에 point불필요
	        		System.out.println("닉네임 변경페이지로 넘어갈 데이터:"+snsMem);
	        		viewName="common/duplicateNick";    		
	        	}else {
	        		//닉네임을 가진 회원이 없을경우  그대로 회원가입진행
	        		result=memberService.insertMember(snsMem, p);
	            	if(result>0) {
	            		//가입한 회원정보 불러와서 로그인진행
	            		snsMem=memberService.selectOneMember(snsEmail);
	            		model.addAttribute("loginMember",snsMem);
	            		viewName="redirect:/";
	            	}else {
	            		msg="소셜 회원정보로 회원가입실패 -소셜로그인 실패: 반복될 경우 관리자에게 문의 바랍니다.";
	            		loc="/";
	            		viewName="common/msg";
	            	}
	        	}
	        	

			}
		}
		
		model.addAttribute("loc",loc);
		model.addAttribute("msg",msg);
		return viewName;
	}
}
