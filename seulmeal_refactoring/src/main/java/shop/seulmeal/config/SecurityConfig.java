package shop.seulmeal.config;

import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import shop.seulmeal.common.CustomAuthenticationSuccessHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Autowired()
	@Qualifier("userServiceImpl")
	private UserDetailsService userService;
		
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		// TODO Auto-generated method stub
		auth.userDetailsService(userService).passwordEncoder(new BCryptPasswordEncoder());
	}
	
	@Override
	public void configure(WebSecurity web) throws Exception {
		// TODO Auto-generated method stub
		web.ignoring().antMatchers("/resources/**");
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		// TODO Auto-generated method stub
		http
		.authorizeRequests()
			///*
			.antMatchers("/","/product/**","/operation/**").permitAll()
			.antMatchers("/admin/**").hasAuthority("1")
			.antMatchers("/community/**").hasAnyAuthority("0","1")
			.antMatchers("/operation/api/insertAnswer").permitAll()
			//*/
			//.antMatchers("/**").permitAll()
		.and()
			.formLogin()
			.usernameParameter("userId")
			.passwordParameter("password")
			.loginPage("/user/login")
			.failureUrl("/user/login?error")
			.successHandler(successHandler())
			.defaultSuccessUrl("/",false)
		.and()
			.logout()
			.logoutRequestMatcher(new AntPathRequestMatcher("/user/logout"))
			.deleteCookies("JSESSIONID","loginCookie")
			.logoutSuccessUrl("/")
		.and()
			.sessionManagement()
			.maximumSessions(1)
			.maxSessionsPreventsLogin(true);
		
		// 자동로그인	
		http
		.rememberMe()
			.key("loginCookie")
			.rememberMeParameter("checkLogin")
			.tokenValiditySeconds(60*60);
		
		// iframe 설정
		http
		.headers()
			.frameOptions().sameOrigin();
		
		http
		.cors().configurationSource(corsConfigurationSource())
		.and()
		.csrf().disable();
		
	}
	
	@Bean
	public AuthenticationSuccessHandler successHandler() {
		
		return new CustomAuthenticationSuccessHandler("/");
	}
	
	@Bean 
    public CorsConfigurationSource corsConfigurationSource() {
		CorsConfiguration configuration = new CorsConfiguration();
		configuration.addAllowedOrigin("*");
        configuration.addAllowedHeader("*");
        configuration.addAllowedMethod("*");
        configuration.setAllowCredentials(true);
        
		UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
		source.registerCorsConfiguration("/**", configuration);
		
        return source;
    }
}


