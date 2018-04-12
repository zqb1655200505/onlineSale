package com.zqb.main.entity;

import java.util.Date;

/**
 * Created by zqb on 2018/4/10.
 */
public class Message extends BasicEntity {
    private User sendUser;

    private User receiveUser;

    private Date sendTime;

    private String message;//为kafkaMsg.toString()，是一个json对象

    public User getSendUser() {
        return sendUser;
    }

    public void setSendUser(User sendUser) {
        this.sendUser = sendUser;
    }

    public User getReceiveUser() {
        return receiveUser;
    }

    public void setReceiveUser(User receiveUser) {
        this.receiveUser = receiveUser;
    }

    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @Override
    public String toString() {
        return "Message{" +
                "id='" + getId() + '\'' +
                "sendUser=" + sendUser +
                ", receiveUser=" + receiveUser +
                ", sendTime=" + sendTime +
                ", message='" + message + '\'' +
                '}';
    }
}
