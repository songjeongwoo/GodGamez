package songjeongwoo.godgamez.service;

import java.util.Map;

import songjeongwoo.godgamez.domain.User;

public interface UserService {
	boolean addUser(User user);
	
	User loginCheck(Map<String, String> loginMap);
}