package com.zqb.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.*;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * @author zqb
 * @decription 配置spring-context
 * @create 2017/7/20
 */
//混合使用java和xml配置，有些在java中不好配置，故使用xml
@Configuration
@ComponentScan(basePackages = {"com.zqb.main.service"})//扫描service包
@MapperScan(basePackages = {"com.zqb.main.dao"})   //扫描dao包
@EnableTransactionManagement //开启事务支持
@EnableAspectJAutoProxy(proxyTargetClass = true)
@ImportResource({"classpath:spring-mapper.xml"})
@Import(DataConfig.class)//导入数据源的配置
public class MyConfig {

}
