package godgamez.selfdevelopment.domain;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class UserQuest {
	private String procStep;

	@JsonFormat(pattern="yyyy-MM-dd", timezone="Asia/Seoul")	
	private LocalDate modDate;
	
	private String handInImg;
	
	private User usr;
	private Quest qst;
}