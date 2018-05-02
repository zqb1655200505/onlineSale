package com.zqb.main.utils;/**
 * Created by zqb on 2017/9/12.
 */

import javax.websocket.Session;

/**
 * @author zqb
 * @decription
 * @create 2017/9/12
 */
public class WebSocketDto {

    private String  code;       //客户端传入的唯一标识
    private int totalNum;       //总数量
    private int handleNum = 0;      //当前操作数量
    private Session session;    //当前websocket的session

    public int getTotalNum() {
        return totalNum;
    }

    public void setTotalNum(int totalNum)
    {
        this.totalNum = totalNum;
    }

    public int getHandleNum()
    {
        return handleNum;
    }

    public void setHandleNum(int handleNum)
    {
        this.handleNum = handleNum;
    }

    public String getCode()
    {
        return code;
    }

    public void setCode(String code)
    {
        this.code = code;
    }

    public Session getSession()
    {
        return session;
    }

    public void setSession(Session session)
    {
        this.session = session;
    }
}
