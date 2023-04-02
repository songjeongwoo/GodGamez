package godgamez.selfdevelopment.dao;

import java.util.List;

import godgamez.selfdevelopment.domain.Log;

public interface LogDao {
	List<Log> selectLogs();
} 