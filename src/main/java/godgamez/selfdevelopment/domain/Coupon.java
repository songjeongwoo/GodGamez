package godgamez.selfdevelopment.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Coupon {
	private int cpnCode;
	private int usrCode;
	private int availability;
	private String store;
	private double dcPer;
}