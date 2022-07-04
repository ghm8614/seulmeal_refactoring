package shop.seulmeal.service.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import shop.seulmeal.service.domain.Comment;
import shop.seulmeal.service.domain.CustomProduct;
import shop.seulmeal.service.domain.Post;
import shop.seulmeal.service.domain.Product;
import shop.seulmeal.service.domain.User;

@Mapper
public interface OperationMapper {
	
	// 공지사항 + 이벤트 + 문의
	public int insertOperation(Post post);
	public Post getOperation(Post post);
	public int updateOperation(Post post);
	public int deleteOperation(Post post);
	public List<Post> getListOperation(Map<String, Object> map);
	public int getTotalCount(Map<String, Object> map);
	public void endEvent();
	
	// 조회수 증가
	public int updateOperationView(int no);
	
	// 문의 답변 완료
	public int updateAnswerStatus(int no);
	
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
	
	// 이벤트 할인
	public int updateDiscountProduct(Map<String,Object> map);
	public int updateDiscountProductC(List<String> list);
	public void endDiscountProduct();
	public int deleteDiscountProduct(int postNo);
	
	// 테스트
	public CustomProduct selectCus(int no);
	
}
