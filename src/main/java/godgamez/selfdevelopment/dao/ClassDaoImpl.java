package godgamez.selfdevelopment.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import godgamez.selfdevelopment.dao.map.ClassMap;
import godgamez.selfdevelopment.domain.Class;

@Repository
public class ClassDaoImpl implements ClassDao {
	@Autowired private ClassMap classMap;
	public List<Class> selectClasses() {
		return classMap.selectClasses();
	}
	public List<Class> selectInUseCls(int clsId) {
		return classMap.selectInUseCls(clsId);
	}
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
	public int insertClass(Class cls) {
		return classMap.insertClass(cls);
	}
	public int deleteClass(int clsId) {
		return classMap.deleteClass(clsId);
	}
}