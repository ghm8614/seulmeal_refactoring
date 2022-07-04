package shop.seulmeal.service.domain;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.sql.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;




@Getter
@Setter
@ToString
@JsonInclude(Include.NON_NULL)
public class User implements UserDetails {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String userId;
	private String userName;
	@JsonIgnore
	private String password;
	//@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date birth;
	private String address;
	private String phone;
	private String email;
	private String grade;
	//@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date regDate;
	private Date loginDate;
	private int blockCount;
	private String nickName;
	private String profileImage;
	private String profileMessage;
	private String role;
	private String userStatus;
	private int totalCount;
	private String confirmStatus;
	private int blackLsitCount;
	private int purchaseCount;
	private String blackListStatus;
	private String foodCategoryName1;
	private String foodCategoryName2;
	private String foodCategoryName3;
	private List<Parts> parts;
	//private List<> follow;
	private List<Relation> relation;
	private List<Like> wish;
	private int totalPoint;

	
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		System.out.println("=========================="+this.role);
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		authorities.add(new SimpleGrantedAuthority(this.role));
		return authorities;
	}
	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return this.userId;
	}
	
	public String getUserName() {
		return this.userName;
	}
	
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}
	
	
}
