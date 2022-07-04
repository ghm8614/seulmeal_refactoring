package shop.seulmeal.web.community;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import shop.seulmeal.common.Search;
import shop.seulmeal.service.attachments.AttachmentsService;
import shop.seulmeal.service.community.CommunityService;
import shop.seulmeal.service.domain.Comment;
import shop.seulmeal.service.domain.Like;
import shop.seulmeal.service.domain.Post;
import shop.seulmeal.service.domain.Relation;
import shop.seulmeal.service.domain.Report;
import shop.seulmeal.service.domain.User;
import shop.seulmeal.service.user.UserService;

@RestController
@RequestMapping("/community/api/*")
public class CommunityRestController {

	@Autowired
	private CommunityService communityService;
	
	@Autowired
	private AttachmentsService attachmentsService;
	
	int pageUnit = 5;
	int pageSize = 5;

	public CommunityRestController() {
		System.out.println(this.getClass());
	}
	
	// 무한스크롤
	@GetMapping("getListPost") // oo
	public List<Post> getListPost(@RequestParam(required = false, defaultValue = "2") int currentPage,
			@RequestParam(required = false) String searchKeyword, @RequestParam(required = false) String searchOption ,
			@RequestParam(required = false) String searchCondition, @RequestParam(required = false) String userId, HttpSession session) {
		
		System.out.println("RestC : CurrentP : "+ currentPage);
		
		Search search = new Search();
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		search.setSearchKeyword(searchKeyword);
		search.setSearchCondition(searchOption);
		search.setSearchCondition(searchCondition);

		
		User loginUser = (User)session.getAttribute("user");

		List<Relation> relationList = communityService.getAllRelation(loginUser.getUserId());
		List<Relation> blockList = new ArrayList<>();
		
		for (Relation block : relationList) {	
			if(block.getRelationStatus().equals("1")) {
				blockList.add(block);
			}
		}
		
		// 메인 게시글 : userId = null (searchKeyword, searchOption 존재)
		// 내 프로필 게시글 : userId = session (searchKeyword, searchOption 존재x)
		// 타 프로필 게시글 : userId  (위와 동일)
		Map<String, Object> map = communityService.getListPostA(search, userId, blockList);
		//map.put("search", search);
		
		// 좋아요 여부 체크
		List<Like> likeList =  communityService.checkLikePost(loginUser.getUserId());

		
		List<Post> postList = (List<Post>)map.get("postList");
		
		Map<String, Object> attachMap = new HashMap<>();
				
		for(Post post : postList) {
			attachMap.put("postNo", post.getPostNo());
			post.setAttachments(attachmentsService.getAttachments(attachMap));
			
			if(likeList != null) {
				// 좋아요 게시글 상태값 변경
				for(Like like: likeList) {
					
					if(like!=null &&post.getPostNo() == like.getPostNo()) {
						post.setLikeStatus("1");
					}
				}
			}
			
			if(post.getAttachments().isEmpty()) {
				
				if(post.getContent().length() > 200) {
					post.setShortContent(post.getContent().substring(0, 201));					
				}else {
					post.setShortContent(post.getContent());
				}
			}else {
				
				if(post.getContent().length() > 50) {
					post.setShortContent(post.getContent().substring(0, 51));					
				}else {
					post.setShortContent(post.getContent());
				}
			}
		}
		System.out.println("/////aaaaa"+postList);
		return postList;
	}

	// 댓글 무한스크롤
	@GetMapping("getListComment/{postNo}") // oo
	public List<Comment> getListComment(@RequestParam(required = false, defaultValue = "2") int currentPage,
			@PathVariable int postNo) {

		Search search = new Search();
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);

		Map<String, Object> map = communityService.getListcomment(search, postNo);
		
		return (List<Comment>)map.get("commentList");
	}
	
	//Comment
	@PostMapping("/insertComment") // oo
	public Comment insertComment(@RequestBody Comment comment, HttpSession session) {

		User user = (User)session.getAttribute("user");
		comment.setUser(user);
	
		communityService.insertComment(comment);
		Comment dbComment = communityService.getComment(comment.getCommentNo());
		
		return dbComment; 

	}

	@PostMapping("/deleteComment/{commentNo}") // ^o
	public void deleteComment(@PathVariable int commentNo) {
		communityService.deleteComment(commentNo);
	}
	
	/*
	@GetMapping("/updateComment/{commentNo}") // oo
	public Comment updateComment(@PathVariable int commentNo) {
		
		return communityService.getComment(commentNo); 
	}*/
	/*
	@PatchMapping("/updateComment/{commentNo}") // o^
	public Comment updateComment(@PathVariable int commentNo, @RequestBody Comment comment) {
		
		comment.setCommentNo(commentNo);
		communityService.updateComment(comment);
		
		return communityService.getComment(commentNo); 
	}*/
	
	

	@PostMapping("insertLike/{postNo}") // oo
	public Map<String,Integer> insertLike(@PathVariable String postNo, HttpSession session) {

		Like like = new Like();
		like.setPostNo(Integer.parseInt(postNo));
		//like.setUserId(userId);
		like.setUserId(((User)session.getAttribute("user")).getUserId());

		Map<String,Integer> map = new HashMap<>();
		int result = communityService.insertLike(like);
		Post post = communityService.getLikePost(Integer.parseInt(postNo));
		
		
		if(result == 1) {
			map.put("좋아요", post.getLikeCount());
			return map;
		}else{
			map.put("좋아요 취소", post.getLikeCount());
			return map;			
		}
	}
/*
	@PostMapping("deleteLike/{postNo}") // oo
	public Post deleteLike(@PathVariable String postNo, HttpSession session) {

		Like like = new Like();

		like.setPostNo(Integer.parseInt(postNo));
		like.setUserId(((User)session.getAttribute("user")).getUserId());

		// 좋아요 취소
		communityService.deleteLike(like);

		// 좋아요 취소한 게시글 좋아요 수 return
		Post post = communityService.getLikePost(Integer.parseInt(postNo));

		System.out.println("/////////" + post);
		
		return post;
	}
*/
	@PostMapping("insertFollow/{relationUserId}") // o
	public Map<String,Object> insertFollow(@PathVariable String relationUserId, HttpSession session) {

		Relation relation = new Relation();
		relation.setRelationStatus("0");
		relation.setUserId(((User)session.getAttribute("user")).getUserId());

		User relationUser = new User();
		relationUser.setUserId(relationUserId);
		relation.setRelationUser(relationUser);
		
		Map<String,Object> resultMap = communityService.insertFollow(relation);
		
		// 1.userFollowCnt
		// 2.relationUserFollowerCnt
		return resultMap;
	}
	
	@PostMapping("deleteFollow/{relationUserId}") // o
	public Map<String,Object> deleteFollow(@PathVariable String relationUserId, HttpSession session) {

		System.out.println("relationUserId: "+ relationUserId);
		
		Relation relation = new Relation();
		relation.setRelationStatus("0");
		relation.setUserId(((User)session.getAttribute("user")).getUserId());
		
		User relationUser = new User();
		relationUser.setUserId(relationUserId);
		relation.setRelationUser(relationUser);

		Map<String,Object> resultMap = communityService.deleteFollow(relation);
			
		// 1.userFollowCnt
		// 2.relationUserFollowerCnt
		return resultMap;
	}

	@GetMapping("getListFollow") // oo
	public List<Relation> getListFollow(@RequestParam(required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchKeyword, HttpSession session) {

		Search search = new Search();

		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		search.setSearchKeyword(searchKeyword);

		String userId = ((User)session.getAttribute("user")).getUserId();
		Map<String, Object> map = communityService.getListFollow(null, userId, "0");//검색없는 	전체목록

		return (List<Relation>) map.get("followList");
	}

	@GetMapping("getListFollower") // oo
	public List<Relation> getListFollower(@RequestParam(required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchKeyword,HttpSession session) {

		Search search = new Search();

		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		search.setSearchKeyword(searchKeyword);

		String relationUserId = ((User)session.getAttribute("user")).getUserId();
		Map<String, Object> map = communityService.getListFollower(search, relationUserId);

		return (List<Relation>) map.get("followerList");
	}

	@PostMapping("insertBlock/{relationUserId}") // oo
	public int insertBlock(@PathVariable String relationUserId, HttpSession session) throws Exception {

		Relation relation = new Relation();
		relation.setRelationStatus("1");
		relation.setUserId(((User) session.getAttribute("user")).getUserId());

		User user = new User();
		user.setUserId(relationUserId);
		relation.setRelationUser(user);

		int result = communityService.insertBlock(relation);
		System.out.println("/////////"+result);
		
		return result;
	}

	@PostMapping("deleteBlock/{relationUserId}")
	public int deleteBlock(@PathVariable String relationUserId, HttpSession session) {

		Relation relation = new Relation();
		relation.setRelationStatus("1");
		relation.setUserId(((User) session.getAttribute("user")).getUserId());
		
		User user = new User();
		user.setUserId(relationUserId);
		relation.setRelationUser(user);
		
		int result = communityService.deleteBlock(relation);
		System.out.println("/////////"+result);
		
		return result;
	}
	
	
	@GetMapping("getListBlock") // oo
	public List<Relation> getListBlock(@RequestParam(required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchKeyword, HttpSession session) {

		Search search = new Search();

		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		search.setSearchKeyword(searchKeyword);

		String userId = ((User)session.getAttribute("user")).getUserId();
		Map<String, Object> map = communityService.getListBlock(search, userId, "1");

		return (List<Relation>) map.get("blockList");
	}

	// 프로필 이미지 삭제		// oo
	@PostMapping("deleteProfileImage")
	public String deleteProfileImage(HttpSession session) throws Exception {

		return "/resources/attachments/profile_image/default_profile.jpg";
	}
	
	@PostMapping("insertReportPost") // o
	public ResponseEntity<Report> insertReportPost(@RequestBody Report report, @AuthenticationPrincipal User user) {
		//JSONObject json = new JSONObject();
		System.out.println("//////: "+ report);
		report.setReporterId(user.getUserId());
		communityService.insertReportPost(report);
		
		return new ResponseEntity<Report>(report, HttpStatus.OK);
	}
	
	@GetMapping("checkReport/{postNo}")
	public ResponseEntity<JSONObject> checkReport(@PathVariable String postNo, @AuthenticationPrincipal User user, Report report){
		JSONObject json = new JSONObject();
		
		report.setPostNo(new Integer(postNo));
		report.setReporterId(user.getUserId());
		int r = communityService.checkReport(report);
		json.put("count", r);
		if(r != 0) {
			return new ResponseEntity<JSONObject>(json, HttpStatus.NO_CONTENT);
		}
		
		return new ResponseEntity<JSONObject>(json, HttpStatus.OK);
	}
	
	@GetMapping("deleteReportPost/{postNo}")
	public ResponseEntity<Integer> deleteReportPost(@PathVariable String postNo) {

		int r = communityService.deleteReportPost(new Integer(postNo));
		if(r != 0) {
			return new ResponseEntity<Integer>(r, HttpStatus.NO_CONTENT);
		}
		
		return new ResponseEntity<Integer>(r, HttpStatus.OK);
	}
}
