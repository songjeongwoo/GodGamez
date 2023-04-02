package godgamez.selfdevelopment.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import godgamez.selfdevelopment.domain.LogSet;
import godgamez.selfdevelopment.service.LogSetService;

@RestController
@RequestMapping
public class LogSetController {
	@Autowired private LogSetService logSetService; 
	
	@GetMapping("/logSet/list/{logSetId}")
	public LogSet getPost(@PathVariable int logSetId) {
		return logSetService.getLogSet(logSetId); 
	}
	
	@PutMapping("/logSet/fix")
	public boolean fixLogSet(@RequestBody LogSet logSet) {
		return logSetService.fixLogSet(logSet);
	}
}