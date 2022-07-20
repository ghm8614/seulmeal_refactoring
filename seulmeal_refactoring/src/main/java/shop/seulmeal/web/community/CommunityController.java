package shop.seulmeal.web.community;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import shop.seulmeal.common.Page;
import shop.seulmeal.common.Search;
import shop.seulmeal.service.attachments.AttachmentsService;
import shop.seulmeal.service.community.CommunityService;
import shop.seulmeal.service.domain.Attachments;
import shop.seulmeal.service.domain.Comment;
import shop.seulmeal.service.domain.Like;
import shop.seulmeal.service.domain.Post;
import shop.seulmeal.service.domain.Relation;
import shop.seulmeal.service.domain.Report;
import shop.seulmeal.service.domain.User;
import shop.seulmeal.service.product.ProductService;
import shop.seulmeal.service.user.UserService;

@Controller
@RequestMapping("/api/v1/community")
@RequiredArgsConstructor
public class CommunityController {

	private final CommunityService communityService;
	private final UserService userService;
	private final ProductService productService;
	private final AttachmentsService attachmentsService;
	
	@Value("${pageUnit}")
	private int pageUnit;

	@Value("${pageSize}")
	private int pageSize;

	@GetMapping("/")
	public String communityMain(@RequestParam(required = false) String searchKeyword,
			@RequestParam(required = false) String searchCondition, Model model, HttpSession session) throws Exception {

		// 비회원 게시판 사용불가
		User loginUser = (User) session.getAttribute("user");

		if (loginUser == null) {
			return "user/login";
		}

		// 검색조건
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(pageSize);
		search.setSearchKeyword(searchKeyword);
		search.setSearchCondition(searchCondition);

		// 차단유저 게시글 제외한 전체 게시글
		Map<String, Object> postMap = communityService.getListPost(search, loginUser.getUserId(), null);
		List<Post> postList = (List<Post>) postMap.get("postList");

		// 게시글 무한스크롤 (maxPage 필요)
		Page resultPage = new Page(1, (int) postMap.get("postTotalCount"), pageUnit, pageSize);

		// 게시글 번호에 해당하는 이미지 파일
		Map<String, Object> attachMap = new HashMap<>();
		for (Post post : postList) {
			attachMap.put("postNo", post.getPostNo());
			post.setAttachments(attachmentsService.getAttachments(attachMap));
			
			if (post.getAttachments().isEmpty()) {
				if (post.getContent().length() > 200) {
					post.setShortContent(post.getContent().substring(0, 201));
				} else {
					post.setShortContent(post.getContent());
				}
			} else {
				if (post.getContent().length() > 50) {
					post.setShortContent(post.getContent().substring(0, 51));
				} else {
					post.setShortContent(post.getContent());
				}
			}
		}

		Map<String, Object> followMap = communityService.getListFollow(null, loginUser.getUserId(), "0");
		Map<String, Object> followerMap = communityService.getListFollower(null, loginUser.getUserId());
		Map<String, Object> blockMap = communityService.getListBlock(null, loginUser.getUserId(), "1");

		// model
		model.addAttribute("postList", postList);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("followMap", followMap);
		model.addAttribute("followerMap", followerMap);
		model.addAttribute("blockMap", blockMap);
		model.addAttribute("search", search);

		return "community/communityMain";
	}

	@GetMapping("/post")
	public String insertPost() {
		return "community/insertCommunityPost";
	}

	@PostMapping("/post")
	public String insertPost(@ModelAttribute Post post, MultipartFile[] uploadfile, Attachments attachments,
			HttpSession session) throws IllegalStateException, IOException {

		User loginUser = (User) session.getAttribute("user");
		post.setUser(loginUser);
		communityService.insertPost(post);

		// 첨부파일 유효성 체크
		if (uploadfile.length > 0) {
			attachments.setPostNo(Integer.toString(post.getPostNo()));
			attachmentsService.insertAttachments(uploadfile, attachments);
		}

		return "redirect:/api/v1/community/posts/" + post.getPostNo();
	}

	@GetMapping("/posts/{postNo}")
	public String getPost(@PathVariable int postNo, Model model, HttpSession session) {

		User loginUser = (User)session.getAttribute("user");
		Post post = communityService.getPost(postNo);

		// 타인 게시글 조회시에만, 조회수 증가
		if (!(loginUser.getUserId().equals(post.getUser().getUserId()))) {
			communityService.postViewsUp(postNo);
		}

		// 해당 post의 첨부파일
		Map<String, Object> attachMap = new HashMap<>();
		attachMap.put("postNo", postNo);
		List<Attachments> attachmentList = attachmentsService.getAttachments(attachMap);

		// 댓글 (무한스크롤, maxPage 필요)
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(pageSize);
		Map<String, Object> map = communityService.getListcomment(search, postNo);
		Page resultPage = new Page(1, (int) map.get("commentTotalCount"), pageUnit, pageSize);

		// model
		model.addAttribute("post", post);
		model.addAttribute("attachmentList", attachmentList);
		model.addAttribute("commentList", (List<Comment>) map.get("commentList"));
		model.addAttribute("resultPage", resultPage);

		return "community/getCommunityPost";
	}

	@GetMapping("/posts/update/{postNo}") // o
	public String updatePost(@PathVariable int postNo, Model model) {

		// post 가져오기
		Post post = communityService.getPost(postNo);

		// 첨부파일 가져오기
		Map<String, Object> map = new HashMap<>();
		map.put("postNo", postNo);

		// post 도메인에 첨부파일 넣기
		post.setAttachments(attachmentsService.getAttachments(map));

		// model
		model.addAttribute("post", post);

		return "community/updateCommunityPost";
	}

	@PutMapping("/posts/{postNo}")
	public String updatePost(@ModelAttribute Post post, @PathVariable int postNo, MultipartFile[] uploadfile,
			Attachments attachments, String deleteAttachmentNo, String deleteAttachmentName)
			throws IllegalStateException, IOException {

		// db와 폴더 첨부파일 삭제
		attachmentsService.deleteAttachments(deleteAttachmentNo, deleteAttachmentName);

		// 새로 추가한 첨부파일 등록, 유효성 체크
		if (uploadfile != null) {
			attachments.setPostNo(Integer.toString(postNo));
			attachmentsService.insertAttachments(uploadfile, attachments);
		}

		// post 업데이트
		communityService.updatePost(post);

		return "redirect:/api/v1/community/posts/" + postNo;
	}

	@DeleteMapping("/posts/{postNo}")
	public String deletePost(@PathVariable int postNo) {

		communityService.deletePost(postNo);

		return "redirect:/api/v1/community/";
	}

	@GetMapping("/post/reports/{postNo}")
	public String getPostAdmin(@PathVariable int postNo, Model model, HttpSession session) {

		// 해당 post
		Post post = communityService.getPostAdmin(postNo);

		// 타인 게시글 조회시에만, 조회수 증가
		if (!((User) session.getAttribute("user")).getUserId().equals(post.getUser().getUserId())) {
			communityService.postViewsUp(postNo);
		}

		// 해당 post의 첨부파일
		Map<String, Object> map02 = new HashMap<>();
		map02.put("postNo", postNo);
		List<Attachments> attachmentList = attachmentsService.getAttachments(map02);

		// 댓글 목록 (무한스크롤 -> maxPage 필요)
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(pageSize);
		Map<String, Object> map = communityService.getListcomment(search, postNo);
		Page resultPage = new Page(1, (int) map.get("commentTotalCount"), pageUnit, pageSize);
		System.out.println("///" + map.get("commentTotalCount"));
		System.out.println("///" + resultPage);

		// model
		model.addAttribute("post", post);
		model.addAttribute("attachmentList", attachmentList);
		model.addAttribute("commentList", (List<Comment>) map.get("commentList"));
		model.addAttribute("resultPage", resultPage);

		System.out.println("////////" + attachmentList);
		return "community/getCommunityPost";
	}

	@GetMapping("/posts/reports/{currentPage}") // o
	public String getListReportPost(@PathVariable(value = "currentPage", required = false) Integer currentPage,
			Model model) {

		System.out.println("type : " + currentPage.getClass().getTypeName());
		System.out.println("값 : " + currentPage);

		Search search = new Search();
		if (currentPage == 0) {
			currentPage = 1;
		}
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		System.out.println("////////" + search);

		Map<String, Object> map = communityService.getListReportPost(search);
		Page resultPage = new Page(search.getCurrentPage(), (int) map.get("reportTotalCount"), pageUnit, pageSize);
		System.out.println("////////" + resultPage);

		model.addAttribute("reportList", (List<Report>) map.get("reportList"));
		model.addAttribute("resultPage", resultPage);
		// search 필요x

		return "/community/listCommunityReportPost";
	}

	@GetMapping("/profiles/{userId}")
	public String getProfile(@PathVariable String userId, Model model, HttpSession session, Relation relation)
			throws Exception {

		User loginUser = (User) session.getAttribute("user");
		User profileUser = userService.getProfile(userId);

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(pageSize);

		// 본인 프로필 (default)
		boolean isMine = true;
		String relationStatus = null;
		Map<String, Object> postMap = null;

		// 타인 프로필
		if (!(loginUser.getUserId().equals(userId))) {
			
			isMine = false;
			User relationUser = new User();
			relation.setUserId(loginUser.getUserId());
			relationUser.setUserId(userId);
			relation.setRelationUser(relationUser);
			relationStatus = communityService.checkRelation(relation);

			postMap = communityService.getListPost(search, null, userId);
		} else {
			postMap = communityService.getListPost(search, loginUser.getUserId(), loginUser.getUserId());
		}

		// 게시글 무한스크롤 (maxPage 필요)
		Page resultPage = new Page(1, (int) postMap.get("postTotalCount"), pageUnit, pageSize);

		// 게시글 번호에 해당하는 이미지 파일
		List<Post> postList = (List<Post>) postMap.get("postList");
		Map<String, Object> attachMap = new HashMap<>();

		for (Post post : postList) {
			attachMap.put("postNo", post.getPostNo());
			post.setAttachments(attachmentsService.getAttachments(attachMap));

			if (post.getAttachments().isEmpty()) {
				if (post.getContent().length() > 200) {
					post.setShortContent(post.getContent().substring(0, 201));
				} else {
					post.setShortContent(post.getContent());
				}
			} else {
				if (post.getContent().length() > 50) {
					post.setShortContent(post.getContent().substring(0, 51));
				} else {
					post.setShortContent(post.getContent());
				}
			}
		}
		
		// 팔로우, 팔로워, 차단 목록
		Map<String, Object> followMap = communityService.getListFollow(null, userId, "0");
		Map<String, Object> followerMap = communityService.getListFollower(null, userId);
		Map<String, Object> blockMap = communityService.getListBlock(null, userId, "1");

		// model
		model.addAttribute("isMine", isMine);
		model.addAttribute("relationStatus", relationStatus);
		model.addAttribute("profileUser", profileUser);
		model.addAttribute("postList", postList);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("followMap", followMap);
		model.addAttribute("followerMap", followerMap);
		model.addAttribute("blockMap", blockMap);

		return "/community/getCommunityProfile";
	}

	@GetMapping("/profile") // oo
	public String updateProfile(HttpSession session, Model model) throws Exception {

		model.addAttribute("foodcategoryList", productService.getListFoodCategory());
		return "/community/updateCommunityProfile";
	}

	@PutMapping("/profile") // oo
	public String updateProfile(MultipartFile imageFile, @ModelAttribute User user, String[] foodcategory,
			HttpSession session, Model model) throws Exception {

		// 프로필 사진
		String imageFilePath = null;
		String path = System.getProperty("user.dir") + "/src/main/webapp/resources/attachments/profile_image";
		// String path =
		// "/home/tomcat/apache-tomcat-9.0.64/webapps/seulmeal/resources/attachments/profile_image";
		File file = new File(path);

		if (!file.exists()) {
			file.mkdirs();
		}

		if (imageFile.isEmpty()) {
			user.setProfileImage("default_profile.jpg");
		} else {
			String contentType = imageFile.getContentType();
			String originalFileExtension = null;

			if (contentType.contains("image/jpeg")) {
				originalFileExtension = ".jpg";
			} else if (contentType.contains("image/png")) {
				originalFileExtension = ".png";
			} else if (contentType.contains("image/jpg")) {
				originalFileExtension = ".jpg";
			}

			imageFilePath = path + "/" + user.getUserId() + "_profile" + originalFileExtension;
			String imageFileName = user.getUserId() + "_profile" + originalFileExtension;

			// 이미지 파일 로컬에 저장
			file = new File(imageFilePath);
			imageFile.transferTo(file);

			// 저장한 이미지 파일을 user에 저장
			user.setProfileImage(imageFileName);
		}

		// 선호 음식 카테고리
		if (foodcategory != null && foodcategory.length > 0) {
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
		}

		User loginUser = (User) session.getAttribute("user");
		user.setBlackListStatus(loginUser.getBlackListStatus());
		userService.updateProfile(user);
		session.setAttribute("user", user);

		return "redirect:/api/v1/community/profiles/" + user.getUserId();
	}

}