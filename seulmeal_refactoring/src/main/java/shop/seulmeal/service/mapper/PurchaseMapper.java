package shop.seulmeal.service.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import shop.seulmeal.common.Search;

import shop.seulmeal.service.domain.CustomParts;
import shop.seulmeal.service.domain.CustomParts;
import shop.seulmeal.service.domain.CustomProduct;
import shop.seulmeal.service.domain.Purchase;

@Mapper
public interface PurchaseMapper {
	
	//오토컴플릿
	public List<Map> autocomplete(Map<String, Object> paramMap) throws Exception;
	
	//커스터마이징재료 추가 
	public int insertMinusParts(Map<String, Object> map);
	public int insertPlusParts(Map<String, Object> map);
	//public int insertCustomParts(Map<String, Object> map);
	
	//커스터마이징상재료 상세 
	public CustomParts getCustomParts(int CustomPartsNo);

	//커스터마이징재료 리스트
	public List<CustomParts> getListCustomParts(int customProductNo);
	
	//커스터마이징재료 삭제 
	public int deleteCustomParts(int customProductNo);
	
	
	//커스터마이징상품 추가 
	public int insertCustomProduct(CustomProduct customProduct);
	
	//커스터마이징상품 상세 (커스터마이징옵션 수정페이지에서 출력)
	public CustomProduct getCustomProduct(int customProductNo);
	
	//커스터마이징상품 리스트(장바구니)
	public List<CustomProduct> getListCustomProduct(Map<String, Object> map);
	
	//커스터마이징상품 수정(구매번호추가), 커스터마이징재료 수정은 delete 후 다시 insert
	public int updateCustomProductPurchaseNo(CustomProduct customProduct);
	public int updateCustomProductStatus(CustomProduct customProduct);
	
	//장바구니에서 커스터마이징상품 수량변경
	public int updateCustomProductCount(CustomProduct customProduct);
	
	//커스터마이징상품 삭제(장바구니리스트에서 삭제 눌렀을때)
	public int deleteCustomProduct(int customProductNo);
	
	
	//구매추가
	public int insertPurchase(Purchase purchase);
	
	//구매상세 
	public Purchase getPurchase(int purchaseNo);
	
	//구매내역리스트
	public List<Purchase> getListPurchase(Map<String, Object> map);
	
	//구매 후 imp_uid, amount 결제정보추가 
	public int updatePurchase(Purchase purchase);
	
	//구매코드 변경 
	public int updatePurchaseCode(Purchase purchase);
	
	//구매내역 삭제 
	public int deletePurchase(int purchaseNo);
	
	//개수
	public int getCustomProductTotalCount(Map<String, Object> map);
	public int getPurchaseTotalCount(Map<String, Object> map);
	public int getSaleTotalCount(Search search);
	
	//판매내역리스트
	public List<Purchase> getListSale(Search search);

}
