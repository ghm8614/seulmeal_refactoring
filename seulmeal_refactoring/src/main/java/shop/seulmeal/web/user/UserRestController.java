package shop.seulmeal.web.user;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import shop.seulmeal.common.Page;
import shop.seulmeal.common.Search;
import shop.seulmeal.service.confirm.ConfirmService;
import shop.seulmeal.service.domain.Parts;
import shop.seulmeal.service.domain.Point;
import shop.seulmeal.service.domain.Purchase;
import shop.seulmeal.service.domain.Relation;
import shop.seulmeal.service.domain.User;
import shop.seulmeal.service.naver.impl.KakaoAPI;
import shop.seulmeal.service.naver.impl.LoginService;
import shop.seulmeal.service.product.ProductService;
import shop.seulmeal.service.purchase.PurchaseService;
import shop.seulmeal.service.user.UserService;

@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	@Autowired
	private UserService userService;
		
	@Autowired
	private ConfirmService confirmService;
	
	@Autowired
	private LoginService loginService;
	
	@Autowired
	private PurchaseService purchaseService;
	

	public UserRestController() {
		// TODO Auto-generated constructor stub
	}
	
	@GetMapping("/username")
	public Principal cuname(Principal principal) {
		System.out.println("principal 알려줘 : "+principal);
		return principal;
	}
	
	@GetMapping("api/confirmUserId/{userId}")
	public JSONObject confirmUserId(@PathVariable String userId) throws Exception {
		JSONObject json = new JSONObject();
		
		int no = userService.confirmUserId(userId);
		if(no == 0) {
			json.put("result", "success");
		} else {
			json.put("result", "fail");
		}
			
		return json;
	}
	
	@GetMapping("api/confirmPassword/{password}")
	public JSONObject confirmPassword(@PathVariable String password, HttpSession session) throws Exception {
		
		User user=(User)session.getAttribute("user");
		String realPw=user.getPassword();
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		JSONObject json = new JSONObject();
		
		
		if(encoder.matches(password, realPw)) {
			json.put("result", "success");
		} else {
			json.put("result", "fail");
		}
			
		return json;
	}
	
	
	@PostMapping("api/confirmLogin")
	public JSONObject confirmlogin(@RequestBody Map temp) throws Exception {
		System.out.println("::temp : "+temp);
		
		String userId = (String)temp.get("userId");
		String password= (String)temp.get("password");
		
		JSONObject json = new JSONObject();
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		User user=userService.getUser(userId);
		
		if(user == null) {
			json.put("result", "failId");
			
		} else {
			String dbPassword = user.getPassword();
			
			if(encoder.matches(password, dbPassword)) {
				json.put("result", "success");
			} else {
				json.put("result", "failPassword");
			}
			
		}
			
		return json;
	}
	
	@GetMapping("api/confirmUserNickname/{nickName}")
	public JSONObject confirmUserNickname(@PathVariable String nickName) throws Exception {
		JSONObject json = new JSONObject();
		int no = userService.confirmUserId(nickName);
		if(no == 0) {
			json.put("result", "success");
		} else {
			json.put("result", "fail");
		}
		return json;
	}
	@GetMapping("api/findId")
	public JSONObject findId(@RequestParam(required = false) Map<String, Object> idSearch, HttpSession session) throws Exception {
		System.out.println("idSearch"+idSearch);
		String userName = (String)idSearch.get("name");
		System.out.println(":: userName : "+userName);
		String email = (String)idSearch.get("email");
		System.out.println(":: email : "+email);
		String phone = (String)idSearch.get("phone");
		System.out.println(":: phone : "+phone);
		
		JSONObject json = new JSONObject();
		
		if(!email.isEmpty()) {
			
			
			User user = userService.confirmUserEmail(email);
			if(user != null) {
				System.out.println("username : "+user.getUserName());
				if(user.getUserName().equals(userName)) {
					
					int num = confirmService.confirmNum();
					String message = "인증번호는 ["+num+"] 입니다";
					confirmService.sendMail(message, email);
					session.setAttribute("num", num);
					session.setAttribute("userId", user.getUserId());
					json.put("result", "success");
					
					
				} else {
					json.put("result", "fail");
				}	
				return json;
			} else {
				json.put("result", "fail");
				return json;
			}
			
		} else {
			
			User user = userService.confirmUserPhone(phone);
			if(user != null) {
				
				System.out.println("username : "+user.getUserName());
				if(user.getUserName().equals(userName)) {
					
					int num = confirmService.confirmNum();
					String message = "[슬밀]인증번호는 ["+num+"] 입니다.";
					System.out.println("message : "+message);
					
					confirmService.sendSMS(phone, message);
					session.setAttribute("num", num);
					session.setAttribute("userId", user.getUserId());
					json.put("result", "success");
					
					
				} else {
					json.put("result", "fail");
				}	
				return json;
			} else {
				json.put("result", "fail");
				return json;
			}
			
		}
		
	}
	
	@GetMapping("api/findPassword")
	public JSONObject findPassword(@RequestParam(required = false) Map<String, Object> passwordSearch, HttpSession session) throws Exception {
		System.out.println("idSearch"+passwordSearch);
		
		JSONObject json = new JSONObject();
		
		String userId = (String)passwordSearch.get("id");
		System.out.println(":: userId : "+userId);
		String email = (String)passwordSearch.get("email");
		System.out.println(":: email : "+email);
		String phone = (String)passwordSearch.get("phone");
		System.out.println(":: phone : "+phone);
		
		if(!email.isEmpty()) {
			User user = userService.confirmUserEmail(email);
			
			if(user != null) {
				System.out.println("userId : "+user.getUserId());
				
				
				if(user.getUserId().equals(userId)) {
					
					int num = confirmService.confirmNum();
					String message = "인증번호는 ["+num+"] 입니다.";
					confirmService.sendMail(message, email);
					session.setAttribute("num", num);
					session.setAttribute("userId", user.getUserId());
					json.put("result", "success");
					
					
				} else {
					json.put("result", "fail");
					
				}	
				return json;
			} else {
				json.put("result", "fail");
				return json;
			}
			
		} else {
			User user = userService.confirmUserPhone(phone);
			if(user != null) {
				System.out.println("userId : "+user.getUserId());
					if(user.getUserId().equals(userId)) {
					
					int num = confirmService.confirmNum();
					String message = "[슬밀]인증번호는 ["+num+"] 입니다.";
					System.out.println("message : "+message);
					
					confirmService.sendSMS(phone, message);
					session.setAttribute("num", num);
					session.setAttribute("userId", user.getUserId());
					json.put("result", "success");
					
					
				} else {
					json.put("result", "fail");
					
				}	
				return json;
			} else {
				json.put("result", "fail");
				return json;
			}

		}
	}
	
	@GetMapping("api/findIdCode")
	public JSONObject findIdCode(@RequestParam(required = false) Map<String, Object> idSearch, HttpSession session) throws Exception {
		System.out.println();
		System.out.println("idSearch"+idSearch);
		int code = Integer.parseInt((String)idSearch.get("code")) ;
		System.out.println(":: code : "+code);
		/*
		 * String email = (String)idSearch.get("email");
		 * System.out.println(":: email : "+email); String phone =
		 * (String)idSearch.get("phone"); System.out.println(":: phone : "+phone);
		 */
		
		JSONObject json = new JSONObject();
		
		int num =(Integer)session.getAttribute("num");
		String userId = (String)session.getAttribute("userId");
		System.out.println("내가보낸 인증번호 : "+code);
		System.out.println("들어있는 인증번호 : "+num);
		if(code==num) {
			json.put("result", "인증완료");
			json.put("userId", userId);
			session.removeAttribute("num");
			//session.removeAttribute("userId");
		} else {
			json.put("result", "인증실패");
		}
		
		return json;
		
		
	}
	
	@GetMapping("api/confirmUserPhone/{phone}")
	public JSONObject confirmUserPhone(@PathVariable String phone,HttpSession session) throws Exception {
		JSONObject json = new JSONObject();
		
		User user = userService.confirmUserPhone(phone);
		
		
		if(user == null) {			
			int num = confirmService.confirmNum();
			String message = "인증번호는 ["+num+"] 입니다"
					+ "\n커스텀이 가능한 슬밀 밀키트 몰입입니다.";
			System.out.println("message : "+message);
			
			confirmService.sendSMS(phone, message);
			session.setAttribute(phone, num);
			json.put("result", "success");
		} else {
			json.put("result", "fail");
		}
		
		return json;
	}
	
	@GetMapping(value = { "api/confirmUserEmail/{email}", "api/confirmUserEmail"})
	public JSONObject confirmUserEmail(@PathVariable(required = false) String email, @RequestParam(required = false) Map<String, Object> idSearch, HttpSession session) throws Exception {
		System.out.println("idSearch"+idSearch);
		
		
		JSONObject json = new JSONObject();
		
		if(email != null) {
			
			User user = userService.confirmUserEmail(email);
			
			if(user == null) {			
				int num = confirmService.confirmNum();
				String message = "인증번호는 ["+num+"] 입니다.";
				confirmService.sendMail(message, email);
				session.setAttribute(email, num);
				json.put("result", "success");
				
			} else {
				json.put("result", "fail");
			}
			
			return json;
		} else if(idSearch.get("idSearch").equals("1")) {
			
			String userName = (String)idSearch.get("name");
			System.out.println(":: userName : "+userName);
			email = (String)idSearch.get("email");
			System.out.println(":: email : "+email);
			User user = userService.confirmUserEmail(email);
			System.out.println("username : "+user.getUserName());
			if(user.getUserName().equals(userName)) {
				
				int num = confirmService.confirmNum();
				String message = "인증번호는 ["+num+"] 입니다";
				confirmService.sendMail(message, email);
				session.setAttribute(email, num);
				session.setAttribute("userId", user.getUserId());
				json.put("result", "success");
				
				
			} else {
				json.put("result", "fail");
			}	
			return json;
		} else {
			
			String userId = (String)idSearch.get("id");
			System.out.println(":: userId : "+userId);
			email = (String)idSearch.get("email");
			System.out.println(":: email : "+email);
			User user = userService.confirmUserEmail(email);
			System.out.println("userId : "+user.getUserId());
			if(user.getUserId().equals(userId)) {
				
				int num = confirmService.confirmNum();
				String message = "[슬밀]인증번호는 ["+num+"] 입니다";
				confirmService.sendMail(message, email);
				session.setAttribute(email, num);
				session.setAttribute("userId", user.getUserId());
				json.put("result", "success");
				
				
			} else {
				json.put("result", "fail");
			}	
			
			return json;
		}
		
	}
		
		
	
	@GetMapping(value ={"api/confirmCode/{confirm}/{confrimNum}","api/confirmCode/{confrimNum}"} )
	public JSONObject confirmCode(@PathVariable(required = false) String confirm,
							@PathVariable(required = false) Integer confrimNum, HttpSession session) throws Exception {
		
		JSONObject json = new JSONObject();
		int num =(Integer)session.getAttribute(confirm);
		String userId = (String)session.getAttribute("userId");
		System.out.println("내가보낸 인증번호 : "+confrimNum);
		System.out.println("들어있는 인증번호 : "+num);
		if(confrimNum == num) {
			json.put("result", "인증완료");
			session.removeAttribute(confirm);
		} else {
			json.put("result", "인증실패");
		}
		
		return json;
	}
	
	public String confirmCaptcha() throws Exception {
		return null;
	}
	
	@GetMapping("api/naver")
	public String authNaver(@RequestParam Map<String, String> resValue) {
		System.out.println(resValue);
		String token = loginService.getNaverAccessToken(resValue.get("state"), resValue.get("code"));
		User user = loginService.getUserInfo(token);
		System.out.println(user);
		return "code : ";
	}
	
	@PostMapping("api/insertPoint")
	public JSONObject insertPoint(@RequestBody Map<String, Object> map, Point point,  HttpSession session) throws Exception{
		
		JSONObject json = new JSONObject();

		int purchaseNo=(Integer)map.get("purchaseNo");
		System.out.println(":: purchase : "+purchaseNo);
		
		
		
		Purchase purchase = purchaseService.getPurchase(purchaseNo);
		purchase.setPurchaseStatus("0");
		purchaseService.updatePurchaseCode(purchase);
		
		
		String userId=purchase.getUser().getUserId();
		User user=userService.getUser(userId);
		
		point.setUserId(userId);
		point.setPurchaseNo(purchase.getPurchaseNo());
		point.setPointStatus("2");
		point.setPoint(purchase.getPrice());
		userService.insertPoint(point);
		
		
		
		user.setTotalPoint((purchase.getPrice()+user.getTotalPoint()));
		userService.updateUserTotalPoint(user);
		user=userService.getUser(userId);
		
		json.put("chargePoint", purchase.getPrice());
		json.put("totalPoint", user.getTotalPoint());
		
		return json;
	}
	
	/*
	 * @GetMapping(value = { "api/listBlackList" }) public List<Relation>
	 * getUserList() throws Exception {
	 * 
	 * List<Relation> blackList = userService.getListBlackList();
	 * 
	 * 
	 * 
	 * return blackList; }
	 */
}
