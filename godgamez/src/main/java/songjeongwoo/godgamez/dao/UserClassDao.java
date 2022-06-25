package songjeongwoo.godgamez.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import songjeongwoo.godgamez.domain.Class;
import songjeongwoo.godgamez.domain.UserClass;

public interface UserClassDao {
	int insertUserClass(int usrCode, int clsId);
	List<UserClass> selectUsrClsList(int usrCode);
	
	List<Class> selectClassesForUser(int usrCode);
	int deleteUserClassForUnreg(@Param("usrCode")int userCode);
	int deleteUserClass(int usrCode, int clsId);
	
	/*
		
	List<Class> searchClassesForUser(Map<String, String> searchMap);
	*/
}