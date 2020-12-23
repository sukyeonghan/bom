package com.kh.bom.member.model.vo;

import java.util.Iterator;

import org.apache.commons.lang.StringUtils;

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
		Member member=new Member();

		ObjectMapper mapper= new ObjectMapper();
		JsonNode rootNode=mapper.readTree(body); //트리형으로
		
		//구글
		if(this.sns.isGoogle()) {
			//하나 찾을때는 .get()/여러개  찾을때는 .findPath()
			//asText() 스트링으로 변환
			String  id =rootNode.get("id").asText();  //각 sns id
			if(sns.isGoogle()) {
				member.setGoogleId(id);
			}
			
			member.setMemNick(rootNode.get("displayName").asText());//닉네임
			//JsonNode nameNode=rootNode.findPath("name"); //이름
			//String name=nameNode.get("familyName").asText()+nameNode.get("giveName").asText();
			
			Iterator<JsonNode> iterEmails=rootNode.findPath("emails").elements(); //구글은 이메일이 여러개
			while(iterEmails.hasNext()) {
				JsonNode emailNode=iterEmails.next();
				String type=emailNode.get("type").asText();
				if(StringUtils.equals(type, "account")) {
					member.setMemEmail(emailNode.get("value").asText()); //타입이 account인거 셋
					break;
				}
			}
			
		//네이버	
		}else if(this.sns.isNaver()) {
			JsonNode resNode=rootNode.get("response");
			member.setNaverId(resNode.get("id").asText());
			member.setMemNick(resNode.get("nickname").asText());
			member.setMemEmail(resNode.get("email").asText());

		}
	
		
		return member;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
