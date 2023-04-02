package godgamez.selfdevelopment.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import godgamez.selfdevelopment.dao.map.UserQuestMap;
import godgamez.selfdevelopment.domain.UserQuest;

@Repository
public class UserQuestDaoImpl implements UserQuestDao {
	@Autowired private UserQuestMap userQuestMap;
	
	public List<UserQuest> selectUsrQstList() {
		return userQuestMap.selectUsrQstList();
	}

	public List<UserQuest> selectUsrQstListOfUsr(int usrCode) {
		return userQuestMap.selectUsrQstListOfUsr(usrCode);
	}
	
	/////////////////////////////////////////////////
	/* user 퀘스트 리스트 */
	public List<UserQuest> selectQstsForUsr(int usrCode) {
		return userQuestMap.selectQstsForUsr(usrCode);
	}
	
	/* user 운동 퀘스트 리스트 */
	public List<UserQuest> selectExcQstsForUsr(int usrCode) {
		return userQuestMap.selectExcQstsForUsr(usrCode);
	}
	
	/* user 공부 퀘스트 리스트 */
	public List<UserQuest> selectStdQstsForUsr(int usrCode) {
		return userQuestMap.selectStdQstsForUsr(usrCode);
	}
	
	/* 난이도별 검색 */
	public List<UserQuest> selectQstDifficulty(UserQuest userQuest) {
		return userQuestMap.selectQstDifficulty(userQuest);
	}
	
	/* user 클래스명 검색   */
	public List<UserQuest> selectQstClsName(UserQuest userQuest) {
		return userQuestMap.selectQstClsName(userQuest);
	}
	
	/* user 퀘스트 수락 */
	public int addUsrQst(UserQuest userQuest) {
		return userQuestMap.addUsrQst(userQuest);
	}
	
	/* 수락한 퀘스트 체크 */
	public UserQuest selectUserQst(UserQuest userQuest) {
		return userQuestMap.selectUserQst(userQuest);
	}
	
	/* 퀘스트 포기 */
	public int deleteUserQst(UserQuest userQuest) {
		return userQuestMap.deleteUserQst(userQuest);
	}
	
	/* admin 수행중 */
	public List<UserQuest> selectAcptdQstCnt(int qstId) {
		return userQuestMap.selectAcptdQstCnt(qstId);
	}
	
	/* 퀘스트 수행완료(제출) */
	public int doUserQuest(UserQuest userQuest) {
		return userQuestMap.doUserQuest(userQuest);
	}
	/* 수행완료 - 사진삭제 */
	public int updateUserQuestHandInImg(UserQuest userQuest) {
		return userQuestMap.updateUserQuestHandInImg(userQuest);
	}
	/////////////////////////////////////////////////
	
	/*@Autowired private UserQuestMap userQuestMap;
	
	@Override
	public List<UserQuest> selectUserQuestsByUsrCode(int usrCode) {
		return userQuestMap.selectUserQuestsByUsrCode(usrCode);
	}
	
	@Override
	public List<UserQuest> selectUserQuestsByQstId(int qstId) {
		return userQuestMap.selectUserQuestsByQstId(qstId);
	}
	
	@Override
	public int insertUserQuest(UserQuest userQuest) {
		return userQuestMap.insertUserQuest(userQuest);
	}
	
	@Override
	public int doneUserQuest(Map<String, String> doQstMap) {
		int usrCode = Integer.parseInt(doQstMap.get("usrCode"));
		int qstId = Integer.parseInt(doQstMap.get("qstId"));
		return userQuestMap.doneUserQuest(usrCode, qstId);
	}
	
	@Override
	public int deleteUserQuest(UserQuest userQuest) {
		return userQuestMap.deleteUserQuest(userQuest);
	}*/

	public int deleteUserQuestForUnreg(int usrCode) {
		return userQuestMap.deleteUserQuestForUnreg(usrCode);
	}
	
	public int deleteUserQuestImg(int usrCode, int qstId) {
		return userQuestMap.deleteUserQuestHandInImg(usrCode, qstId);
	}
}