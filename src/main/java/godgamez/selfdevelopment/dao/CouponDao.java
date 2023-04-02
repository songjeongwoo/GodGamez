package godgamez.selfdevelopment.dao;

import java.util.List;

import godgamez.selfdevelopment.domain.Coupon;

public interface CouponDao {
	List<Coupon> selectCoupons();
	List<Coupon> selectUsedCoupons();
	List<Coupon> selectNUsedCoupons();
	List<Coupon> selectCouponsForUser(int usrCode);
	
	Coupon selectCoupon(int cpnCode);
	
	int insertCoupon(Coupon coupon);
	int useCoupon(Coupon coupon);
}