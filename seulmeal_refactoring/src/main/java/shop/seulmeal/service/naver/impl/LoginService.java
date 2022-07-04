package shop.seulmeal.service.naver.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import shop.seulmeal.service.domain.User;

@Service
public class LoginService {
	
	BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
	private final String CLIENT_ID = "9v2VufeHsXfFnp8KaD49";
	private final String CLIENT_SECRET = "lsnuMAPBZg";
	
	public LoginService() {
		// TODO Auto-generated constructor stub
	}
	
	public User getUserInfo(String token) {
		String url ="https://openapi.naver.com/v1/nid/me";
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(url);
		post.setHeader("Authorization","bearer "+token);
		String asd = "";
		
		
		User user = null;		
		try {			
			HttpResponse res = client.execute(post);
			ObjectMapper mapper = new ObjectMapper();
			String enty = EntityUtils.toString(res.getEntity());
			JsonNode rootNode = mapper.readTree(enty);
			System.out.println("rootNode"+rootNode);
			JsonNode rootbody = rootNode.get("response");
			
			String dat = rootbody.get("birthyear").asText()+"-"+rootbody.get("birthday").asText();
			SimpleDateFormat fo = new SimpleDateFormat("YYYY-MM-DD");
			Date date = fo.parse(dat); 
			System.out.println("0"+rootbody.get("mobile").asText());
			
			user = new User();
			user.setUserId(rootbody.get("id").asText()+"_NAVER");
			user.setPassword(rootbody.get("id").asText());
			user.setEmail(rootbody.get("email").asText());
			user.setPhone((rootbody.get("mobile").asText()).replace("+82", "0"));
			user.setUserName(rootbody.get("name").asText());
			//user.setBirth(date);
			System.out.println(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (asd.equals("null")) {
			return user;
		} else {
			return user;
		}
	}
	
	public String getNaverAccessToken(String state, String code) {
		String url = "https://nid.naver.com/oauth2.0/token";		
		
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(url);
		Map<String, String> map = new HashMap<String, String>();
		map.put("grant_type", "authorization_code");
		map.put("client_id", CLIENT_ID);
		map.put("client_secret", CLIENT_SECRET);
		map.put("state", state);
		map.put("code", code);
		
		String asd = "";
		try {
			post.setEntity(new UrlEncodedFormEntity(convertParameter(map)));
			HttpResponse res = client.execute(post);
			ObjectMapper mapper = new ObjectMapper();
			String enty = EntityUtils.toString(res.getEntity());
			JsonNode rootNode = mapper.readTree(enty);
			System.out.println("rootNode"+rootNode);
			asd = rootNode.get("access_token").asText();
			System.out.println("asdfasd : " + asd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (asd.equals("null")) {
			return asd;
		} else {
			return asd;
		}
	}
	
	//////////////////////
	public List<NameValuePair> convertParameter(Map<String,String> paramMap){
		List<NameValuePair> paramList = new ArrayList<NameValuePair>();
		
		Set<Entry<String,String>> entries = paramMap.entrySet();
		
		for(Entry<String,String> entry : entries) {
			paramList.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
		}
		return paramList;
	}	
}
