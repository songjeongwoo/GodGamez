package godgamez.selfdevelopment.service;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import godgamez.selfdevelopment.domain.Message;

@Service
public class MailServiceImpl implements MailService {
	@Autowired private JavaMailSender mailSender;
	
	@Override
	public void send(Message msg) {
		MimeMessage message = mailSender.createMimeMessage();
		
		try {
			message.addRecipient(RecipientType.TO, new InternetAddress(msg.getTo()));
			message.setSubject(msg.getSubject());
			message.setText(msg.getText(), "utf-8", "html");
		} catch(Exception e) {}
		
		mailSender.send(message);
	}
}