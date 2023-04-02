package godgamez.selfdevelopment.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import godgamez.selfdevelopment.domain.Log;
import godgamez.selfdevelopment.service.LogService;

@RestController
@RequestMapping
public class LogController {
	@Autowired private LogService logService;
	
	@GetMapping("/log/list")
	public List<Log> getLogs() {
		return logService.getLogs(); 
	}
}