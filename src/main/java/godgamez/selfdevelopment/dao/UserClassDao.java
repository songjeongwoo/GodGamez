package godgamez.selfdevelopment.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import godgamez.selfdevelopment.domain.Class;
import godgamez.selfdevelopment.domain.UserClass;

public interface UserClassDao {
	List<UserClass> selectUsrClsList(int usrCode);
	int insertUserClass(int usrCode, int clsId);
	int deleteUserClass(int usrCode, int clsId);	 	
	int deleteUserClassForUnreg(@Param("usrCode")int userCode);
	
	List<Class> selectClassesForUser(int usrCode);
	List<Class> searchClassesForUser(Map<String, String> searchMap);
}