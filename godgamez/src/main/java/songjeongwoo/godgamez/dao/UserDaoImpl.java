package songjeongwoo.godgamez.dao;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import songjeongwoo.godgamez.dao.map.UserMap;
import songjeongwoo.godgamez.domain.User;

@Repository
public class UserDaoImpl implements UserDao {
	@Autowired private UserMap userMap;
	@Override
	public int insertUser(User user) {
		return userMap.insertUser(user);
	}
	
	@Override
	public User loginCheck(Map<String, String> loginMap) {
		String usrId = loginMap.get("usrId");
		String usrPw = loginMap.get("usrPw");
		
		User user = userMap.selectUserById(usrId);

		if(user != null && user.getUsrPw().equals(usrPw))
			return user;
		else
			return null;
	}
}