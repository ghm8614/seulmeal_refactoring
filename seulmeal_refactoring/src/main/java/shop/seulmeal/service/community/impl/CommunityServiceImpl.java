package shop.seulmeal.service.community.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import shop.seulmeal.common.Search;
import shop.seulmeal.service.community.CommunityService;
import shop.seulmeal.service.domain.Comment;
import shop.seulmeal.service.domain.Like;
import shop.seulmeal.service.domain.Post;
import shop.seulmeal.service.domain.Relation;
import shop.seulmeal.service.domain.Report;
import shop.seulmeal.service.mapper.CommunityMapper;

@Service("communityServiceImpl")
public class CommunityServiceImpl implements CommunityService {

   @Autowired
   private CommunityMapper communityMapper;

   // C
   public CommunityServiceImpl() {
      System.out.println(this.getClass());
   }

   // M

   // Post
   @Override
   public int insertPost(Post post) {
      return communityMapper.insertPost(post);
   }

   @Override
   public Post getPost(int postNo) {
      return communityMapper.getPost(postNo);
   }

   @Override
   public Map<String, Object> getListPost(Search search, String userId) {
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("search", search);
      map.put("userId", userId);

      map.put("postList", communityMapper.getListPost(map));
      map.put("postTotalCount", communityMapper.getPostTotalCount(map));

      return map;
   }

   @Override
   public Map<String, Object> getListPostA(Search search, String userId, List<Relation> blockList) {

      Map<String, Object> map = new HashMap<String, Object>();
      
      map.put("search", search);
      map.put("userId", userId);
      map.put("blockList", blockList);
      
      map.put("postList", communityMapper.getListPostA(map));
      map.put("postTotalCount", communityMapper.getPostTotalCountA(map));
      
      return map;
   }
   

   @Override
   public int updatePost(Post post) {
      return communityMapper.updatePost(post);
   }

   @Override
   public int deletePost(int postNo) {
      return communityMapper.deletePost(postNo);
   }

   // Comment
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

   /*
   @Override
   public int updateComment(Comment comment) {
      return communityMapper.updateComment(comment);
   }*/


   // Report
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

   // Like
   @Override
   public int insertLike(Like like) {
      
      // userId가 like 눌렀는지 체크
      Like dbLike = communityMapper.checkLike(like);
      
      // 좋아요
      if(dbLike == null) {
         
         communityMapper.postLikeCountUp(like.getPostNo());
         communityMapper.insertLike(like);
         return 1;
         
      } else { // 좋아요 취소
      
         System.out.println("///////이미 좋아요 눌렀음, 좋아요 취소");
         communityMapper.postLikeCountDown(dbLike.getPostNo());
         communityMapper.deleteLike(dbLike);
         return -1;
      }
   }
/*
   @Override
   public int deleteLike(Like like) {
      
      // userId가 like 눌렀는지 체크
      Like dbLike = communityMapper.checkLike(like);

      // 이미 눌렀을 때,  실행 x
      if(dbLike == null) {
         System.out.println("///////좋아요 누르지 않았음, delete 실패");
         return -1;
      }
      
      communityMapper.postLikeCountDown(like.getPostNo());
      return communityMapper.deleteLike(like);
   }
*/
   @Override
   public Post getLikePost(int postNo) {
      return communityMapper.getPost(postNo);
   }

   // Relation
   @Override
   public Map<String,Object> insertFollow(Relation relation) {
      
      Relation dbRelation = communityMapper.getRelation(relation);
      
      if(dbRelation == null){
         communityMapper.insertRelation(relation);
      }
      
      Map<String,Object> map = new HashMap<>();
      map.put("userId", relation.getUserId());
      map.put("relationUserId", relation.getRelationUser().getUserId());
      map.put("relationStatus", relation.getRelationStatus());
      
      // 내 팔로우 개수 -1
      int userFollowCnt = communityMapper.getRelationTotalCount(map);
      // 상대 팔로워 개수 -1
      int relationUserFollowerCnt = communityMapper.getFollowerTotalCount(map);
      
      System.out.println("userFC:"+userFollowCnt);
      System.out.println("relationUserFC:"+relationUserFollowerCnt);
      
      Map<String,Object> resultMap = new HashMap<>();
      resultMap.put("userFollowCnt", userFollowCnt);
      resultMap.put("relationUserFollowerCnt", relationUserFollowerCnt);
      
      return resultMap;
   }
   
   @Override
   public Map<String,Object> deleteFollow(Relation relation) {   //o
      System.out.println("relation: "+ relation);
      
      Relation dbRelation = communityMapper.getRelation(relation);
      
      if(dbRelation != null & dbRelation.getRelationStatus().equals("0")){
         System.out.println("db 존재 o, delete follow!");
         communityMapper.deleteRelation(dbRelation);
      }
      
      Map<String,Object> map = new HashMap<>();
      map.put("userId", relation.getUserId());
      map.put("relationUserId", relation.getRelationUser().getUserId());
      map.put("relationStatus", relation.getRelationStatus());
      
      // 내 팔로우 개수 -1
      int userFollowCnt = communityMapper.getRelationTotalCount(map);
      // 상대 팔로워 개수 -1
      int relationUserFollowerCnt = communityMapper.getFollowerTotalCount(map);
      
      System.out.println("userFC:"+userFollowCnt);
      System.out.println("relationUserFC:"+relationUserFollowerCnt);
      
      Map<String,Object> resultMap = new HashMap<>();
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
      Map<String, Object> map = new HashMap<String,    Object>();
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
   public int insertBlock(Relation relation) {

      Relation dbRelation = communityMapper.getRelation(relation);
      
      if (dbRelation != null) {
         if(dbRelation.getRelationStatus().equals("0")) {// userId가 relationUserId를 친추한 경우, 
            communityMapper.updateRelation(dbRelation);
            System.out.println("//////db에 이미 follow 존재, 데이터 상태 변경");
            return 1;
         }else if(dbRelation.getRelationStatus().equals("1")) {// userId가 relationUserId를 이미 블락한 경우
            System.out.println("//////db에 이미 block 존재, 데이터 삽입 x");
            return -1;
         }
      }

      System.out.println("/////db 존재 x, insert block!");
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
   public int deleteBlock(Relation relation) {   //o
      
      Relation dbRelation = communityMapper.getRelation(relation);
      
      return (dbRelation != null & dbRelation.getRelationStatus().equals("1")) ? communityMapper.deleteRelation(dbRelation):-1;
   }

   @Override
   public int postViewsUp(int postNo) {
      return communityMapper.postViewsUp(postNo);
   }

   @Override
   public List<Relation> getAllRelation(String userId) {
      return communityMapper.getAllRelation(userId);
   }

   // 신고체크
   @Override
   public int checkReport(Report report) {
      // TODO Auto-generated method stub
      return communityMapper.checkReport(report);
   }

   @Override
   public String checkRelation(Relation relation) {
      // TODO Auto-generated method stub
      return communityMapper.checkRelation(relation);
   }

   @Override
   public List<Like> checkLikePost(String userId) {
      // TODO Auto-generated method stub
      return communityMapper.checkLikePost(userId);
   }

@Override
public Post getPostAdmin(int postNo) {
	// TODO Auto-generated method stub
	return communityMapper.getPostAdmin(postNo);
}
   
   

}