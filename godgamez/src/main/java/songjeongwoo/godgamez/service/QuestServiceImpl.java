package songjeongwoo.godgamez.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import songjeongwoo.godgamez.dao.QuestDao;
import songjeongwoo.godgamez.dao.UserQuestDao;
//import songjeongwoo.godgamez.dao.UserQuestDao;
import songjeongwoo.godgamez.domain.Quest;
import songjeongwoo.godgamez.domain.UserQuest;

@Service
public class QuestServiceImpl implements QuestService{
	@Autowired private QuestDao questDao;
	@Autowired private UserQuestDao userQuestDao;
	
	/* 유저별 전체/운동/공부탭 별 퀘스트 목록 조회 */
	@Override
	public List<UserQuest> getQstsForUsr(String qstCtg, int usrCode) {
		return userQuestDao.selectQstsForUsr(qstCtg, usrCode);
	}
	
	/* 난이도별 퀘스트 조회 */
	@Override
	public List<UserQuest> srchQstDifficulty(int usrCode, int difficulty) {
		return userQuestDao.selectQstDifficulty(usrCode, difficulty);
	}
	
	/* user 클래스명 검색 */
	@Override
	public List<UserQuest> srchQstClsName(UserQuest userQuest) {
		return userQuestDao.selectQstClsName(userQuest);
	}
	/*
	@Override
	public boolean acptQst(UserQuest userQuest) {
		return userQuestDao.addUsrQst(userQuest) > 0;
	}
	@Override
	public UserQuest chckAcptdQst(UserQuest userQuest) {
		return userQuestDao.selectUserQst(userQuest);
	}
	@Override
	public boolean abandonQst(UserQuest userQuest) {
		return userQuestDao.deleteUserQst(userQuest) > 0;
	}
	*/
	
	//admin
	@Override
	public List<Quest> getQuests() {
		return questDao.selectQuests();
	}
	
	@Override
	public List<Quest> getStdQuests() {
		return questDao.selectStdQuests();
	}
	
	@Override
	public List<Quest> getExcQuests() {
		return questDao.selectExcQuests();
	}
	
	@Override
	public List<Quest> srchQstName(Map<String, String> qstName) {
		return questDao.selectQstName(qstName);
	}
	
	@Override
	public boolean addQuest(Quest quest) {
		return questDao.insertQuest(quest) > 0;
	}
	
	@Override
	public Integer getQstId() {
		return questDao.selectQstId();
	}
	
	@Override
	public Quest getQuest(int qstId) {
		return questDao.selectQuest(qstId);
	}
	
	@Override
	public boolean fixQuest(Quest quest) {
		return questDao.updateQuest(quest) > 0;
	}
	
	@Override
	public boolean delQuest(int qstId) {
		return questDao.deleteQuest(qstId) > 0;
	}
	
	/*
	@Override
	public List<UserQuest> getAcptdQstCnt(int qstId) {
		return userQuestDao.selectAcptdQstCnt(qstId);
	}
	
	@Override
	public boolean finishUserQuest(UserQuest userQuest) {
		return userQuestDao.doUserQuest(userQuest) > 0;
	}
	
	@Override
	public boolean deleteUserQuestHandInImg(UserQuest userQuest) {
		return userQuestDao.updateUserQuestHandInImg(userQuest) > 0;
	}
	
	*/
}