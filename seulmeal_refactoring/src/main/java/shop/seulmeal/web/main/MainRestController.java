package shop.seulmeal.web.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import shop.seulmeal.common.Search;
import shop.seulmeal.service.domain.Like;
import shop.seulmeal.service.domain.Product;
import shop.seulmeal.service.domain.User;
import shop.seulmeal.service.operation.OperationService;
import shop.seulmeal.service.product.ProductService;

@RestController
public class MainRestController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	private OperationService operationService;
	
	@Value("${operation.query.pageUnit}")
	int pageUnit;
	
	@Value("${operation.query.pageSize}")
	int pageSize;
	
	public MainRestController() {
		// TODO Auto-generated constructor stub
	}
	
	@GetMapping("/api/main")
	public Map<String,Object> getMain(@RequestParam(required = false, defaultValue = "2") int currentPage, HttpSession session) throws Exception {
		JSONObject json = new JSONObject();
		Search search = new Search();
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		Map<String,Object> map = productService.getListProduct(search);
		List<Product> list = (List)map.get("list");
		
		User user = (User)session.getAttribute("user");
		
		if(user != null) {
			List<Like> likeList = productService.getListLikeAll(user.getUserId());
			for (Product product : list) {
				
				for (Like like : likeList) {
					if(product.getProductNo() == like.getProductNo()) {
						product.setLikeStatus(1);
					}					
				}				
			}			
		}

		
		return map;
	}
	
	@GetMapping("/api/getDayStatistics/{status}/{month}")
	public Map<String,Object> getDayStatistics(@PathVariable int status,@PathVariable int month){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("month",month);
		/* status
		 * 0 = 월통계
		 * 1 = 월 상위 10개 판매 상품
		 * 2 = 월 상위 10개 판매 재료
		 * 3 = 월 최고의 게시글, 상품
		 */
		
		if(status == 0) {
			// user 일일 가입자수
			map.put("table", "users");		
			map.put("userDay",operationService.countAdminDay(map));
			
			// 구매 횟수
			map.put("table", "purchase");
			map.put("purchaseDay",operationService.countAdminDay(map));
			
			// 판매액
			map.put("option", "price");
			map.put("purchasePriceDay",operationService.countAdminDay(map));
			map.put("option", null);
			
			// 리뷰횟수
			map.put("table", "review");
			map.put("reviewDay",operationService.countAdminDay(map));
			
			// 문의 횟수
			map.put("table", "post");
			map.put("post_status", 3);
			map.put("queryDay",operationService.countAdminDay(map));
			
			// 게시판 글쓴 횟수
			map.put("post_status", 0);
			map.put("communityDay",operationService.countAdminDay(map));
		}
		
		if(status == 1) {
			// 이달의 탑텐 최고 판매상품
			map.put("count", 10);
			map.put("monthSaleProduct10",operationService.monthSaleProduct(map));
			
		}
		
		if(status == 2) {
			// 이달의 탑텐 최고 판매재료
			map.put("count", 10);
			map.put("monthSaleParts",operationService.monthSaleParts(map));
		}
		
		if(status == 3) {
			// 이달의 좋아요 최고 게시글
			map.put("table", "post");
			map.put("monthPostLike",operationService.monthChart(map));
			
			// 이달의 최고댓글 게시글
			map.put("table", "post p,comments c");
			map.put("monthPostComment",operationService.monthChart(map));
			
			// 이달의 최고 판매상품
			map.put("table", "product p, purchase pp, customproduct c");
			map.put("monthSaleProduct",operationService.monthChart(map));
		}
		return map;
	}
}
