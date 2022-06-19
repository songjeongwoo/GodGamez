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
		
		registry.addViewController("/guide/aboutUs").setViewName("guide/aboutUs");
		registry.addViewController("/guide/tos").setViewName("guide/tos");

		registry.addViewController("/user/join/step1").setViewName("user/addUserChk");
		registry.addViewController("/user/join/step2").setViewName("user/addUserIn");
		registry.addViewController("/user/join/step3").setViewName("user/addUserOut");
	}
}
