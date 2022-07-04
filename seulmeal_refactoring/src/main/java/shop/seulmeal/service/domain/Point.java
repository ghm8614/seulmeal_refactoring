package shop.seulmeal.service.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Point {
	
	private int pointNo;
	private String userId;
	private int purchaseNo;
	private String pointStatus;
	private int point;
	private Date regDate;

}
