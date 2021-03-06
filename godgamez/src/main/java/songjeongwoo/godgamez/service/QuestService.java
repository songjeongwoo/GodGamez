package songjeongwoo.godgamez.service;

import java.util.List;
import java.util.Map;

import songjeongwoo.godgamez.domain.Quest;
//import songjeongwoo.godgamez.domain.UserQuest;
import songjeongwoo.godgamez.domain.UserQuest;

public interface QuestService {
	/*
	boolean acptQst(UserQuest userQuest);
	UserQuest chckAcptdQst(UserQuest userQuest);
	boolean abandonQst(UserQuest userQuest);
	*/
	
	List<Quest> getQuests();
	List<Quest> getStdQuests();
	List<Quest> getExcQuests();
	List<Quest> srchQstName(Map<String, String> qstName);
	boolean addQuest(Quest quest);
	Integer getQstId();
	Quest getQuest(int qstId);
	boolean fixQuest(Quest quest);
	boolean delQuest(int qstId);
	
	/* 유저별 전체/운동/공부탭 별 퀘스트 목록 조회 */
	List<UserQuest> getQstsForUsr(String qstCtg, int usrCode);
	/* 난이도별 퀘스트 조회 */
	List<UserQuest> srchQstDifficulty(int usrCode, int difficulty);
	/* user 클래스명 검색 */
	List<UserQuest> srchQstClsName(UserQuest userQuest);
	/*
	List<UserQuest> getAcptdQstCnt(int qstId);
	boolean finishUserQuest(UserQuest userQuest);
	boolean deleteUserQuestHandInImg(UserQuest userQuest);
	*/
}
