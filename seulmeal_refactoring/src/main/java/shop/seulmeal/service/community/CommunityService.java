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
   public Map<String,Object> getListPost(Search search, String userId);
   public Map<String,Object> getListPostA(Search search, String userId, List<Relation> blockList);//test
   public int updatePost(Post post);
   public int deletePost(int postNo);
   
   //Comment
   public int insertComment(Comment comment);
   public Comment getComment(int commentNo);
   public Map<String,Object> getListcomment(Search search, int postNo);
   //public int updateComment(Comment comment);
   public int deleteComment(int commentNo);
    
   //Report
   public int insertReportPost(Report report);
   public Map<String,Object> getListReportPost(Search search);
   public int deleteReportPost(int postNo);

   //Like
   public int insertLike(Like like);
   //public int deleteLike(Like like);
   public Post getLikePost(int postNo);
   
   //Relation
   public Map<String,Object> insertFollow(Relation relation);
   public Map<String,Object> getListFollow(Search search, String userId, String relationStatus);
   public Map<String,Object> getListFollower(Search search, String relationUserId);
   public Map<String,Object> deleteFollow(Relation relation);
   public int updateRelation(Relation relation);//follow->block
   public List<Relation> getAllRelation(String userId);
   
   public int insertBlock(Relation relation);
   public Map<String,Object> getListBlock(Search search, String userId, String relationStatus);
   public int deleteBlock(Relation relation);
   
   
   public int postViewsUp(int postNo);
   
   // 신고체크
   public int checkReport(Report report);
   public String checkRelation(Relation relation);
   public List<Like> checkLikePost(String userId);
}