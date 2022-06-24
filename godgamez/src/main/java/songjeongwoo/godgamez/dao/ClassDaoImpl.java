package songjeongwoo.godgamez.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import songjeongwoo.godgamez.dao.map.ClassMap;
import songjeongwoo.godgamez.domain.Class;

@Repository
public class ClassDaoImpl implements ClassDao {
	@Autowired private ClassMap classMap;
	@Override
	public List<Class> selectClasses() {
		return classMap.selectClasses();
	}
	
	/*
	@Override
	public List<Class> selectInUseCls(int clsId) {
		return classMap.selectInUseCls(clsId);
	}
	*/
	
	@Override
	public List<Class> searchClss(Map<String, String> searchMap) {
		String mainCtg = searchMap.get("mainCtg");
		String subCtg = searchMap.get("subCtg");
		String clsName = searchMap.get("clsName");
		
		if(mainCtg != null && !mainCtg.isEmpty() && !mainCtg.equals("")) {
			return classMap.searchClassByMain(mainCtg);
		} else if(subCtg != null && !subCtg.isEmpty() && !subCtg.equals("")) {
			return classMap.searchClassBySub(subCtg);
		} else if(clsName != null && !clsName.isEmpty() && !clsName.equals("")) {
			return classMap.searchClassByName(clsName);
		} else return null;
	}
	
	@Override
	public int insertClass(Class cls) {
		return classMap.insertClass(cls);
	}
	
	@Override
	public int deleteClass(int clsId) {
		return classMap.deleteClass(clsId);
	}
}