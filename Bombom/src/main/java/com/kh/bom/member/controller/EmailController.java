package com.kh.bom.member.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.kh.bom.member.model.service.MemberService;
import com.kh.bom.member.model.vo.Member;

@Controller
@SessionAttributes("veriCode")
public class EmailController {

	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private MemberService service;

	@RequestMapping(value="/email/auth")
	@ResponseBody
	public int sendEmail(String email,Model m, HttpSession session) throws Exception{
		Member mem=service.selectMemberEmail(email);
		
		int code=0;
		if(mem!=null) {
		
		System.out.println(mem);
		Random random =new Random();
		code=random.nextInt(900000)+100000;
		
	

		String setFrom ="blue604321@gmail.com";
		String toMail = email;
		String title = "[다시:봄]비밀번호 생성을 위한 인증번호 이메일입니다.";
		String content = "인증번호는" + code + "입니다.";
		
		try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
		
		System.out.println(code);
		m.addAttribute("veriCode",code);

		
		}else {
			 System.out.println("없는 이메일입니다.");
			 System.out.println(email);
			 return code;
			 
		}
		return code;
	}
	
	
	@RequestMapping(value="/email/confirm")
	@ResponseBody
	public boolean codeConfirmation(String code, String oriCode) {
		
		System.out.println("인증번호:"+ oriCode);
		System.out.println("내가 쓴 번호"+ code);
		if(oriCode.equals(code)) {
			return true;
		}
			
		
			
		return false; 
				
	}
	
}
