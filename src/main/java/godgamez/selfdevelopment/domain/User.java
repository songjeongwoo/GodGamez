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
public class User {
	private int usrCode;
	private String position;
	private String usrId;
	private String usrPw;
	private String usrName;
	private String nickname;
	
	@JsonFormat(pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private LocalDate birthday;
	
	private String phoneNum;
	private float usrLv;
	private int gold;
	
	@JsonFormat(pattern="yyyy-MM-dd", timezone="Asia/Seoul")	
	private LocalDate regDate;
	
	private String usrIcon;
}