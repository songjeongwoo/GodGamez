package godgamez.selfdevelopment.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import godgamez.selfdevelopment.dao.map.UserMap;
import godgamez.selfdevelopment.domain.User;

@Repository
public class UserDaoImpl implements UserDao {
	@Autowired private UserMap userMap;
	
	public List<User> selectRankers() {
		return userMap.selectRankers();
	}
	
	public List<User> selectPlayers() {
		return userMap.selectPlayers();
	}
	
	public List<User> selectNoobs() {
		return userMap.selectNoobs();
	}
	
	public List<User> selectOutPlayers() {
		return userMap.selectOutPlayers();
	}
	
	public List<User> selectGms() {
		return userMap.selectGms();
	}
	
	public List<User> selectUsers(Map<String, String> positionMap) {
		if(positionMap.get("position") != null) {
			String position = positionMap.get("position");
			
			switch(position) {
			case "PLAYERS": return userMap.selectPlayers();
			case "NOOB": return userMap.selectNoobs();
			case "OUT": return userMap.selectOutPlayers();
			case "GM": return userMap.selectGms();
			default: return null;
			}
		} return null;
	}

	public User selectUserByCode(int usrCode) {
		return userMap.selectUserByCode(usrCode);
	}

	public User selectUserById(String usrId) {
		return userMap.selectUserById(usrId);
	}

	public User selectUserByPhonenum(String phoneNum) {
		return userMap.selectUserByPhonenum(phoneNum);
	}

	public User selectUserByNick(String nickname) {
		return userMap.selectUserByNick(nickname);
	}
	
	/* 한정된 데이터로 user 객체 뽑아내기 */
	public User selectUser(Map<String, String> getMap) {
		if(getMap.get("usrCode") != null) {
			int usrCode = Integer.parseInt(getMap.get("usrCode"));
			return userMap.selectUserByCode(usrCode);
		} else if(getMap.get("usrId") != null)
			return userMap.selectUserById(getMap.get("usrId"));
		else if(getMap.get("phoneNum") != null)
			return userMap.selectUserByPhonenum(getMap.get("phoneNum"));
		else if(getMap.get("nickname") != null)
			return userMap.selectUserByNick(getMap.get("nickname"));
		else return null;
	}
	
	public List<User> searchUsersById(String usrId) {
		return userMap.searchUsersById(usrId);
	}

	public List<User> searchUsersByName(String usrName) {
		return userMap.searchUsersByName(usrName);
	}

	public List<User> searchUsersByNick(String nickname) {
		return userMap.searchUsersByName(nickname);
	}

	/* 유저 검색해서 리스트 추출 */
	public List<User> searchUsers(Map<String, String> searchMap) {
		if(searchMap.get("usrId") != null)
			return userMap.searchUsersById(searchMap.get("usrId"));
		else if(searchMap.get("usrCode") != null)
			return userMap.searchUsersByCode(Integer.parseInt(searchMap.get("usrCode")));
		else if(searchMap.get("usrName") != null)
			return userMap.searchUsersByName(searchMap.get("usrName"));
		else if(searchMap.get("nickname") != null)
			return userMap.searchUsersByNick(searchMap.get("nickname"));
		else return null;
	}
	
	public int insertUser(User user) {
		return userMap.insertUser(user);
	}
	
	public int updateUser(User user) {
		return userMap.updateUser(user);
	}
	
	public int patchUser(User user) {
		return userMap.patchUser(user);
	}
	
	public int deleteUser(int usrCode) {
		return userMap.deleteUser(usrCode);
	}

	public User loginCheck(Map<String, String> loginMap) {
		String usrId = loginMap.get("usrId");
		String usrPw = loginMap.get("usrPw");
		
		User user = userMap.selectUserById(usrId);
		
		if(user != null && user.getUsrPw().equals(usrPw)) return user;
		else return null;
	}
	
	public void logout(HttpSession session) {
		session.invalidate();
	}
	
	public int selectUserCodeSeqNextVal() {
		return userMap.selectUserCodeSeqNextVal();
	}
	
	public int selectUserCodeSeqCurrVal() {
		return userMap.selectUserCodeSeqCurrVal();
	}
}