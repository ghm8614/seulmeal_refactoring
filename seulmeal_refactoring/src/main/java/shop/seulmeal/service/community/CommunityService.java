package shop.seulmeal.service.community;

import java.util.List;
import java.util.Map;

import shop.seulmeal.common.Search;
import shop.seulmeal.service.domain.Comment;
import shop.seulmeal.service.domain.Like;
import shop.seulmeal.service.domain.Post;
import shop.seulmeal.service.domain.Relation;
import shop.seulmeal.service.domain.Report;

public interface CommunityService {
   
   //Post
   public int insertPost(Post post);
   public Post getPost(int postNo);
   public Post getPostAdmin(int postNo);
   public Map<String,Object> getListPost(Search search, String loginUserId, String userId);
   public int updatePost(Post post);
   public int deletePost(int postNo);
   public int postViewsUp(int postNo);
   
   //Comment
   public int insertComment(Comment comment);
   public Comment getComment(int commentNo);
   public Map<String,Object> getListcomment(Search search, int postNo);
   public int deleteComment(int commentNo);
    
   //Report
   public int insertReportPost(Report report);
   public Map<String,Object> getListReportPost(Search search);
   public int deleteReportPost(int postNo);
   public int checkReport(Report report);

   //Like
   public int insertLike(Like like);
   public Post getLikePost(int postNo);
   public List<Like> checkLikePost(String userId);
   
   //Relation
   public Map<String,Object> insertFollow(Relation relation);
   public Map<String,Object> getListFollow(Search search, String userId, String relationStatus);
   public Map<String,Object> getListFollower(Search search, String relationUserId);
   public Map<String,Object> deleteFollow(Relation relation);
   public int updateRelation(Relation relation); //follow->block
   public List<Relation> getAllRelation(String userId);
   
   public int insertBlock(Relation relation);
   public Map<String,Object> getListBlock(Search search, String userId, String relationStatus);
   public int deleteBlock(Relation relation);
   public String checkRelation(Relation relation);
}