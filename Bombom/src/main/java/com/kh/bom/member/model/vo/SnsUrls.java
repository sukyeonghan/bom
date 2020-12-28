package com.kh.bom.member.model.vo;

public interface SnsUrls {
	//sns연결 url을 선언해놓은 인터페이스
	
	static final String NAVER_ACCESS_TOKEN =
            "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code";
	static final String NAVER_AUTH = "https://nid.naver.com/oauth2.0/authorize";
	
	static final String NAVER_PROFILE_URL = 
	                                "https://openapi.naver.com/v1/nid/me";

	//구글
	static final String GOOGLE_PROFILE_URL = "https://www.googleapis.com/oauth2/v2/userinfo";
	
	


}