package godgamez.selfdevelopment.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import godgamez.selfdevelopment.dao.map.LogoMap;
import godgamez.selfdevelopment.domain.Logo;

@Repository
public class LogoDaoImpl implements LogoDao {
	@Autowired private LogoMap logoMap;

	public List<Logo> selectLogos() {
		return logoMap.selectLogos();
	}

	public Logo selectLogo(int logoId) {
		return logoMap.selectLogo(logoId);
	}

	public int insertLogo(Logo logo) {
		return logoMap.insertLogo(logo);
	}

	public int updateLogo(Logo logo) {
		return logoMap.updateLogo(logo);
	}

	public int deleteLogo(int logoId) {
		return logoMap.deleteLogo(logoId);
	}
}