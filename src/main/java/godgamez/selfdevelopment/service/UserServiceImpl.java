package godgamez.selfdevelopment.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import godgamez.selfdevelopment.dao.UserClassDao;
import godgamez.selfdevelopment.dao.UserDao;
import godgamez.selfdevelopment.dao.UserQuestDao;
import godgamez.selfdevelopment.domain.Class;
import godgamez.selfdevelopment.domain.User;
import godgamez.selfdevelopment.domain.UserClass;
import godgamez.selfdevelopment.domain.UserQuest;

@Service
public class UserServiceImpl implements UserService {
	@Autowired private UserDao userDao;
	@Autowired private UserQuestDao userQuestDao;
	@Autowired private UserClassDao userClassDao;

	/*아이디 찾기
	@Override
	public User findUsrId(String usrName, String phoneNum, LocalDate birthday) {
		return userDao.selectUsrId(usrName, phoneNum, birthday);
	}
	
	비번 찾기
	@Override
	public User findUsrPw(String usrId, String usrName, String phoneNum) {
		return userDao.selectUsrPw(usrId, usrName, phoneNum);
	}*/
	
	@Override
	public List<User> getRankers() {
		return userDao.selectRankers();
	}

	@Override
	public User getUser(Map<String, String> getMap) {
		return userDao.selectUser(getMap);
	}
	
	@Override
	public List<User> getUsers(Map<String, String> positionMap) {
		return userDao.selectUsers(positionMap);
	}
	
	@Override
	public List<User> findUsers(Map<String, String> searchMap) {
		return userDao.searchUsers(searchMap);
	}
	
	@Override
	public boolean addUser(User user) {
		return userDao.insertUser(user) > 0;
	}
	
	@Override
	public boolean fixUser(User user) {
		return userDao.updateUser(user) > 0;
	}
	
	@Override
	public boolean patchUser(User user) {
		return userDao.patchUser(user) > 0;
	}
	
	@Override
	public boolean delUser(int usrCode) {
		return userDao.deleteUser(usrCode) > 0;
	}
	
	@Override
	public User loginCheck(Map<String, String> loginMap) {
		return userDao.loginCheck(loginMap);
	}
	
	@Override
	public void logout(HttpSession session) {
		 userDao.logout(session);
	}
	
	@Override
	public List<UserQuest> getUsrQstList() {
		return userQuestDao.selectUsrQstList();
	}
	
	@Override
	public List<UserQuest> getUsrQstListOfUsr(int usrCode) {
		return userQuestDao.selectUsrQstListOfUsr(usrCode);
	}
	
	@Override
	public boolean delUserQuestForUnreg(int usrCode) {
		return userQuestDao.deleteUserQuestForUnreg(usrCode) > 0;
	}
	
	@Override
	public boolean deleteUserQuestImg(int usrCode, int qstId) {
		return userQuestDao.deleteUserQuestImg(usrCode, qstId) > 0;
	}
	
	@Override
	public List<UserClass> getUsrClsList(int userCode) {
		return userClassDao.selectUsrClsList(userCode);
	}
	
	@Override
	public boolean addUserClass(int usrCode, int clsId) {
		return userClassDao.insertUserClass(usrCode, clsId) > 0;
	}
	
	@Override
	public boolean delUserClass(int usrCode, int clsId) {
		return userClassDao.deleteUserClass(usrCode, clsId) > 0;
	}
	
	@Override
	public boolean delUserClassForUnreg(int usrCode) {
		return userClassDao.deleteUserClassForUnreg(usrCode) > 0;
	}
	
	@Override
	public List<Class> getClassesForUser(int usrCode) {
		return userClassDao.selectClassesForUser(usrCode);
	}
	
	@Override	
	public List<Class> findClassesForUser(Map<String, String> searchMap) {
		return userClassDao.searchClassesForUser(searchMap);
	}
	
	@Override
	public int getUserCodeSeqNextVal() {
		return userDao.selectUserCodeSeqNextVal();
	}
	
	@Override
	public int getUserCodeSeqCurrVal() {
		return userDao.selectUserCodeSeqCurrVal();
	}
}