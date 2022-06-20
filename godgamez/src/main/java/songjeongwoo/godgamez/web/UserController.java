package songjeongwoo.godgamez.web;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import songjeongwoo.godgamez.domain.User;
import songjeongwoo.godgamez.service.UserService;

@RestController
@RequestMapping
public class UserController {
	@Autowired private UserService userService;
	
	/* 회원 가입 */
	@Transactional
	@PostMapping("/user/add")
	public boolean addUser(@RequestBody User user) {
		return userService.addUser(user);
	}
	
	/* 로그인 */
	@PostMapping("/user/loginProc")
	public int login(@RequestBody Map<String, String> loginMap, HttpSession session) throws Exception {
		int result = 0;
		
		try {
			User user = userService.loginCheck(loginMap);
			if(user != null) {
				session.setAttribute("user", user);
				if(user.getPosition().equals("NOOB") || user.getPosition().equals("PLAYER")) return 1;
				else if(user.getPosition().equals("GM")) return 2;
			} else return 0;
		} catch(Exception e) {
			return 0;
		}
		return result;
	}
	
	/* 로그아웃 */
	@GetMapping("/user/logout")
	public ModelAndView logout(ModelAndView mv, HttpSession session) {
		session.invalidate();
		mv.setViewName("main");
		return mv;
	}
}
