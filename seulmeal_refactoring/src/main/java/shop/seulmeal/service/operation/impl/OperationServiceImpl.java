package shop.seulmeal.service.operation.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import shop.seulmeal.common.Search;
import shop.seulmeal.service.domain.Comment;
import shop.seulmeal.service.domain.Post;
import shop.seulmeal.service.domain.Product;
import shop.seulmeal.service.mapper.OperationMapper;
import shop.seulmeal.service.operation.OperationService;

@Service("operationServiceImpl")
public class OperationServiceImpl implements OperationService {
	
	@Autowired	
	private OperationMapper operationMapper;
	
	public OperationServiceImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}
	
	// 공지사항 + 이벤트 + 문의CustomProductCustomProduct
	@Override
	public int insertOperation(Post post) {
		// TODO Auto-generated method stub
		return operationMapper.insertOperation(post);
	}

	@Override
	public Post getOperation(Post post) {
		// TODO Auto-generated method stub
		// 조회수 증가
		operationMapper.updateOperationView(post.getPostNo());
		
		return operationMapper.getOperation(post);
	}

	@Override
	public int updateOperation(Post post) {
		// TODO Auto-generated method stub
		return operationMapper.updateOperation(post);
	}

	@Override
	public int deleteOperation(Post post) {
		// TODO Auto-generated method stub
		if(post.getPostStatus().equals("2")) {
			int r = operationMapper.deleteDiscountProduct(post.getPostNo());
			System.out.println("========================="+r+"=========================");
			
		}
		
		return operationMapper.deleteOperation(post);
	}

	@Override
	public Map<String, Object> getListOperation(Search search, int postStatus) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("search", search);
		map.put("postStatus", postStatus);
		
		map.put("list", operationMapper.getListOperation(map));
		map.put("totalCount",operationMapper.getTotalCount(map));
		
		return map;
	}
	

	@Override
	public int insertAnswer(Comment comment) {
		// TODO Auto-generated method stub
		// 답변 완료
		operationMapper.updateAnswerStatus(comment.getPostNo());
		
		return operationMapper.insertAnswer(comment);
	}

	@Override
	public List<Comment> getListAnswer(int no) {
		// TODO Auto-generated method stub
		return operationMapper.getListAnswer(no);
	}

	@Override
	public int updateAnswer(Comment comment) {
		// TODO Auto-generated method stub
		return operationMapper.updateAnswer(comment);
	}

	@Override
	public int deleteAnswer(Comment comment) {
		// TODO Auto-generated method stub
		return operationMapper.deleteAnswer(comment);
	}

	@Scheduled(cron = "0 12 17 * * ? ")
	public void endEvent() throws Exception {
		System.out.println("test");
		operationMapper.endEvent();
		operationMapper.endDiscountProduct();
	}

	@Override
	public List<Map<String, Object>> userCount(String table) {
		// TODO Auto-generated method stub
		
		return operationMapper.userCount(table);
	}

	@Override
	public List<Map<String, Object>> salePrice() {
		// TODO Auto-generated method stub
		return operationMapper.salePrice();
	}

	@Override
	public List<Map<String, Object>> getProductName(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return operationMapper.getProductName(map);
	}

	@Override
	public Product getProduct(String name) {
		// TODO Auto-generated method stub
		return operationMapper.getProduct(name);
	}

	@Override
	public int updateDiscountProduct(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return operationMapper.updateDiscountProduct(map);
	}

	@Override
	public int updateDiscountProductC(List<String> list) {
		// TODO Auto-generated method stub
		return operationMapper.updateDiscountProductC(list);
	}

	@Override
	public Map<String, Object> countAdmin() {
		// TODO Auto-generated method stub
		return operationMapper.countAdmin();
	}

	@Override
	public List<Map<String,Object>> selectUserProduct(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return operationMapper.selectUserProduct(map);
	}

	@Override
	public List<Map<String, Object>> countAdminDay(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return operationMapper.countAdminDay(map);
	}

	@Override
	public List<Map<String, Object>> monthChart(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return operationMapper.monthChart(map);
	}

	@Override
	public List<Map<String, Object>> monthSaleParts(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return operationMapper.monthSaleParts(map);
	}

	@Override
	public List<Map<String,Object>> monthSaleProduct(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return operationMapper.monthSaleProduct(map);
	}

}
