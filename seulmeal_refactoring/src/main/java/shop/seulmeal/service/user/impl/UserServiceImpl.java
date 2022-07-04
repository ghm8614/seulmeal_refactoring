package shop.seulmeal.service.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import shop.seulmeal.common.Search;
import shop.seulmeal.service.domain.Parts;
import shop.seulmeal.service.domain.Point;
import shop.seulmeal.service.domain.Relation;
import shop.seulmeal.service.domain.User;
import shop.seulmeal.service.mapper.UserMapper;
import shop.seulmeal.service.user.UserService;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService, UserDetailsService{
	
	@Autowired
	private UserMapper userMapper;

	@Override
	public int insertUser(User user) throws Exception {
		// TODO Auto-generated method stub
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		
		return userMapper.insertUser(user);
	}
	

	@Override
	public int insertHatesParts(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.insertHatesParts(map);
	}
	
	@Override
	public User getUser(String userId) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.getUser(userId);
	}
	
	@Override
	public List<Parts> getUserHatesParts(String userId) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.getUserHatesParts(userId);
	}


	@Override
	public Map<String, Object> getListUser(Search search) throws Exception {

		Map<String, Object> map=new HashMap<>();
		map.put("search", search);

		
		List<User> list=userMapper.getListUser(search);
		int totalCount=userMapper.getListUserTotalCount(search);
		
		map.put("list", list);
		map.put("totalCount", totalCount);
		
		return map;
	}
	
	@Override
	public List<Relation> getListBlackList() throws Exception {
		
		List<Relation> list=userMapper.getListBlackList();

		return list;
	}

	@Override
	public int updateUser(User user) throws Exception {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		return userMapper.updateUser(user);
	}

	@Override
	public int deleteUser(String userId) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.deleteUser(userId);
	}

	public int confirmUserId(String userId) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.checkDuplicationUserId(userId);
	}

	@Override
	public User confirmUserPhone(String phone) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.checkDuplicationPhone(phone);
	}

	@Override
	public User confirmUserEmail(String email) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.checkDuplicationEmail(email);
	}

	@Override
	public int confirmCode(String code) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int confirmUserNickname(String nickname) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.checkDuplicationNickName(nickname);
	}

	@Override
	public int confirmCaptcha(String captcha) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int kakaoLogin() throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int naverLogin() throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	
	@Override
	public int insertPoint(Point point) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.insertPoint(point);
	}

	@Override
	public Map<String, Object>  getListPoint(Search search, String userId) throws Exception {


		Map<String, Object> map=new HashMap<>();
		map.put("search", search);
		map.put("userId", userId);
		
		List<Point> pointList=userMapper.getListPoint(map);
		int pointTotalCount=userMapper.getListPointTotalCount(map);
		
		map.put("pointList", pointList);
		map.put("pontTotalCount", pointTotalCount);
		
		return map;
		
		
	}

	@Override
	public User getProfile(String userId) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.getProfile(userId);
	}

	@Override
	public int updateProfile(User user) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.updateProfile(user);
	}
	
	@Override
	public int updateBlockCount(String userId) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.updateBlockCount(userId);
	}
	
	@Scheduled(cron = "0 41 11 * * ? ")
	public void updateBlackList() throws Exception {
		userMapper.insertBlackList();
		userMapper.resetBlockCount();
		userMapper.updateBlackList();
	}
	
	@Scheduled(cron = "0 34 12 1 * ? ")
	public void updateGrade() throws Exception {
		userMapper.updateUserGrade();
		userMapper.resetPurchaseCount();
	}

	
	// 유저 패스워드 인증
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		User user= null;
		System.out.println(username);
		try {
			user = userMapper.getUser(username);
			if(user == null) {
				throw new UsernameNotFoundException("없는 아이디임");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;
	}


	@Override
	public int updatePassword(User user) throws Exception {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		return userMapper.updatePassword(user);
	}


	@Override
	public Point getPoint(int pointNo) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.getPoint(pointNo);
	}


	@Override
	public int updateUserTotalPoint(User user) throws Exception {
		
		return userMapper.updateUserTotalPoint(user);
	}


	@Override
	public String getRecentPurchase(String userId) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.getRecentPurchase(userId);
	}


	@Override
	public int deletePoint(int purchaseNo) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.deletePoint(purchaseNo);
	}


	

	


	



	

	
	
	
}
