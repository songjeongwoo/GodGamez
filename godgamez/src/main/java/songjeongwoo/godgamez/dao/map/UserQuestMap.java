package songjeongwoo.godgamez.dao.map;

import java.util.List;

import songjeongwoo.godgamez.domain.UserQuest;

public interface UserQuestMap {
	/* 유저별 전체/운동/공부탭 별 퀘스트 목록 조회 */
	List<UserQuest> selectQstsForUsr(int usrCode);
	List<UserQuest> selectExcQstsForUsr(int usrCode);
	List<UserQuest> selectStdQstsForUsr(int usrCode);
	
}