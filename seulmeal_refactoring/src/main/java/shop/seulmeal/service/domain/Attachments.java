package shop.seulmeal.service.domain;

import java.sql.Date;

import lombok.Setter;
import lombok.Getter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class Attachments {
	private int attachmentsNo;
	private String attachmentName;
	private Date regDate;
	private String status;
	
	// 데이터 번호용
	private String productNo;
	private String reviewNo;
	private String postNo;
	private String commentNo;
}
