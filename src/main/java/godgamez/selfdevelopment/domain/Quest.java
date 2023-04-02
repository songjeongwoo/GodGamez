package godgamez.selfdevelopment.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Quest {
	private int qstId;
	private Class cls;
	private String qstName;
	private int difficulty;
	private String qstContent;
	private String qstImg;
}