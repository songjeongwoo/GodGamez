package songjeongwoo.godgamez.dao.map;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import songjeongwoo.godgamez.domain.UserQuest;

public interface UserQuestMap {
	/* 유저별 전체/운동/공부탭 별 퀘스트 목록 조회 */
	List<UserQuest> selectQstsForUsr(int usrCode);
	List<UserQuest> selectExcQstsForUsr(int usrCode);
	List<UserQuest> selectStdQstsForUsr(int usrCode);
	/* 난이도별 퀘스트 조회 */ //파라미터가 2개 이상일 경우 @Param을 통해 어떤 파라미터가 어떤 변수인지 알려준다.
	List<UserQuest> selectQstDifficulty(@Param("usrCode")int usrCode, @Param("difficulty")int difficulty);
	
}