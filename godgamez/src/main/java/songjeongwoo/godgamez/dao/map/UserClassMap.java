package songjeongwoo.godgamez.dao.map;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import songjeongwoo.godgamez.domain.Class;
import songjeongwoo.godgamez.domain.UserClass;

public interface UserClassMap {
	int insertUserClass(@Param("usrCode")int usrCode, @Param("clsId")int clsId);
	List<UserClass> selectUserClasses(int usrCode);
	
	List<Class> selectClassesForUser(int usrCode);
	int deleteUserClassForUnreg(@Param("usrCode")int userCode);
	int deleteUserClass(@Param("usrCode")int userCode, @Param("clsId")int classId);
	/*
		
	List<Class> searchClassByMainForUser(int usrCode, String mainCtg);
	List<Class> searchClassBySubForUser(int usrCode, String subCtg);
	List<Class> searchClassByNameForUser(int usrCode, String clsName);
	*/
}