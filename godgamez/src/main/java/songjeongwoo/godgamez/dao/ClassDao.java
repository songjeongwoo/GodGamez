package songjeongwoo.godgamez.dao;

import java.util.List;
import java.util.Map;

import songjeongwoo.godgamez.domain.Class;

public interface ClassDao {
	List<Class> selectClasses();
//	List<Class> selectInUseCls(int clsId);
	List<Class> searchClss(Map<String, String> searchMap);
	int insertClass(Class cls);
	int deleteClass(int clsId);
}