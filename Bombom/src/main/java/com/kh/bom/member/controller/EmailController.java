package com.kh.bom.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.bom.member.model.service.MemberService;
import com.kh.bom.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
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
	
	
	//회원관리 -이메일 전송 
	@RequestMapping(value="/email/member", method = RequestMethod.POST)
	@ResponseBody
	public boolean sendEmailMember(String emailReceiver,String emailSubject, String emailText,
			@RequestParam(value="emailFile",required=false) MultipartFile[] emailFile, HttpSession session) throws Exception{
		String setFrom ="sujeong.dev@gmail.com"; //보내는 사람
		String subject=emailSubject; 
		String text=emailText;//이메일내용
		
		List<String> delFileList=new ArrayList();
		//받는사람리스트
		List<String>emailList=Arrays.asList(emailReceiver.split(","));
		System.out.println("전달받은 이메일전체:"+emailList);

		

		//MimeMessage message = mailSender.createMimeMessage();
		//MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
		for(String email: emailList) {
			
			MimeMessagePreparator preparator = new MimeMessagePreparator() { 
				@Override public void prepare(MimeMessage mimeMessage) throws Exception { 
					final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8"); 
					helper.setFrom(new InternetAddress(setFrom)); 
					helper.setTo(new InternetAddress(email)); 
					helper.setSubject(subject); //이메일 제목
					
					
					//이미지
					//img태그 수 찾기
					String word="<img";
					String[] sarr = text.split(">");
	                int len = sarr.length;
	                int count = 0;
	                for(int i = 0; i<len; i++){
	                   if(sarr[i].contains(word)){
	                        count++;
	                   }
	                }
	                
	                System.out.println("img태그수:"+count);
	                if(count>0) {
	                	String text=emailText; //실제 받은 값
	                	System.out.println(text);
	                	Map <String, FileSystemResource>map=new HashMap<String, FileSystemResource>();
	                	
	                	//태그내 src주소 cid로 전환
	                	for(int i=0;i<count;i++) {
	                	
							int idx=text.indexOf("src=\""+session.getServletContext().getContextPath()+"/resources/upload/ckeditor/");
							System.out.println(idx);
							String subText=text.substring(idx+5);
							int last=subText.indexOf("\"");
							String imgName=subText.substring(0, last);
							last=imgName.lastIndexOf("/");
							imgName=imgName.substring(last+1);
							System.out.println("이미지 이름"+imgName);
							
							String text2=text.replace(session.getServletContext().getContextPath()+"/resources/upload/ckeditor/"+imgName, "cid:"+imgName);
							System.out.println("변환후" +text2);
		
							String imgPath= session.getServletContext().getRealPath("/resources/upload/ckeditor/");
							FileSystemResource imgFsr = new FileSystemResource(new File(imgPath+imgName)); 
							//setText다음에 addInline추가 
							//추가를 위해 img이름,경로 담아가기
							map.put(imgName,imgFsr);
							text=text2;
	                	}
	                	
	                	System.out.println("변환 최종"+text);
	                	helper.setText(text, true); 
	                	
	                	Iterator<String> keys = map.keySet().iterator();
	                    while( keys.hasNext() ){
	                        String key = keys.next();
	                        helper.addInline(key, map.get(key));
	                    }
	                }else {
	                	
	                	helper.setText(text, true); 
	                }
	                
	                //파일첨부
	                String path=session.getServletContext().getRealPath("/resources/upload/email");
	                Map <String, FileSystemResource>fileMap=new HashMap<String, FileSystemResource>();
		    		File dir = new File(path);
		    		if(!dir.exists())dir.mkdirs();
		    		for(MultipartFile f:emailFile) {
		    			if(!f.isEmpty()) {
		    			
		    				//본래 파일이름 가져오기
		    				String originalName=f.getOriginalFilename();
		    				System.out.println("파일이름"+originalName);
		    				//확장자 분리
		    				String ext=originalName.substring(originalName.lastIndexOf(".")+1);
		    				//리네임양식정하기
		    				SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
		    				int rndValue=(int)(Math.random()*1000);
		    				String reName="file"+sdf.format(System.currentTimeMillis())+"_"+rndValue+"."+ext;
		    				try {
		    					f.transferTo(new File(path+"/"+reName));
		    				}catch(IOException e) {
		    					e.printStackTrace();
		    				}
		    				
		    				FileSystemResource fsr = new FileSystemResource(new File(path+"/"+reName));
		    				fileMap.put(originalName,fsr);
//		    				
//		    				System.out.println(path+"/"+reName);
//		    				FileSystemResource fsr = new FileSystemResource(path+"/"+reName);
//		    				helper.addAttachment(originalName, fsr);
		    				delFileList.add(reName);//삭제를 위해 reName한 파일 명 리스트에 보관
		    			}
		    		}
		    		
		    		
					
		    		Iterator<String> keys2 = fileMap.keySet().iterator();
		    		while( keys2.hasNext() ){
		    			String key2 = keys2.next();
		    			helper.addAttachment(key2, fileMap.get(key2));
		    		}
				} 
				
							
			}; 
			
			mailSender.send(preparator); 
			
		}
		//전송후 첨부파일 지우기
		String path=session.getServletContext().getRealPath("/resources/upload/email");
		if(delFileList.size()>0) {	
			for(String name:delFileList) {
				String deletePath=path+"/"+name;
				File del=new File(deletePath);
				if(del.exists())del.delete();
			}
		}
		
	return true;
		
	}
}

		
		
		
		
		
		
		
		
		
