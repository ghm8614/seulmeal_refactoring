package shop.seulmeal.service.confirm;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Random;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.mail.internet.MimeMessage;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class ConfirmService {
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	public ConfirmService() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}
	private String makeSignature(String url, String timestamp, String method, String accessKey, String secretKey) throws NoSuchAlgorithmException, InvalidKeyException {
	    String space = " ";                    // one space
	    String newLine = "\n";                 // new line
	    

	    String message = new StringBuilder()
	        .append(method)
	        .append(space)
	        .append(url)
	        .append(newLine)
	        .append(timestamp)
	        .append(newLine)
	        .append(accessKey)
	        .toString();

	    SecretKeySpec signingKey;
	    String encodeBase64String;
		try {
			
			signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
			Mac mac = Mac.getInstance("HmacSHA256");
			mac.init(signingKey);
			byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
		    encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			encodeBase64String = e.toString();
		}
	    

	  return encodeBase64String;
	}
	
	public void sendSMS(String phone, String message) {
		String hostNameUrl = "https://sens.apigw.ntruss.com";     		// 호스트 URL
		String requestUrl= "/sms/v2/services/";                   		// 요청 URL
		String requestUrlType = "/messages";                      		// 요청 URL
		String accessKey = "fJeZpufXlk2vcmRTITYS";                     	// 네이버 클라우드 플랫폼 회원에게 발급되는 개인 인증키			// Access Key : https://www.ncloud.com/mypage/manage/info > 인증키 관리 > Access Key ID
		String secretKey = "cupUDfaolp9hXy75nwS9cjPBhhP8hHh564nn5fm1";  // 2차 인증을 위해 서비스마다 할당되는 service secret key	// Service Key : https://www.ncloud.com/mypage/manage/info > 인증키 관리 > Access Key ID	
		String serviceId = "ncp:sms:kr:277501036471:seulmeal";       // 프로젝트에 할당된 SMS 서비스 ID							// service ID : https://console.ncloud.com/sens/project > Simple & ... > Project > 서비스 ID
		String method = "POST";											// 요청 method
		String timestamp = Long.toString(System.currentTimeMillis()); 	// current timestamp (epoch)
		requestUrl += serviceId + requestUrlType;
		String apiUrl = hostNameUrl + requestUrl;
		System.out.println(123123);
		//String apiUrl = hostNameUrl+requestUrl+serviceId+requestUrlType;		
		//String apiUrl = "https://sens.apigw.ntruss.com/sms/v2/services/ncp:sms:kr:277501036471:seulmeal/messages";
		// JSON 을 활용한 body data 생성
		JSONObject bodyJson = new JSONObject();
		JSONObject toJson = new JSONObject();
	    JSONArray  toArr = new JSONArray();
	    System.out.println("111111"+toArr);
	    //toJson.put("subject","");							// Optional, messages.subject	개별 메시지 제목, LMS, MMS에서만 사용 가능
	    //toJson.put("content","sms test in spring 111");	// Optional, messages.content	개별 메시지 내용, SMS: 최대 80byte, LMS, MMS: 최대 2000byte
	    toJson.put("to",phone);						// Mandatory(필수), messages.to	수신번호, -를 제외한 숫자만 입력 가능
	    toArr.add(toJson);
	    System.out.println(toArr);
	    bodyJson.put("type","SMS");							// Madantory, 메시지 Type (SMS | LMS | MMS), (소문자 가능)
	    //bodyJson.put("contentType","");					// Optional, 메시지 내용 Type (AD | COMM) * AD: 광고용, COMM: 일반용 (default: COMM) * 광고용 메시지 발송 시 불법 스팸 방지를 위한 정보통신망법 (제 50조)가 적용됩니다.
	    //bodyJson.put("countryCode","82");					// Optional, 국가 전화번호, (default: 82)
	    bodyJson.put("from","01035937843");					// Mandatory, 발신번호, 사전 등록된 발신번호만 사용 가능		
	    //bodyJson.put("subject","");						// Optional, 기본 메시지 제목, LMS, MMS에서만 사용 가능
	    bodyJson.put("content",message);	// Mandatory(필수), 기본 메시지 내용, SMS: 최대 80byte, LMS, MMS: 최대 2000byte
	    bodyJson.put("messages", toArr);					// Mandatory(필수), 아래 항목들 참조 (messages.XXX), 최대 1,000개
	    
	    //String body = bodyJson.toJSONString();
	    String body = bodyJson.toString();
	    
	    System.out.println(body);
	    
        try {
            URL url = new URL(apiUrl);

            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setUseCaches(false);
            con.setDoOutput(true);
            con.setDoInput(true);
            con.setRequestProperty("content-type", "application/json;UTF-8");
            con.setRequestProperty("x-ncp-apigw-timestamp", timestamp);
            con.setRequestProperty("x-ncp-iam-access-key", accessKey);
            con.setRequestProperty("x-ncp-apigw-signature-v2", makeSignature(requestUrl, timestamp, method, accessKey, secretKey));
            con.setRequestMethod(method);
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            
            wr.write(body.getBytes());
            wr.flush();
            wr.close();

            int responseCode = con.getResponseCode();
            BufferedReader br;
            System.out.println("responseCode" +" " + responseCode);
            if(responseCode == 202) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else { // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }

            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            
            System.out.println(response.toString());

        } catch (Exception e) {
            System.out.println(e);
        }
	}
	
	public void sendMail(String content, String to) {
		MimeMessage mimeMessage = javaMailSender.createMimeMessage();
		try {
			
			MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, false, "UTF-8");
			mimeMessageHelper.setTo(to);
			
			mimeMessageHelper.setSubject("seulMeal 인증메일 입니다");

			String ct ="<img style='width:1000px; height:300px;' src=\'http://www.seulmeal.shop/resources/attachments/image/seulMeal.png\' /><br><br>";			
			content += "<br>커스텀이 가능한 슬밀 밀키트몰입니다.";
			content += "<br><br>";
			content += "<a href='http://www.seulmeal.shop/'>seulMealFactory</a><br/>";
			mimeMessageHelper.setText(content, true);
			javaMailSender.send(mimeMessage);
			System.out.println("성공");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("실패");
			throw new RuntimeException(e);
		}
	}
	
	public int confirmNum() {
		Random generator = new Random();
        generator.setSeed(System.currentTimeMillis());
        
        int num = (generator.nextInt(1000000) % 1000000);
        
        return num;
	}
}
