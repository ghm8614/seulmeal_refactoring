package shop.seulmeal.web.purchase;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import shop.seulmeal.common.Page;
import shop.seulmeal.common.Search;
import shop.seulmeal.service.domain.CustomProduct;
import shop.seulmeal.service.domain.Parts;
import shop.seulmeal.service.domain.Point;
import shop.seulmeal.service.domain.Product;
import shop.seulmeal.service.domain.Purchase;
import shop.seulmeal.service.domain.User;
import shop.seulmeal.service.product.ProductService;
import shop.seulmeal.service.purchase.PurchaseService;
import shop.seulmeal.service.user.UserService;

@RestController
@RequestMapping("/purchase/api/*")
public class PurchaseRestController {
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Value("${pageUnit}")
	int pageUnit;
	
	@Value("${pageSize}")
	int pageSize;
	
	public PurchaseRestController(){
		System.out.println(this.getClass());
	}
	
	//오토컴플릿
	@PostMapping("autocomplete")
	public @ResponseBody Map<String, Object> autocomplete(@RequestParam Map<String, Object> paramMap) throws Exception{
		
		List<Map> resultList = purchaseService.autocomplete(paramMap);
		paramMap.put("resultList", resultList);

		return paramMap;
	}

	//장바구니에서 수량변경
	@GetMapping("updateCustomProduct/{customProductNo}/{count}")
	public CustomProduct updateCusotmProduct(@PathVariable int customProductNo, @PathVariable int count, CustomProduct customProduct) throws Exception {
	
		System.out.println("/purchase/api/updateCusotmProduct : "+customProductNo+count);
		
		customProduct=purchaseService.getCustomProduct(customProductNo);
		customProduct.setCount(count);
		
		int result = purchaseService.updateCustomProductCount(customProduct);
		System.out.println("update: "+result);

		return customProduct;	
		
	}	
	
	//커스터마이징 상품 옵션수정
	@GetMapping("getCustomProduct/{customProductNo}")
	@Transactional(rollbackFor= {Exception.class})
	public Map<String, Object> getCustomProduct(@PathVariable int customProductNo, CustomProduct customProduct, Model model) throws Exception {
		
		System.out.println("/purchase/api/getCustomProduct :Get");
		
		customProduct=purchaseService.getCustomProduct(customProductNo);
		
		List<Parts> partsList=productService.getProductParts(customProduct.getProduct().getProductNo());
		
		Map<String, Object> map=new HashedMap();
		map.put("customProduct", customProduct);
		map.put("partsList",partsList);
		
		return map;
	}	
	
	//포인트사용 시 비밀번호확인
	@PostMapping("confirmPassword")
	public JSONObject confirmPassword(@RequestBody Map temp, HttpSession session) throws Exception {
	
		System.out.println("/purchase/api/confirmPassword : "+temp);
		
		String password=(String)temp.get("password");
		int usePoint=(int)temp.get("usePoint");
		
		User user=(User)session.getAttribute("user");
		String realPw=user.getPassword();
		int realPt=user.getTotalPoint();
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		JSONObject json=new JSONObject();
		if(encoder.matches(password, realPw) && usePoint<=realPt) {
			json.put("success", "true");
		}else if(usePoint > realPt) {
			json.put("success","pt");
		}else {
			json.put("success","pw");
		}
		return json;	
	}	
	
	//아임포트 결제 전 DB에 insertPurchase
	@PostMapping("insertPurchase")
	public Purchase insertPurchase(@RequestBody Map<String, Object> map, Purchase purchase, Point point, HttpSession session) throws Exception {
		
		System.out.println("/purchase/api/insertPurchase :"+map);
		
		User user=(User)(session.getAttribute("user"));
		
		purchase.setUser(user);
		purchase.setName((String)map.get("name"));
		purchase.setAddress((String)map.get("address"));
		purchase.setPhone((String)map.get("phone"));
		purchase.setEmail((String)map.get("email"));
		purchase.setMessage((String)map.get("message"));
		purchase.setPrice(Integer.parseInt((String)map.get("price")));
		purchase.setPaymentCondition(String.valueOf(map.get("paymentCondition")));
		purchase.setUsePoint(Integer.parseInt((String)map.get("usePoint")));
		
		//insert
		int result=purchaseService.insertPurchase(purchase);
		
		//커스터마이징상품에 구매번호추가 but 결제중 취소할 수 있으니 구매상태는 구매완료가 아닌 0
		ArrayList customProductNo=(ArrayList) map.get("customProductNo");
		
		List<CustomProduct> cpList=new ArrayList<CustomProduct>();
		for(int i=0; i<customProductNo.size(); i++) {
			CustomProduct cp=new CustomProduct();
			cp=purchaseService.getCustomProduct(Integer.parseInt((String)customProductNo.get(i)));
			cp.setPurchaseNo(purchase.getPurchaseNo());
			purchaseService.updateCustomProductPurchaseNo(cp);
			cpList.add(cp);
		}
		
		//get
		purchase=purchaseService.getPurchase(purchase.getPurchaseNo());
		purchase.setUser(user);

		return purchase;	
		
	}	
	
	//아임포트 검증
	@PostMapping("verifyIamport")
	public JSONObject verifyIamport(@RequestBody Purchase purchase, Point point, HttpSession session) throws Exception {
		
		System.out.println("/purchase/api/verifyIamport : "+purchase);
		
		//결제완료 시 구매상태 상품준비중으로 변경
		int success=purchaseService.updatePurchase(purchase);
		System.out.println("/purchase/api/verifyIamport update : "+success);
			
		purchase=purchaseService.getPurchase(purchase.getPurchaseNo());
		System.out.println("/purchase/api/verifyIamport purchaseNo : "+ purchase.getPurchaseNo());
		User user=(User)(session.getAttribute("user"));
		purchase.setUser(user);		
		
		String token=purchaseService.getImportToken();
		System.out.println("/purchase/api/verifyIamport token : "+ token);
		
		JSONObject json=new JSONObject();
		if(success ==1) {
			String portAmount=purchaseService.getAmount(token, Integer.toString(purchase.getPurchaseNo()));
			
			if(purchase.getPrice() == Integer.parseInt(portAmount)) {
				
				//커스터마이징상품은 장바구니리스트에서 삭제 
				List<CustomProduct> cpList=purchase.getCustomProduct();
				for(CustomProduct cp : cpList) {
					purchaseService.updateCustomProductStatus(cp);
				}
				
				if(purchase.getUsePoint()!=0) {
					//사용포인트
					point.setUserId(user.getUserId());
					point.setPurchaseNo(purchase.getPurchaseNo());
					point.setPointStatus("0");
					point.setPoint(purchase.getUsePoint());
					userService.insertPoint(point);
					//총포인트에서 사용포인트 빼기
					user.setTotalPoint(user.getTotalPoint()-purchase.getUsePoint());
					userService.updateUserTotalPoint(user);
				}
				
				json.put("purchase", purchase);
				json.put("sucess", "true");
				json.put("message", "성공!!!!!!");
			}else {
				json.put("success", "false");
				int cancel=purchaseService.cancelPayment(token, Integer.toString(purchase.getPurchaseNo()));
				if(cancel==1) {
					json.put("message", "성공!!!!!");
				}else {
					json.put("message", "실패");
				}
			}
		}else {
			purchaseService.cancelPayment(token, Integer.toString(purchase.getPurchaseNo()));
			json.put("message", "취소실패ㅠㅠ");
		}
		return json;
	}
	
	//구매내역리스트 무한스크롤
	@RequestMapping(value={"/getListPurchase","/getListPurchase/{currentPage}", "/getListPurchase/{currentPage}/{searchCondition}"})
	public List<Purchase> getListPurchase(@PathVariable int currentPage, @PathVariable(required = false) String searchCondition, Search search, HttpSession session)
			throws Exception {
		
		System.out.println("/purchase/api/getListPurchase : "+currentPage);
		
		User user=(User)session.getAttribute("user");
		String userId=user.getUserId();
		
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		search.setSearchCondition(searchCondition);

		Map<String, Object> map = purchaseService.getListPurchase(search, userId);
		List<Purchase> purchaseList=(List<Purchase>)map.get("purchaseList");
		
		for(Purchase p:purchaseList) {
			p.setUser(user);
		}
		return purchaseList;
	}
	
	//배송하기, 구매확정 후 구매처리상태변경
   @PostMapping("updatePurchaseCode")
   public int updatePurchaseCode(@RequestBody Purchase purchase, Point point, Product product, HttpSession session) throws Exception{

         System.out.println("/purchase/api/updatePurchaseCode : POST"+purchase);
         
         purchaseService.updatePurchaseCode(purchase);
         purchase=purchaseService.getPurchase(purchase.getPurchaseNo());
         User user=(User)(session.getAttribute("user"));
         purchase.setUser(user);
         
         //구매확정 후 포인트적립
         int plusPoint=0;
         if(purchase.getPurchaseStatus().equals("4")) {
         
            int total=purchase.getPrice()+purchase.getUsePoint();
            String grade=user.getGrade();
            
            if(grade.equals("0")) {
               plusPoint=(int) (total*0.005);
            }else if(grade.equals("1")) {
               plusPoint=(int) (total*0.01);
            }else if(grade.equals("2")) {
               plusPoint=(int) (total*0.03);
            }else if(grade.equals("3")) {
               plusPoint=(int) (total*0.05);
            }
           
           point.setUserId(user.getUserId());
           point.setPurchaseNo(purchase.getPurchaseNo());
           point.setPointStatus("1");
           point.setPoint(plusPoint);
           userService.insertPoint(point);
           //유저 총포인트
           user.setTotalPoint(user.getTotalPoint()+plusPoint);
           userService.updateUserTotalPoint(user);
           
           //상품재고변경
           List<CustomProduct> list=purchase.getCustomProduct();
           for(CustomProduct cp:list) {
        	   Product p = cp.getProduct();
        	   productService.updateProductStock(p.getProductNo(), p.getStock()-cp.getCount());
           }     
           
         }           
         return plusPoint;
      }   
}
