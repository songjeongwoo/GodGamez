package godgamez.selfdevelopment.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import godgamez.selfdevelopment.domain.Coupon;
import godgamez.selfdevelopment.service.CouponService;

@RestController
@RequestMapping
public class CouponController {
	@Autowired private CouponService couponService;
	// 사용완료 쿠폰
	@GetMapping("/coupon/listNUsed")
	public List<Coupon> nUsedCoupon() {
		return couponService.getUsedCoupons();
	}
	
	// 사용가능 쿠폰
	@GetMapping("/coupon/listUsed")
	public List<Coupon> UsedCoupon() {
		return couponService.getNUsedCoupons();
	}
	
	 //쿠폰 발급 
	@Transactional
	@PostMapping("/coupon/add")
	public boolean addCoupon(@RequestBody Coupon coupon) {
		return couponService.addCoupon(coupon);
	}
	
	// 쿠폰 사용처리
	@Transactional
	@PutMapping("/coupon/useCoupon")
	public boolean useCoupon(@RequestBody Coupon coupon) {
		return couponService.useCoupon(coupon);
	}

	//쿠폰 선택
	@GetMapping("/coupon/get/{cpnCode}")
	public Coupon getCoupon(@PathVariable int cpnCode) {
		return couponService.getCoupon(cpnCode);
	}
}