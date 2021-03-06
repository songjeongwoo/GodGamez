package songjeongwoo.godgamez.dao;

import java.util.List;

import songjeongwoo.godgamez.domain.UserQuest;

public interface UserQuestDao {
	/* 유저별 전체/운동/공부탭 별 퀘스트 목록 조회 */
	List<UserQuest> selectQstsForUsr(String qstCtg, int usrCode);
	/* 난이도별 퀘스트 조회 */
	List<UserQuest> selectQstDifficulty(int usrCode, int difficulty);
	/* user 클래스명 검색  */
	List<UserQuest> selectQstClsName(UserQuest userQuest);
	
}