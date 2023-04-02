package godgamez.selfdevelopment.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import godgamez.selfdevelopment.dao.LogSetDao;
import godgamez.selfdevelopment.domain.LogSet;

@Service
public class LogSetServiceImpl implements LogSetService{
	@Autowired private LogSetDao logSetDao;

	@Override
	public LogSet getLogSet(int logSetId) {
		return logSetDao.selectLogSet(logSetId);
	}

	@Override
	public boolean fixLogSet(LogSet logSet) {
		return logSetDao.updateLogSet(logSet) > 0;
	}
}