package com.zqb.main.entity;

import java.util.Date;

/**
 * Created by zqb on 2018/4/10.
 */
public class Comment extends BasicEntity{

    private Goods goods;

    private String fatherId;

    private User user;

    private String comment;

    private Date commentTime;

    private boolean haveChildren;

    private int level;

    public Goods getGoods() {
        return goods;
    }

    public void setGoods(Goods goods) {
        this.goods = goods;
    }

    public String getFatherId() {
        return fatherId;
    }

    public void setFatherId(String fatherId) {
        this.fatherId = fatherId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(Date commentTime) {
        this.commentTime = commentTime;
    }

    public boolean isHaveChildren() {
        return haveChildren;
    }

    public void setHaveChildren(boolean haveChildren) {
        this.haveChildren = haveChildren;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id='" + getId() + '\'' +
                "goods=" + goods +
                ", fatherId='" + fatherId + '\'' +
                ", user=" + user +
                ", comment='" + comment + '\'' +
                ", commentTime=" + commentTime +
                ", haveChildren=" + haveChildren +
                ", level=" + level +
                ", deleteFlag=" + getDeleteFlag() +
                '}';
    }
}
