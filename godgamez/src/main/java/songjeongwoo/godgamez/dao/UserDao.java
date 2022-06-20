package songjeongwoo.godgamez.dao;

import java.util.Map;

import songjeongwoo.godgamez.domain.User;

public interface UserDao {
	int insertUser(User user);
	
	User loginCheck(Map<String, String> loginMap);
}