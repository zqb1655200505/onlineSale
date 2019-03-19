package com.zqb.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;

/**
 * @author zqb
 * @decription 配置spring-context
 * @create 2017/7/20
 */
//混合使用java和xml配置，有些在java中不好配置，故使用xml
@Configuration
@ComponentScan(basePackages = {"com.zqb.main.service"})   //扫描service包
//@MapperScan(basePackages = {"com.zqb.main.dao"})   //扫描dao包
@ImportResource({"classpath:spring-mapper.xml"})
public class MyConfig {

}
