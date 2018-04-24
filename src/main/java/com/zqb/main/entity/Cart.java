package com.zqb.main.entity;

/**
 * Created by zqb on 2018/4/24.
 */
public class Cart extends BasicEntity<Cart> {

    private Goods goods;

    private User user;

    private int goodsNum;

    public Goods getGoods() {
        return goods;
    }

    public void setGoods(Goods goods) {
        this.goods = goods;
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

    @Override
    public String toString() {
        return "Cart{" +
                "id='" + getId() + '\'' +
                "goods=" + goods +
                ", user=" + user +
                ", goodsNum=" + goodsNum +
                ", deleteFlag=" + getDeleteFlag() +
                '}';
    }
}
