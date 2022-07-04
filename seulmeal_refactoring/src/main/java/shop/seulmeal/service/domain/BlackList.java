package shop.seulmeal.service.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BlackList {

	private int blackListNo;
	private User user;
	private Date regDate;
	
}
