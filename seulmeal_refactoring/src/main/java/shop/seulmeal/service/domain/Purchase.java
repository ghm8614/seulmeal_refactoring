package shop.seulmeal.service.domain;

import java.sql.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class Purchase {
	private int purchaseNo;
	private User user;
	private int price;
	private String address;
	private String name;
	private String phone;
	private String email;
	private String message;
	private String purchaseStatus;
	private String status;
	private Date regDate;
	private String paymentCondition;
	private String imp_uid;
	private int amount;
	private int usePoint;
	
	private List<CustomProduct> customProduct;
}
