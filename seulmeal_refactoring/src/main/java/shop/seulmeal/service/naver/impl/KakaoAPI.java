package shop.seulmeal.service.naver.impl;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import javax.net.ssl.HttpsURLConnection;

import org.springframework.objenesis.instantiator.basic.ObjectInputStreamInstantiator;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;

@Service
public class KakaoAPI {
	
	public String getAccessToken(String code) {
		String accessToken = "";
		String refreshToken = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";
		
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=5d0862d7e4baae490cfc20f9ef7c6cb5");
			sb.append("&redirect_uri=http://www.seulmeal.shop/user/kakaoLogin");
			sb.append("&code="+code);
			
			
			bw.write(sb.toString());
			bw.flush();
			int responseCode = conn.getResponseCode();
			System.out.println(":: responseCode1 :"+responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String line = "";
			String result = "";
			while((line = br.readLine())!=null) {
				result +=line;
			}
			System.out.println("response body :"+result);
			
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			
			accessToken = element.getAsJsonObject().get("access_token").getAsString();
			refreshToken = element.getAsJsonObject().get("refresh_token").getAsString();
			
			br.close();
			bw.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return accessToken;
	}
	
	
	
	public HashMap<String, Object> getUserInfo(String accessToken) {
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		String reqUrl = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqUrl);
			HttpsURLConnection conn = (HttpsURLConnection)url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "Bearer "+accessToken);
			int responseCode = conn.getResponseCode();
			System.out.println(":: responseCode2 : "+responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String line = "";
			String result = "";
			
			
			while((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : "+result);
			JsonParser parser = new JsonParser();
			JsonElement element =  parser.parse(result);
			
			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakaoAccount = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
			
			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
			String email = kakaoAccount.getAsJsonObject().get("email").getAsString();
			
			userInfo.put("nickname", nickname);
			userInfo.put("email", email);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userInfo;
	}

	
	public void kakaoLogout(String accessToken) {
		String reqURI="https://kapi.kakao.com/v1/user/logout";
		try {
			URL url = new URL(reqURI);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "Bearer "+accessToken);
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode3 :"+responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String line = "";
			String result = "";
			while((line = br.readLine())!=null) {
				result +=line;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
