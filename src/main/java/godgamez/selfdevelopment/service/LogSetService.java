package godgamez.selfdevelopment.service;

import godgamez.selfdevelopment.domain.LogSet;

public interface LogSetService {
	LogSet getLogSet(int logSetId);
	
	boolean fixLogSet(LogSet logSet);
}