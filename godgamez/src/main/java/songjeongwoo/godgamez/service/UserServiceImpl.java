package songjeongwoo.godgamez.service;

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
}