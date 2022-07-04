package shop.seulmeal.service.domain;

import java.sql.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Relation {

	private int relationNo;
	private String userId;
	private User relationUser;
	private String relationStatus;
	private Date regDate;
	
}
