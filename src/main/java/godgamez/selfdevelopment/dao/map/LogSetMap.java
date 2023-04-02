package godgamez.selfdevelopment.dao.map;

import godgamez.selfdevelopment.domain.LogSet;

public interface LogSetMap {
	LogSet selectLogSet(int logSetId);
	int updateLogSet(LogSet logset);	
}