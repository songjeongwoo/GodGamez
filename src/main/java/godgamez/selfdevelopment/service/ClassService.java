package godgamez.selfdevelopment.service;

import java.util.List;
import java.util.Map;

import godgamez.selfdevelopment.domain.Class;

public interface ClassService {
	List<Class> getClasses();
	List<Class> getInUseCls(int clsId);
	List<Class> findClasses(Map<String, String> searchMap);
	boolean addClass(Class cls);
	boolean delClass(int clsId);
}