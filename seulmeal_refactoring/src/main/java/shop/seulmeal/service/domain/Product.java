package shop.seulmeal.service.domain;

import java.sql.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class Product {
	private int productNo;
	private Foodcategory foodCategory;
	private String name;
	private String subContent;
	private String thumbnail;
	private int price;
	private int calorie;
	private String content;
	private Date regDate;
	private String status;
	private int stock;
	private double averageRating;
	private int likeCount;
	private int reviewCount;

	// 상품에 들어간 재료
	private List<Parts> parts;

	// 상품이 리뷰를 가지고 있다.
	private List<Review> review;
	
	// 할인
	private int discount;
	private int originPrice;
	
	private int likeStatus;
}
