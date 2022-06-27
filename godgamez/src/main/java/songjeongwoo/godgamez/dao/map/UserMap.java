package songjeongwoo.godgamez.dao.map;


import java.util.List;

import songjeongwoo.godgamez.domain.User;

public interface UserMap {
	int insertUser(User user);
	
	User selectUserById(String usrId);
	
	int updateUser(User user);
	
	/* admin - 포지션 별 유저 리스트 소환  */
	List<User> selectPlayers();
	List<User> selectNoobs();
	List<User> selectOutPlayers();
	List<User> selectGms();
	
	User selectUserByCode(int usrCode);
	User selectUserByPhonenum(String phoneNum);
	User selectUserByNick(String nickname);
	
	int patchUser(User user);
	
	List<User> searchUsersById(String usrId);
	List<User> searchUsersByCode(int usrCode);
	List<User> searchUsersByName(String usrName);
	List<User> searchUsersByNick(String nickname);
	
	int deleteUser(int usrCode);
}