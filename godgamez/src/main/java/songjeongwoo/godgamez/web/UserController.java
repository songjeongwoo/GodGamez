package songjeongwoo.godgamez.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
