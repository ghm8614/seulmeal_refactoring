package shop.seulmeal.common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;

import lombok.Getter;
import lombok.Setter;


public class CustomAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

	
	public CustomAuthenticationSuccessHandler(String defaultUrl){
		setDefaultTargetUrl(defaultUrl);
	} 
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		
		if(session != null) {
			String targetUrl = (String)session.getAttribute("prevPage");
			System.out.println(targetUrl);
			if(targetUrl != null) {
				System.out.println("==========saveUrl Go : "+targetUrl);
				session.removeAttribute("prevPage");
				getRedirectStrategy().sendRedirect(request, response, targetUrl);
			} else {
				super.onAuthenticationSuccess(request, response, authentication);
			}			
		} else {
			System.out.println("==========defaultUrl Go : "+authentication);
			super.onAuthenticationSuccess(request, response, authentication);
		}
	}	

}
