package godgamez.selfdevelopment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import godgamez.selfdevelopment.dao.LogDao;
import godgamez.selfdevelopment.domain.Log;

@Service
public class LogServiceImpl implements LogService{
	@Autowired private LogDao logDao;

	@Override
	public List<Log> getLogs() {
		return logDao.selectLogs();
	}
} 