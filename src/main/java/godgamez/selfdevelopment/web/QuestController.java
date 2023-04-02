package godgamez.selfdevelopment.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import godgamez.selfdevelopment.domain.Quest;
import godgamez.selfdevelopment.domain.UserQuest;
import godgamez.selfdevelopment.service.QuestService;

@RestController
@RequestMapping
public class QuestController {
	@Autowired private QuestService questService;
	
	//user 퀘스트 리스트
	@GetMapping("/quest/qstsForUsr")
	public List<UserQuest> getQstsForUsr(int usrCode) {
		return questService.getQstsForUsr(usrCode);
	}
	//user quest 운동탭
	@GetMapping("/quest/usrExcQstList")
	public List<UserQuest> getExcQstsForUsr(int usrCode) {
		return questService.getExcQstsForUsr(usrCode);
	}
	//user quest 공부탭
	@GetMapping("/quest/usrStdQstList")
	public List<UserQuest> getStdQstsForUsr(int usrCode) {
		return questService.getStdQstsForUsr(usrCode);
	}
	//난이도별 퀘스트 조회
	@PostMapping("/quest/difficulty")
	public List<UserQuest> srchQstDifficulty(@RequestBody UserQuest userQuest) {
		return questService.srchQstDifficulty(userQuest);
	}
	//user 클래스명 검색
	@PostMapping("/quest/clsName")
	public List<UserQuest> srchQstClsName(@RequestBody UserQuest userQuest) {
		return questService.srchQstClsName(userQuest);
	}
	//user 퀘스트 수락
	@PostMapping("/quest/addUsrQst")
	public boolean acptQst(@RequestBody UserQuest userQuest) {
			return questService.acptQst(userQuest);
	}
	//수락한 퀘스트 체크
	@PostMapping("/quest/chckAcptdQst")
	public UserQuest chckAcptdQst(@RequestBody UserQuest userQuest) {
		return questService.chckAcptdQst(userQuest);
	}
	//퀘스트 포기
	@DeleteMapping("/quest/abandonQst")
	public boolean abandonQst(@RequestBody UserQuest userQuest) {
		return questService.abandonQst(userQuest);
	}
	
	//admin 전체 퀘스트 목록
	@GetMapping("/quest/list")
	public List<Quest> getQuests() {
		return questService.getQuests();
	}
	//admin 공부 퀘스트 목록
	@GetMapping("quest/admin/study")
	public List<Quest> getStdQuests() {
		return questService.getStdQuests();
	}
	//admin 운동 퀘스트 목록
	@GetMapping("quest/admin/exercise")
	public List<Quest> getExcQuests() {
		return questService.getExcQuests();
	}
	//admin 퀘스트명 검색 - 전체
	@PostMapping("/quest/admin/srchQstName")
	public List<Quest> srchQstName(@RequestBody Map<String, String> qstName) {
		return questService.srchQstName(qstName);
	}
	//퀘스트 추가
	@PostMapping("/quest/add")
	public boolean addQuest(@RequestBody Quest quest) {
		return questService.addQuest(quest);
	}
	//퀘스트 추가 - qstId
	@GetMapping("/quest/qstId")
	public Integer getQstId() {
		return questService.getQstId();
	}
	//퀘스트 상세 조회 - user, admin
	@GetMapping("/quest/list/{qstId}")
	public Quest getQuest(@PathVariable int qstId) {
		return questService.getQuest(qstId);
	}
	//퀘스트 수정
	@PutMapping("/quest/fix")
	public boolean fixQuest(@RequestBody Quest quest) {
		return questService.fixQuest(quest);
	}
	//퀘스트 관리자 삭제
	@DeleteMapping("/quest/del/{qstId}")
	public boolean delQuest(@PathVariable int qstId) {
		return questService.delQuest(qstId);
	}
	//퀘스트 조회 - 수행 중
	@GetMapping("/quest/userQuest/ActpdQstCnt")
	public List<UserQuest> getAcptdQstCnt(int qstId) {
		return questService.getAcptdQstCnt(qstId);
	}
	//회원퀘스트(수행 중) - 완료버튼 클릭 시
	@PutMapping("/quest/userQuest/finishUserQuest")
	public boolean finishUserQuest(@RequestBody UserQuest userQuest) {
		return questService.finishUserQuest(userQuest);
	}
	//회원퀘스트(수행 완료) - 사진삭제 버튼 클릭 시 
	@PutMapping("/quest/userQuest/deleteUserQuestHandInImg")
	public boolean deleteUserQuestHandInImg(@RequestBody UserQuest userQuest) {
		return questService.deleteUserQuestHandInImg(userQuest);
	}
}