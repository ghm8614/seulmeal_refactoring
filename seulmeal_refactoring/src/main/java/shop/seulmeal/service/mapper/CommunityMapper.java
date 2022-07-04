package shop.seulmeal.service.mapper;

import java.util.List;
import java.util.Map;
import java.util.function.IntPredicate;

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
   public int postViewsUp(int postNo);
   public int updatePost(Post post);
   public int deletePost(int postNo);
   
   public List<Post> getListPost(Map<String,Object> map);//Search(검색+정렬) + userId(myPost)
   public List<Post> getListPostA(Map<String,Object> map);//Search(검색+정렬) + userId(myPost)
   public int getPostTotalCount(Map<String,Object> map);//
   public int getPostTotalCountA(Map<String,Object> map);

   
   //Comment
   public int insertComment(Comment comment);
   public Comment getComment(int commentNo);
   public int updateComment(Comment comment);
   public int deleteComment(int commentNo);// Comment comment?
   
   public List<Comment> getListComment(Map<String,Object> map);
   public int getCommentTotalCount(int postNo);//검색옵션 필요 x -> map X
   public void postCommentCountUp(int postNo);
   public void postCommentCountDown(int postNo);
   
   //Report
   public int insertReportPost(Report report);
   public int deleteReportPost(int postNo);
   
   public List<Report> getListReportPost(Search search);
   public int getReportTotalCount();
   
   //Like
   public Like checkLike(Like like);
   public List<Like> checkLikePost(String userId);
   public int insertLike(Like like);
   public int deleteLike(Like like);
   public int postLikeCountUp(Integer postNo);
   public int postLikeCountDown(Integer postNo);
   
   //Relation 
   public int insertRelation(Relation relation);
   public List<Relation> getListRelation(Map<String,Object> map);//userId, search, relationStatus
   public List<Relation> getListRelation(Relation relation);//추가
   public int getRelationTotalCount(Map<String,Object> map);
   public int updateRelation(Relation relation);//follow->block
   public int deleteRelation(Relation relation);
   public Relation getRelation(Relation relation);
   public List<Relation> getAllRelation(String userId);
   
   public List<String> getListFollower(Map<String,Object> map);//
   public int getFollowerTotalCount(Map<String,Object> map);//

   
   //TestCode
   public int deletePostAll();
   public void deleteReportPostAll();
   public void deleteRelationAll();
   
   // 신고 체크
   public int checkReport(Report report);
   public String checkRelation(Relation relation);
}