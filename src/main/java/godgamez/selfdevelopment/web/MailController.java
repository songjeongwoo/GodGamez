package godgamez.selfdevelopment.web;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import godgamez.selfdevelopment.domain.Message;
import godgamez.selfdevelopment.service.MailService;

@RestController
@RequestMapping
public class MailController {
	@Autowired private MailService mailService;
	
	@PostMapping("/mail")
	public void send(@RequestBody Message msg) {
		mailService.send(msg);
	}
	
	/* 메일인증코드발급 */
	@GetMapping("/make/authCode")
	public String makeCode(HttpServletResponse response) {
		String authCode = "";
		String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		
		for(int i = 0; i < 5; i++) authCode += str.charAt((int)Math.floor(Math.random() * str.length()));
		
		Cookie cookie = new Cookie("verificationCode", authCode);
		cookie.setMaxAge(86400);
		cookie.setPath("/");
		response.addCookie(cookie);
		
		return authCode;
	}
	
	/*
	@ExceptionHandler(MailSendException.class)
	public boolean handle() {
		return false;
	}
	*/
}