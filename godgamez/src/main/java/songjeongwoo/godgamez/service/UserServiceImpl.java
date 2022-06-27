package songjeongwoo.godgamez.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import songjeongwoo.godgamez.dao.UserDao;
import songjeongwoo.godgamez.dao.UserClassDao;
import songjeongwoo.godgamez.domain.User;
import songjeongwoo.godgamez.domain.Class;
import songjeongwoo.godgamez.domain.UserClass;

@Service
public class UserServiceImpl implements UserService {
	@Autowired private UserDao userDao;
	@Autowired private UserClassDao userClassDao;
	
	@Override
	public boolean addUser(User user) {
		return userDao.insertUser(user) > 0;
	}
	
	/* 회원가입 시 클래스 추가 */
	@Override
	public boolean addUserClass(int usrCode, int clsId) {
		return userClassDao.insertUserClass(usrCode, clsId) > 0;
	}
	
	@Override
	public User loginCheck(Map<String, String> loginMap) {
		return userDao.loginCheck(loginMap);
	}
	
	/* 회원정보 수정 페이지 조회 시 유저 클래스 목록 조회*/
	@Override
	public List<UserClass> getUsrClsList(int userCode) {
		return userClassDao.selectUsrClsList(userCode);
	}
	
	/* 회원정보변경 및 관리자 직접 수정 */
	@Override
	public boolean fixUser(User user) {
		return userDao.updateUser(user) > 0;
	}
	
	/* 회원 클래스 초기화 - 회원정보 변경 시 유저에 따라 다르게 클래스 목록 조회  */
	@Override
	public List<Class> getClassesForUser(int usrCode) {
		return userClassDao.selectClassesForUser(usrCode);
	}
	
	@Override
	public boolean delUserClassForUnreg(int usrCode) {
		return userClassDao.deleteUserClassForUnreg(usrCode) > 0;
	}
	
	/* 유저 클래스 삭제 - 회원정보 변경 시 */
	@Override
	public boolean delUserClass(int usrCode, int clsId) {
		return userClassDao.deleteUserClass(usrCode, clsId) > 0;
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
	
	/* 신규 회원 인증 처리 및 탈퇴 신청 회원 복구 처리 - admin 또는 회원탈퇴 신청 */
	@Override
	public boolean patchUser(User user) {
		return userDao.patchUser(user) > 0;
	}
	
	/* 이름, 별명, 아이디로 회원 목록 검색 */
	@Override
	public List<User> findUsers(Map<String, String> searchMap) {
		return userDao.searchUsers(searchMap);
	}
	
	/* 관리자 회원 삭제
	@Override
	public List<UserQuest> getUsrQstListOfUsr(int usrCode) {
		return userQuestDao.selectUsrQstListOfUsr(usrCode);
	}
	
	@Override
	public boolean delUserQuestForUnreg(int usrCode) {
		return userQuestDao.deleteUserQuestForUnreg(usrCode) > 0;
	} */
	
	@Override
	public boolean delUser(int usrCode) {
		return userDao.deleteUser(usrCode) > 0;
	}
}