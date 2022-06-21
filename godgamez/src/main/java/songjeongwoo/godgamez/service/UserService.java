package songjeongwoo.godgamez.service;

import java.util.List;
import java.util.Map;

import songjeongwoo.godgamez.domain.User;

public interface UserService {
	boolean addUser(User user);
	
	User loginCheck(Map<String, String> loginMap);
	
	/* admin */
	List<User> getUsers(Map<String, String> positionMap);
	User getUser(Map<String, String> getMap);
	boolean patchUser(User user);
}