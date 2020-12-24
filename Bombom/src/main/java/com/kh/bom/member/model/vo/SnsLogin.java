package com.kh.bom.member.model.vo;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

public class SnsLogin {
	
	private OAuth20Service oauthService;
	private SnsValue sns;
	
	public SnsLogin(SnsValue sns) {
		this.oauthService=new ServiceBuilder(sns.getClientId())
				.apiSecret(sns.getClientSecret())
				.callback(sns.getRedirectUrl())
				.build(sns.getApi20Instance());
		this.sns=sns;
	}
	
	//연결한 Url주소 가져오기
	public String  getNaverAuthURL() {
		return this.oauthService.getAuthorizationUrl();
	}
	
	//code로 프로필정보가져오기
	public Member getUserProfile(String code) throws Exception {
		//코드로 엑세스토큰 받기
		OAuth2AccessToken accessToken=oauthService.getAccessToken(code);

		OAuthRequest request =new OAuthRequest(Verb.GET, this.sns.getProfileUrl());
		oauthService.signRequest(accessToken, request);
		Response response =oauthService.execute(request);
		
		return parseJson(response.getBody());
	}
	
	
	//body json파싱
	public  Member parseJson(String body) throws Exception {
		System.out.println("===============\n"+body+"=====================");
		//body에 이런형식으로 들어가있음.
//		{
//		  "id": "122334748662",
//		  "email": "bom@gmail.com",
//		  "verified_email": true,
//		  "name": "봄봄이",
//		  "given_name": "봄",
//		  "family_name": "강",
//		  "picture": "https://lh3.googleusercontent.com/a-/AOejfowejfefekfefkB8MX=s96-c",
//		  "locale": "ko"
//		}
		
		Member member=new Member(); //세팅한 값 담을 객체

		ObjectMapper mapper= new ObjectMapper();
		JsonNode rootNode=mapper.readTree(body); //트리형으로
		
		//구글
		if(this.sns.isGoogle()) {
			//하나 찾을때는 .get()/여러개  찾을때는 .findPath()
			//asText() 스트링으로 변환
			member.setGoogleId(rootNode.get("id").asText());//구글고유아이디
			member.setMemEmail(rootNode.get("email").asText()); //이메일
			member.setMemNick(rootNode.get("name").asText());//닉네임
			member.setMemPro(rootNode.get("picture").asText());//프로필사진
			
			
		//네이버	
		}else if(this.sns.isNaver()) {
			JsonNode resNode=rootNode.get("response"); //형식이 이중{}이라, JsonNode로 내부{}에 접근
			member.setNaverId(resNode.get("id").asText());
			member.setMemNick(resNode.get("nickname").asText());
			member.setMemEmail(resNode.get("email").asText());
			member.setMemPro(resNode.get("profile_image").asText());
		}
	
		
		return member;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
