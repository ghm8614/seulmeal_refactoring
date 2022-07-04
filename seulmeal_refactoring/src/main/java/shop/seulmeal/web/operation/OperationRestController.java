package shop.seulmeal.web.operation;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import shop.seulmeal.service.attachments.AttachmentsService;
import shop.seulmeal.service.confirm.ConfirmService;
import shop.seulmeal.service.domain.Attachments;
import shop.seulmeal.service.domain.Comment;
import shop.seulmeal.service.domain.Post;
import shop.seulmeal.service.domain.Product;
import shop.seulmeal.service.domain.User;
import shop.seulmeal.service.operation.OperationService;
import shop.seulmeal.service.product.ProductService;

@RestController
@RequestMapping("operation/api/*")
public class OperationRestController {
	
	@Autowired
	@Qualifier("operationServiceImpl")
	private OperationService operationService;
	
	@Autowired
	private AttachmentsService attachmentsService;
	
	@Autowired
	private ConfirmService confirmService;
	
	@PostMapping("deleteOperation")
	public ResponseEntity<JSONObject> deleteOperation(@RequestBody Post post) {
		JSONObject json = new JSONObject();
		System.out.println(post);
		HttpHeaders headers = new HttpHeaders();
		int r = operationService.deleteOperation(post);
		json.put("result", r);
		
		return new ResponseEntity<JSONObject>(json, headers, HttpStatus.OK);
	}
	
	@PostMapping(value ="insertAnswer", consumes = {"multipart/form-data"})
	@Transactional(rollbackFor = Exception.class)
	public Comment insertAnswer(@RequestParam(value="uploadfile", required = false) MultipartFile[] uploadfile,
								@RequestParam(value="content") String content, HttpSession session,
								@RequestParam(value="postNo") int postNo, Comment comment, Attachments attachments) throws IllegalStateException, IOException {
		
		System.out.println(uploadfile.length);
		User user = (User)session.getAttribute("user");
		comment.setUser(user);
		comment.setPostNo(postNo);
		comment.setContent(content);
		System.out.println(comment);
		operationService.insertAnswer(comment);
		// 현재 날짜 구하기
		LocalDate now = LocalDate.now();
		// 포맷 정의 
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		System.out.println("formatter : "+formatter);
		// 포맷 적용
		String formatedNow = now.format(formatter);
		comment.setRegDate(Date.valueOf(formatedNow));
		
		if(uploadfile != null) {
			attachments.setCommentNo(Integer.toString(comment.getCommentNo()));			
			attachmentsService.insertAttachments(uploadfile, attachments);
			
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("commentNo", comment.getCommentNo());
			List<Attachments> list =attachmentsService.getAttachments(map);
			comment.setAttachments(list);
		}		

		return comment;
	}
	
	@PostMapping("deletetAnswer")
	public int deleteAnswer(@RequestBody JSONObject data, Comment comment) {
		comment.setCommentNo((Integer)data.get("commentNo"));
		
		int r = operationService.deleteAnswer(comment);		
		
		return r;
	}
	
	@PostMapping("autocomplete")
	public Map<String, Object> autocomplete(@RequestParam Map<String, Object> paramMap) throws Exception {
		//Product product = productService.getProductName(productName);
		System.out.println(paramMap);
		paramMap.put("resultList",operationService.getProductName(paramMap));
		
		return paramMap;
	}
	
	@GetMapping("getProduct/{productName}")
	public Product getProduct(@PathVariable String productName) {
		Product product = operationService.getProduct(productName);
		return product;
	}
	
	@PostMapping("confirmQueryPassword")
	public JSONObject confirmQueryPassword(@RequestBody Post post ) {
		JSONObject json = new JSONObject(); 
		
		Post sPost = operationService.getOperation(post);
		System.out.println(sPost);
		System.out.println(post);
		if(sPost !=null && sPost.getPassword().equals(post.getPassword())) {
			json.put("result","true");
		} else {
			json.put("result","false");
		}
		
		return json;
	}
	
	/// 이벤트 상품 제거
	@PostMapping("delectEventProduct")
	public JSONObject delectEventProduct(@RequestBody Map<String,Object> map) {
		JSONObject json = new JSONObject();
		List<String> list = new ArrayList<String>();
		list.add(Integer.toString((Integer)map.get("productNo")));
		int r = operationService.updateDiscountProductC(list);
		
		if(r==0) {
			json.put("result","false");
		} else {
			json.put("result","true");
		}
		
		return json;
	}
	
	@PostMapping("confirm")
	public JSONObject confirmUser(@RequestBody User user, HttpSession session) {
		System.out.println("유저 : "+user);
		int num = confirmService.confirmNum();
		String message = "인증번호는 ["+num+"] 입니다";
		if(user.getEmail() != null) {
			confirmService.sendMail(message, user.getEmail());
			session.setAttribute(user.getEmail(), message);
		} else if(user.getPhone() != null) {
			confirmService.sendSMS(user.getPhone(), message);
			session.setAttribute(user.getPhone(), message);
		}
		
		JSONObject json = new JSONObject();
		json.put("result", "sucess");
		return json;
	}
	
	@PostMapping("jsonTest")	
	public JSONObject testRequestBody(@RequestBody JSONObject test) {
		System.out.println("======================Test Start=============================");
		System.out.println("JSON============="+test+"=============");
		System.out.println("CommentNo============="+test.get("commentNo")+"=============");
		System.out.println("testNo============="+test.get("testNo")+"=============");
		System.out.println("ok============="+test.get("ok")+"=============");
		System.out.println("======================Test End=============================");
		return test;
	}
}
