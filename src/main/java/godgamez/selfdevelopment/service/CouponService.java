package godgamez.selfdevelopment.service;

import java.util.List;

import godgamez.selfdevelopment.domain.Coupon;

public interface CouponService {
	List<Coupon> getCoupons();
	List<Coupon> getUsedCoupons();
	List<Coupon> getNUsedCoupons();
	List<Coupon> getCouponsForUser(int usrCode);
	
	Coupon getCoupon(int cpnCode);
	
	boolean addCoupon(Coupon coupon);
	boolean useCoupon(Coupon coupon);
}