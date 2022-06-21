package songjeongwoo.godgamez.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import songjeongwoo.godgamez.dao.UserDao;
import songjeongwoo.godgamez.domain.User;

@Service
public class UserServiceImpl implements UserService {
	@Autowired private UserDao userDao;
	@Override
	public boolean addUser(User user) {
		return userDao.insertUser(user) > 0;
	}
	
	@Override
	public User loginCheck(Map<String, String> loginMap) {
		return userDao.loginCheck(loginMap);
	}
	
	/* admin */
	@Override
	public List<User> getUsers(Map<String, String> positionMap) {
		return userDao.selectUsers(positionMap);
	}
	
	@Override
	public User getUser(Map<String, String> getMap) {
		return userDao.selectUser(getMap);
	}
	
	@Override
	public boolean patchUser(User user) {
		return userDao.patchUser(user) > 0;
	}
}