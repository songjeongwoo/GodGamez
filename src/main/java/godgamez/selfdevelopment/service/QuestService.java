package godgamez.selfdevelopment.service;

import java.util.List;
import java.util.Map;

import godgamez.selfdevelopment.domain.Quest;
import godgamez.selfdevelopment.domain.UserQuest;

public interface QuestService {
	List<UserQuest> getQstsForUsr(int usrCode);
	List<UserQuest> getExcQstsForUsr(int usrCode);
	List<UserQuest> getStdQstsForUsr(int usrCode);
	List<UserQuest> srchQstDifficulty(UserQuest userQuest);
	List<UserQuest> srchQstClsName(UserQuest userQuest);
	boolean acptQst(UserQuest userQuest);
	UserQuest chckAcptdQst(UserQuest userQuest);
	boolean abandonQst(UserQuest userQuest);
	
	List<Quest> getQuests();
	List<Quest> getStdQuests();
	List<Quest> getExcQuests();
	List<Quest> srchQstName(Map<String, String> qstName);
	boolean addQuest(Quest quest);
	Integer getQstId();
	Quest getQuest(int qstId);
	boolean fixQuest(Quest quest);
	boolean delQuest(int qstId);
	List<UserQuest> getAcptdQstCnt(int qstId);
	boolean finishUserQuest(UserQuest userQuest);
	boolean deleteUserQuestHandInImg(UserQuest userQuest);
}
