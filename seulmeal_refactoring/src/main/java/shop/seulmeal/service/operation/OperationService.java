package shop.seulmeal.service.operation;

import java.util.List;
import java.util.Map;

import shop.seulmeal.common.Search;
import shop.seulmeal.service.domain.Comment;
import shop.seulmeal.service.domain.Post;
import shop.seulmeal.service.domain.Product;

public interface OperationService {
	// 공지사항 + 이벤트 + 문의
	public int insertOperation(Post post);
	public Post getOperation(Post post);
	public int updateOperation(Post post);
	public int deleteOperation(Post post);
	public Map<String,Object> getListOperation(Search search, int postStatus);
	
	// 답변
	public int insertAnswer(Comment comment);
	public List<Comment> getListAnswer(int no);
	public int updateAnswer(Comment comment);
	public int deleteAnswer(Comment comment);
	
	// main
	public List<Map<String,Object>> selectUserProduct(Map<String,Object> map);
	
	// admin
	public List<Map<String,Object>> userCount(String table);
	public List<Map<String,Object>> salePrice();
	public Map<String,Object> countAdmin();
	public List<Map<String,Object>> countAdminDay(Map<String,Object> map);
	public List<Map<String,Object>> monthChart(Map<String,Object> map);
	public List<Map<String,Object>> monthSaleParts(Map<String,Object> map);
	public List<Map<String,Object>> monthSaleProduct(Map<String,Object> map);
	
	// 오토컴플릿
	public List<Map<String,Object>> getProductName(Map<String,Object> map);
	public Product getProduct(String name);
	
	//이벤트 할인
	public int updateDiscountProduct(Map<String,Object> map);
	public int updateDiscountProductC(List<String> list);
	
}
