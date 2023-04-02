package godgamez.selfdevelopment.dao;

import java.util.List;

import godgamez.selfdevelopment.domain.Logo;

public interface LogoDao {
	List<Logo> selectLogos();
	Logo selectLogo(int logoId);
	
	int insertLogo(Logo logo);
	int updateLogo(Logo logo);	
	int deleteLogo(int logoId);
}