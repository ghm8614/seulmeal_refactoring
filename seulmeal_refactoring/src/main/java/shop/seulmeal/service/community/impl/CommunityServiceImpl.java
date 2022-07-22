package shop.seulmeal.service.community.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;
import shop.seulmeal.common.Search;
import shop.seulmeal.service.community.CommunityService;
import shop.seulmeal.service.domain.Comment;
import shop.seulmeal.service.domain.Like;
import shop.seulmeal.service.domain.Post;
import shop.seulmeal.service.domain.Relation;
import shop.seulmeal.service.domain.Report;
import shop.seulmeal.service.mapper.CommunityMapper;

@Service("communityServiceImpl")
@RequiredArgsConstructor
public class CommunityServiceImpl implements CommunityService {

	private final CommunityMapper communityMapper;

	@Override
	public int insertPost(Post post) {
		return communityMapper.insertPost(post);
	}

	@Override
	public Post getPost(int postNo) {
		return communityMapper.getPost(postNo);
	}
	
	@Override
	public Post getPostAdmin(int postNo) {
		return communityMapper.getPostAdmin(postNo);
	}

	@Override
	public Map<String, Object> getListPost(Search search, @RequestParam(required = false) String loginUserId,
			String userId) {

		Map<String, Object> relationMap = new HashMap<String, Object>();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		Map<String, Object> resultMap = new HashMap<String, Object>();

		if (loginUserId != null) {
			relationMap.put("userId", loginUserId);
			relationMap.put("relationStatus", "1");
			paramMap.put("blockList", communityMapper.getListRelation(relationMap));
		}
		paramMap.put("search", search);
		paramMap.put("userId", userId);

		List<Post> postList = communityMapper.getListPost(paramMap);
		resultMap.put("postList", postList);
		resultMap.put("postTotalCount", communityMapper.getPostTotalCount(paramMap));

		// 로그인 유저가 좋아요 누른 게시글 상태값 변경
		if (loginUserId != null) {
			List<Like> likeList = communityMapper.checkLikePost(loginUserId);
			for (Post post : postList) {
				if (likeList != null) {
					for (Like like : likeList) {
						if (like != null && post.getPostNo() == like.getPostNo()) {
							post.setLikeStatus("1");
						}
					}
				}
			}
		}
		return resultMap;
	}

	@Override
	public int updatePost(Post post) {
		return communityMapper.updatePost(post);
	}

	@Override
	public int deletePost(int postNo) {
		return communityMapper.deletePost(postNo);
	}
	
	@Override
	public int postViewsUp(int postNo) {
		return communityMapper.postViewsUp(postNo);
	}

	@Override
	public int insertComment(Comment comment) {
		communityMapper.postCommentCountUp(comment.getPostNo());
		return communityMapper.insertComment(comment);
	}

	@Override
	public Comment getComment(int commentNo) {
		return communityMapper.getComment(commentNo);
	}

	@Override
	public Map<String, Object> getListcomment(Search search, int postNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("postNo", postNo);

		map.put("commentList", communityMapper.getListComment(map));
		map.put("commentTotalCount", communityMapper.getCommentTotalCount(postNo));

		return map;
	}

	@Override
	public int deleteComment(int commentNo) {
		Comment comment = communityMapper.getComment(commentNo);
		communityMapper.postCommentCountDown(comment.getPostNo());
		return communityMapper.deleteComment(commentNo);
	}

	@Override
	public int insertReportPost(Report report) {
		return communityMapper.insertReportPost(report);
	}

	@Override
	public Map<String, Object> getListReportPost(Search search) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reportList", communityMapper.getListReportPost(search));
		map.put("reportTotalCount", communityMapper.getReportTotalCount());

		return map;
	}

	@Override
	public int deleteReportPost(int postNo) {
		communityMapper.deletePost(postNo);
		return communityMapper.deleteReportPost(postNo);
	}
	
	@Override
	public int checkReport(Report report) {
		return communityMapper.checkReport(report);
	}

	@Override
	public int insertLike(Like like) {
		// userId가 like 눌렀는지 체크
		Like dbLike = communityMapper.checkLike(like);

		// 좋아요
		if (dbLike == null) {
			communityMapper.postLikeCountUp(like.getPostNo());
			communityMapper.insertLike(like);
			return 1;

		} else { // 좋아요 취소
			communityMapper.postLikeCountDown(dbLike.getPostNo());
			communityMapper.deleteLike(dbLike);
			return -1;
		}
	}

	@Override
	public Post getLikePost(int postNo) {
		return communityMapper.getPost(postNo);
	}
	
	@Override
	public List<Like> checkLikePost(String userId) {
		return communityMapper.checkLikePost(userId);
	}

	@Override
	public Map<String, Object> insertFollow(Relation relation) {
		Relation dbRelation = communityMapper.getRelation(relation);

		if (dbRelation == null) {
			communityMapper.insertRelation(relation);
		}

		Map<String, Object> map = new HashMap<>();
		map.put("userId", relation.getUserId());
		map.put("relationUserId", relation.getRelationUser().getUserId());
		map.put("relationStatus", relation.getRelationStatus());

		// 내 팔로우 수 +1
		int userFollowCnt = communityMapper.getRelationTotalCount(map);
		// 상대 팔로워 수 +1
		int relationUserFollowerCnt = communityMapper.getFollowerTotalCount(map);

		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("userFollowCnt", userFollowCnt);
		resultMap.put("relationUserFollowerCnt", relationUserFollowerCnt);

		return resultMap;
	}

	@Override
	public Map<String, Object> deleteFollow(Relation relation) { 
		Relation dbRelation = communityMapper.getRelation(relation);

		if (dbRelation != null & dbRelation.getRelationStatus().equals("0")) {
			communityMapper.deleteRelation(dbRelation);
		}

		Map<String, Object> map = new HashMap<>();
		map.put("userId", relation.getUserId());
		map.put("relationUserId", relation.getRelationUser().getUserId());
		map.put("relationStatus", relation.getRelationStatus());

		// 내 팔로우 수 -1
		int userFollowCnt = communityMapper.getRelationTotalCount(map);
		// 상대 팔로워 수 -1
		int relationUserFollowerCnt = communityMapper.getFollowerTotalCount(map);

		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("userFollowCnt", userFollowCnt);
		resultMap.put("relationUserFollowerCnt", relationUserFollowerCnt);

		return resultMap;
	}

	@Override
	public Map<String, Object> getListFollow(Search search, String userId, String relationStatus) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("userId", userId);
		map.put("relationStatus", relationStatus);

		map.put("followList", communityMapper.getListRelation(map));
		map.put("followTotalCount", communityMapper.getRelationTotalCount(map));

		return map;
	}

	@Override
	public Map<String, Object> getListFollower(Search search, String relationUserId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("relationUserId", relationUserId);

		map.put("followerList", communityMapper.getListFollower(map));
		map.put("followerTotalCount", communityMapper.getFollowerTotalCount(map));

		return map;
	}

	@Override
	public int updateRelation(Relation relation) {
		return communityMapper.updateRelation(relation);
	}

	@Override
	public List<Relation> getAllRelation(String userId) {
		return communityMapper.getAllRelation(userId);
	}
	
	@Override
	public int insertBlock(Relation relation) {

		Relation dbRelation = communityMapper.getRelation(relation);

		if (dbRelation != null) {
			if (dbRelation.getRelationStatus().equals("0")) {// userId가 relationUserId를 친추한 경우,
				communityMapper.updateRelation(dbRelation);
				return 1;
			} else if (dbRelation.getRelationStatus().equals("1")) {// userId가 relationUserId를 이미 블락한 경우
				return -1;
			}
		}

		return communityMapper.insertRelation(relation);
	}

	@Override
	public Map<String, Object> getListBlock(Search search, String userId, String relationStatus) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("userId", userId);
		map.put("relationStatus", relationStatus);
		
		map.put("blockList", communityMapper.getListRelation(map));
		map.put("blockTotalCount", communityMapper.getRelationTotalCount(map));
		
		return map;
	}
	
	@Override
	public int deleteBlock(Relation relation) {
		Relation dbRelation = communityMapper.getRelation(relation);

		return (dbRelation != null & dbRelation.getRelationStatus().equals("1"))
				? communityMapper.deleteRelation(dbRelation)
				: -1;
	}

	@Override
	public String checkRelation(Relation relation) {
		return communityMapper.checkRelation(relation);
	}
}