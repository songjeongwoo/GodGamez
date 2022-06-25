package songjeongwoo.godgamez.service;

import java.util.List;
import java.util.Map;

import songjeongwoo.godgamez.domain.User;
import songjeongwoo.godgamez.domain.Class;
import songjeongwoo.godgamez.domain.UserClass;

public interface UserService {
	boolean addUser(User user);
	boolean addUserClass(int usrCode, int clsId);
	
	User loginCheck(Map<String, String> loginMap);
	
	boolean fixUser(User user);
	List<Class> getClassesForUser(int usrCode);
	boolean delUserClassForUnreg(int usrCode);
	boolean delUserClass(int usrCode, int clsId);
	
	List<UserClass> getUsrClsList(int userCode);
	
	/* admin */
	List<User> getUsers(Map<String, String> positionMap);
	User getUser(Map<String, String> getMap);
	boolean patchUser(User user);
}