package godgamez.selfdevelopment.web;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping
public class AttachController {
	@Value("${attachDir}")
	private String attachDir;
	
	@Value("${logoAttachDir}")
	private String logoAttachDir;
	
	@Value("${questAttachDir}")
	private String questAttachDir;
	
	@Value("${userAttachDir}")
	private String userAttachDir;
	
	@Value("${userQuestAttachDir}")
	private String userQuestAttachDir;
	
	@GetMapping("/logo/attach")
	public String logoMain() {
		return "admin/logo/crudLogo";
	}
	
	@PostMapping("/logo/attach")
	public String attachLogo(MultipartFile attachFile, Model model, HttpServletRequest request) {
		String dir = request.getServletContext().getRealPath(logoAttachDir);
		String fileName = request.getParameter("fileNameIn") + ".jpg";
		
		save(dir + "/" + fileName, attachFile);
		
		model.addAttribute("fileName", fileName);
	
		return "admin/logo/crudLogo";
	}
	
	@PostMapping("/quest/attach")
	@ResponseBody
	public void questAttach(MultipartFile attachFile, HttpServletRequest request) {
		String dir = request.getServletContext().getRealPath(questAttachDir);
		String fileName = request.getParameter("curQstId") + ".jpg";
		
		save(dir + "/" + fileName, attachFile);
	}
	
	@PostMapping("/userQuest/attach")
	@ResponseBody
	public void userQuestAttach(MultipartFile attachFile, HttpServletRequest request) {
		String dir = request.getServletContext().getRealPath(userQuestAttachDir);
		String fileName = request.getParameter("usrQstId") + ".jpg";
		System.out.println(attachFile);
		
		save(dir + "/" + fileName, attachFile); //NullPointerException 발생, try문법으로 IOException이 아니라 그냥 Exception으로 묶으면 파일저장 안 됨..
	}
	
	private void save(String fileName, MultipartFile attachFile) {
		System.out.println("gg");
		try {
			attachFile.transferTo(new File(fileName));
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}