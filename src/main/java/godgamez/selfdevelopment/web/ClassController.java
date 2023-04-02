package godgamez.selfdevelopment.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import godgamez.selfdevelopment.domain.Class;
import godgamez.selfdevelopment.service.ClassService;

@RestController
@RequestMapping
public class ClassController {
	@Autowired private ClassService classService;
	//클래스 목록 조회
	@GetMapping("/class/list")
	public List<Class> getClasses() {
		return classService.getClasses();
	}
	//클래스 - 사용퀘스트
	@GetMapping("/class/getInUseCls")
	public List<Class> getInUseCls(int clsId) {
		return classService.getInUseCls(clsId);
	}
	//공부 클래스 조회
	@GetMapping("/class/list/study")
	public List<Class> getStdClasses() {
		Map<String, String> map = new HashMap<>();
		map.put("mainCtg", "공부");
		return classService.findClasses(map);
	}
	//운동 클래스 조회 
	@GetMapping("/class/list/exercise")
	public List<Class> getExcClasses() {
		Map<String, String> map = new HashMap<>();
		map.put("mainCtg", "운동");
		return classService.findClasses(map);
	}
	// 클래스 검색 - crudQuest.jsp에서 씀
	@PostMapping("/class/search")
	public List<Class> searchCls(@RequestBody Map<String, String> searchMap) {
		return classService.findClasses(searchMap);
	}
	//클래스 추가
	@PostMapping("/class/add")
	public boolean addClass(@RequestBody Class cls) {
		return classService.addClass(cls);
	}
	//클래스 삭제
	@DeleteMapping("/class/del/{clsId}")
	public boolean delClass(@PathVariable int clsId) {
		return classService.delClass(clsId);
	}
}