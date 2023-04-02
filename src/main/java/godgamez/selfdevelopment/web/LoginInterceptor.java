package godgamez.selfdevelopment.web;
/*
package kwonchaerin.selfdevelopment.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		try {
			HttpSession session = request.getSession();
			Object user = session.getAttribute("user");
			
			if(user != null) return true;
			else {
				response.sendRedirect("/kwonchaerin.selfdevelopment/user/login");
				return false;
			}
		} catch(Exception e) {
			return false;
		}
	}
}
*/