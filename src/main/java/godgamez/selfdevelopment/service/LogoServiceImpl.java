package godgamez.selfdevelopment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import godgamez.selfdevelopment.dao.LogoDao;
import godgamez.selfdevelopment.domain.Logo;

@Service
public class LogoServiceImpl implements LogoService{
	@Autowired private LogoDao logoDao;

	@Override
	public List<Logo> getLogos() {
		return logoDao.selectLogos();
	}

	@Override
	public Logo getLogo(int logoId) {
		return logoDao.selectLogo(logoId);
	}

	@Override
	public boolean addLogo(Logo logo) {
		return logoDao.insertLogo(logo) > 0;
	}

	@Override
	public boolean fixLogo(Logo logo) {
		return logoDao.updateLogo(logo) > 0;
	}

	@Override
	public boolean delLogo(int logoId) {
		return logoDao.deleteLogo(logoId) > 0;
	}
}