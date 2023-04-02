package godgamez.selfdevelopment.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebMvc
@ComponentScan("godgamez.selfdevelopment")
@ImportResource("classpath:godgamez/selfdevelopment/config/app.xml")
public class AppConfig implements WebMvcConfigurer {
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}
	
	public void configureViewResolvers(ViewResolverRegistry registry) {
		registry.jsp("/WEB-INF/view/", ".jsp");
	}
	
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("main");
		
		registry.addViewController("/user/login").setViewName("user/login");
		
		registry.addViewController("/user/join/step1").setViewName("user/addUserChk");
		registry.addViewController("/user/join/step2").setViewName("user/addUserIn");
		registry.addViewController("/user/join/step3").setViewName("user/addUserOut");
		
		registry.addViewController("/user/account/step1").setViewName("user/getUserIdPwChk");
		registry.addViewController("/user/account/step2").setViewName("user/getUserIdPwOut");
		
		registry.addViewController("/user/playerpage/**").setViewName("user/getUser");
		registry.addViewController("/user/mypage").setViewName("user/mypage");
		
		registry.addViewController("/user/verifiy").setViewName("user/verification");
		registry.addViewController("/user/modify/step1").setViewName("user/fixUserChk");
		registry.addViewController("/user/modify/step2").setViewName("user/fixUserIn");
		
		registry.addViewController("/user/quit/step1").setViewName("user/delUserChk");
		registry.addViewController("/user/quit/step2").setViewName("user/delUserOut");
		
		registry.addViewController("/admin").setViewName("admin/main");
		
		registry.addViewController("/admin/classes").setViewName("admin/class/crudClass");
		registry.addViewController("/admin/coupons").setViewName("admin/coupon/cruCoupon");
		registry.addViewController("/admin/log").setViewName("admin/log/getLog");
		registry.addViewController("/admin/logos").setViewName("admin/logo/crudLogo");
		registry.addViewController("/admin/quests").setViewName("admin/quest/crudQuest");
		registry.addViewController("/admin/users").setViewName("admin/user/crudUser");
		registry.addViewController("/admin/users/mail").setViewName("admin/user/fixMail");
		
		registry.addViewController("/coupon/shop").setViewName("coupon/getCoupon");
		
		registry.addViewController("/guide/aboutUs").setViewName("guide/aboutUs");
		registry.addViewController("/guide/tos").setViewName("guide/tos");
		
		registry.addViewController("/quest/board").setViewName("quest/getQuests");
		registry.addViewController("/quest/quest").setViewName("quest/getQuest");
		registry.addViewController("/quest/report").setViewName("quest/doQuest");
	}

	/*
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(loginInterceptor())
			.addPathPatterns("/**")
			.excludePathPatterns("/", "/user/login", "/user/loginProc", "/user/join/**", "/guide/**",
					"/quest/board", "/community/board", "/coupon/shop", "/admin/**");
	}
	
	@Bean
	public LoginInterceptor loginInterceptor() {
		return new LoginInterceptor();
	}
	*/
}