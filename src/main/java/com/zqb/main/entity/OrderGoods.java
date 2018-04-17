package com.zqb.main.entity;

/**
 * Created by zqb on 2018/4/10.
 */
public class OrderGoods extends BasicEntity {
    private Order order;

    private Goods goods;

    private int goodsNum;

    private boolean isSeckill;

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Goods getGoods() {
        return goods;
    }

    public void setGoods(Goods goods) {
        this.goods = goods;
    }

    public int getGoodsNum() {
        return goodsNum;
    }

    public void setGoodsNum(int goodsNum) {
        this.goodsNum = goodsNum;
    }

    public boolean isSeckill() {
        return isSeckill;
    }

    public void setSeckill(boolean seckill) {
        isSeckill = seckill;
    }

    @Override
    public String toString() {
        return "OrderGoods{" +
                "id='" + getId() + '\'' +
                "order=" + order +
                ", goods=" + goods +
                ", goodsNum=" + goodsNum +
                ", isSeckill=" + isSeckill +
                ", deleteFlag=" + getDeleteFlag() +
                '}';
    }
}
