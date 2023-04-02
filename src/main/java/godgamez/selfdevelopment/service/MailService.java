package godgamez.selfdevelopment.service;

import godgamez.selfdevelopment.domain.Message;

public interface MailService {
	void send(Message msg);
}