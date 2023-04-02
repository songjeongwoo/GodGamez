package godgamez.selfdevelopment.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import godgamez.selfdevelopment.domain.Class;
import godgamez.selfdevelopment.domain.Coupon;
import godgamez.selfdevelopment.domain.User;
import godgamez.selfdevelopment.domain.UserClass;
import godgamez.selfdevelopment.domain.UserQuest;
import godgamez.selfdevelopment.service.CouponService;
import godgamez.selfdevelopment.service.UserService;

@RestController
@RequestMapping
public class UserController {
	@Autowired private UserService userService;
	@Autowired private CouponService couponService;
	
	/* 로그인한 유저정보 */
	@GetMapping("/isLogined")
	public User loginUsr(HttpSession session) {
		User user = (User)session.getAttribute("user");
		return user;
	}
	
	/* 로그인 */
	@PostMapping("/user/loginProc")
	public int login(@RequestBody Map<String, String> loginMap, HttpSession session) throws Exception {
		int result = 0;
		
		try {
			User user = userService.loginCheck(loginMap);
			if(user != null) {
				session.setAttribute("user", user);
				session.setMaxInactiveInterval(-1);
				
				if(user.getPosition().equals("NOOB") || user.getPosition().equals("PLAYER")) return 1;
				else if(user.getPosition().equals("GM")) return 2;
			} else return 0;
		} catch(Exception e) {
			return 0;
		}
		return result;
	}
	
	/* 로그아웃 */
	@GetMapping("/user/logout")
	public ModelAndView logout(ModelAndView mv, HttpSession session) {
		session.invalidate();
		mv.setViewName("main");
		return mv;
	}
	
	/* 임시 비밀번호 발급 */
	@Transactional
	@PutMapping("/make/tmpPw")
	public String makeTmpPw(@RequestBody User user, HttpServletResponse response, HttpSession session) {
		String tmpPw = "";
		String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789,./~!@#$%^&*()_+-=<>?:{}";
		for(int i = 0; i < 9; i++) tmpPw += str.charAt((int)Math.floor(Math.random() * str.length()));
		user.setUsrPw(tmpPw);
		
		if(userService.fixUser(user)) return tmpPw;
		else return "";
	}
	
	/* 랭킹보드 */
	@GetMapping("/user/get/rankers")
	public List<User> getRankers() {
		return userService.getRankers();
	}
	
	/* 한정된 데이터로 유저 객체 소환 */
	@PostMapping("/user/get")
	public User getUser(@RequestBody Map<String, String> getMap) {
		User target = userService.getUser(getMap);
		return target;
	}
	
	/* 포지션별 회원 목록 조회 */
	@PostMapping("/user/listUsers")
	public List<User> getUsers(@RequestBody Map<String, String> positionMap) {
		return userService.getUsers(positionMap);
	}
	
	/* 이름, 별명, 아이디로 회원 목록 검색 */
	@PostMapping("/user/findUsers")
	public List<User> findUsers(@RequestBody Map<String, String> searchMap) {
		return userService.findUsers(searchMap);
	}
	
	/* 메일 인증 -> 등급 업 */
	@Transactional
	@PatchMapping("/user/verifyProc")
	public boolean bePlayer(HttpSession session, @RequestBody String authCode,
			@CookieValue(value="verificationCode", required=false) Cookie authCodeCookie, HttpServletResponse response) {
		boolean isVerified = false;
		User user = (User)(session.getAttribute("user"));
		if(user != null && authCodeCookie != null) {
			String answer = authCodeCookie.getValue();
			authCode = authCode.replaceAll("\"", "");
			
			if(authCode.equals(answer)) {
				user.setPosition("PLAYER");
				user.setUsrLv((float)1);
				isVerified = userService.patchUser(user);
			}
			if(isVerified) {
				Cookie cookie = new Cookie("verificationCode", null);
				cookie.setMaxAge(0);
				cookie.setPath("/");
				response.addCookie(cookie);
				session.setAttribute("user", user);
			}
		}
		return isVerified;
	}
	
	/* 관리자가 회원 등급 업 */
	@Transactional
	@PatchMapping("/user/bePlayer")
	public boolean usrPlayer(@RequestBody User user) {
		user.setPosition("PLAYER");
		return userService.patchUser(user);
	}
	
	/* 레벨업 & 골드 지급 시스템 */
	@Transactional
	@PatchMapping("/user/earnExpGold")
	public User getReward(HttpSession session, @RequestBody int difficulty) {
		User user = (User)(session.getAttribute("user"));
		
		float totLv = user.getUsrLv();
		int level = (int)Math.floor(totLv);
		float getExp = (level%difficulty * difficulty^3 * level) / (1/(float)difficulty * level*level);
		
		int gold = user.getGold();
		float earn = (float)(difficulty^3) * (level + difficulty) / ((1/(float)difficulty * level + level/(float)difficulty)*5);
		
		if((int)(totLv - level + getExp) > 0) earn += (totLv - level + getExp)*difficulty;
		
		user.setUsrLv(totLv + getExp);
		user.setGold(gold + (int)Math.floor(earn));
		
		if(userService.patchUser(user)) {
			session.setAttribute("user", user);
			return user;
		} else return null;
	}
	
	/* 골드 사용 */
	@Transactional
	@PatchMapping("/user/useGold")
	public boolean useGold(HttpSession session, @RequestBody int price) {
		User user = (User)(session.getAttribute("user"));
		
		int gold = user.getGold();
		user.setGold(gold - price);
		
		if(userService.patchUser(user)) {
			session.setAttribute("user", user);
			return true;
		} else return false;
	}
	
	/* 회원탈퇴 */
	@Transactional
	@PatchMapping("/user/quitProc")
	public boolean holdQuit(HttpSession session) {
		User user = (User)(session.getAttribute("user"));
		user.setPosition("OUT");
		
		if(userService.patchUser(user)) {
			session.invalidate();
			return true;
		} else return false;
	}
	
	/* 추가, 가입 */
	@Transactional
	@PostMapping("/user/add")
	public boolean addUser(@RequestBody User user) {
		return userService.addUser(user);
	}
	
	/* 회원정보변경 및 관리자 직접 수정 */
	@Transactional
	@PutMapping("/user/fix")
	public boolean fixUser(@RequestBody User user, HttpSession session) {
		if(userService.fixUser(user)) {
			session.setAttribute("user", user);
			return true;
		} else return false;
	}
	
	/* 회원 클래스 초기화 */
	@Transactional
	@DeleteMapping("/userclass/reset/{usrCode}")
	public int resetUserClasses(@PathVariable int usrCode) {
		if(userService.getClassesForUser(usrCode) != null) {
			if(userService.delUserClassForUnreg(usrCode)) return 2;
			else return 1;
		} else return 0;
	}
	
	/* 관리자 회원 삭제 */
	@Transactional
	@DeleteMapping("/user/del/{usrCode}")
	public Map<String, String> delUser(@PathVariable String usrCode) {
		int userCode = Integer.parseInt(usrCode);
		boolean rst = false;
		
		if(userService.getClassesForUser(userCode) != null && userService.getUsrQstListOfUsr(userCode) != null)
			rst = userService.delUserClassForUnreg(userCode) && userService.delUserQuestForUnreg(userCode) && userService.delUser(userCode);
		else if(userService.getClassesForUser(userCode) != null)
			rst = userService.delUserClassForUnreg(userCode) && userService.delUser(userCode);
		else if(userService.getUsrQstListOfUsr(userCode) != null)
			rst = userService.delUserQuestForUnreg(userCode) && userService.delUser(userCode);
		else rst = userService.delUser(userCode);
		
		Map<String, String> result = new HashMap<>();
		
		result.put("userCode", userCode + "");
		if(rst) result.put("isDone", "성공");
		else result.put("isDone", "실패");
		
		return result;
	}
	
	/* 유저퀘스트목록조회 */
	@GetMapping("/quest/userquest/list")
	public List<UserQuest> getUsrQsts() {
		return userService.getUsrQstList();
	}
	
	/* 특정유저퀘스트목록조회 */
	@PostMapping("/user/quest/list")
	public List<UserQuest> getUsrQstsOfUsr(@RequestBody String usrCode) {
		return userService.getUsrQstListOfUsr(Integer.parseInt(usrCode));
	}
	
	/* 유저퀘스트 제출이미지 삭제 */
	@PostMapping("/user/quest/del/img")
	public boolean getUsrQstsOfUsr(@RequestBody Map<String, String> delImgMap) {
		int usrCode = Integer.parseInt(delImgMap.get("usrCode"));
		int qstId = Integer.parseInt(delImgMap.get("qstId"));
		return userService.deleteUserQuestImg(usrCode, qstId);
	}
	
	/* 유저 쿠폰 목록 조회 */
	@GetMapping("/user/coupon/list/{usrCode}")
	public List<Coupon> getUsrCpns(@PathVariable int usrCode) {
		return couponService.getCouponsForUser(usrCode);
	}
	
	/* 유저 클래스 목록 조회 */
	@PostMapping("/user/class/list")
	public List<UserClass> getUsrClss(@RequestBody String userCode) {
		return userService.getUsrClsList(Integer.parseInt(userCode));
	}

	//유저에 따라 다르게 클래스 목록 조회
	@PostMapping("/user/class/list/{usrCode}")
	public List<Class> getClassesForUser(@PathVariable String usrCode) {
		return userService.getClassesForUser(Integer.parseInt(usrCode));
	}

	//유저에 따라 다르게 클래스 검색
	@PostMapping("/user/class/search")
	public List<Class> searchClsForUser(@RequestBody Map<String, String> searchMap) {
		return userService.findClassesForUser(searchMap);
	}
	
	/* 유저 클래스 추가 */
	@Transactional
	@PostMapping("/user/class/add")
	public boolean addUserClass(@RequestBody Map<String, String> addUsrClsMap) {
		int userCode = Integer.parseInt(addUsrClsMap.get("userCode"));
		int classId = Integer.parseInt(addUsrClsMap.get("classId"));
		return userService.addUserClass(userCode, classId);
	}
	
	/* 유저 클래스 삭제 */
	@Transactional
	@PostMapping("/user/class/del")
	public boolean delUser(@RequestBody Map<String, String> addUsrClsMap) {
		int userCode = Integer.parseInt(addUsrClsMap.get("userCode"));
		int classId = Integer.parseInt(addUsrClsMap.get("classId"));
		return userService.delUserClass(userCode, classId);
	}
}