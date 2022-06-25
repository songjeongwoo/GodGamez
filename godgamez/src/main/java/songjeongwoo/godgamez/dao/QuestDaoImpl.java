package songjeongwoo.godgamez.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import songjeongwoo.godgamez.dao.map.QuestMap;
import songjeongwoo.godgamez.domain.Quest;

@Repository
public class QuestDaoImpl implements QuestDao {
	@Autowired private QuestMap questMap;
	@Override
	public List<Quest> selectQuests() {
		return questMap.selectQuests();
	}
	@Override
	public List<Quest> selectStdQuests() {
		return questMap.selectStdQuests();
	}
	@Override
	public List<Quest> selectExcQuests() {
		return questMap.selectExcQuests();
	}
	@Override
	public List<Quest> selectQstName(Map<String, String> qstName) {
		return questMap.selectQstName(qstName);
	}
	@Override
	public int insertQuest(Quest quest) {
		return questMap.insertQuest(quest);
	}
	@Override
	public Integer selectQstId() {
		return questMap.selectQstId();
	}
	@Override
	public Quest selectQuest(int qstId) {
		return questMap.selectQuest(qstId);
	}
	@Override
	public int updateQuest(Quest quest) {
		return questMap.updateQuest(quest);
	}
	@Override
	public int deleteQuest(int qstId) {
		return questMap.deleteQuest(qstId);
	}
}
