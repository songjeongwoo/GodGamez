package songjeongwoo.godgamez.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import songjeongwoo.godgamez.dao.map.UserClassMap;
import songjeongwoo.godgamez.domain.Class;
import songjeongwoo.godgamez.domain.UserClass;

@Repository
public class UserClassDaoImpl implements UserClassDao {
	@Autowired private UserClassMap userClassMap;
	
	@Override
	public int insertUserClass(int usrCode, int clsId) {
		return userClassMap.insertUserClass(usrCode, clsId);
	}
	
	@Override
	public List<UserClass> selectUsrClsList(int usrCode) {
		return userClassMap.selectUserClasses(usrCode);
	}
	
	@Override
	public List<Class> selectClassesForUser(int usrCode) {
		return userClassMap.selectClassesForUser(usrCode);
	}
	
	@Override
	public int deleteUserClassForUnreg(int usrCode) {
		return userClassMap.deleteUserClassForUnreg(usrCode);
	}
	
	@Override
	public int deleteUserClass(int usrCode, int clsId) {
		return userClassMap.deleteUserClass(usrCode, clsId);
	}
	
	/*
		
	@Override
	public List<Class> searchClassesForUser(Map<String, String> searchMap) {
		int usrCode = Integer.parseInt(searchMap.get("userCode"));
		String mainCtg = searchMap.get("mainCtg");
		String subCtg = searchMap.get("subCtg");
		String clsName = searchMap.get("clsName");
		
		if(mainCtg != null && !mainCtg.isEmpty() && !mainCtg.equals("")) {
			return userClassMap.searchClassByMainForUser(usrCode, mainCtg);
		} else if(subCtg != null && !subCtg.isEmpty() && !subCtg.equals("")) {
			return userClassMap.searchClassBySubForUser(usrCode, subCtg);
		} else if(clsName != null && !clsName.isEmpty() && !clsName.equals("")) {
			return userClassMap.searchClassByNameForUser(usrCode, clsName);
		} else return null;
	}
	*/
}