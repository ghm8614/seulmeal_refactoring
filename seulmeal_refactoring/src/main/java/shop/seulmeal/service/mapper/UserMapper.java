
package shop.seulmeal.service.mapper;


import java.util.List;
import java.util.Map;



import org.apache.ibatis.annotations.Mapper;

import shop.seulmeal.common.Search;
import shop.seulmeal.service.domain.Parts;
import shop.seulmeal.service.domain.Point;
import shop.seulmeal.service.domain.Relation;
import shop.seulmeal.service.domain.User;

@Mapper
public interface UserMapper {

	public int insertUser(User user) throws Exception;

	public int insertHatesParts(Map<String, Object> map) throws Exception;
	
	public int insertHatesParts(Parts parts, String userId) throws Exception;
	
	public User getUser(String userId) throws Exception;
	
	public List<Parts> getUserHatesParts(String userId) throws Exception;
	
	public int updateUser(User user) throws Exception;
	
	public int deleteUser(String userId) throws Exception;
	
	public List<User> getListUser(Search search) throws Exception;
	
	public List<Relation> getListBlackList() throws Exception;

	public int getListBlackListTotalCount() throws Exception;
	
	public int getListUserTotalCount(Search search) throws Exception;
	
	public int checkDuplicationUserId(String userId) throws Exception;
	
	public int checkDuplicationNickName(String nickName) throws Exception;
		
	public User checkDuplicationPhone(String phone) throws Exception;
	
	public User checkDuplicationEmail(String email) throws Exception;
	
	public int updateUserGrade() throws Exception;
	
	public int resetPurchaseCount() throws Exception;
	
	public int updateUserTotalPoint(User user) throws Exception;
	
	public int insertBlackList() throws Exception;
	
	public int resetBlockCount() throws Exception;
	
	public int updateBlackList() throws Exception;
		
	//public List<BlackList> getListBlackList(Search search) throws Exception;
	
	public int insertPoint(Point point) throws Exception;
	
	public Point getPoint(int pointNo) throws Exception;
	
	//public Point getPoint(Point point) throws Exception;
	
	public List<Point> getListPoint(Map<String, Object> map) throws Exception;
	
	public int getListPointTotalCount(Map<String, Object> map) throws Exception;
	
	public User getProfile(String userId) throws Exception;

	public int updateProfile(User user) throws Exception;
	
	public int updateBlockCount(String userId) throws Exception;
	
	public int updatePassword(User user) throws Exception;
	
	public String getRecentPurchase(String userId) throws Exception;
	
	public int deletePoint(int purchaseNo) throws Exception;
	
	
	
	
	
	
	
}
