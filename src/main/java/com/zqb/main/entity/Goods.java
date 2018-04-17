package com.zqb.main.entity;

/**
 * Created by zqb on 2018/4/10.
 */
public class Goods extends BasicEntity{

    private String goodsName;

    private User user;

    private int goodsNum;

    private String goodsPic;

    private String goodsDescription;

    private double goodsPrice;

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getGoodsNum() {
        return goodsNum;
    }

    public void setGoodsNum(int goodsNum) {
        this.goodsNum = goodsNum;
    }

    public String getGoodsPic() {
        return goodsPic;
    }

    public void setGoodsPic(String goodsPic) {
        this.goodsPic = goodsPic;
    }

    public String getGoodsDescription() {
        return goodsDescription;
    }

    public void setGoodsDescription(String goodsDescription) {
        this.goodsDescription = goodsDescription;
    }

    public double getGoodsPrice() {
        return goodsPrice;
    }

    public void setGoodsPrice(double goodsPrice) {
        this.goodsPrice = goodsPrice;
    }

    @Override
    public String toString() {
        return "Goods{" +
                "id='" + getId() + '\'' +
                "goodsName='" + goodsName + '\'' +
                ", user=" + user +
                ", goodsNum=" + goodsNum +
                ", goodsPic='" + goodsPic + '\'' +
                ", goodsDescription='" + goodsDescription + '\'' +
                ", goodsPrice=" + goodsPrice +
                ", deleteFlag=" + getDeleteFlag() +
                '}';
    }
}
