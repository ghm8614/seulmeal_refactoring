package shop.seulmeal.service.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter @Setter
public class ProductParts {
	private int productPartsNo;
	private Product product;
	private Parts	parts;
	private String status;
}
