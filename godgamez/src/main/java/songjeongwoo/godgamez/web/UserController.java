package songjeongwoo.godgamez.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	/* admin - 포지션별 회원 목록 조회 */
	@PostMapping("/user/listUsers")
	public List<User> getUsers(@RequestBody Map<String, String> positionMap) {
		return userService.getUsers(positionMap);
	}
	
	/* admin - 한정된 데이터로 유저 객체 소환 */
	@PostMapping("/user/get")
	public User getUser(@RequestBody Map<String, String> getMap) {
		User target = userService.getUser(getMap);
		return target;
	}
	
	/* 신규 회원 인증 처리 및 탈퇴 신청 회원 복구 처리 */
	@Transactional
	@PatchMapping("/user/bePlayer")
	public boolean usrPlayer(@RequestBody User user) {
		user.setPosition("PLAYER");
		return userService.patchUser(user);
	}
}
