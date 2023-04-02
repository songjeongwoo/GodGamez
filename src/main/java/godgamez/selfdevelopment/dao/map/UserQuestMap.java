package godgamez.selfdevelopment.dao.map;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import godgamez.selfdevelopment.domain.UserQuest;

public interface UserQuestMap {
	List<UserQuest> selectUsrQstList();
	List<UserQuest> selectUsrQstListOfUsr(@Param("usrCode")int usrCode);
	
	/* user 퀘스트 리스트  */
	List<UserQuest> selectQstsForUsr(int usrCode);
	/* user 운동 퀘스트 리스트 */
	List<UserQuest> selectExcQstsForUsr(int usrCode);
	/* user 공부 퀘스트 리스트 */
	List<UserQuest> selectStdQstsForUsr(int usrCode);
	/* 난이도별 검색 */
	List<UserQuest> selectQstDifficulty(UserQuest userQuest);
	
	/* user 클래스명 검색   */
	List<UserQuest> selectQstClsName(UserQuest userQuest);
	
	/* user 퀘스트 수락 */
	int addUsrQst(UserQuest userQuest);
	/* 수락한 퀘스트 체크 */
	UserQuest selectUserQst(UserQuest userQuest);
	/* 퀘스트 포기 */
	int deleteUserQst(UserQuest userQuest);
	
	/* admin 수행중 */
	List<UserQuest> selectAcptdQstCnt(int qstId);
	
	/* 퀘스트 수행완료(제출) */
	int doUserQuest(UserQuest userQuest);
	
	/* 수행완료 - 사진삭제 */
	int updateUserQuestHandInImg(UserQuest userQuest);
	
	int deleteUserQuestForUnreg(@Param("usrCode")int usrCode);
	int deleteUserQuestHandInImg(@Param("usrCode")int usrCode, @Param("qstId")int qstId);
}