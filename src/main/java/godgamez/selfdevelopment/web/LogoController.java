package godgamez.selfdevelopment.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import godgamez.selfdevelopment.domain.Logo;
import godgamez.selfdevelopment.service.LogoService;

@RestController
@RequestMapping
public class LogoController {
	@Autowired private LogoService logoService; 
	
	@GetMapping("/logo/list")
	public List<Logo> getLogos() {
		return logoService.getLogos(); 
	}
	
	@GetMapping("/logo/list/{logoId}")
	public Logo getPost(@PathVariable int logoId) {
		return logoService.getLogo(logoId); 
	}
	
	@PostMapping("/logo/add") 
	public boolean addLogo(@RequestBody Logo logo) {
		return logoService.addLogo(logo);
	}
	
	@PutMapping("/logo/fix")
	public boolean fixLogo(@RequestBody Logo logo) {
		return logoService.fixLogo(logo);
	}
	
	@DeleteMapping("/logo/del/{logoId}")
	public boolean delLogo(@PathVariable int logoId) {
		return logoService.delLogo(logoId);
	}
}