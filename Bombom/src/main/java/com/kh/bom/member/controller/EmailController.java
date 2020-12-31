package com.kh.bom.member.controller;

import java.util.Date;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.bom.member.model.service.MemberService;
import com.kh.bom.member.model.vo.Member;

@Controller

public class EmailController {

	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private MemberService service;
	
	//인증번호 이메일 전송 
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
		
		
		session.setAttribute("veriCode", code);
		session.setAttribute("veriEmail", email);
		session.setMaxInactiveInterval(1*60);
		
		}else {
			 System.out.println("없는 이메일입니다.");
			 System.out.println(email);
			 return code;
			 
		}
		return code;
	}
	
	//인증번호확인 
	@RequestMapping(value="/email/confirm")
	@ResponseBody
	public boolean codeConfirmation(int code, HttpSession session) {
		
		
		int oriCode= (int)session.getAttribute("veriCode");
		System.out.println("인증번호:"+ oriCode);
		System.out.println("내가 쓴 번호"+ code);

		if(oriCode==code) {
			
			return true;
					
		}
			
		return false; 
				
	}
	
	//회원탈퇴,휴먼계정안내 이메일 전송 
	@RequestMapping(value="/email/member")
	@ResponseBody
	public boolean sendEmailMember(Member member,String type, Model m,HttpSession session) throws Exception{
		int result=0;
		String setFrom ="sujeong.dev@gmail.com"; //보내는 사람
		String nick=member.getMemNick(); //받는 회원 닉네임
		String email=member.getMemEmail(); //받는 회원 이메일
		String subject="";
		String text="";
		String day="";
		
		if(type.equals("휴면")) {
			subject="[다시:봄] 장기 비 로그인 계정  휴면 전환안내";
			text="안녕하세요."+nick+"님, 장기간 [다시:봄] 이용이 없으셨던 회원님의 계정이 휴면계정으로 전환될 예정입니다. 이용에 차질이 없도록 사전에 안내 드리면 휴면전환을 원치 않으실경우 "+day+"이전에 [다시:봄]에 방문하셔서 로그인하여 주시기를 바랍니다.";
		}else if(type.equals("개인정보")) {
			subject="[다시:봄] 개인정보 이용안내 ";
			text="안녕하세요. [다시:봄]입니다. 본 메일은 개인정보보호법 제 39조 8 및 동법 시행령 제 48조의 6(개인정보 이용내역 통지)에 따라 회원님께 발송되는 '개인정보 이용내역' 안내 메일입니다. 본 메일은 해당년 1월 1일까지 회원상태를 유지하고 있는 회원님께 발송됩니다. ";
			text+="<table>"
					+ "<tr><th>개인정보수집항목</th><th>이용목적</th></tr>"
					+ "<tr><td>이메일,닉네임,프로필사진</td><td>서비스이용을 위한 회원가입</td></tr>"
					+ "</table>";
		}
		
		try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(email);
            helper.setSubject(subject);
            helper.setText(text,true);
                   
            mailSender.send(message);
            result=1;
            
        }catch(Exception e) {
            e.printStackTrace();
        }
			
		return result>0?true:false;

	}
		
}
