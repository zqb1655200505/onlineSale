package com.zqb.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;

/**
 * @author zqb
 * @decription 配置spring-context
 * @create 2017/7/20
 */
@Configuration
//混合使用java和xml配置，有些在java中不好配置，故使用xml
@ComponentScan(basePackages = {"com.zqb.main.service"})
@ImportResource({"classpath:spring-mapper.xml"})
public class ContextConfig {
}
