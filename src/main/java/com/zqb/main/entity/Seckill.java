package com.zqb.main.entity;

import java.util.Date;

/**
 * Created by zqb on 2018/4/10.
 */
public class Seckill extends BasicEntity{

    private Goods goods;

    private int restNum;

    private double seckillPrice;

    private Date seckillBeginTime;

    private Date seckillEndTime;

    public Goods getGoods() {
        return goods;
    }

    public void setGoods(Goods goods) {
        this.goods = goods;
    }

    public int getRestNum() {
        return restNum;
    }

    public void setRestNum(int restNum) {
        this.restNum = restNum;
    }

    public double getSeckillPrice() {
        return seckillPrice;
    }

    public void setSeckillPrice(double seckillPrice) {
        this.seckillPrice = seckillPrice;
    }

    public Date getSeckillBeginTime() {
        return seckillBeginTime;
    }

    public void setSeckillBeginTime(Date seckillBeginTime) {
        this.seckillBeginTime = seckillBeginTime;
    }

    public Date getSeckillEndTime() {
        return seckillEndTime;
    }

    public void setSeckillEndTime(Date seckillEndTime) {
        this.seckillEndTime = seckillEndTime;
    }

    @Override
    public String toString() {
        return "Seckill{" +
                "id='" + getId() + '\'' +
                "goods=" + goods +
                ", restNum=" + restNum +
                ", seckillPrice=" + seckillPrice +
                ", seckillBeginTime=" + seckillBeginTime +
                ", seckillEndTime=" + seckillEndTime +
                ", deleteFlag=" + getDeleteFlag() +
                '}';
    }
}
