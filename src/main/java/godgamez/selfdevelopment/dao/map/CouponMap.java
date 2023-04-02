package godgamez.selfdevelopment.dao.map;

import java.util.List;

import godgamez.selfdevelopment.domain.Coupon;

public interface CouponMap {
	List<Coupon> selectCoupons();
	List<Coupon> selectUsedCoupons();
	List<Coupon> selectNUsedCoupons();
	List<Coupon> selectCouponsForUser(int usrCode);
	
	Coupon selectCoupon(int cpnCode);
	int insertCoupon(Coupon coupon);
	int useCoupon(int cpnCode);
}