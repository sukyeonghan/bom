package com.kh.bom;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.admin.model.service.AdminService;
import com.kh.bom.member.model.service.MemberService;
import com.kh.bom.member.model.vo.Alarm;
import com.kh.bom.member.model.vo.Member;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private AdminService service;
	@Autowired
	private MemberService memberService;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, ModelAndView mv,HttpSession session) {
		logger.info("Welcome home! The client locale is {}.", locale);
		Member m=(Member)session.getAttribute("loginMember");
		if(m!=null) {
			System.out.println("홈컨트롤러에서 "+m);
			System.out.println(m.getMemNo());
			//List<Alarm> alarmList=;
			mv.addObject("countAlarm",memberService.countAlarm(m.getMemNo()));
			mv.addObject("alarmList",memberService.selectAlarmList(m.getMemNo()));
			//System.out.println("알림리스트"+alarmList);
		}
		mv.setViewName("index");
		return mv;
	}
	
}
