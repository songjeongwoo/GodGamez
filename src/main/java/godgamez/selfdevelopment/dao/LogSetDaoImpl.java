package godgamez.selfdevelopment.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import godgamez.selfdevelopment.dao.map.LogSetMap;
import godgamez.selfdevelopment.domain.LogSet;

@Repository
public class LogSetDaoImpl implements LogSetDao {
	@Autowired private LogSetMap logSetMap;

	public LogSet selectLogSet(int logSetId) {
		return logSetMap.selectLogSet(logSetId);
	}

	public int updateLogSet(LogSet logSet) {
		return logSetMap.updateLogSet(logSet);
	}
}