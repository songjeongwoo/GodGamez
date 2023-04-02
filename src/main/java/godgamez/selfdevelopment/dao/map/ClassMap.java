package godgamez.selfdevelopment.dao.map;

import java.util.List;

import godgamez.selfdevelopment.domain.Class;

public interface ClassMap {
	List<Class> selectClasses();
	List<Class> selectInUseCls(int clsId);
	List<Class> searchClassByMain(String mainCtg);
	List<Class> searchClassBySub(String subCtg);
	List<Class> searchClassByName(String clsName);
	int insertClass(Class cls);
	int deleteClass(int clsId);
}