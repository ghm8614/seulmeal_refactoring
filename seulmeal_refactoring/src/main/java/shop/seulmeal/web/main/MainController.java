package shop.seulmeal.web.main;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import shop.seulmeal.common.Page;
import shop.seulmeal.common.Search;
import shop.seulmeal.service.domain.Like;
import shop.seulmeal.service.domain.Post;
import shop.seulmeal.service.domain.Product;
import shop.seulmeal.service.domain.User;
import shop.seulmeal.service.operation.OperationService;
import shop.seulmeal.service.product.ProductService;
import shop.seulmeal.service.user.UserService;

@Controller
public class MainController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	private OperationService operationService;
	
	@Autowired
	private UserService userService;
	
	@Value("${operation.query.pageUnit}")
	int pageUnit;
	
	@Value("${operation.query.pageSize}")
	int pageSize;
	
	@GetMapping(value ={"/{admin}","/"})
	public String main(HttpSession session, Model model, HttpServletRequest request,@AuthenticationPrincipal User userC, @PathVariable(required = false) String admin) throws Exception {
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) {
			ip = req.getRemoteAddr();
		}
		System.out.println("ip : : : : : "+ip);
		model.addAttribute("clientIP", ip);
		System.out.println("admin : "+admin);
		if(admin !=null && admin.equals(" admin")) {
			System.out.println(admin);
			session.setAttribute("prevPage","");
		}
		
		// 자동로그인
		Cookie[] cookies = request.getCookies();		
		if(cookies != null) {
			String userId = null;
			for (Cookie cookie : cookies) {
				if(cookie.getName().equals("loginCookie")) {
					userId = cookie.getValue();
				}
			}			
			User dbUser = userService.getUser(userId);			
			if(dbUser != null) {
				session.setAttribute("user", dbUser);
			}
		}
		
		Search search = new Search();
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}		
		search.setPageSize(pageSize);
		search.setSearchCondition("0");
		// 이벤트		
		Map<String,Object> map = operationService.getListOperation(search, 2);	
		model.addAttribute("listE",(List<Post>)map.get("list"));
		
		// 푸드 카테고리
		model.addAttribute("list",(List<Post>)map.get("list"));		
		session.setAttribute("fList",productService.getListFoodCategory());
		
		// 유저 관리
		User user = (User)session.getAttribute("user");
		if(user == null) {
			session.setAttribute("user", userC);
		}	
		
		// 추천음식
		search = new Search();
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}		
		search.setPageSize(pageSize);
		

		// 메인페이지 모든 상품들
		map = productService.getListProduct(search);
		List<Product> list = (List)map.get("list");
				
		if(userC != null) {
			List<Like> likeList = productService.getListLikeAll(userC.getUserId());
			for (Product product : list) {
				
				for (Like like : likeList) {
					if(product.getProductNo() == like.getProductNo()) {
						product.setLikeStatus(1);
					}					
				}				
			}			
		}
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		model.addAttribute("list",list);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		map.put("month",0);
		if(userC == null) {
			// 이달의 최고판매 10개
			map.put("option", "main");
			map.put("count", 10);
			
			model.addAttribute("monthSaleProduct",operationService.monthSaleProduct(map));
			
			
		} else {
			System.out.println("userC : "+userC);
			if(userC.getFoodCategoryName1() == null) {
				// 이달의 최고판매 10개
				map.put("option", "main");
				map.put("count", 10);
				
				List<Map<String,Object>> bestList = operationService.monthSaleProduct(map);
				
				List<Like> likeList2 = productService.getListLikeAll(userC.getUserId());
				for (Map<String,Object> p2 : bestList) {
					System.out.println("p2 p2 : "+p2.get("PRODUCT_NO"));
					String productNo = String.valueOf(p2.get("PRODUCT_NO"));
					for (Like like : likeList2) {
						if(productNo.equals(Integer.toString(like.getProductNo()))) {
							p2.put("likeStatus", 1);
						}					
					}				
				}
				
				model.addAttribute("monthSaleProduct",bestList);
			}else {
				map.put("user", userC);
				
				List<Map<String,Object>> bestList = operationService.selectUserProduct(map);
						
				List<Like> likeList2 = productService.getListLikeAll(userC.getUserId());
				for (Map<String,Object> p2 : bestList) {
					String productNo = String.valueOf(p2.get("PRODUCT_NO"));
					for (Like like : likeList2) {
						if(productNo.equals(Integer.toString(like.getProductNo()))) {
							p2.put("likeStatus", 1);
						}					
					}				
				}
				
				model.addAttribute("monthSaleProduct",bestList);
			}
		}
		
		
		return "main/main";
	}
	
	@GetMapping("/admin")
	public String adminPage(HttpSession session, Model model, HttpServletRequest request) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		User user = (User)session.getAttribute("user");
		model.addAttribute("count",operationService.countAdmin());
		model.addAttribute("userCount",operationService.userCount("users"));
		model.addAttribute("purchaseCount",operationService.userCount("purchase"));
		model.addAttribute("salePrice",operationService.salePrice());
		
		// table 부분
		map.put("month",0);
		
		// user 일일 가입자수
		map.put("table", "users");		
		model.addAttribute("userDay",operationService.countAdminDay(map));
		
		// 구매 횟수
		map.put("table", "purchase");
		model.addAttribute("purchaseDay",operationService.countAdminDay(map));
		
		// 판매액
		map.put("option", "price");
		model.addAttribute("purchasePriceDay",operationService.countAdminDay(map));
		map.put("option", null);
		
		// 리뷰횟수
		map.put("table", "review");
		model.addAttribute("reviewDay",operationService.countAdminDay(map));
		
		// 문의 횟수
		map.put("table", "post");
		map.put("post_status", 3);
		model.addAttribute("queryDay",operationService.countAdminDay(map));
		
		// 게시판 글쓴 횟수
		map.put("post_status", 0);
		model.addAttribute("communityDay",operationService.countAdminDay(map));
		
		// 이달의 좋아요 최고 게시글
		map.put("table", "post");
		model.addAttribute("monthPostLike",operationService.monthChart(map));
		
		// 이달의 최고댓글 게시글
		map.put("table", "post p,comments c");
		model.addAttribute("monthPostComment",operationService.monthChart(map));
		
		// 이달의 최고 판매상품
		map.put("table", "product p, purchase pp, customproduct c");
		model.addAttribute("monthSaleProduct",operationService.monthChart(map));
		
		// 이달의 탑텐 최고 판매재료
		map.put("count", 10);
		model.addAttribute("monthSaleParts",operationService.monthSaleParts(map));
		
		// 이달의 탑텐 최고 판매상품
		map.put("count", 10);
		model.addAttribute("monthSaleProduct10",operationService.monthSaleProduct(map));
		
		if(user != null) {
			String referer = request.getServletPath();
			String[] refererA = referer.split("/");
			session.setAttribute("prevPage", refererA[1]);
			if(user.getRole().equals("1")) {
				return "admin/admin";
			}
		}
		
		
		return "redirect:/";
	}
}
