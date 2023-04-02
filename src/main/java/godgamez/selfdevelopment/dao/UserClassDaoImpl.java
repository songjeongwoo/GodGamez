package godgamez.selfdevelopment.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import godgamez.selfdevelopment.dao.map.UserClassMap;
import godgamez.selfdevelopment.domain.Class;
import godgamez.selfdevelopment.domain.UserClass;

@Repository
public class UserClassDaoImpl implements UserClassDao {
	@Autowired private UserClassMap userClassMap;
	
	public List<UserClass> selectUsrClsList(int usrCode) {
		return userClassMap.selectUserClasses(usrCode);
	}

	public int insertUserClass(int usrCode, int clsId) {
		return userClassMap.insertUserClass(usrCode, clsId);
	}
	
	public int deleteUserClass(int usrCode, int clsId) {
		return userClassMap.deleteUserClass(usrCode, clsId);
	}
	
	public int deleteUserClassForUnreg(int usrCode) {
		return userClassMap.deleteUserClassForUnreg(usrCode);
	}
	
	public List<Class> selectClassesForUser(int usrCode) {
		return userClassMap.selectClassesForUser(usrCode);
	}
	
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
}