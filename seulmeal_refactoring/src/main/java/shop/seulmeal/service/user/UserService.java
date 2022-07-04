package shop.seulmeal.service.user;

import java.util.List;
import java.util.Map;

import shop.seulmeal.common.Search;
import shop.seulmeal.service.domain.BlackList;
import shop.seulmeal.service.domain.Parts;
import shop.seulmeal.service.domain.Point;
import shop.seulmeal.service.domain.Relation;
import shop.seulmeal.service.domain.User;

public interface UserService {

	public int insertUser(User user) throws Exception;
	
	public int insertHatesParts(Map<String, Object> map) throws Exception;
	
	public User getUser(String userId) throws Exception;
	
	public List<Parts> getUserHatesParts(String userId) throws Exception;
	
	public int updateUser(User user) throws Exception;
	
	public int deleteUser(String userId) throws Exception;
	
	public Map<String, Object> getListUser(Search search) throws Exception;
	
	public List<Relation> getListBlackList() throws Exception;
	
	public int confirmUserId(String userId) throws Exception; 
	
	public User confirmUserPhone(String phone) throws Exception;
	
	public User confirmUserEmail(String email) throws Exception;
	
	public int confirmCode(String code) throws Exception;
	
	public int confirmUserNickname(String nickname) throws Exception;
	
	public int confirmCaptcha(String captcha) throws Exception;
	
	public int kakaoLogin() throws Exception;
	
	public int naverLogin() throws Exception;
	
	public int insertPoint(Point point) throws Exception;
	
	public Point getPoint(int pointNo) throws Exception;
	
	public Map<String, Object> getListPoint(Search search, String userId) throws Exception;
	
	public User getProfile(String userId) throws Exception;
	
	public int updateProfile(User user) throws Exception;
	
	public int updateBlockCount(String userId) throws Exception;
	
	public void updateBlackList() throws Exception;
	
	public void updateGrade() throws Exception;
	
	public int updatePassword(User user) throws Exception;
	
	public int updateUserTotalPoint(User user) throws Exception;
	
	public String getRecentPurchase(String userId) throws Exception;
	
	public int deletePoint(int purchaseNo) throws Exception;

	
}
