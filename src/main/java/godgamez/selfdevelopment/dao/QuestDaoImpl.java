package godgamez.selfdevelopment.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import godgamez.selfdevelopment.dao.map.QuestMap;
import godgamez.selfdevelopment.domain.Quest;

@Repository
public class QuestDaoImpl implements QuestDao {
	@Autowired private QuestMap questMap;
	public List<Quest> selectQuests() {
		return questMap.selectQuests();
	}
	public List<Quest> selectStdQuests() {
		return questMap.selectStdQuests();
	}
	public List<Quest> selectExcQuests() {
		return questMap.selectExcQuests();
	}
	public List<Quest> selectQstName(Map<String, String> qstName) {
		return questMap.selectQstName(qstName);
	}
	public int insertQuest(Quest quest) {
		return questMap.insertQuest(quest);
	}
	public Integer selectQstId() {
		return questMap.selectQstId();
	}
	public Quest selectQuest(int qstId) {
		return questMap.selectQuest(qstId);
	}
	public int updateQuest(Quest quest) {
		return questMap.updateQuest(quest);
	}
	public int deleteQuest(int qstId) {
		return questMap.deleteQuest(qstId);
	}
}
