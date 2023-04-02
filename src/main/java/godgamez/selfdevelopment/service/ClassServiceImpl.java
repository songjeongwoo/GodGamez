package godgamez.selfdevelopment.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import godgamez.selfdevelopment.dao.ClassDao;
import godgamez.selfdevelopment.domain.Class;

@Service
public class ClassServiceImpl implements ClassService {
	@Autowired private ClassDao classDao;
	@Override
	public List<Class> getClasses() {
		return classDao.selectClasses();
	}
	@Override
	public List<Class> getInUseCls(int clsId) {
		return classDao.selectInUseCls(clsId);
	}
	@Override	
	public List<Class> findClasses(Map<String, String> searchMap) {
		return classDao.searchClss(searchMap);
	}
	@Override
	public boolean addClass(Class cls) {
		return classDao.insertClass(cls) > 0;
	}
	@Override
	public boolean delClass(int clsId) {
		return classDao.deleteClass(clsId) > 0;
	}
}