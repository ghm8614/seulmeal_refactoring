package shop.seulmeal.web.user;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import shop.seulmeal.common.Page;
import shop.seulmeal.common.Search;
import shop.seulmeal.service.domain.Foodcategory;
import shop.seulmeal.service.domain.Parts;
import shop.seulmeal.service.domain.Point;
import shop.seulmeal.service.domain.Purchase;
import shop.seulmeal.service.domain.User;
import shop.seulmeal.service.naver.impl.KakaoAPI;
import shop.seulmeal.service.naver.impl.LoginService;
import shop.seulmeal.service.product.ProductService;
import shop.seulmeal.service.purchase.PurchaseService;
import shop.seulmeal.service.user.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private ProductService productService;

	@Autowired
	private LoginService loginService;

	@Autowired
	private KakaoAPI kakaoApi;

	@Autowired
	private PurchaseService purchaseService;

	int pageUnit = 10;
	int pageSize = 10;

	public UserController() {
		System.out.println(this.getClass());
	}

	@GetMapping("insertUser")
	public String insertUser() throws Exception {

		return "user/insertUser";
	}

	@PostMapping("insertUser")
	public String insertUser(@ModelAttribute("user") User user, HttpSession session) throws Exception {

		System.out.println("::user : " + user);
		userService.insertUser(user);
		session.setAttribute("user", user);

		return "redirect:/user/insertUserInformation";
	}

	@GetMapping("insertUserInformation")
	public String insertUserInformation(Model model) throws Exception {

		List<Foodcategory> foodcategoryList = productService.getListFoodCategory();
		model.addAttribute("foodcategoryList", foodcategoryList);
		return "user/insertUserInformation";
	}

	@PostMapping("insertUserInformation")
	public String insertUserInformation(String[] foodcategory, MultipartFile imageFile, String profilemessage,
			String[] partsName, HttpSession session) throws Exception {

		User user = (User) session.getAttribute("user");

		System.out.println(user);

		if (foodcategory.length == 1) {
			user.setFoodCategoryName1(foodcategory[0]);
		} else if (foodcategory.length == 2) {
			user.setFoodCategoryName1(foodcategory[0]);
			user.setFoodCategoryName2(foodcategory[1]);
		} else {
			user.setFoodCategoryName1(foodcategory[0]);
			user.setFoodCategoryName2(foodcategory[1]);
			user.setFoodCategoryName3(foodcategory[2]);
		}

		String imageFilePath = null;
//		String absolutePath = new File("").getAbsolutePath()+"\\";
		//String path = System.getProperty("user.dir") + "/src/main/webapp/resources/attachments/profile_image";
		String path = "/home/tomcat/apache-tomcat-9.0.64/webapps/seulmeal/resources/attachments/profile_image";
		File file = new File(path);

		if (!file.exists()) {
			file.mkdirs();
		}

		if (!imageFile.isEmpty()) {
			String contentType = imageFile.getContentType();
			String originalFileExtension = null;

			if (contentType.contains("image/jpeg")) {
				originalFileExtension = ".jpg";
			} else if (contentType.contains("image/png")) {
				originalFileExtension = ".png";
			} else if(contentType.contains("image/jpg")) {
	        	 originalFileExtension = ".jpg";
	         }

			imageFilePath = path + "/" + user.getUserId() + "_profile" + originalFileExtension;
			String imageFileName = user.getUserId() + "_profile" + originalFileExtension;
			System.out.println("//////userId: " + user.getUserId());
			System.out.println("//////imageFilePath: " + imageFilePath);
			System.out.println("//////originalFileExtension: " + originalFileExtension);
			System.out.println("//////getOriginalFilename(): " + imageFile.getOriginalFilename());

			// 이미지 파일 로컬에 저장
			file = new File(imageFilePath);
			imageFile.transferTo(file);

			// 저장한 이미지 파일을 User session 저장 또는 수정
//			User user = (User)session.getAttribute("user");
			user.setProfileImage(imageFileName);
		}

		if (profilemessage != null) {
			user.setProfileMessage(profilemessage);
		}

		userService.updateProfile(user);

		if (partsName != null) {
			List<Parts> parts = new ArrayList<>();

			for (int i = 0; i < partsName.length; i++) {
				// System.out.println("::partsName : "+partsName[i]);

				Map<String, Object> map1 = new HashMap<String, Object>();
				map1.put("name", partsName[i]);
				Parts hateParts = productService.getParts(map1);
				System.out.println("::hateParts : " + hateParts);
				parts.add(hateParts);

			}

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", parts);
			map.put("userId", user.getUserId());
			userService.insertHatesParts(map);
		}

		return "redirect:/";
	}

	@GetMapping("getUpdateUser/{userId}")
	public String getUpdateUser(@PathVariable("userId") String userId, Model model) throws Exception {

		User user = userService.getUser(userId);
		List<Foodcategory> foodcategoryList = productService.getListFoodCategory();

		model.addAttribute("user", user);
		model.addAttribute("foodcategoryList", foodcategoryList);

		return "user/getUpdateUser";
	}

	@PostMapping("getUpdateUser")
	public String getUpdateUser(@ModelAttribute("user") User user, String[] foodcategory, MultipartFile imageFile,
			String profilemessage, String[] partsName, String newPassword, HttpSession session) throws Exception {

		if (!newPassword.isEmpty()) {
			user.setPassword(newPassword);
		}

		if (foodcategory.length == 1) {
			user.setFoodCategoryName1(foodcategory[0]);
		} else if (foodcategory.length == 2) {
			user.setFoodCategoryName1(foodcategory[0]);
			user.setFoodCategoryName2(foodcategory[1]);
		} else {
			user.setFoodCategoryName1(foodcategory[0]);
			user.setFoodCategoryName2(foodcategory[1]);
			user.setFoodCategoryName3(foodcategory[2]);
		}

		String imageFilePath = null;
//		String absolutePath = new File("").getAbsolutePath()+"\\";
		// String path =
		// System.getProperty("user.dir")+"/src/main/webapp/resources/attachments/profile_image";
		String path = "/home/tomcat/apache-tomcat-9.0.64/webapps/seulmeal/resources/attachments/profile_image";
		File file = new File(path);

		if (!file.exists()) {
			file.mkdirs();
		}

		if (!imageFile.isEmpty()) {
			String contentType = imageFile.getContentType();
			String originalFileExtension = null;

			if (contentType.contains("image/jpeg")) {
				originalFileExtension = ".jpg";
			} else if (contentType.contains("image/png")) {
				originalFileExtension = ".png";
			} else if(contentType.contains("image/jpg")) {
	        	 originalFileExtension = ".jpg";
	         }

			imageFilePath = path + "/" + user.getUserId() + "_profile" + originalFileExtension;
			String imageFileName = user.getUserId() + "_profile" + originalFileExtension;
			System.out.println("//////userId: " + user.getUserId());
			System.out.println("//////imageFilePath: " + imageFilePath);
			System.out.println("//////originalFileExtension: " + originalFileExtension);
			System.out.println("//////getOriginalFilename(): " + imageFile.getOriginalFilename());

			// 이미지 파일 로컬에 저장
			file = new File(imageFilePath);
			imageFile.transferTo(file);

			// 저장한 이미지 파일을 User session 저장 또는 수정
//			User user = (User)session.getAttribute("user");
			user.setProfileImage(imageFileName);
		}

		if (profilemessage != null) {
			user.setProfileMessage(profilemessage);
		}

		userService.updateUser(user);

		if (partsName != null) {
			List<Parts> parts = new ArrayList<>();

			for (int i = 0; i < partsName.length; i++) {
				// System.out.println("::partsName : "+partsName[i]);

				Map<String, Object> map1 = new HashMap<String, Object>();
				map1.put("name", partsName[i]);
				Parts hateParts = productService.getParts(map1);
				System.out.println("::hateParts : " + hateParts);
				parts.add(hateParts);

			}

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", parts);
			map.put("userId", user.getUserId());
			userService.insertHatesParts(map);
		}

		String sessionId = ((User) session.getAttribute("user")).getUserId();
		if (sessionId.equals(user.getUserId())) {
			session.setAttribute("user", user);
		}
		return "redirect:/user/getUpdateUser/" + sessionId;
	}

	@GetMapping("login")
	public String login(HttpServletRequest request) throws Exception {
		String referer = request.getHeader("Referer");
		request.getSession().setAttribute("prevPage", referer);
		System.out.println(referer);
		return "user/login";
	}

	// @PostMapping("login")
	public String login(@ModelAttribute("user") User user, String checkLogin, HttpSession session,
			HttpServletResponse response) throws Exception {
		System.out.println("::user : " + user);

		User dbUser = userService.getUser(user.getUserId());

		if (dbUser != null) {

			if (user.getPassword().equals((dbUser.getPassword()))) {
				session.setAttribute("user", dbUser);
			}

			if (checkLogin != null) {
				if (checkLogin.equals("1")) {
					Cookie loginCookie = new Cookie("loginCookie", dbUser.getUserId());
					loginCookie.setPath("/");
					long limitTime = 60 * 60 * 24 * 90;
					loginCookie.setMaxAge((int) limitTime);
					response.addCookie(loginCookie);
				}
			}

		}

		return "redirect:/";
	}

	@GetMapping("logout")
	public String logout(HttpSession session, HttpServletResponse response) throws Exception {
		// 자동로그인 삭제
		Cookie nCookie = new Cookie("loginCookie", null);
		nCookie.setPath("/");
		nCookie.setMaxAge(0);
		response.addCookie(nCookie);

		session.invalidate();
		return "redirect:/";
	}

	@GetMapping("findUserIdView")
	public String findUserId() throws Exception {

		return "user/findUserIdView";
	}

	@PostMapping("findUserId")
	public String findUserId(String email, Model model) throws Exception {
		System.out.println(":: email : " + email);
		email = email.replace(",", "");
		System.out.println(":: email2 : " + email);

		User user = userService.confirmUserEmail(email);

		model.addAttribute("user", user);

		return "user/findUserId";

	}

	@GetMapping("findUserPasswordView")
	public String findUserPasswordView() throws Exception {

		return "user/findUserPasswordView";
	}

	@PostMapping("findUserPasswordView")
	public String findUserPassword(String userId, String phone, String email, HttpSession session) throws Exception {

		session.setAttribute("userId", userId);

		return "redirect:/user/resetUserPassword/" + userId;

	}

	@GetMapping("resetUserPassword")
	public String resetUserPassword() throws Exception {

		return "user/resetUserPassword";
	}

	
	 @PostMapping("resetUserPassword") public String resetUserPassword( String
	 password, HttpSession session) throws Exception {
	  
	 String userId = (String)session.getAttribute("userId");
	 
	  User user = new User(); user.setUserId(userId); user.setPassword(password);
	  
	 userService.updatePassword(user);
	  
	 return "redirect:/"; }
	

	/*
	 * @PostMapping("resetUserPassword") public String resetUserPassword( String
	 * password, String userId, HttpSession session) throws Exception {
	 * 
	 * String userId = (String)session.getAttribute("userId");
	 * 
	 * User user = new User(); user.setUserId(userId); user.setPassword(password);
	 * 
	 * userService.updatePassword(user);
	 * 
	 * return "redirect:/"; }
	 */

	@GetMapping("userGradeModal")
	public String userGradeModal() throws Exception {

		return "userGradeModal";
	}

	@GetMapping("deleteUser")
	public String deleteUser() throws Exception {

		return "user/deleteUser";
	}

	@PostMapping("deleteUser")
	public String deleteUser(String password, HttpSession session) throws Exception {

		if (password.equals(((User) session.getAttribute("user")).getPassword())) {
			userService.deleteUser(((User) session.getAttribute("user")).getUserId());

			session.invalidate();
		}
			return "redirect:/";
	}

	@GetMapping(value = { "listUser/{currentPage}/{searchCondition}", "listUser/{currentPage}", "listUser" })
	public String getUserList(Model model, @PathVariable(required = false) String currentPage,
			@PathVariable(required = false) String searchCondition, String searchKeyword) throws Exception {

		Search search = new Search();
		if (currentPage != null) {
			search.setCurrentPage(new Integer(currentPage));
		}
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		search.setPageSize(pageSize);
		search.setSearchCondition(searchCondition);
		search.setSearchKeyword(searchKeyword);
		System.out.println(search);

		Map<String, Object> map = userService.getListUser(search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);

		model.addAttribute("list", map.get("list"));
		model.addAttribute("page", resultPage);
		model.addAttribute("search", search);

		return "user/listUser";
	}

	@GetMapping("getUser/{userId}")
	public String getUser(@PathVariable("userId") String userId, Model model) throws Exception {

		User user = userService.getUser(userId);

		String recentPurchaseNo = userService.getRecentPurchase(userId);

		if (recentPurchaseNo != null) {
			int recentPurchaseNo1 = Integer.parseInt(recentPurchaseNo);
			Purchase purchase = purchaseService.getPurchase(recentPurchaseNo1);
			model.addAttribute("purchase", purchase);

		}

		model.addAttribute("user1", user);

		return "user/getUser";
	}

	@GetMapping("chargeUserPoint")
	public String chargeUserPoint(Model model, HttpSession session) throws Exception {

		User user = (User) session.getAttribute("user");
		model.addAttribute("user", user);

		return "user/insertPoint";
	}

	@GetMapping("getChargeUserPoint/{purchaseNo}")
	public String getChargeUserPoint(@PathVariable int purchaseNo, User user, Point point, Purchase purchase,
			Model model) throws Exception {

		System.out.println("/getListCustomProduct : " + purchaseNo);

		purchase = purchaseService.getPurchase(purchaseNo);

		model.addAttribute(purchase);

		purchase.setPurchaseStatus("0");
		purchaseService.updatePurchaseCode(purchase);

		point.setUserId(purchase.getUser().getUserId());
		point.setPointNo(purchaseNo);
		point.setPointStatus("2");
		point.setPoint(purchase.getPrice());
		userService.insertPoint(point);

		user = userService.getUser(purchase.getUser().getUserId());

		user.setTotalPoint((purchase.getPrice() + user.getTotalPoint()));
		userService.updateUserTotalPoint(user);
		user = userService.getUser(user.getUserId());

		model.addAttribute(user);
		userService.updateUserTotalPoint(user);

		return "user/getChargeUserPoint";
	}

	@GetMapping(value = { "listUserPoint/{currentPage}/{searchCondition}", "listUserPoint/{currentPage}",
			"listUserPoint" })
	public String listUserPoint(Model model, @PathVariable(required = false) String currentPage,
			@PathVariable(required = false) String searchCondition, HttpSession session) throws Exception {

		Search search = new Search();
		if (currentPage != null) {
			search.setCurrentPage(new Integer(currentPage));
		}
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		search.setPageSize(pageSize);
		search.setSearchCondition(searchCondition);
		System.out.println(search);

		User dbUser = (User) session.getAttribute("user");

		Map<String, Object> map = userService.getListPoint(search, dbUser.getUserId());

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("pontTotalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);

		model.addAttribute("pointList", map.get("pointList"));
		model.addAttribute("page", resultPage);
		model.addAttribute("search", search);

		return "user/listUserPoint";
	}

	@RequestMapping(value = "kakaoLogin")
	public String kakaoLogin(@RequestParam("code") String code, HttpSession session) throws Exception {

		ModelAndView mav = new ModelAndView();
		System.out.println("::code : " + code);

		// 1번 인증코드 전달
		String accessToken = kakaoApi.getAccessToken(code);
		// 2번 인증코드로 토큰 전달
		HashMap<String, Object> userInfo = kakaoApi.getUserInfo(accessToken);

		System.out.println("login info : " + userInfo.toString());

		if (userInfo.get("email") != null && userService.getUser((String) userInfo.get("email")) == null) {

			User user = new User();
			user.setUserId((String) userInfo.get("email"));
			user.setUserName((String) userInfo.get("nickname"));
			user.setPassword((String) userInfo.get("email"));
			user.setEmail((String) userInfo.get("email"));
			user.setNickName((String) userInfo.get("nickname"));
			/* user.setPhone("010-000-0000"); */
			userService.insertUser(user);

			user = userService.getUser((String) userInfo.get("email"));
			session.setAttribute("user", user);
		} else {
			User user = userService.getUser((String) userInfo.get("email"));
			System.out.println("::user : " + user);
			session.setAttribute("user", user);
		}

		return "redirect:/";
	}

	@GetMapping("naver")
	public String naver(@RequestParam Map<String, String> resValue, HttpSession session) throws Exception {
		System.out.println(resValue);
		String token = loginService.getNaverAccessToken(resValue.get("state"), resValue.get("code"));
		User user = loginService.getUserInfo(token);
		System.out.println(user);

		int result = userService.confirmUserId(user.getUserId());

		if (result == 0) {
			userService.insertUser(user);
		}
		user = userService.getUser(user.getUserId());
		session.setAttribute("user", user);

		return "redirect:/";
	}

}