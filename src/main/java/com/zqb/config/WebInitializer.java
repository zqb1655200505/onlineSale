package com.zqb.config;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

/**
 * @author zqb
 * @decription 代替web.xml对项目进行初始化配置
 * @create 2017/7/20
 */
public class WebInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {
    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class<?>[]{ContextConfig.class};
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class<?>[]{WebConfig.class};
    }

    @Override
    protected String[] getServletMappings() {
        //‘/’表示会处理所有dispatcher-servlet请求
        return new String[]{"/"};
    }
}
