package songjeongwoo.godgamez.service;

import java.util.List;
import java.util.Map;

import songjeongwoo.godgamez.domain.Quest;
//import songjeongwoo.godgamez.domain.UserQuest;
import songjeongwoo.godgamez.domain.UserQuest;

public interface QuestService {
	/*
	List<UserQuest> srchQstDifficulty(UserQuest userQuest);
	List<UserQuest> srchQstClsName(UserQuest userQuest);
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
	/*
	List<UserQuest> getAcptdQstCnt(int qstId);
	boolean finishUserQuest(UserQuest userQuest);
	boolean deleteUserQuestHandInImg(UserQuest userQuest);
	*/
}
