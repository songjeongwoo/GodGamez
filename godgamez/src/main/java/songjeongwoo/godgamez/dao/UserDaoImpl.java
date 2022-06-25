package songjeongwoo.godgamez.dao;

import java.util.List;
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
	
	@Override
	public int updateUser(User user) {
		return userMap.updateUser(user);
	}
	
	/* admin */
	@Override
	public List<User> selectUsers(Map<String, String> positionMap) {
		if(positionMap.get("position") != null) {
			String position = positionMap.get("position");
			
			switch(position) {
			case "PLAYERS": return userMap.selectPlayers(); // noob, player, out
			case "NOOB": return userMap.selectNoobs();
			case "OUT": return userMap.selectOutPlayers();
			case "GM": return userMap.selectGms();
			default: return null;
			}
		} return null;
	}
	
	/* 한정된 데이터로 user 객체 뽑아내기 */
	@Override
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
	
	@Override
	public int patchUser(User user) {
		return userMap.patchUser(user);
	}
}