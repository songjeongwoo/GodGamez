package songjeongwoo.godgamez.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import songjeongwoo.godgamez.dao.map.UserQuestMap;
import songjeongwoo.godgamez.domain.UserQuest;

@Repository
public class UserQuestDaoImpl implements UserQuestDao {
	@Autowired private UserQuestMap userQuestMap;
	
	/* 유저별 전체/운동/공부탭 별 퀘스트 목록 조회 */
	@Override
	public List<UserQuest> selectQstsForUsr(String qstCtg, int usrCode) {
		if(qstCtg != null) {			
			switch(qstCtg) {
			case "ALL": return userQuestMap.selectQstsForUsr(usrCode);
			case "EXERCISE": return userQuestMap.selectExcQstsForUsr(usrCode);
			case "STUDY": return userQuestMap.selectStdQstsForUsr(usrCode);
			default: return null;
			}
		} return null;
	}
	
	/* 난이도별 퀘스트 조회 */
	@Override
	public List<UserQuest> selectQstDifficulty(int usrCode, int difficulty) {
		return userQuestMap.selectQstDifficulty(usrCode, difficulty);
	}
	
	/* user 클래스명 검색   */
	@Override
	public List<UserQuest> selectQstClsName(UserQuest userQuest) {
	return userQuestMap.selectQstClsName(userQuest);
	}
	
}