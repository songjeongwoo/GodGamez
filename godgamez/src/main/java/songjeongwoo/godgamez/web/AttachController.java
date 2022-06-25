package songjeongwoo.godgamez.web;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping
public class AttachController {
	@Value("${attachDir}")
	private String attachDir;
	
	@Value("${questAttachDir}")
	private String questAttachDir;
	
	@PostMapping("/quest/attach")
	@ResponseBody
	public void questAttach(MultipartFile attachFile, HttpServletRequest request) {
		String dir = request.getServletContext().getRealPath(questAttachDir);
		String fileName = request.getParameter("curQstId") + ".jpg";
		
		save(dir + "/" + fileName, attachFile);
	}
	
	private void save(String fileName, MultipartFile attachFile) {
		try {
			attachFile.transferTo(new File(fileName));
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//퀘스트 삭제 시 해당 퀘스트 이미지 삭제
	@DeleteMapping("/quest/attach/del")
	public void questAttachDel(@RequestBody int qstId, HttpServletRequest request) {
		String dir = request.getServletContext().getRealPath(questAttachDir);
		
		File file = new File(dir + "/" + qstId + ".jpg");
		if(file.exists()) {
			file.delete();		
		}
		
	}
}