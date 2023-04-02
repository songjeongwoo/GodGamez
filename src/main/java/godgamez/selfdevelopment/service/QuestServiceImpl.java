package godgamez.selfdevelopment.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import godgamez.selfdevelopment.dao.QuestDao;
import godgamez.selfdevelopment.dao.UserQuestDao;
import godgamez.selfdevelopment.domain.Quest;
import godgamez.selfdevelopment.domain.UserQuest;

@Service
public class QuestServiceImpl implements QuestService{
	@Autowired private QuestDao questDao;
	@Autowired private UserQuestDao userQuestDao;
	@Override
	public List<UserQuest> getQstsForUsr(int usrCode) {
		return userQuestDao.selectQstsForUsr(usrCode);
	}
	@Override
	public List<UserQuest> getExcQstsForUsr(int usrCode) {
		return userQuestDao.selectExcQstsForUsr(usrCode);
	}
	@Override
	public List<UserQuest> getStdQstsForUsr(int usrCode) {
		return userQuestDao.selectStdQstsForUsr(usrCode);
	}
	@Override
	public List<UserQuest> srchQstDifficulty(UserQuest userQuest) {
		return userQuestDao.selectQstDifficulty(userQuest);
	}
	@Override
	public List<UserQuest> srchQstClsName(UserQuest userQuest) {
		return userQuestDao.selectQstClsName(userQuest);
	}
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
}