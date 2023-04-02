package godgamez.selfdevelopment.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import godgamez.selfdevelopment.domain.Class;
import godgamez.selfdevelopment.domain.User;
import godgamez.selfdevelopment.domain.UserClass;
import godgamez.selfdevelopment.domain.UserQuest;

public interface UserService {	
	/*아이디 찾기
	User findUsrId(String usrName, String phoneNum, LocalDate birthday);
	비번 찾기
	User findUsrPw(String usrId, String usrName, String phoneNum);*/
	
	List<User> getRankers();
	List<User> getUsers(Map<String, String> positionMap);
	User getUser(Map<String, String> getMap);
	List<User> findUsers(Map<String, String> searchMap);
	
	boolean addUser(User user);
	boolean fixUser(User user);
	boolean patchUser(User user);
	boolean delUser(int usrCode);
	
	User loginCheck(Map<String, String> loginMap);
	void logout(HttpSession session);
	
	List<UserQuest> getUsrQstList();
	List<UserQuest> getUsrQstListOfUsr(int usrCode);
	boolean delUserQuestForUnreg(int usrCode);
	
	List<UserClass> getUsrClsList(int userCode);
	boolean addUserClass(int usrCode, int clsId);
	boolean delUserClass(int usrCode, int clsId);
	boolean delUserClassForUnreg(int usrCode);
	boolean deleteUserQuestImg(int usrCode, int clsId);

	List<Class> getClassesForUser(int usrCode);
	List<Class> findClassesForUser(Map<String, String> searchMap);
	
	int getUserCodeSeqNextVal();
	int getUserCodeSeqCurrVal();
}