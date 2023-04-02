package godgamez.selfdevelopment.dao;

import java.util.List;
import java.util.Map;

import godgamez.selfdevelopment.domain.Quest;

public interface QuestDao {
	List<Quest> selectQuests();
	List<Quest> selectStdQuests();
	List<Quest> selectExcQuests();
	List<Quest> selectQstName(Map<String, String> qstName);
	int insertQuest(Quest quest);
	Integer selectQstId();
	Quest selectQuest(int qstId);
	int updateQuest(Quest quest);
	int deleteQuest(int qstId);
}
