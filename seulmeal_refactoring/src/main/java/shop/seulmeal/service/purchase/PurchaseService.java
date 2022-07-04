package shop.seulmeal.service.purchase;

import java.util.List;
import java.util.Map;

import org.apache.http.NameValuePair;

import shop.seulmeal.common.Search;
import shop.seulmeal.service.domain.CustomParts;
import shop.seulmeal.service.domain.CustomProduct;
import shop.seulmeal.service.domain.Purchase;

public interface PurchaseService {
	
	//오토컴플릿
	public List<Map>autocomplete(Map<String, Object> paramMap) throws Exception;
	
	//커스터마이징재료 추가 
	public int insertMinusParts(int customProductNo, String minusNo, String minusName);
	public int insertPlusParts(int customProductNo, String plusPartsNo, String plusPrice, String plusGram);
	
	//커스터마이징상재료 상세 
	public CustomParts getCustomParts(int CustomPartsNo);
	
	//커스터마이징재료 리스트
	public List<CustomParts> getListCustomParts(int customProductNo);
	
	//커스터마이징재료 삭제 
	public int deleteCustomParts(int customProductNo);
	
	
	//커스터마이징상품 추가 
	public int insertCustomProduct(CustomProduct customProduct);
	
	//커스터마이징상품 상세 
	public CustomProduct getCustomProduct(int customProductNo);
	
	//커스터마이징상품 리스트(장바구니)
	public Map<String, Object> getListCustomProduct(Search search, String userId);
	
	//커스터마이징상품 수정(구매번호추가)
	public int updateCustomProductPurchaseNo(CustomProduct customProduct);
	//커스터마이징상품 수정(장바구니리스트에서 삭제)
	public int updateCustomProductStatus(CustomProduct customProduct);
	
	//장바구니에서 커스터마이징상품 수량변경 
	public int updateCustomProductCount(CustomProduct customProduct);
	
	//커스터마이징상품 삭제(장바구니사용여부 수정)
	public int deleteCustomProduct(int customProductNo);
	
	
	//구매추가
	public int insertPurchase(Purchase purchase);
	
	//구매상세 
	public Purchase getPurchase(int purchaseNo);
	
	//구매내역리스트
	public Map<String, Object> getListPurchase(Search search, String userId);
	
	//결제정보 추가 
	public int updatePurchase(Purchase purchase);
	
	//구매코드 변경 
	public int updatePurchaseCode(Purchase purchase);
	
	//구매내역 삭제 
	public int deletePurchase(int purchaseNo);
	
	//아임포트 인증(토큰)받아주는 함수
	public String getImportToken();
	
	// Map을 사용해서 Http요청 파라미터를 만들어 주는 함수
	public List<NameValuePair> convertParameter(Map<String,String> paramMap);
	
	// 결제취소
	public int cancelPayment(String token, String mid);
	
	// 아임포트 결제정보에서 amount 조회
	public String getAmount(String token, String mId);
	
	//판매내역리스트 
	public Map<String, Object> getListSale(Search search);
}
