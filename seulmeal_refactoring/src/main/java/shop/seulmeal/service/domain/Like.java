package shop.seulmeal.service.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class Like {
	 
	private int likeNo;
	private String userId; 
	private Integer postNo;
	private Integer commentNo;
	private Integer productNo;
	
}
