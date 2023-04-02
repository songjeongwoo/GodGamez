package godgamez.selfdevelopment.dao.map;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import godgamez.selfdevelopment.domain.Class;
import godgamez.selfdevelopment.domain.UserClass;

public interface UserClassMap {
	List<UserClass> selectUserClasses(int usrCode);
	int insertUserClass(@Param("usrCode")int usrCode, @Param("clsId")int clsId);
	int deleteUserClass(@Param("usrCode")int userCode, @Param("clsId")int classId);
	int deleteUserClassForUnreg(@Param("usrCode")int userCode);
	
	List<Class> selectClassesForUser(int usrCode);
	List<Class> searchClassByMainForUser(int usrCode, String mainCtg);
	List<Class> searchClassBySubForUser(int usrCode, String subCtg);
	List<Class> searchClassByNameForUser(int usrCode, String clsName);
}