package shop.seulmeal.service.domain;

import java.sql.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class Parts {
	private int partsNo;
	private String name;
	private int price;
	private int calorie;
	private Date regDate;
	private String status;
	private int gram; //custom에서 사용
	
	// productNo
	private int productNo;
	// productPartsNo
	private int productPartsNo;
	
	// hateParts
	private String userId;
}
