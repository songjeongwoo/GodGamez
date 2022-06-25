package songjeongwoo.godgamez.dao;

import java.util.List;
import java.util.Map;

import songjeongwoo.godgamez.domain.User;

public interface UserDao {
	int insertUser(User user);
	
	User loginCheck(Map<String, String> loginMap);
	
	int updateUser(User user);
	
	/* admin */
	List<User> selectUsers(Map<String, String> positionMap);
	User selectUser(Map<String, String> getMap);
	int patchUser(User user);
}