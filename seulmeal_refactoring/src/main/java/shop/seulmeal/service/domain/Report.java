package shop.seulmeal.service.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class Report {
	
	private int reportNo;
	private int postNo;
	private String reporterId;
	private String reason;
	private Date regDate;
	private String status;
	
}
