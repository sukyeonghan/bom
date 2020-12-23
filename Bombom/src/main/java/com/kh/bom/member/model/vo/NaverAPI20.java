package com.kh.bom.member.model.vo;

import com.github.scribejava.core.builder.api.DefaultApi20;

public class NaverAPI20 extends DefaultApi20 implements SnsUrls{
	private static NaverAPI20 _instance;
	
	private NaverAPI20() {}
	
	private static class InstanceHolder{
		//instanceHolder를 부를 때 한번만 생성
		private static final NaverAPI20 INSTANCE =new NaverAPI20();
	}
	
	public static NaverAPI20 instance() {
		//1.첫번째방식
		//외부에서 getInstance()호출시 
		//없을때는 만들고
		//_instance가 만들어져 있으면 _instance반환 
//		if(_instance==null) {
//			_instance= new NaverAPI20();
//		}
//		return _instance;
		
		//2.두번째방식
		return InstanceHolder.INSTANCE;
	}
	@Override
	public String getAccessTokenEndpoint() {
		// TODO Auto-generated method stub
		return NAVER_ACCESS_TOKEN;
	}
	@Override
	protected String getAuthorizationBaseUrl() {
		// TODO Auto-generated method stub
		return NAVER_AUTH;
	}

}
