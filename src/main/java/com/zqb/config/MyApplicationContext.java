package com.zqb.config;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * Created by zqb on 2018/5/24.
 * 通过此类获取 ApplicationContext，再通过ApplicationContext获取实体bean
 */
public class MyApplicationContext implements ApplicationContextAware {
    private static ApplicationContext applicationContext = null;

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        if (MyApplicationContext.applicationContext == null)
        {
            MyApplicationContext.applicationContext = applicationContext;
            System.out.println(
                    "========ApplicationContext配置成功,在普通类可以通过调用MyApplicationContext.getAppContext()获取applicationContext对象,applicationContext="
                            + applicationContext + "========");
        }
    }

    public static ApplicationContext getApplicationContext() {
        return applicationContext;
    }


    public static Object getBean(String name) {
        return getApplicationContext().getBean(name);
    }
}
