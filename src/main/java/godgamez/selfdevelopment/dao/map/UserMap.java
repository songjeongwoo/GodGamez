package godgamez.selfdevelopment.dao.map;

import java.util.List;

import godgamez.selfdevelopment.domain.User;

public interface UserMap {
	/*아이디 찾기
	User selectUsrId(@Param("usrName")String usrName, @Param("phoneNum")String phoneNum, @Param("birthday")LocalDate birthday);
	비번 찾기
	User selectUsrPw(@Param("usrId")String usrId, @Param("usrName")String usrName, @Param("phoneNum")String phoneNum);*/
	
	List<User> selectPlayers();
	List<User> selectRankers();
	List<User> selectNoobs();
	List<User> selectOutPlayers();
	List<User> selectGms();
	
	User selectUserByCode(int usrCode);
	User selectUserById(String usrId);
	User selectUserByPhonenum(String phoneNum);
	User selectUserByNick(String nickname);
	
	List<User> searchUsersById(String usrId);
	List<User> searchUsersByCode(int usrCode);
	List<User> searchUsersByName(String usrName);
	List<User> searchUsersByNick(String nickname);
	
	int insertUser(User user);
	int updateUser(User user);
	int patchUser(User user);
	int deleteUser(int usrCode);

	int selectUserCodeSeqNextVal();
	int selectUserCodeSeqCurrVal();
}