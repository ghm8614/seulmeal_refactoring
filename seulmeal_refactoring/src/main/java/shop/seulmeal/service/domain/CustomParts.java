package shop.seulmeal.service.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class CustomParts {
	private int customPartsNo;
	private int customProductNo;
	private int minusNo; //제외재료번호 
	private String minusName; //제외재료이름 
	private int gram;
	private Parts parts; //추가재료

}