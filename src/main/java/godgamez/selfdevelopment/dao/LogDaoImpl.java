package godgamez.selfdevelopment.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import godgamez.selfdevelopment.dao.map.LogMap;
import godgamez.selfdevelopment.domain.Log;

@Repository
public class LogDaoImpl implements LogDao{
	@Autowired private LogMap logMap;
	
	public List<Log> selectLogs() {
		return logMap.selectLogs();
	}
	
} 