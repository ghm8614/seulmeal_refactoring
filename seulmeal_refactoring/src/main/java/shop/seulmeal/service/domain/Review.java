package shop.seulmeal.service.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class Review {
	private int reviewNo;
	private Product product;
	private User user;
	private String title;
	private String content;
	private int rating;
	private Date regDate;
	private String status;
}
