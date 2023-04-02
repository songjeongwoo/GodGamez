package godgamez.selfdevelopment.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Logo {
	private int logoId;
	private String fileName;
	private String linkUrl;
	private String altText;
}