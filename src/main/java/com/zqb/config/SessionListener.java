package com.zqb.config;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * 设置session过期时间，代替web.xml中设置
 *  <session-config>
 *  <session-timeout>30</session-timeout>
 *  </session-config>
 *  30分钟
 *
 * Created by zqb on 2018/4/16.
 */
public class SessionListener implements HttpSessionListener{
    @Override
    public void sessionCreated(HttpSessionEvent event) {
        event.getSession().setMaxInactiveInterval(30*60);//设置session过期时间为30min
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent event) {

    }
}
