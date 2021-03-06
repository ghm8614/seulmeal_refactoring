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
	
	//???????????????
	@PostMapping("autocomplete")
	public @ResponseBody Map<String, Object> autocomplete(@RequestParam Map<String, Object> paramMap) throws Exception{
		
		List<Map> resultList = purchaseService.autocomplete(paramMap);
		paramMap.put("resultList", resultList);

		return paramMap;
	}

	//?????????????????? ????????????
	@GetMapping("updateCustomProduct/{customProductNo}/{count}")
	public CustomProduct updateCusotmProduct(@PathVariable int customProductNo, @PathVariable int count, CustomProduct customProduct) throws Exception {
	
		System.out.println("/purchase/api/updateCusotmProduct : "+customProductNo+count);
		
		customProduct=purchaseService.getCustomProduct(customProductNo);
		customProduct.setCount(count);
		
		int result = purchaseService.updateCustomProductCount(customProduct);
		System.out.println("update: "+result);

		return customProduct;	
		
	}	
	
	//?????????????????? ?????? ????????????
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
	
	//??????????????? ??? ??????????????????
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
	
	//???????????? ?????? ??? DB??? insertPurchase
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
		
		//??????????????????????????? ?????????????????? but ????????? ????????? ??? ????????? ??????????????? ??????????????? ?????? 0
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
	
	//???????????? ??????
	@PostMapping("verifyIamport")
	public JSONObject verifyIamport(@RequestBody Purchase purchase, Point point, HttpSession session) throws Exception {
		
		System.out.println("/purchase/api/verifyIamport : "+purchase);
		
		//???????????? ??? ???????????? ????????????????????? ??????
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
				
				//??????????????????????????? ??????????????????????????? ?????? 
				List<CustomProduct> cpList=purchase.getCustomProduct();
				for(CustomProduct cp : cpList) {
					purchaseService.updateCustomProductStatus(cp);
				}
				
				if(purchase.getUsePoint()!=0) {
					//???????????????
					point.setUserId(user.getUserId());
					point.setPurchaseNo(purchase.getPurchaseNo());
					point.setPointStatus("0");
					point.setPoint(purchase.getUsePoint());
					userService.insertPoint(point);
					//?????????????????? ??????????????? ??????
					user.setTotalPoint(user.getTotalPoint()-purchase.getUsePoint());
					userService.updateUserTotalPoint(user);
				}
				
				json.put("purchase", purchase);
				json.put("sucess", "true");
				json.put("message", "??????!!!!!!");
			}else {
				json.put("success", "false");
				int cancel=purchaseService.cancelPayment(token, Integer.toString(purchase.getPurchaseNo()));
				if(cancel==1) {
					json.put("message", "??????!!!!!");
				}else {
					json.put("message", "??????");
				}
			}
		}else {
			purchaseService.cancelPayment(token, Integer.toString(purchase.getPurchaseNo()));
			json.put("message", "??????????????????");
		}
		return json;
	}
	
	//????????????????????? ???????????????
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
	
	//????????????, ???????????? ??? ????????????????????????
   @PostMapping("updatePurchaseCode")
   public int updatePurchaseCode(@RequestBody Purchase purchase, Point point, Product product, HttpSession session) throws Exception{

         System.out.println("/purchase/api/updatePurchaseCode : POST"+purchase);
         
         purchaseService.updatePurchaseCode(purchase);
         purchase=purchaseService.getPurchase(purchase.getPurchaseNo());
         User user=(User)(session.getAttribute("user"));
         purchase.setUser(user);
         
         //???????????? ??? ???????????????
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
           //?????? ????????????
           user.setTotalPoint(user.getTotalPoint()+plusPoint);
           userService.updateUserTotalPoint(user);
           
           //??????????????????
           List<CustomProduct> list=purchase.getCustomProduct();
           for(CustomProduct cp:list) {
        	   Product p = cp.getProduct();
        	   productService.updateProductStock(p.getProductNo(), p.getStock()-cp.getCount());
           }     
           
         }           
         return plusPoint;
      }   
}
