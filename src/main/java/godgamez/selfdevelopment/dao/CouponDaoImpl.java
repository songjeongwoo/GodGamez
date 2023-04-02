package godgamez.selfdevelopment.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import godgamez.selfdevelopment.dao.map.CouponMap;
import godgamez.selfdevelopment.domain.Coupon;

@Repository
public class CouponDaoImpl implements CouponDao {
	@Autowired private CouponMap couponMap;
	
	public List<Coupon> selectCoupons() {
		return couponMap.selectCoupons();
	}
	
	public List<Coupon> selectUsedCoupons() {
		return couponMap.selectUsedCoupons();
	}
	
	public List<Coupon> selectNUsedCoupons() {
		return couponMap.selectNUsedCoupons();
	}

	public List<Coupon> selectCouponsForUser(int usrCode) {
		return couponMap.selectCouponsForUser(usrCode);
	}
	
	public Coupon selectCoupon(int cpnCode) {
		return couponMap.selectCoupon(cpnCode);
	}
	
	public int insertCoupon(Coupon coupon) {
		return couponMap.insertCoupon(coupon);
	}
	
	public int useCoupon(Coupon coupon) {
		return couponMap.useCoupon(coupon.getCpnCode());
	}
}