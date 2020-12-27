package com.kh.bom;

import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.admin.model.service.AdminService;
import com.kh.bom.member.model.service.MemberService;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.member.model.vo.SnsLogin;
import com.kh.bom.member.model.vo.SnsValue;

/**
 * Handles requests for the application home page.
 */
@Controller
@SessionAttributes({"naver_url","google_url"})
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private AdminService service;
	@Autowired
	private MemberService memberService;
	@Inject
	private SnsValue naverSns;
	@Inject
	private SnsValue googleSns;
	@Inject
	private GoogleConnectionFactory googleConnectionFactory;
	@Inject
	private OAuth2Parameters googleOAuth2Parameters;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, ModelAndView mv,HttpSession session) {
		logger.info("Welcome home! The client locale is {}.", locale);
		Member m=(Member)session.getAttribute("loginMember");
		if(m!=null) {
			//List<Alarm> alarmList=;
			//mv.addObject("countAlarm",memberService.countAlarm(m.getMemNo()));
			//mv.addObject("alarmList",memberService.selectAlarmList(m.getMemNo()));
			session.setAttribute("countAlarm", memberService.countAlarm(m.getMemNo()));
			//session.setAttribute("alarmList", memberService.selectAlarmList(m.getMemNo()));
			//System.out.println("알림리스트"+alarmList);
			session.setAttribute("loginMember",memberService.selectMemberOne(m.getMemNo()));
		}
		//url주소 넘겨주기
		SnsLogin snsLogin = new SnsLogin(naverSns);
		mv.addObject("naver_url", snsLogin.getNaverAuthURL());
		
//		SnsLogin googleLogin = new SnsLogin(googleSns);
//		mv.addObject("google_url", googleLogin.getNaverAuthURL());
		/* 구글code 발행을 위한 URL 생성 */
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		
		mv.addObject("google_url", url);
		
		mv.addObject("loginMember", m);
		mv.setViewName("index");
		return mv;
	}
	
	
}
