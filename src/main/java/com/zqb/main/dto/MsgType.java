package com.zqb.main.dto;

/**
 * Created by xcd on 2017/4/20.
 */
public enum MsgType
{
    Success(200,"操作成功"),
    Error(400,"操作失败"),

    SecKillFalse(300,"该商品不在秒杀队列"),
    SecKillLoading(301,"等待处理结果"),
    AccessNotAllow(100,"尚未登录");




    MsgType(int code,String msgName)
    {
        this.code=code;
        this.msgName=msgName;
    }

    private int code;

    private String msgName;

}
