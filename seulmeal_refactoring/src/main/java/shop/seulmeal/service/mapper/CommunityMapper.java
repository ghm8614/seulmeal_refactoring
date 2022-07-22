package shop.seulmeal.service.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import shop.seulmeal.common.Search;
import shop.seulmeal.service.domain.Comment;
import shop.seulmeal.service.domain.Like;
import shop.seulmeal.service.domain.Post;
import shop.seulmeal.service.domain.Relation;
import shop.seulmeal.service.domain.Report;

@Mapper
public interface CommunityMapper {
   
   //Post
   public int insertPost(Post post);
   public Post getPost(int postNo);
   public Post getPostAdmin(int postNo);
   public List<Post> getListPost(Map<String,Object> map);
   public int getPostTotalCount(Map<String,Object> map);
   public int updatePost(Post post);
   public int deletePost(int postNo);
   public int postViewsUp(int postNo);
   public void postCommentCountUp(int postNo);
   public void postCommentCountDown(int postNo);
   
   //Comment
   public int insertComment(Comment comment);
   public Comment getComment(int commentNo);
   public List<Comment> getListComment(Map<String,Object> map);
   public int getCommentTotalCount(int postNo);
   public int deleteComment(int commentNo);
   
   //Report
   public int insertReportPost(Report report);
   public List<Report> getListReportPost(Search search);
   public int getReportTotalCount();
   public int deleteReportPost(int postNo);
   public int checkReport(Report report);
   
   //Like
   public int insertLike(Like like);
   public int deleteLike(Like like);
   public Like checkLike(Like like);
   public List<Like> checkLikePost(String userId);
   public int postLikeCountUp(Integer postNo);
   public int postLikeCountDown(Integer postNo);
   
   //Relation 
   public int insertRelation(Relation relation);
   public List<Relation> getListRelation(Map<String,Object> map);
   public List<Relation> getListRelation(Relation relation);
   public List<String> getListFollower(Map<String,Object> map);
   public int getFollowerTotalCount(Map<String,Object> map);
   public int getRelationTotalCount(Map<String,Object> map);
   public int updateRelation(Relation relation); //follow->block
   public int deleteRelation(Relation relation);
   public Relation getRelation(Relation relation);
   public List<Relation> getAllRelation(String userId);
   public String checkRelation(Relation relation);

}