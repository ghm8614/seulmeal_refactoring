package shop.seulmeal.web.community;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import shop.seulmeal.common.Search;
import shop.seulmeal.service.attachments.AttachmentsService;
import shop.seulmeal.service.community.CommunityService;
import shop.seulmeal.service.domain.Comment;
import shop.seulmeal.service.domain.Like;
import shop.seulmeal.service.domain.Post;
import shop.seulmeal.service.domain.Relation;
import shop.seulmeal.service.domain.Report;
import shop.seulmeal.service.domain.User;

@RestController
@RequestMapping("/api/v1/community")
@RequiredArgsConstructor
public class CommunityRestController {

	private final CommunityService communityService;
	private final AttachmentsService attachmentsService;

	@Value("${pageUnit}")
	private int pageUnit;

	@Value("${pageSize}")
	private int pageSize;

	@GetMapping("/posts")
	public List<Post> getListPost(@RequestParam(required = false, defaultValue = "2") int currentPage,
			@RequestParam(required = false) String searchKeyword, @RequestParam(required = false) String searchOption,
			@RequestParam(required = false) String searchCondition, @RequestParam(required = false) String userId,
			HttpSession session) {

		User loginUser = (User) session.getAttribute("user");
		
		// 검색조건
		Search search = new Search();
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		search.setSearchKeyword(searchKeyword);
		search.setSearchCondition(searchOption);
		search.setSearchCondition(searchCondition);

		// 차단유저 게시글 제외한 전체 게시글
		Map<String, Object> postMap = communityService.getListPost(search, loginUser.getUserId(), null);
		List<Post> postList = (List<Post>) postMap.get("postList");
		
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
		return postList;
	}

	@GetMapping("/comments/{postNo}")
	public List<Comment> getListComment(@RequestParam(required = false, defaultValue = "2") int currentPage,
			@PathVariable int postNo) {

		Search search = new Search();
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);

		Map<String, Object> map = communityService.getListcomment(search, postNo);

		return (List<Comment>) map.get("commentList");
	}

	@PostMapping("/comments")
	public Comment insertComment(@RequestBody Comment comment, HttpSession session) {

		User loginUser = (User) session.getAttribute("user");
		comment.setUser(loginUser);

		communityService.insertComment(comment);
		Comment dbComment = communityService.getComment(comment.getCommentNo());

		return dbComment;
	}

	@DeleteMapping("/comments/{commentNo}")
	public void deleteComment(@PathVariable int commentNo) {
		communityService.deleteComment(commentNo);
	}

	@PostMapping("/likes/{postNo}")
	public Map<String, Integer> insertLike(@PathVariable int postNo, HttpSession session) {

		Like like = new Like();
		like.setUserId(((User) session.getAttribute("user")).getUserId());
		like.setPostNo(postNo);

		Map<String, Integer> map = new HashMap<>();
		int result = communityService.insertLike(like);
		Post post = communityService.getLikePost(postNo);

		if (result == 1) {
			map.put("좋아요", post.getLikeCount());
		} else {
			map.put("좋아요 취소", post.getLikeCount());
		}
		return map;
	}

	@PostMapping("/follow/{relationUserId}")
	public Map<String, Object> insertFollow(@PathVariable String relationUserId, HttpSession session) {

		Relation relation = new Relation();
		relation.setRelationStatus("0");
		relation.setUserId(((User) session.getAttribute("user")).getUserId());

		User relationUser = new User();
		relationUser.setUserId(relationUserId);
		relation.setRelationUser(relationUser);

		Map<String, Object> resultMap = communityService.insertFollow(relation);

		// 1.userFollowCnt
		// 2.relationUserFollowerCnt
		return resultMap;
	}

	@DeleteMapping("/follow/{relationUserId}")
	public Map<String, Object> deleteFollow(@PathVariable String relationUserId, HttpSession session) {

		System.out.println("relationUserId: " + relationUserId);

		Relation relation = new Relation();
		relation.setRelationStatus("0");
		relation.setUserId(((User) session.getAttribute("user")).getUserId());

		User relationUser = new User();
		relationUser.setUserId(relationUserId);
		relation.setRelationUser(relationUser);

		Map<String, Object> resultMap = communityService.deleteFollow(relation);

		// 1.userFollowCnt
		// 2.relationUserFollowerCnt
		return resultMap;
	}

	@GetMapping("/followings")
	public List<Relation> getListFollow(@RequestParam(required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchKeyword, HttpSession session) {

		Search search = new Search();

		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		search.setSearchKeyword(searchKeyword);

		String userId = ((User) session.getAttribute("user")).getUserId();
		Map<String, Object> map = communityService.getListFollow(null, userId, "0");// 검색없는 전체목록

		return (List<Relation>) map.get("followList");
	}

	@GetMapping("/followers")
	public List<Relation> getListFollower(@RequestParam(required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchKeyword, HttpSession session) {

		Search search = new Search();

		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		search.setSearchKeyword(searchKeyword);

		String relationUserId = ((User) session.getAttribute("user")).getUserId();
		Map<String, Object> map = communityService.getListFollower(search, relationUserId);

		return (List<Relation>) map.get("followerList");
	}

	@PostMapping("/block/{relationUserId}")
	public int insertBlock(@PathVariable String relationUserId, HttpSession session) throws Exception {

		Relation relation = new Relation();
		relation.setRelationStatus("1");
		relation.setUserId(((User) session.getAttribute("user")).getUserId());

		User user = new User();
		user.setUserId(relationUserId);
		relation.setRelationUser(user);

		int result = communityService.insertBlock(relation);
		System.out.println("/////////" + result);

		return result;
	}

	@DeleteMapping("/block/{relationUserId}")
	public int deleteBlock(@PathVariable String relationUserId, HttpSession session) {

		Relation relation = new Relation();
		relation.setRelationStatus("1");
		relation.setUserId(((User) session.getAttribute("user")).getUserId());

		User user = new User();
		user.setUserId(relationUserId);
		relation.setRelationUser(user);

		int result = communityService.deleteBlock(relation);
		System.out.println("/////////" + result);

		return result;
	}

	@GetMapping("/blocks")
	public List<Relation> getListBlock(@RequestParam(required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchKeyword, HttpSession session) {

		Search search = new Search();

		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		search.setSearchKeyword(searchKeyword);

		String userId = ((User) session.getAttribute("user")).getUserId();
		Map<String, Object> map = communityService.getListBlock(search, userId, "1");

		return (List<Relation>) map.get("blockList");
	}

	// 프로필 이미지 삭제
	@DeleteMapping("/profileImage")
	public String deleteProfileImage(HttpSession session) throws Exception {

		return "/resources/attachments/profile_image/default_profile.jpg";
	}

	@PostMapping("/posts/reports") // o
	public ResponseEntity<Report> insertReportPost(@RequestBody Report report, @AuthenticationPrincipal User user) {
		// JSONObject json = new JSONObject();
		System.out.println("//////: " + report);
		report.setReporterId(user.getUserId());
		communityService.insertReportPost(report);

		return new ResponseEntity<Report>(report, HttpStatus.OK);
	}

	@GetMapping("/posts/reports/check/{postNo}")
	public ResponseEntity<JSONObject> checkReport(@PathVariable String postNo, @AuthenticationPrincipal User user,
			Report report) {
		JSONObject json = new JSONObject();

		report.setPostNo(new Integer(postNo));
		report.setReporterId(user.getUserId());
		int r = communityService.checkReport(report);
		json.put("count", r);
		if (r != 0) {
			return new ResponseEntity<JSONObject>(json, HttpStatus.NO_CONTENT);
		}

		return new ResponseEntity<JSONObject>(json, HttpStatus.OK);
	}

	@DeleteMapping("/posts/reports/{postNo}")
	public ResponseEntity<Integer> deleteReportPost(@PathVariable String postNo) {

		int r = communityService.deleteReportPost(new Integer(postNo));
		if (r != 0) {
			return new ResponseEntity<Integer>(r, HttpStatus.NO_CONTENT);
		}

		return new ResponseEntity<Integer>(r, HttpStatus.OK);
	}
}
