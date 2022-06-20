package songjeongwoo.godgamez.dao.map;


import songjeongwoo.godgamez.domain.User;

public interface UserMap {
	int insertUser(User user);
	
	User selectUserById(String usrId);
}