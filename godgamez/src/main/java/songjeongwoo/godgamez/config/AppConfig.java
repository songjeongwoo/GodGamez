package songjeongwoo.godgamez.config;

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
@ComponentScan("songjeongwoo.godgamez")
@ImportResource("classpath:songjeongwoo/godgamez/config/app.xml")
public class AppConfig implements WebMvcConfigurer {
	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}
	
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		registry.jsp("/WEB-INF/view/", ".jsp");
	}
	
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("main");
		registry.addViewController("/user/mypage").setViewName("user/mypage");
		
		registry.addViewController("/user/modify/step1").setViewName("user/fixUserChk");
		registry.addViewController("/user/modify/step2").setViewName("user/fixUserIn");
		
		registry.addViewController("/user/quit/step1").setViewName("user/delUserChk");
		registry.addViewController("/user/quit/step2").setViewName("user/delUserOut");
		
		/* 소개 & 약관 */
		registry.addViewController("/guide/aboutUs").setViewName("guide/aboutUs");
		registry.addViewController("/guide/tos").setViewName("guide/tos");
		
		/* 회원가입 */
		registry.addViewController("/user/join/step1").setViewName("user/addUserChk");
		registry.addViewController("/user/join/step2").setViewName("user/addUserIn");
		registry.addViewController("/user/join/step3").setViewName("user/addUserOut");
		
		/* 로그인 */
		registry.addViewController("/user/login").setViewName("user/login");
		
		registry.addViewController("/admin").setViewName("admin/main");

		registry.addViewController("/admin/users").setViewName("admin/user/crudUser");
		registry.addViewController("/admin/classes").setViewName("admin/class/crudClass");
		registry.addViewController("/admin/quests").setViewName("admin/quest/crudQuest");
	}
}
