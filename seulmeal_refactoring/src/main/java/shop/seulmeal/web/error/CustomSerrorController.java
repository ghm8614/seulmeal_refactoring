package shop.seulmeal.web.error;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CustomSerrorController implements ErrorController {
	private static final String PATH = "/error";
	
	@RequestMapping(value=PATH)
	public String erorr(HttpServletRequest request) {
		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		//System.out.println(status);
		if(status != null) {
			int statusCode = Integer.valueOf(status.toString());
			
			if(statusCode == HttpStatus.FORBIDDEN.value()) {				
				return "errors/403";
			}
			
			if(statusCode == HttpStatus.NOT_FOUND.value()) {
				return "errors/404";
			}
			
			if(statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
				return "errors/500";
			}
		}
		
		
		return "error";
	}
}
