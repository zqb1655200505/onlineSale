package com.zqb.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import java.io.IOException;

/**
 * @author zqb
 * @decription 配置springMVC dispatcher-servlet
 * @create 2017/7/20
 */
@Configuration
@EnableWebMvc
@ComponentScan(basePackages = {"com.zqb.main.controller"})
public class WebConfig extends WebMvcConfigurerAdapter{

    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");

        //如果只是解析为InternalResourceView的话，不需要做以下配置，但是如果要
        //解析为JstlView，就需要做
        //resolver.setViewClass(org.springframework.web.servlet.view.JstlView.class);
        return resolver;
    }

    /**
     * @name configureDefaultServletHandling
     * @description 要求DispatcherServlet将静态请求转发到servlet默认的servlet上，
     *              而不是使用DispatcherServlet本身来处理。
     *              例如前端直接请求a.txt，我们会将其定位到服务器的路径上，
     *              而不是使用DispatcherServlet类来处理
     * @param  configurer
     * @return
     */
    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry){
        InterceptorRegistration interceptorRegistration =  registry.addInterceptor(new SpringMVCInterceptor());
        //在所有handler操作前进行拦截检查，拦截后后执行SpringMVCInterceptor的preHandle操作
        interceptorRegistration.addPathPatterns("/onlineSale/myCart/*");
        interceptorRegistration.addPathPatterns("/onlineSale/myOrder/*");
        interceptorRegistration.addPathPatterns("/onlineSale/myStore/*");

        //排除特定handler不需要拦截检查
//        interceptorRegistration.excludePathPatterns("/onlineSale/register");
//        interceptorRegistration.excludePathPatterns("/onlineSale/login");
//        interceptorRegistration.excludePathPatterns("/onlineSale/sysLogin");
    }

    @Bean(name="multipartResolver")
    public CommonsMultipartResolver getResolver() throws IOException {
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        resolver.setMaxUploadSize(104857600);
        resolver.setMaxInMemorySize(4096);
        resolver.setDefaultEncoding("UTF-8");
        //设置文件上传时临时路径，未设置时默认为servlet容器所在目录
        //resolver.setUploadTempDir(new FileSystemResource("/temp/project/uploads"));
        return resolver;
    }

    //作用同上，均是配置文件上传
//    @Bean(name = "standardServletMultipartResolver")
//    public MultipartResolver multipartResolver() throws IOException{
//        return new StandardServletMultipartResolver();
//    }
}
