package godgamez.selfdevelopment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import godgamez.selfdevelopment.dao.CouponDao;
import godgamez.selfdevelopment.domain.Coupon;

@Service
public class CouponServiceImpl implements CouponService {
	@Autowired private CouponDao couponDao;
	
	@Override
	public List<Coupon> getCoupons() {
		return couponDao.selectCoupons();
	}
	
	@Override
	public List<Coupon> getUsedCoupons() {
		return couponDao.selectUsedCoupons();
	}
	
	@Override
	public List<Coupon> getNUsedCoupons() {
		return couponDao.selectNUsedCoupons();
	}
	
	@Override
	public List<Coupon> getCouponsForUser(int usrCode) {
		return couponDao.selectCouponsForUser(usrCode);
	}
	
	@Override
	public Coupon getCoupon(int cpnCode) {
		return couponDao.selectCoupon(cpnCode);
	}
	
	@Override
	public boolean addCoupon(Coupon coupon) {
		return couponDao.insertCoupon(coupon) > 0;
	}
	
	@Override
	public boolean useCoupon(Coupon coupon) {
		return couponDao.useCoupon(coupon) > 0;
	}
}