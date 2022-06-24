package songjeongwoo.godgamez.service;

import java.util.List;
import java.util.Map;

import songjeongwoo.godgamez.domain.Class;

public interface ClassService {
	List<Class> getClasses();
//	List<Class> getInUseCls(int clsId);
	List<Class> findClasses(Map<String, String> searchMap);
	boolean addClass(Class cls);
	boolean delClass(int clsId);
}