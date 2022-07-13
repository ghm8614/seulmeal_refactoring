package shop.seulmeal.service.domain;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@JsonInclude(Include.NON_NULL)
public class Post {
	private int postNo;
	private User user;
	private String title;
	private String content;
	private String shortContent;
	private int views;
	private int commentCount;
	private int likeCount;
	private String thumnail;
	private Date regDate;
	private Date updateDate;
	private Date endDate;
	private String postStatus;
	private String publicStatus;
	private String password;
	private String answerStatus;
	private String status;
	private String likeStatus;
	private List<Comment> comments;
	private List<Attachments> attachments;
	
	// 다음글
	private Post bpost;
	
	// 이전글
	private Post npost;
	
	// 할인
	private int discount;
	
	// 할인상품
	private List<Product> discountProduct;

	// @Setter 대용
	@Builder 
	public Post(List<Attachments> attachments, String likeStatus, String shortContent) {
		this.attachments = attachments;
		this.likeStatus = likeStatus;
		this.shortContent = shortContent;
	}
}
