package songjeongwoo.godgamez.dao;

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
}