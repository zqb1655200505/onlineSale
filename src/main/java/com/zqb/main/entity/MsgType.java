package com.zqb.main.entity;

/**
 * Created by xcd on 2017/4/20.
 */
public enum MsgType
{
    Success(200,"成功"),
    Error(400,"错误");


    MsgType(int code,String msgName)
    {
        this.code=code;
        this.msgName=msgName;
    }

    private int code;

    private String msgName;
}
