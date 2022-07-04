package shop.seulmeal.service.naver.impl;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	public EmailService() {
		// TODO Auto-generated constructor stub
	}
	
	public void sendMail(String content, String to) {
		MimeMessage mimeMessage = javaMailSender.createMimeMessage();
		try {
			MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, false, "UTF-8");
			mimeMessageHelper.setTo(to);
			mimeMessageHelper.setSubject("seulMeal 인증메일 입니다");
			mimeMessageHelper.setText(content, false);
			javaMailSender.send(mimeMessage);
			System.out.println("성공");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("실패");
			throw new RuntimeException(e);
		}
	}

}
