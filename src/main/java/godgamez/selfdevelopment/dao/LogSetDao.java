package godgamez.selfdevelopment.dao;

import godgamez.selfdevelopment.domain.LogSet;

public interface LogSetDao {
	LogSet selectLogSet(int logSetId);
	int updateLogSet(LogSet logSet);
}