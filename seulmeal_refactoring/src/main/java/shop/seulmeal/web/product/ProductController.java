package shop.seulmeal.web.product;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import shop.seulmeal.common.Page;
import shop.seulmeal.common.Search;
import shop.seulmeal.service.domain.Foodcategory;
import shop.seulmeal.service.domain.Like;
import shop.seulmeal.service.domain.Parts;
import shop.seulmeal.service.domain.Product;
import shop.seulmeal.service.domain.Review;
import shop.seulmeal.service.domain.User;
import shop.seulmeal.service.product.ProductService;
import shop.seulmeal.service.user.UserService;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	int pageUnit = 10;
	int pageSize = 10;

	//private String path =System.getProperty("user.dir")+"/src/main/webapp/resources/attachments/";
	private String path = "/home/tomcat/apache-tomcat-9.0.64/webapps/seulmeal/resources/attachments/";
	
	public ProductController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	
	
	/* <PRODUCT> */

	@GetMapping("insertProduct")
	public String insertProduct(Model model) throws Exception {

		model.addAttribute("list", productService.getListFoodCategory());

		return "/product/insertProduct";
	}

	@PostMapping("insertProduct")
	@Transactional
	public String insertProduct(Product product, Foodcategory f, Model model, String partsNo, String partsName,MultipartFile thumbnailFile)
			throws Exception {
		product.setFoodCategory(f);
		
		System.out.println(thumbnailFile);
		if(thumbnailFile != null) {
			String thumbnailName = UUID.randomUUID().toString()+"_"+thumbnailFile.getOriginalFilename();
			
			File newFileName = new File(path,thumbnailName);
			thumbnailFile.transferTo(newFileName);
			product.setThumbnail(thumbnailName);
		}
		
		productService.insertProduct(product);

		List<Parts> list = new ArrayList<Parts>();
		if(partsNo != null) {
			String[] no = partsNo.split(",");
			String[] name = partsName.split(",");

			for (int i = 0; i < no.length; i++) {
				Parts parts = new Parts();
				parts.setPartsNo(new Integer(no[i]));
				parts.setName(name[i]);
				parts.setProductNo(product.getProductNo());
				System.out.println(parts);
				list.add(parts);
			}		
			System.out.println(list);
			int r = productService.insertProductParts(list);
			
			if (r == no.length) {
				System.out.println("성공");
			}
		}		

		System.out.println("상품 : " + product);
		return "redirect:/product/admin/listProduct";
	}

	@GetMapping("getProduct/{prodNo}")
	public String getProduct(@PathVariable(required = false) String currentPage, @PathVariable int prodNo, Search search, Model model, HttpServletRequest request) throws Exception {
		Product product = productService.getProduct(prodNo);
		List<Parts> list = productService.getProductParts(product.getProductNo());
		product.setParts(list);
		
		String referer = request.getServletPath();
		String[] refererA = referer.split("/");
		model.addAttribute("url",refererA[1]+"/"+refererA[2]+"/"+refererA[3]);

		if (currentPage != null) {
			search.setCurrentPage(new Integer(currentPage));
		}
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(20);
		System.out.println(search);
		
		search.setSearchSort(prodNo);

		Map<String, Object> map = productService.getListReview(search);
		List<Review> list0 = (List) map.get("list");
		List<Review> listr = new ArrayList();

		for (Review review : list0) {
			listr.add(review);
		}

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);

		model.addAttribute("review", listr);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("product", product);
		return "/product/getProduct";
	}
	@GetMapping(value = { "/listProduct/{currentPage}/{searchCondition}", "/listProduct/{currentPage}","/listProduct" })
	public String getListProductAsUser(Model model, Search search, @PathVariable(required = false) String currentPage,
			@PathVariable(required = false) String searchCondition, HttpSession session) throws Exception {

		if (currentPage != null) {
			search.setCurrentPage(new Integer(currentPage));
		}
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setSearchCondition(searchCondition);
		System.out.println(search);
  
		Map<String, Object> map = productService.getListProduct(search);
		List<Product> list = (List) map.get("list");
		
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


		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);

		model.addAttribute("list", list);
		model.addAttribute("page", resultPage);
		model.addAttribute("search", search);
		System.out.println(search);
		return "/product/listProductAsUser";
	}
	
	
	
	@GetMapping(value = { "/admin/listProduct/{currentPage}/{searchCondition}", "/admin/listProduct/{currentPage}", "/admin/listProduct" })
	public String getListProductAsAdmin(Model model, Search search, @PathVariable(required = false) String currentPage,
			@PathVariable(required = false) String searchCondition, HttpSession session) throws Exception {
		if(session.getAttribute(currentPage) != null) {
			session.removeAttribute(currentPage);
		}
	
		if (currentPage != null) {
			search.setCurrentPage(new Integer(currentPage));
		}
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setSearchCondition(searchCondition);
		System.out.println(search);
		
		session.setAttribute("currentPage", currentPage);
  
		Map<String, Object> map = productService.getListProductAsAdmin(search);
		List<Product> list = (List) map.get("list");


		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);

		model.addAttribute("list", list);
		model.addAttribute("page", resultPage);
		model.addAttribute("search", search);

		return "/product/listProductAsAdmin";
	}
	

	@GetMapping(value = { "updateProduct/{productNo}" })
	public String updateProduct(@PathVariable int productNo, Model model) throws Exception {
		model.addAttribute("product", productService.getProduct(productNo));
		model.addAttribute("list", productService.getListFoodCategory());
		System.out.println("GET : updateProduct");
		System.out.println(model.getAttribute("product"));
		return "/product/updateProduct";
	}

	@PostMapping(value = { "updateProduct/{productNo}" })
	public String updateProduct(@PathVariable int productNo, Product product, Foodcategory f, Model model, String partsNo, String partsName,MultipartFile thumbnailFile) throws Exception {
		product.setProductNo(productNo);
		product.setFoodCategory(f);

		System.out.println("thumbnailFile : "+thumbnailFile.getOriginalFilename());
		if(thumbnailFile != null && !thumbnailFile.getOriginalFilename().equals("")) {
			String thumbnailName = UUID.randomUUID().toString()+"_"+thumbnailFile.getOriginalFilename();
			
			File newFileName = new File(path,thumbnailName);
			thumbnailFile.transferTo(newFileName);
			product.setThumbnail(thumbnailName);
		}

		productService.updateProduct(product);
		
		return "redirect:/product/admin/listProduct/1";
	}	
	@GetMapping(value = {"deleteProduct/{productNo}"})
	public String deleteProduct(@PathVariable int productNo, HttpSession session) throws Exception {
		productService.deleteProduct(productNo);
		String currentPage = (String) session.getAttribute("currentPage");
		session.removeAttribute(currentPage);
		return "redirect:/product/admin/listProduct/"+currentPage;
	}
	
	@GetMapping(value = {"restoreProduct/{productNo}"})
	public String restoreProduct(@PathVariable int productNo, HttpSession session) throws Exception {
		productService.restoreProduct(productNo);
		String currentPage = (String) session.getAttribute("currentPage");
		session.removeAttribute(currentPage);
		return "redirect:/product/admin/listProduct/"+currentPage;
	}
	
	
	
	
	
	
	
	/* < PARTS > */
		
	@PostMapping(value = {"insertParts"})
	public String insertParts(Parts parts, HttpSession session) throws Exception {
		productService.insertParts(parts);
		String currentPage = (String) session.getAttribute("currentPage");
		return "redirect:/product/listParts/"+currentPage+"/0";
	}
	
	@GetMapping(value = {"listParts/{currentPage}/{searchCondition}", "listParts"})
	public String getListParts(Model model, Search search, @PathVariable(required = false) String currentPage,
				@PathVariable(required = false) String searchCondition, HttpSession session) throws Exception {

		if(session.getAttribute(currentPage) != null) {
			session.removeAttribute(currentPage);
		}
	
		if (currentPage != null) {
			search.setCurrentPage(new Integer(currentPage));
		}
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setSearchCondition(searchCondition);
		System.out.println(search);

		session.setAttribute("currentPage", currentPage);

		Map<String, Object> map = productService.getListParts(search);
		List<Parts> list = (List) map.get("list");
		List<Parts> listr = new ArrayList();

		for (Parts parts : list) {
			listr.add(parts);
		}

		Page resultPage = new Page
				(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);

		model.addAttribute("list", listr);
		model.addAttribute("page", resultPage);
		model.addAttribute("search", search);

		return "/product/listParts";
	}
	
	@PostMapping(value = {"updateParts"})
	public String updateParts(Parts parts, HttpSession session) throws Exception {
		productService.updateParts(parts);
		String currentPage = (String) session.getAttribute("currentPage");
		session.removeAttribute(currentPage);
		return "redirect:/product/listParts/"+currentPage+"/0";
	}
		
	@GetMapping(value = {"deleteParts/{partsNo}"})
	public String deleteParts(@PathVariable int partsNo, HttpSession session) throws Exception { 
		productService.deleteParts(partsNo);
		String currentPage = (String) session.getAttribute("currentPage");
		session.removeAttribute(currentPage);
		return "redirect:/product/listParts/"+currentPage+"/0";
	}
	@GetMapping(value = {"restoreParts/{partsNo}"})
	public String restoreParts(@PathVariable int partsNo, HttpSession session) throws Exception { 
		productService.restoreParts(partsNo);
		String currentPage = (String) session.getAttribute("currentPage");
		session.removeAttribute(currentPage);
		return "redirect:/product/listParts/"+currentPage+"/1";
	}
	
	
	
	
	
	
	/* < REVIEW > */

	@GetMapping(value = { "insertReview/{productNo}" })
	public String insertReview(@PathVariable int productNo, HttpSession session, Model model) throws Exception {
		model.addAttribute("user", session.getAttribute("user"));
		model.addAttribute("product", (Product) productService.getProduct(productNo));
		return "/product/insertReview";
	}

	@PostMapping(value = { "insertReview/{productNo}" })
	public String insertReview(@PathVariable int productNo, HttpSession session, Review review) throws Exception {
		review.setUser((User) session.getAttribute("user"));
		review.setProduct((Product)productService.getProduct(productNo));
		
		productService.insertReview(review);
		
		return "redirect:/product/getProduct/"+productNo;
	}
	
	@GetMapping(value= {"listReview/{currentPage}/{searchCondition}","listReview/{currentPage}", "listReview"})
	public String getListReviewAsAdmin(HttpSession session, @PathVariable(required = false) String currentPage, @PathVariable(required = false) String searchCondition, Search search, Model model) throws Exception {
		
		if(session.getAttribute(currentPage) != null) {
			session.removeAttribute(currentPage);
		}
		
		if (currentPage != null) {
			search.setCurrentPage(new Integer(currentPage));
		}
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setSearchCondition(searchCondition);
		System.out.println(search);
		
		session.setAttribute("currentPage", currentPage);
		  
		Map<String, Object> map =  productService.getListReviewAsAdmin(search);
		List<Review> list = (List) map.get("list");
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		
		model.addAttribute("review", list);
		model.addAttribute("page", resultPage);
		model.addAttribute("search", search);
	
		return "/product/listReview";
	}
	
	@PostMapping(value= {"updateReview/{productNo}"})
	public String updateReview(@PathVariable int productNo, Review review, HttpSession session) throws Exception {
		review.setProduct(productService.getProduct(productNo));
		review.setStatus("0");
		System.out.println(review);
		productService.updateReview(review);
		return "redirect:/product/getProduct/"+productNo;
	}
	
	@GetMapping(value= {"deleteReview/{reviewNo}"})
	public String deleteReview(@PathVariable int reviewNo, HttpSession session) throws Exception {
		productService.deleteReview(reviewNo);
		String currentPage = (String) session.getAttribute("currentPage");
		session.removeAttribute(currentPage);
		return "redirect: /product/listReview/"+currentPage;
	}
	
	@GetMapping(value= {"restoreReview/{reviewNo}"})
	public String restoreReview(@PathVariable int reviewNo, HttpSession session) throws Exception {
		productService.restoreReview(reviewNo);
		String currentPage = (String) session.getAttribute("currentPage");
		session.removeAttribute(currentPage);
		return "redirect:/product/listReview/"+currentPage;
	}

	
	
	
	
	/* FOODCATEGORY */
	
	@PostMapping(value = {"insertFoodCategory"})
	public String insertFoodCategory(String name) throws Exception {
		productService.insertFoodCategory(name);
		
		return "redirect:/product/listFoodCategory";
	}
	
	@GetMapping(value = {"listFoodCategory/{status}", "listFoodCategory"})
	public String getListFoodCategory(@PathVariable(required=false) String status, Model model) throws Exception {
			if(status == null) {
				status = "0";
			}
			
			List<Foodcategory> list = productService.getAdminFoodCategory(status);

			model.addAttribute("list", list);

			return "/product/listFoodCategory";
	}
	
	@GetMapping(value= {"deleteFoodCategory/{foodCategoryNo}"})
	public String deleteFoodCategory(@PathVariable int foodCategoryNo) throws Exception {
		productService.deleteFoodCategory(foodCategoryNo);
		return "redirect:/product/listFoodCategory";
	}
	@GetMapping(value= {"restoreFoodCategory/{foodCategoryNo}"})
	public String restoreFoodCategory(@PathVariable int foodCategoryNo) throws Exception {
		productService.restoreFoodCategory(foodCategoryNo);
		return "redirect:/product/listFoodCategory";
	}
	
	
	
	
	/* 상품 좋아요 리스트 */
	@GetMapping(value= {"listLikeProduct/{currentPage}", "listLikeProduct"})
	public String getListLikeProduct(HttpSession session, Search search, @PathVariable(required=false) String currentPage, Model model ) throws Exception {
		if(session.getAttribute(currentPage) != null) {
			session.removeAttribute(currentPage);
		}
	
		if (currentPage != null) {
			search.setCurrentPage(new Integer(currentPage));
		}
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		System.out.println(search);
		
		session.setAttribute("currentPage", currentPage);
		
		User user = (User) session.getAttribute("user");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userId", user.getUserId());
		map.put("search", search);

		Map<String, Object> result = productService.getListLikeProduct(map);
		List<Product> product = (List) result.get("list");

		Page resultPage = new Page
				(search.getCurrentPage(), ((Integer) result.get("totalCount")).intValue(), pageUnit, pageSize);

		model.addAttribute("like", product);
		model.addAttribute("page", resultPage);
		model.addAttribute("search", search);

		return "/product/listLikeProduct";
	}
}