package godgamez.selfdevelopment.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import godgamez.selfdevelopment.domain.User;

public interface UserDao {
	/*아이디 찾기
	User selectUsrId(String usrName, String phoneNum, LocalDate birthday);
	비번 찾기
	User selectUsrPw(String usrId, String usrName, String phoneNum);*/
	
	List<User> selectRankers();
	
	List<User> selectPlayers();
	List<User> selectNoobs();
	List<User> selectOutPlayers();
	List<User> selectGms();
	
	List<User> selectUsers(Map<String, String> positionMap);
	
	User selectUserByCode(int usrCode);
	User selectUserById(String usrId);
	User selectUserByPhonenum(String phoneNum);
	User selectUserByNick(String usrNick);
	
	User selectUser(Map<String, String> getMap);
	
	List<User> searchUsersById(String usrId);
	List<User> searchUsersByName(String usrName);
	List<User> searchUsersByNick(String usrNick);
	
	List<User> searchUsers(Map<String, String> searchMap);
	
	int insertUser(User user);
	int updateUser(User user);
	int patchUser(User user);
	int deleteUser(int usrCode);
	
	User loginCheck(Map<String, String> loginMap);
	void logout(HttpSession session);
	
	int selectUserCodeSeqNextVal();
	int selectUserCodeSeqCurrVal();
}