package godgamez.selfdevelopment.service;

import java.util.List;

import godgamez.selfdevelopment.domain.Logo;

public interface LogoService {
	List<Logo> getLogos();
	Logo getLogo(int logoId);
	
	boolean addLogo(Logo logo);
	boolean fixLogo(Logo logo);
	boolean delLogo(int logoId);
}