package com.kh.bom.member.model.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
@Service
public class KakaoService {

	public String getAccessToken(String authorize_code) {
		String access_Token="";
		String refresh_Token="";
		String reqURL="https://kauth.kakao.com/oauth/token";
		
		try {
			URL url=new URL(reqURL);
			HttpURLConnection conn=(HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			
			BufferedWriter bw=new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb=new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=a91b8caf81f73042dbfd9fc0a1552e66");
			sb.append("&redirect_uri=http://localhost:9090/bom/auth/kakao/callback");
			sb.append("&code="+authorize_code);
			bw.write(sb.toString());
			bw.flush();
			
			int responseCode=conn.getResponseCode();
			System.out.println("responseCode"+responseCode);
			
			BufferedReader br =new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line="";
			String result="";
			
			while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);

            br.close();
            bw.close();
			
		}catch(IOException e) {
			e.printStackTrace();
		}
		
		return access_Token;
	}
	
	
	 public HashMap<String, Object> getUserInfo (String access_Token) {

         HashMap<String, Object> userInfo = new HashMap<>();
         String reqURL = "https://kapi.kakao.com/v2/user/me";
         try {
             URL url = new URL(reqURL);
             HttpURLConnection conn = (HttpURLConnection) url.openConnection();
             conn.setRequestMethod("POST");

             conn.setRequestProperty("Authorization", "Bearer " + access_Token);

             int responseCode = conn.getResponseCode();
             System.out.println("responseCode : " + responseCode);

             BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

             String line = "";
             String result = "";

             while ((line = br.readLine()) != null) {
                 result += line;
             }
             System.out.println("response body : " + result);

             JsonParser parser = new JsonParser();
             JsonElement element = parser.parse(result);

             String id = element.getAsJsonObject().get("id").getAsString();
             JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
             JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
             String email=null;
             if(kakao_account.getAsJsonObject().get("email")!=null) {
            	 email = kakao_account.getAsJsonObject().get("email").getAsString();
             }
             String nickname = properties.getAsJsonObject().get("nickname").getAsString();
             String profile_image = properties.getAsJsonObject().get("profile_image").getAsString();

             userInfo.put("id", id);
             userInfo.put("email", email);
             userInfo.put("nickname", nickname);
             userInfo.put("profile_image", profile_image);

         } catch (IOException e) {
             e.printStackTrace();
         }

         return userInfo;
     }
}
